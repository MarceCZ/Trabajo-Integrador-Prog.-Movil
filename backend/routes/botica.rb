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

    