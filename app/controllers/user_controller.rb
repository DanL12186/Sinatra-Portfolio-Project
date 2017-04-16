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
    redirect '/login?error=Please fill in all fields' if required_field_empty?
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      redirect "/login?error=User_authenication_failed"
    end
  end

  post '/signup' do #signup user with valid username/pwd if username doesn't already exist. Doesn't check email validity; outside scope of lab.
    redirect '/signup?error=Please_fill_out_all_fields_and_use_valid_password' if required_field_empty? || invalid_password? || existing_username?
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect "/users/#{@user.slug}" #redirects to user's page
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get "/users/:slug" do #finds user by slug and renders userpage, unless user unauthorized
    @user = User.find_by_slug(params[:slug])
    session[:user_id] == @user.id ? (erb :"/users/userpage") : (redirect_if_not_logged_in)
  end

end
