post '/suscripcion/crear_suscripcion' do
  body = request.body.read
  data = JSON.parse(body)

  usuario_id = data['usuario_id']
  tipo_suscripcion = data['tipo_suscripcion']
  metodo_pago = data['metodo_pago']
  productos = data['productos']
  direccion_data = data['direccion']

  begin
    usuario = Usuario[usuario_id]
    if usuario.nil?
      status 404
      return { mensaje: "Usuario no encontrado" }.to_json
    end

    # Crear una nueva dirección
    direccion = Direccion.create(
      departamento: direccion_data['departamento'],
      distrito: direccion_data['distrito'],
      direccion: direccion_data['direccion'],
      numero: direccion_data['numero']
    )

    # Crear una nueva suscripción
    suscripcion = Suscripcion.create(
      costo: 0.0, # Se actualizará más tarde
      fecha_inicio: Date.today,
      fecha_fin: Date.today.next_month(tipo_suscripcion * 3),
      precio_total: 0.0, # Se actualizará más tarde
      metodo_pago: metodo_pago,
      id_usuario: usuario_id,
      id_estado: 1,
      id_tipo_suscripcion: tipo_suscripcion
    )

    # Crear el kit asociado a la suscripción
    kit = Kit.create(
      subtotal: 0.0, # Se actualizará más tarde
      id_suscripcion: suscripcion.id
    )

    # Calcular el subtotal del kit
    subtotal_kit = 0.0
    productos.each do |producto_info|
      id_producto = producto_info['id_producto']
      cantidad = producto_info['cantidad']

      producto = Producto[id_producto]
      if producto.nil?
        status 404
        return { mensaje: "Producto con ID #{id_producto} no encontrado" }.to_json
      end

      subtotal_kit += producto.precio.to_f * cantidad.to_f

      # Crear el registro en la tabla productos_kits
      ProductoKit.create(
        cantidad: cantidad,
        id_kit: kit.id,
        id_producto: id_producto
      )
    end
    kit.update(subtotal: subtotal_kit.to_f)

    costo_suscripcion = (subtotal_kit.to_f * 0.2).round(2)

    precio_total = (subtotal_kit.to_f + costo_suscripcion).round(2)

    # Actualizar la suscripción con los valores calculados

    suscripcion.update(
      costo: costo_suscripcion,
      precio_total: precio_total
    )

    # Generar los envíos para los meses de la suscripción
    meses = case tipo_suscripcion
            when 1 then 3
            when 2 then 6
            when 3 then 12
            else 0
            end

    meses.times do |i|
      fecha_envio = Date.today.next_month(i)
      Envio.create(
        fecha_envio: fecha_envio,
        id_estado_envio: 2,
        id_kit: kit.id,
        id_direccion: direccion.id
      )
    end

    status 200
    return { mensaje: "Suscripción creada exitosamente" }.to_json

  rescue StandardError => e
    puts "Ocurrió un error inesperado: #{e.message}"
    status 500
    return { mensaje: "Error al procesar la solicitud" }.to_json
  end
end



#Para obtener los datos de la suscripcion de un usuario
get '/suscripcion/complete/:id' do

  status 500
  resp = ''
  begin
      idUser = params['id'].to_i

      query= <<-SQL
      select
        s.costo,
        s.fecha_inicio,
        s.fecha_fin,
        s.precio_total,
        s.metodo_pago,
        s.id as suscripcion_id,
        ts.descripcion as tipo_suscripcion,
        s.id_usuario as usuario_id,
        k.id as kit_id,
        k.subtotal,
        e.fecha_envio,
        ee.descripcion,
        d.departamento,
        d.distrito,
        d.direccion,
        d.numero
      from suscripciones s
        inner join tipo_suscripcion ts on s.id_tipo_suscripcion = ts.id
        inner join kits k on s.id = k.id_suscripcion
        inner join envios e on k.id = e.id_kit and e.fecha_envio > CURRENT_DATE
        inner join direcciones d on d.id = e.id_direccion
        inner join estado_envio ee on ee.id = e.id_estado_envio
      where  s.id_estado = 1
    SQL

      if idUser >0
        query += " and s.id_usuario = ? "
      end

      query +=" ORDER by e.fecha_envio ASC "

     rs = idUser>0 ? DB[query,idUser].first : DB[query].first

     if rs then

        status 200
        resp = rs.to_json
      else
        status 404
        resp = query
      end
      rescue Sequel::DatabaseError => e
        status = 500
        resp = 'Error al acceder a la base de datos'
        puts e.message
      rescue StandardError => e
        status = 500
        resp = 'Ocurrió un error no esperado al listar las suscripciones'
        puts e.message
      end

  status status
  return resp
end

#Para eliminar una suscripción con todos sus envíos y productos
delete '/suscripcion/:id/:idKit' do
  status 500
  resp = ''
  begin
    id = params['id'].to_i
    idKit = params['idKit'].to_i

    if id > 0 and idKit > 0
      suscripcion = Suscripcion.where(id: id).first
      if suscripcion
        kit = Kit.where(id: idKit, id_suscripcion: suscripcion.id).first
        if kit
          envios = Envio.where(id_kit: idKit).all
          productos_kits = ProductoKit.where(id_kit: idKit).all
          if envios.any? and productos_kits.any?
            DB.transaction do
              begin
                envios.each(&:destroy)
                productos_kits.each(&:destroy)
                kit.destroy
                suscripcion.destroy
                status 200
                resp = 'Suscripción y kits eliminados'
              rescue StandardError => e
                DB.rollback
                status 500
                resp = 'Error al eliminar la suscripción y kits'
                puts e.message
              end
            end
          else
            status 400
            resp = 'No se puede eliminar la suscripción porque no tiene envíos o productos'
          end
        else
          status 400
          resp = 'No se puede eliminar la suscripción porque no tiene kits'
        end
      else
        status 400
        resp = 'ID de suscripción no válido'
      end
    else
      status 400
      resp = 'ID de suscripción no válido'
    end
  rescue Sequel::DatabaseError => e
    status 500
    resp = 'Error al acceder a la base de datos'
    puts e.message
  rescue StandardError => e
    status 500
    resp = 'Error inesperado'
    puts e.message
  end

  status status
  resp
end

#cancelar suscripcion

put '/suscripcion/cancelar/:id' do
  id = params['id']
  status 500
  resp = ''

  begin
    record = Suscripcion.where(id: id).first

    if record then
      record.update(
        id_estado: 2
      )

      status 200
      resp = 'Suscripción cancelada'
    else
      status 404
      resp = 'No se encontró la suscripción'
    end
    rescue Sequel::DatabaseError => e
      status = 500
      resp = 'Error al acceder a la base de datos'
      puts e.message
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al cancelar la suscripción'
      puts e.message
    end

  status status
  return resp
end



#prueba
get '/suscripcion/:id/:idKit' do
  status 500
  resp = ''
  begin
    id = params['id'].to_i
    idKit = params['idKit'].to_i

    if id > 0 and idKit > 0
      suscripcion = Suscripcion.where(id: id).first
      if suscripcion
        kit = Kit.where(id: idKit, id_suscripcion: suscripcion.id).first
        if kit
          envios = Envio.where(id_kit: idKit).all
          productos_kits = ProductoKit.where(id_kit: idKit).all
          if envios.any? and productos_kits.any?
            status 200
            resp = {
              suscripcion: suscripcion,
              kit: kit,
              envios: envios,
              productos_kits: productos_kits
            }.to_json
          else
            status 400
            resp = 'No se puede eliminar la suscripción porque no tiene envíos o productos'
          end
        else
          status 400
          resp = 'No se puede eliminar la suscripción porque no tiene kits'
        end
      else
        status 400
        resp = 'ID de suscripción no válido'
      end
    else
      status 400
      resp = 'ID de suscripción no válido'
    end
  rescue Sequel::DatabaseError => e
    status 500
    resp = 'Error al acceder a la base de datos'
    puts e.message
  rescue StandardError => e
    status 500
    resp = 'Error inesperado'
    puts e.message
  end

  status status
  resp
end
