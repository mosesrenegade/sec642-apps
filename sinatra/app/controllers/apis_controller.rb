class ApisController < Sinatra::Base

    before do 
        content_type 'application/json'
    end

    get '/api/v1/' do
      Time.now.to_json(:my_datetime)
    end
  
end