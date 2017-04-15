class BooksController < ApplicationController

  get '/new_book' do
    erb :'/books/new'
  end

  post '/books' do
    @book = Book.create(author: params[:author], title: params[:title], user_id: current_user.id)
    redirect "/users/#{User.find(current_user.id).slug}" #didn't really feel like having to create @user just to set user_id
  end
end
