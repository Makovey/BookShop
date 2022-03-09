require "sinatra"


post '/login' do
    content_type :json
    
    request.body.rewind
    request_payload = JSON.parse request.body.read

    if request_payload['email'] == 'p1@mail.ru'
        send_file 'failure_login.json', :halt => 403
    else
        send_file 'login.json', :halt => 201
    end
    
end

post '/register' do
    content_type :json
    
    send_file 'register.json', :halt => 201
    
end
