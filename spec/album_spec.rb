require 'rspec'
require 'album'
require 'song'


describe '#Album' do
  # before(:each) do
  #   Album.clear()
  # end

  describe('.all') do
    # Note that the class method all() is preceded by a .
    it("returns an empty array when there is no album") do
        expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    # Note that the instance method save() is preceded by a #.
    it("saves an album") do
     album = Album.new("Giant Steps", nil) # nil added as second argument
      album.save()
      album2 = Album.new("Blue", nil) # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end
  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", nil)
      album2 = Album.new("Blue", nil)
      expect(album).to(eq(album2))
    end
  end
  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new("Giant Steps", nil)
      album.save()
      song = Song.new("Naima", album.id, nil)
      song.save()
      song2 = Song.new("Cousin Mary", album.id, nil)
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end
end




# [ 1, 2, 3 ].map { |e| e + 1 }      # preferred
# [ 1, 2, 3 ].map do |e| e + 1 end   # acceptable
