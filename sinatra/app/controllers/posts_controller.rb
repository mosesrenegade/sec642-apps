class PostsController < ApplicationController

    get '/posts' do
        @post = Post.all
        erb :"posts/index"
    end

    get '/posts/new' do
        @post
        # Checking if they are logged in 
        if !logged_in?
            redirect "/login" # Redirect if they aren't
        else
            erb :"posts/new" # Rendering here
        end
    end

    get '/posts/:id' do
        @post = Post.find_by_id(params["id"])
        @post.title = params["title"]
        erb :'posts/show'
    end

    get '/posts/:id/edit' do
        # Checking if they are logged in 
        if !logged_in?
            redirect "/login" # Redirect if they aren't
        else
            if post = current_user.posts.find_by(params[:id])
                "A edit post form #{current_user.id} is editing #{post.id}" # Rendering here
            else
                redirect '/posts'
            end
        end
    end

    post '/posts' do
        @post = Post.new
        @post.title = params["title"]
        @post.content = params[:content]
        @post.user_id = current_user[:id]
        if !logged_in?
            redirect "/login"
        else @post.save 
            redirect '/posts'
        end
    end
      
    #  get '/projects/:id' do |id|
    #    DB[:projects].where(id: id).first.to_json
    #  end
      
    #  put '/projects/:id' do |id|
    #    DB[:projects].where(id: id).update(name: params[:name], description: params[:description], site: params[:site])
    #    DB[:projects].where(id: id).first.to_json
    #  end
      
    #  delete '/projects/:id' do |id|
    #    DB[:projects].where(id: id).delete
    #   '{"status": "success"}'
    # end

end
