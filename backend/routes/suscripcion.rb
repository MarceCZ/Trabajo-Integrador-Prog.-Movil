
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
      return { mensaje: "Error al procesar la solicitud" }.to_json
    end

    # Crear una nueva dirección
    direccion = Direccion.create(
      departamento: direccion_data['departamento'],
      distrito: direccion_data['distrito'],
      direccion: direccion_data['direccion'],
      numero: direccion_data['numero']
    )

    subtotal_kit = 0.0

    suscripcion = Suscripcion.create(
      costo: 0.0,
      fecha_inicio: Date.today,
      fecha_fin: Date.today.next_month(tipo_suscripcion * 3),
      precio_total: 0.0,
      metodo_pago: metodo_pago,
      id_usuario: usuario_id,
      id_estado: 1,
      id_tipo_suscripcion: tipo_suscripcion
    )

    # Crear el kit asociado a la suscripción
    kit = Kit.create(
      subtotal: 0.0,
      id_suscripcion: suscripcion.id
    )

    # Agregar productos al kit
    productos.each do |producto_info|
      id_producto = producto_info['id_producto']
      cantidad = producto_info['cantidad']

      producto = Producto[id_producto]
      if producto.nil?
        status 404
        return { mensaje: "Error al procesar la solicitud" }.to_json
      end

      subtotal_kit += producto.precio * cantidad

      # Crear el registro en la tabla productos_kits
      ProductoKit.create(
        cantidad: cantidad,
        id_kit: kit.id,
        id_producto: id_producto
      )
    end

    # Actualizar el subtotal del kit
    kit.update(subtotal: subtotal_kit)

    costo_suscripcion = suscripcion.precio_total - subtotal_kit

    # Actualizar la suscripción con el costo y el precio total
    suscripcion.update(
      costo: costo_suscripcion,
      precio_total: costo_suscripcion + subtotal_kit
    )

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
    return { mensaje: "Operación realizada exitosamente" }.to_json

  rescue StandardError => e
    puts "Ocurrió un error inesperado: #{e.message}"
    status 500
    return { mensaje: "Error al procesar la solicitud" }.to_json
  end
end
