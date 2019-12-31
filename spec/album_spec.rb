require 'rspec'
require 'album'

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
end
