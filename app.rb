require('sinatra')
# require('sinatra/reloader')
require('./lib/album')
require('pry')
# also_reload('lib/**/*.rb')

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums/new') do
  erb(:new_album)
end

get ('/albums/:id') do
  "This route will show a specific album based on its ID. The value of ID here is #{params[:id]}."
end

post ('/albums') do
   binding.pry
end
