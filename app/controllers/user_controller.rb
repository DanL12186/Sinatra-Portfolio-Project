class UsersController < ApplicationController

  get '/login' do #login request
    erb :"/users/login"
  end

  get '/signup' do
    erb :"/users/new_user"
  end

end
