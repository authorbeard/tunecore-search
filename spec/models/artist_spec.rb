require 'rails_helper'

RSpec.describe Artist do

  before :each do
    @artist = Artist.create(name: Faker::Name.name)
  end

  it 'Each artist has a name' do
    expect(@artist.name).to_not eq(nil)
  end

  it 'An artist can have an album' do
    @artist.albums << Album.create(name: "Black Star")
    expect(@artist.albums.count).to eq(1)
  end

  it 'An artist can have many albums' do
    10.times{ Album.create(name: Faker::Name.name)}
    Album.all.each{|a| 
      @artist.albums << a
      @artist.save
      }
    expect(@artist.albums.count).to eq(10)
  end

  it 'An artist can have many songs' do
    10.times{ Song.create(name: Faker::Name.name)}
    Song.all.each{|s|
      s.artist = @artist
      s.save
    }
    expect(@artist.songs.count).to eq(10)
  end

  it 'can return an array of artist names' do
    expect(Artist.all_names.count).to_not eq(0)
  end






end
