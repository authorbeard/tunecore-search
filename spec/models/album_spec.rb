require 'rails_helper'

RSpec.describe Album do
  before :each do 
    @album = Album.new(name: Faker::Name.name)
  end

  it 'Album can be persisted with only a name' do
    expect(@album.save).to_not eq(false)
  end

  it 'Can be associated to an artist' do
    @album.artist = Artist.create(name: "Black Star")
    @album.save
    expect(@album.artist).to_not be(nil) 
  end

  it 'Can have songs' do
    10.times{ Song.create(name: Faker::Commerce.product_name)}
    @album.songs << Song.all
    @album.save
    expect(@album.songs.count).to eq(10)
  end

  it 'An album can have many songs' do
    10.times{ Song.create(name: Faker::Name.name)}
    Song.all.each{|s|
      s.album = @album
      s.save
    }
    expect(@album.songs.count).to eq(10)
  end


  
end
