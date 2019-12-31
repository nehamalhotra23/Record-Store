require('sinatra')
# require('sinatra/reloader')
# require ("bundler/setup")
# also_reload('lib/**/*.rb')

get ('/') do
  "This will be our home page. '/' is always the root route in a Sinatra application."
end

get ('/albums') do
  "This route will show a list of all albums."
end

get ('/albums/new') do
  "This will take us to a page with a form for adding a new album."
end

get ('/albums/:id') do
  "This route will show a specific album based on its ID. The value of ID here is #{params[:id]}."
end

post ('/albums') do
  "This route will add an album to our list of albums. We can't access this by typing in the URL. In a future lesson, we will use a form that specifies a POST action to reach this route."
end
