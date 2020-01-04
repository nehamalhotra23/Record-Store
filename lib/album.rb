class Album
   attr_accessor :name
   attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
  returned_albums = DB.exec("SELECT * FROM albums;")
  albums = []
  returned_albums.each() do |album|
    name = album.fetch("name")
    id = album.fetch("id").to_i
    albums.push(Album.new({:name => name, :id => id}))
  end
  albums
end

def save
 result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
 @id = result.first().fetch("id").to_i
end

def self.clear
  DB.exec("DELETE FROM albums *;")
end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    if album
    name = album.fetch("name")
    id = album.fetch("id").to_i
    Album.new({:name => name, :id => id})
  else
    nil
  end
  end

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
  end

def delete
  DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};") # new code

end

# def self.search(search_term)
#   @@albums.select{|key, value| value.name =~/#{search_term}/}.values
# end
#
def songs
   Song.find_by_album(self.id)
 end
end
