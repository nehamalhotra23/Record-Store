require('sinatra')
# require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
require("pg")
# also_reload('lib/**/*.rb')


DB = PG.connect({:dbname => "record_store_test"})

get('/') do
  Album.clear()
  redirect to('/albums')
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


post ('/albums') do
 name = params[:album_name]
 album = Album.new({:name => name, :id => nil})
 album.save()
 @albums = Album.all() #
 redirect to('/albums')
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end


patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.all
  redirect to ('/albums')
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  redirect to('/albums')
end

# Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name], :album_id => @album.id, :id => nil})
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
