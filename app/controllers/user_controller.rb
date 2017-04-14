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

  post '/signup' do #signs up a user with valid username and password if username doesn't already exist. Doesn't check email validity; outside the scope of lab.
    redirect '/signup' if required_field_empty? || invalid_password? || existing_username?
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect "/users/userpage"
  end

  get "/users/:slug" do #finds user by slug and renders userpage
    @user = User.find_by_slug(params[:slug])
    erb :"/users/userpage"
  end

end
