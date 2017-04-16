class UsersController < ApplicationController

  get '/login' do #login request; redirects logged in users, otherwise renders login page
    if logged_in?
      @user = User.find(session[:user_id])
      redirect "/users/#{@user.slug}"
    else
      (erb :"/users/login")
    end
  end

  get '/signup' do
    logged_in? ? (redirect '/') : (erb :"/users/new_user")
  end

  post '/login' do #handles login submission form. Rejects empty or unauthorized password/username combos.
    redirect '/login' if required_field_empty?
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  post '/signup' do #signs up a user with valid username and password if username doesn't already exist. Doesn't check email validity; outside the scope of lab.
    redirect '/signup' if required_field_empty? || invalid_password? || existing_username?
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect "/users/#{@user.slug}" #redirects to user's page
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get "/users/:slug" do #finds user by slug and renders userpage
    @user = User.find_by_slug(params[:slug])
    erb :"/users/userpage"
  end

end
