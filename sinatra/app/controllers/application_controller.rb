class ApplicationController < Sinatra::Base

  configure do
    # What folders to use
    set :public_folder, 'public'
    set :views, 'app/views'

    # Blog stuff
    set :blog_name,        ENV['BLOG_NAME']        || '642 Site'
    set :blog_description, ENV['BLOG_DESCRIPTION'] || 'The 642 Blog!!'
    set :author_name,      ENV['AUTHOR_NAME']      || 'The Admin'

    # This has a vulnerability, weak session_secret
    enable :sessions
    set    :session_secret, "secret"
    set    :environment, :production
  end

  Time::DATE_FORMATS[:my_datetime] = "%Y-%m-%d Hour: %H Minute: %M Second: %S"

  get '/' do
    #session[:greeting] = "Hello World"
    #response.set_cookie 'credit_amount', '100'
    erb :"home/index"
    #Time.now.to_s(:my_datetime)
  end

  get '/remember' do
    "You have #{request.cookies['credit_amount']} left in your account"
  end

  get '/manage' do
    @role = session[:role]
    @users = User.all
    if @role == "admin"
      erb :"manage/index"
    else
      "You are not an admin!"
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email]) if session[:email]
    end

    def login(email, password)
      user = User.find_by(:email => email) 
      if user && user.authenticate(password)
          session[:email] = user.email
          session[:role] = user.role
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
      # Emailing them to let them know they logged out
    end

  end

  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end

  def link(url='')
    request.base_url + "/" + url
  end

end
