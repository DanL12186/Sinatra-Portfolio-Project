require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "stealthispasswordsecret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def required_field_empty?
      params.any? {|param| param[1].empty?}
    end

    def invalid_password?
      password = params[:password]
      password.length < 10 || !password.include?(/[A-Z]/) || !password.include?(/[\d]/) || !password.include?(/[~!()}\$@\#{%^&*]/)
    end

    def existing_username?
      User.all.include?(params[:username])
    end
  end
end
