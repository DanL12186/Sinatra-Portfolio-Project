class CharactersController < ApplicationController

  get '/new_character' do
    logged_in? ? (erb :'/characters/new') : (redirect "/login")
  end

  post '/characters' do #handles char creation
    Character.create(params) #both creates and associates char w/book through id (name="book_id"). Adds any new character added to char array.
  end
end
