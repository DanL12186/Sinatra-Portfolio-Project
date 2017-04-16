class CharactersController < ApplicationController

  get '/new_character' do
    logged_in? ? (erb :'/characters/new') : (redirect "/login")
  end

  post '/characters' do #handles char creation
    redirect '/new_character' if required_field_empty?
    Character.create(params) #both creates and associates char w/book through id (name="book_id"). Adds any new character added to char array.
    redirect '/characters/show'
  end

  get '/characters/show' do #points to character show page which displays all characters a user has across all his/her books.
    erb :'/characters/show'
  end

  get '/characters/:id/edit' do
    @character = Character.find(params[:id])
    erb :'/characters/edit'
  end

  post '/characters/:id/edit' do
    @character = Character.find(params[:id])
    binding.pry
    redirect "/books/#{@book.id}/edit" if params[:name].empty? || params[:book_id].empty?
    @character.update(name: params[:name], book_id: params[:book_id])
    redirect 'characters/show'
  end

  delete '/characters/:id/delete' do
    @character = Character.find(params[:id])
    book_id = @character.book_id
    @character.delete
    redirect '/books/#{book_id}/view_book'
  end

end
