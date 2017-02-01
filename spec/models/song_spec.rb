require 'rails_helper'

RSpec.describe Song do
  before :each do
    @song = Song.new(name: Faker::Commerce.product_name)
  end

  it 'song can be persisted with only a name' do
    expect(@song.save).to_not eq(false)
  end

  it 'Can be associated to an artist without an album' do
    @song.artist = Artist.create(name: "Black Star")
    @song.save
    expect(@song.artist).to_not be(nil) 
  end

  it 'Can have songs' do
    10.times{ Song.create(name: Faker::Commerce.product_name)}
    @song.songs << Song.all
    @song.save
    expect(@song.songs.count).to eq(10)
  end

  it 'Correctly associates artists & songs' do
    @song.artist = Artist.create(name: Faker::Commerce.product_name)
    song = Song.create(name: Faker::Commerce.product_name)
    @song.songs << song
    @song.save
    expect(@song.songs.first.artist).to eq(@album.artist)
  end
end
