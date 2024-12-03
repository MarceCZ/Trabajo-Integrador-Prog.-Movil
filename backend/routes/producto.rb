#Pantalla1: Listar todos los productos
get '/producto/listar' do
    status=200
    begin
        query= <<-STRING
        SELECT
            p.id AS producto_id,
            p.nombre AS producto_nombre,
            p.marca AS producto_marca,
            p.precio AS producto_precio,
            p.imagen AS producto_imagen,
            p.presentacion AS producto_presentación,
            p.requiere_receta AS producto_requiere_receta,
            b.nombre AS nombre_botica
        FROM
            productos p
        JOIN
            boticas b ON p.id_botica = b.id;
        STRING
        rs=DB[query].all
        if rs
        resp=rs.to_json
        else
        resp='No hay productos'
        status=404
        end
    rescue StandardError=>e
        status=500
        resp='Ocurrió un error no esperado al listar todos los productos'
        puts e.message
    end
    status status
    resp
    end

#Pantalla 2: Productos según filtros
get '/producto/listar_filtrado' do
    status = 200
    begin
      # Parámetros de filtro
      min_precio = params['min_precio'] || 0
      max_precio = params['max_precio'] || 1000
      marcas = params['marcas'] ? params['marcas'].split(',') : []
      busqueda = params['busqueda'] ? "%#{params['busqueda'].downcase}%" : nil

      query = <<-SQL
        SELECT
          p.id AS producto_id,
          p.nombre AS producto_nombre,
          p.marca AS producto_marca,
          p.precio AS producto_precio,
          p.imagen AS producto_imagen,
          p.presentacion AS producto_presentacion,
          p.requiere_receta AS producto_requiere_receta,
          b.nombre AS nombre_botica
        FROM
          productos p
        JOIN
          boticas b ON p.id_botica = b.id
        WHERE
          p.precio BETWEEN ? AND ?
      SQL

      if !marcas.empty?
        marcas_placeholder = (['?'] * marcas.size).join(',')
        query += " AND p.marca IN (#{marcas_placeholder})"
      end

      if busqueda
        query += " AND LOWER(p.nombre) LIKE ?"
      end

      params_query = [min_precio, max_precio, *marcas]
      params_query << busqueda if busqueda

      rs = DB[query, *params_query].all
      if rs.any?
        resp = rs.to_json
      else
        status = 404
        resp = 'No hay productos que coincidan con los filtros'
      end
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al listar los productos con filtros'
      puts e.message
    end

    status status
    resp
  end

#Pantalla 3: Un producto segun id
get '/producto/:id' do
        id = params['id']
        status = 200
        begin
          if id.match?(/^\d+$/)
            query = <<-SQL
              SELECT
                p.id AS producto_id,
          p.nombre AS producto_nombre,
          p.marca AS producto_marca,
          p.precio AS producto_precio,
          p.descripcion AS descripcion,
          p.contraindicaciones AS contraindicaciones,
          p.advertencias AS advertencias,
          p.imagen AS producto_imagen,
          p.presentacion AS producto_presentacion,
          p.requiere_receta AS producto_requiere_receta,
          b.nombre AS nombre_botica
              FROM
                productos p
              JOIN
                boticas b ON p.id_botica = b.id
              WHERE
                p.id = ?;
            SQL
            rs = DB.fetch(query, id.to_i).first
            if rs
              resp = rs.to_json
            else
              status = 404
              resp = 'No hay información del producto'
            end
          else
            status = 400
            resp = 'ID no válido'
          end
        rescue StandardError => e
          status = 500
          resp = 'Ocurrió un error no esperado al mostrar la información del producto'
          puts e.message
        end

        status status
        resp
      end


# Pantalla5: Listar todos los productos de una botica en específico
get '/botica/:id' do
    id = params['id']
    status = 200
    begin
      if id.match?(/^\d+$/)
        query = <<-SQL
          SELECT
            p.id AS producto_id,
            p.nombre AS producto_nombre,
            p.marca AS producto_marca,
            p.precio AS producto_precio,
            p.imagen AS producto_imagen,
            p.presentacion AS producto_presentacion,
            p.requiere_receta AS producto_requiere_receta,
            b.nombre AS nombre_botica
          FROM
            productos p
          JOIN
            boticas b ON p.id_botica = b.id
          WHERE
            b.id = ?;
        SQL

        rs = DB.fetch(query, id.to_i).all
        if rs.any?
          resp = rs.to_json
        else
          status = 404
          resp = 'No hay productos de la botica'
        end
      else
        status = 400
        resp = 'ID de botica no válido'
      end
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al listar todos los productos de la botica'
      puts e.message
    end
    status status
    resp
  end

# Pantalla 5: Listar todos los productos de una botica en específico con filtros
get '/botica/:id/productos_filtrados' do
    id = params['id']
    status = 200
    begin
      if id.match?(/^\d+$/)
        min_precio = params['min_precio'] || 0
        max_precio = params['max_precio'] || 1000
        marcas = params['marcas'] ? params['marcas'].split(',') : []
        busqueda = params['busqueda'] ? "%#{params['busqueda'].downcase}%" : nil

        query = <<-SQL
          SELECT
            p.id AS producto_id,
            p.nombre AS producto_nombre,
            p.marca AS producto_marca,
            p.precio AS producto_precio,
            p.imagen AS producto_imagen,
            p.presentacion AS producto_presentacion,
            p.requiere_receta AS producto_requiere_receta,
            p.id_botica AS id_botica,
            b.nombre AS nombre_botica
          FROM
            productos p
          JOIN
            boticas b ON p.id_botica = b.id
          WHERE
            b.id = ?
            AND p.precio BETWEEN ? AND ?
        SQL

        if !marcas.empty?
          marcas_placeholder = (['?'] * marcas.size).join(',')
          query += " AND p.marca IN (#{marcas_placeholder})"
        end

        if busqueda
          query += " AND LOWER(p.nombre) LIKE ?"
        end

        params_query = [id.to_i, min_precio, max_precio, *marcas]
        params_query << busqueda if busqueda

        rs = DB[query, *params_query].all
        if rs.any?
          resp = rs.to_json
        else
          status = 404
          resp = 'No hay productos que coincidan con los filtros en la botica especificada'
        end
      else
        status = 400
        resp = 'ID de botica no válido'
      end
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al listar los productos con filtros'
      puts e.message
    end

    status status
    resp
  end



# Listar todas los productos de una suscripcion kit
get '/suscripcion/:id/productos' do
  id = params['id'].to_i
  status = 200
  begin
    if id>0
      query = <<-SQL
        SELECT pk.cantidad,
			    p.id as producto_id,
          CONCAT(p.nombre, ' ', p.presentacion) AS producto_nombre,
          p.marca,
          p.precio * pk.cantidad as subtotal,
          p.imagen as producto_imagen,
          b.nombre as botica_nombre,
          CASE
           WHEN r.imagen IS NOT NULL THEN TRUE
           ELSE FALSE
			    END AS receta_imagen,
		      k.id as kit_id
        FROM productos_kits PK
          INNER JOIN productos P ON PK.id_producto = P.ID
          INNER JOIN boticas B ON P.id_botica = B.ID
          INNER JOIN kits K ON K.id = PK.id_kit
          INNER JOIN suscripciones S ON S.id = K.id_suscripcion AND S.id_estado = 1 AND  S.id_usuario = ?
          LEFT JOIN recetas R ON P.ID = R.id_producto AND R.id_usuario = ?
      SQL

      rs = DB[query,id,id].all
      if rs.any?
        resp = rs.to_json
      else
        status = 404
        resp = 'No hay productos de la suscripción'
      end
    else
      status = 400
      resp = 'ID de suscripción no válido'
    end
  rescue StandardError => e
    status = 500
    resp = 'Ocurrió un error no esperado al listar los productos de la suscripción'
    puts e.message
  end
  status status
  resp
end
