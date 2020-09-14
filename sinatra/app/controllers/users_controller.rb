class UsersController < ApplicationController
    
    get '/signup' do
        @user #=> from the last request below
        erb :"users/new"
    end
    
    post '/users' do
        @user = User.new
        @user.email = params[:email]
        @user.password = params[:password]
        @user.role = "user"
        if @user.save 
            redirect '/login'
        #end
        else
            redirect '/signup'
        end
    end

    get '/users/:id' do
        @role = session[:role]

        if @role == "admin"
          @users = User.find_by(params[:id])
        end

        erb :'users/show'
    end

    get '/users/:id/edit' do
        if !logged_in?
            redirect "/login"
        end
        @role = session[:role]
        if @role == "admin"
            @users = User.find_by(params[:id])
            erb :"users/edit"
        else
            redirect "/login"
        end
    end
    
    patch '/users/:id' do

        @users = User.find_by(params[:id])

        if !logged_in?
            redirect "/login"
        end
        @role = session[:role]
        if @role == "admin"
            @users.update(params[:id]).permit(:email, :password, :role)
            redirect "/users/:id"    
        else
            redirect "/login"
        end
    end

    delete '/users/:id' do
        
        @users = User.find_by(params[:id])

        if !logged_in?
            redirect "/login"
        end
        @role = session[:role]
        if @role == "admin"
            @users.destroy_by(params[:id])
            redirect "/users/:id"    
        else
            redirect "/login"
        end
    end

end
