require 'sinatra'
require 'json'
require 'securerandom'
require 'postmark'
require 'bcrypt'

client = Postmark::ApiClient.new('e83f9e61-0c0d-457e-a091-ed7b84d0fb86')

# ==========================================================================================

# Para obtener todos los datos de usuario por id
get '/usuario/:id' do
  id = params['id']

  status 500
  resp = ''

  begin
    record = Usuario.where(id: id).first

    if record then
      status 200
      resp = record.to_json
    else
      status 404
      resp = 'Usuario no encontrado'
    end
    rescue Sequel::DatabaseError => e
      status = 500
      resp = 'Error al acceder a la base de datos'
      puts e.message
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al validar el usuario'
      puts e.message
    end

  status status
  return resp
end

# ==========================================================================================

# Para actualizar datos de usuario por id
put '/usuario/:id' do
  id = params['id']
  body = request.body.read
  data = JSON.parse(body)

  nombres = data['nombres']
  apellidos = data['apellidos']
  fecha_nacimiento = data['fecha_nacimiento']
  correo = data['correo']
  celular = data['celular']
  contrasena = data['contrasena']
  altura = data['altura']
  peso = data['peso']
  sexo = data['sexo']
  condiciones_medicas = data['condiciones_medicas']
  alergias = data['alergias']
  otros = data['otros']

  status 500
  resp = ''

  begin
    record = Usuario.where(id: id).first

    if record then
      record.update(
        nombres: nombres,
        apellidos: apellidos,
        fecha_nacimiento: fecha_nacimiento,
        correo: correo,
        celular: celular,
        contrasena: contrasena,
        altura: altura,
        peso: peso,
        sexo: sexo,
        condiciones_medicas: condiciones_medicas,
        alergias: alergias,
        otros: otros
      )

      status 200
      resp = 'Usuario actualizado exitosamente'
    else
      status 404
      resp = 'Usuario no encontrado'
    end
    rescue Sequel::DatabaseError => e
      status = 500
      resp = 'Error al acceder a la base de datos'
      puts e.message
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al validar el usuario'
      puts e.message
    end

  status status
  return resp
end

# ==========================================================================================

# Para login
post '/usuario/login' do
  body = request.body.read
  data = JSON.parse(body)

  correo = data['correo']
  contrasena = data['contrasena']

  # Configuración de respuesta inicial
  response = ''

  begin
    # Buscar el usuario por correo
    record = Usuario.where(correo: correo).first

    if record
      # decifrar contraseña
      if BCrypt::Password.new(record.contrasena) == contrasena
        # Contraseña correcta
        status 200
        resp = { idUsuario: record.id }.to_json
      else
        # Contraseña incorrecta
        status 404
        resp = 'Correo y/o contraseña incorrectos'
      end
    else
      # Usuario no encontrado
      status 404
      resp = 'Correo y/o contraseña incorrectos'
    end

  rescue BCrypt::Errors::InvalidHash
    # Error si `record.contrasena` no es un hash válido de BCrypt
    puts "Error: la contraseña almacenada no es un hash válido de BCrypt."
    status 500
    resp = 'Error en el sistema de contraseñas. Contacte soporte.'

  rescue Sequel::DatabaseError => e
    # Error de base de datos
    puts "Error al acceder a la base de datos: #{e.message}"
    status 500
    resp = 'Error al acceder a la base de datos'

  rescue StandardError => e
    # Otro error inesperado
    puts "Ocurrió un error inesperado: #{e.message}"
    status 500
    resp = 'Ocurrió un error inesperado al validar el usuario'
  end

  status status
  return resp
end

# ==========================================================================================

# Para recuperar contraseña
post '/usuario/validar' do
  body = request.body.read
  data = JSON.parse(body)
  correo = data['correo']

  resp = ''

  begin
    # Buscar el usuario por correo
    record = Usuario.where(correo: correo).first

    if record
      # Generar nueva contraseña temporal
      nueva_contrasena = SecureRandom.hex(8)
      record.update(contrasena: BCrypt::Password.create(nueva_contrasena))
      puts "Contraseña temporal generada: #{nueva_contrasena}"

      # Enviar correo con Postmark
      begin
        client.deliver_with_template(
          from: '20210651@aloe.ulima.edu.pe',
          to: correo,
          template_alias: 'recuperar_contrasena',
          template_model: {
            nueva_contrasena: nueva_contrasena,
            nombres: record.nombres,
            product_name: 'MediPlan+',
            company_name: 'MediPlan+ Corp.',
            company_address: ''
          }
        )
        puts 'Correo enviado exitosamente'
        status 200
        resp = 'Correo enviado con nueva contraseña'

      rescue Postmark::Error => e
        puts "Error al enviar correo: #{e.message}"
        status 500
        resp = 'Error al enviar el correo'
      end

    else
      puts 'Correo no encontrado en la base de datos'
      status 404
      resp = 'Correo no encontrado'
    end

  rescue Sequel::DatabaseError => e
    puts "Error al acceder a la base de datos: #{e.message}"
    status 500
    resp = 'Error al acceder a la base de datos'

  rescue StandardError => e
    puts "Ocurrió un error inesperado: #{e.message}"
    status 500
    resp = 'Ocurrió un error inesperado al validar el usuario'
  end

  status status
  return resp
end

# ==========================================================================================

post '/usuario/registro' do
  body = request.body.read
  data = JSON.parse(body)

  resp = ''

  usuario = Usuario.create(
    nombres: data['nombres'],
    apellidos: data['apellidos'],
    correo: data['correo'],
    celular: data['celular'],
    fecha_nacimiento: data['fechaNacimiento'],
    contrasena: BCrypt::Password.create(data['contrasena']),
    altura: data['altura'],
    peso: data['peso'],
    sexo: data['sexo'],
    condiciones_medicas: data['condiciones_medicas'],
    alergias: data['alergias'],
    otros: data['otros']
  )

  if usuario
    status 200
    resp = 'Usuario creado exitosamente'
  else
    status 500
    resp = 'Error al crear el usuario'
  end

  status status
  return resp
end


# ==========================================================================================

post '/usuario/actualizar_correo' do
  data = JSON.parse(request.body.read)
  correo = data['correo']
  nuevo_correo = '20210651@aloe.ulima.edu.pe'

  resp = ''

  begin
    # Buscar el usuario por correo
    record = Usuario.where(correo: correo).first

    if record
      # Actualizar el correo
      record.update(correo: nuevo_correo)
      status 200
      resp = 'Correo actualizado con éxito'
    else
      # Usuario no encontrado
      status 404
      resp = 'No se encontró el correo'
    end
  rescue Sequel::DatabaseError => e
    # Error de base de datos
    status 500
    resp = 'Error al acceder a la base de datos'
    puts e.message
  rescue StandardError => e
    # Otro tipo de error
    status 500
    resp = 'Ocurrió un error no esperado al validar el usuario'
    puts e.message
  end

  # Devolver la respuesta
  resp
end 

# ==========================================================================================

post '/usuario/eliminar' do
  content_type :json

  # Obtener el parámetro id_usuario
  id_usuario = params[:id_usuario]

  # Verificar si el id_usuario es válido
  if id_usuario.nil? || !id_usuario.match?(/^\d+$/)
    status 400
    return { message: 'ID de usuario no válido' }.to_json
  end

  # Convertir id_usuario a un número entero
  id_usuario = id_usuario.to_i

  # Buscar al usuario en la base de datos por ID
  usuario = Usuario.where(id: id_usuario).first

  # Si el usuario existe, eliminamos
  if usuario
    # Eliminar el usuario
    usuario.delete

    # Reiniciar el contador de auto-incremento de la tabla usuarios
    DB.run("DELETE FROM sqlite_sequence WHERE name = 'usuarios'")

    status 200
    return { message: 'Usuario eliminado exitosamente' }.to_json
  else
    # Si el usuario no existe
    status 404
    return { message: 'Usuario no encontrado' }.to_json
  end
end

# ==========================================================================================

post '/usuario/verificar_correo' do
  content_type :json
  body = request.body.read
  data = JSON.parse(body)
  correo = data['correo']

  resp = ''

  if correo.nil? || correo.empty?
    status 400
    resp = 'El correo es obligatorio'
  end

  usuario_existente = Usuario.where(correo: correo).first
  if usuario_existente
    status 409
    resp = 'El correo ya está registrado'
  else
    status 200
    resp = 'Correo disponible'
  end

  status status
  return resp
end






