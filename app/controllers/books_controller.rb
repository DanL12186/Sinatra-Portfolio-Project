class BooksController < ApplicationController

  get '/new_book' do #renders book creation page unless not logged in
    logged_in? ? (erb :'/books/new') : (redirect "/login")
  end

  post '/books' do
    redirect '/new_book?error=Please_fill_out_all_fields' if required_field_empty?
    @book = Book.create(author: params[:author], title: params[:title], user_id: current_user.id)
    redirect "/users/#{User.find(current_user.id).slug}" #didn't really feel like having to create @user
  end

  get '/books/show' do #render book show page unless not logged in
    if logged_in?
      @user = User.find(current_user.id)
      erb :'books/show'
    else
      redirect_if_not_logged_in
    end
  end

  get '/books/:id/edit' do
    @book = Book.find(params[:id])
    erb :'/books/edit'
  end

  get '/books/:id/view_book' do
    @book = Book.find(params[:id])
    erb :'/books/view_book'
  end

  post '/books/:id/edit' do #handles book editing
    @book = Book.find(params[:id])
    redirect "/books/#{@book.id}/edit?error=Please_fill_out_all_fields" if params[:author].empty? || params[:id].empty? #made necessary by empty splat param
    @book.update(title: params[:title], author: params[:author])
    redirect "/books/show"
  end

  delete '/books/:id/delete' do #deletes all characters associated with a book, then deletes book.
    @book = Book.find(params[:id])
    @book.characters.each do |char|
      char.delete
    end
    @book.delete
    redirect "/books/show"
  end

end
