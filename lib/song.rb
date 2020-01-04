class Song
  attr_reader :id
  attr_accessor :name, :album_id

  def initialize(attributes)
   @name = attributes.fetch(:name)
   @album_id = attributes.fetch(:album_id)
   @id = attributes.fetch(:id)
 end

  def ==(song_to_compare)
    if song_to_compare != nil
    (self.name() == song_to_compare.name()) && (self.album_id() == song_to_compare.album_id())
  else
    false
  end
  end

  def self.all
    @@songs.values
  end

  def save
   result = DB.exec("INSERT INTO songs (name, album_id) VALUES ('#{@name}', #{@album_id}) RETURNING id;")
   @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    song = DB.exec("SELECT * FROM songs WHERE id = #{id};").first
    if song
      name = song.fetch("name")
      album_id = song.fetch("album_id").to_i
      id = song.fetch("id").to_i
      Song.new({:name => name, :album_id => album_id, :id => id})
    else
      nil
    end
  end

  def update(name, album_id)
    self.name = name
    self.album_id = album_id
    @@songs[self.id] = Song.new(self.name, self.album_id, self.id)
  end

  def delete
    @@songs.delete(self.id)
  end

  def self.clear
    @@songs = {}
  end

  def self.find_by_album(alb_id)
    songs = []
    @@songs.values.each do |song|
      if song.album_id == alb_id
        songs.push(song)
      end
    end
    songs
  end
  def album
    Album.find(self.album_id)
  end
end
