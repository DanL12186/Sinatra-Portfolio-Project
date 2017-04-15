class BooksController < ApplicationController

  get '/new_book' do #renders book creation page unless not logged in
    logged_in? ? (erb :'/books/new') : (redirect "/login")
  end

  post '/books' do
    redirect '/new_book' if required_field_empty?
    @book = Book.create(author: params[:author], title: params[:title], user_id: current_user.id)
    redirect "/users/#{User.find(current_user.id).slug}" #didn't really feel like having to create @user
  end

  get '/books/show' do #render book show page unless not logged in
    if logged_in?
      @user = User.find(current_user.id)
      erb :'books/show'
    else
      redirect '/login'
    end
  end

  get '/books/:id/edit' do
    @book = Book.find(params[:id])
    erb :'/books/edit'
  end

  post '/books/:id/edit' do
    @book = Book.find(params[:id])
    redirect "/books/#{@book.id}/edit" if params[:author].empty? || params[:id].empty?
    @book.update(title: params[:title], author: params[:author])
    redirect "/books/show"
  end
end
