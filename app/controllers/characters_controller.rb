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

end
