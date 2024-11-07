#Pantalla 4: boticas
get '/botica/listar' do
    status=200
    begin
        rs=Botica.all
        if rs
        resp=rs.to_json
        else
        resp='No hay información de boticas'
        status=404
        end
    rescue StandardError=>e
        status=500
        resp='Ocurrió un error no esperado al listar las boticas'
        puts e.message
    end
    status status
    resp
    end

# Pantalla 4: boticas con filtro de búsqueda
get '/botica/listar_filtrado' do
    status = 200
    begin
      busqueda = params['busqueda'] ? "%#{params['busqueda'].downcase}%" : nil
  
      query = <<-SQL
        SELECT 
          b.*
        FROM 
          boticas b
      SQL
  
      if busqueda
        query += " WHERE LOWER(b.nombre) LIKE ?"
      end
  
      rs = busqueda ? DB[query, busqueda].all : DB[query].all
  
      if rs.any?
        resp = rs.to_json
      else
        status = 404
        resp = 'No hay información de boticas que coincidan con la búsqueda'
      end
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al listar las boticas'
      puts e.message
    end
  
    status status
    resp
  end
  

    