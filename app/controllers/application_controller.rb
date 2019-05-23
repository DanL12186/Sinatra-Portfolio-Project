require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "stealthispwdsecret"
  end

  get '/' do
    @user = User.find_by(session[:user_id])
    erb :index
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def required_field_empty?
      params.any? { |param| param[1].empty? } #this can get snagged on an empty splat.
    end

    def invalid_password? #ensures user entered an alphanumeric mixed-case pwd with a symbol. If this returns true, page will reload without explanation.
      pwd = params[:password] #password is in plaintext at this juncture...
      pwd.length < 10 || !pwd.match(/[A-Z]/) || !pwd.match(/[a-z]/) || !pwd.match(/\d/) || !pwd.match(/[~!()}\$@\#{%^&*]/)
    end

    def existing_username?
      User.all.include?(params[:username])
    end
  end
end
