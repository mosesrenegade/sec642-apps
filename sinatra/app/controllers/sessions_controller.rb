class SessionsController < ApplicationController

    get '/login' do
        @title = "Login"
        erb :"sessions/login" 
    end

    post '/sessions' do
        # login a user with this email
        login(params[:email], params[:password])
        redirect '/posts'
    end

    get '/logout' do
        logout!
    end

end