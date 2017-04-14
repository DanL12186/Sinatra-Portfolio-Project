class UsersController < ApplicationController

  get '/login' do #login request
    erb :"/users/login"
  end

  get '/signup' do
    erb :"/users/new_user"
  end

  post '/login' do #handles login submission form. Rejects empty or unauthorized password/username combos.
    redirect '/login' if required_field_empty?
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id if @user.authenticate(params[:password])
      redirect "/users/:slug"
    else
      redirect '/login'
    end
  end

  get "/users/:slug" do
    @user = find_by_slug(params[:slug])
    erb :"/users/userpage"
  end

end
