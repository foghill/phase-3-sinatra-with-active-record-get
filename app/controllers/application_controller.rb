class ApplicationController < Sinatra::Base

  # Add this line to set the Content-Type header for all responses
set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # get all the games from the database
    games = Game.all.order(:title).limit(10)
    # return a JSON response with an array of all the game data
    games.to_json
end

#use the :id syntac to create a dynamic route
get '/games/:id' do
  # look up the game in the databae using its ID
  game=Game.find(params[:id])
  #send a JSON-formatted response of the game data
  #game.to_json
  #include associated reviews in the JSON response
  game.to_json(include: { reviews: { include: :user } })
end


end