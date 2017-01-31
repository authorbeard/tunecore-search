require 'rails_helper'

RSpec.describe Artist do

  before :each do
    @artist = Artist.create(name: Faker::Name.name)
  end

  it 'Each artist has a name' do
    expect(@artist.name).to_not eq(nil)
  end

  it 'An artist can have an album' do
    # artist = Artist.create(name: "David Bowie")
    @artist.albums << Album.new(name: "Black Star")
    expect(@artist.albums.count).to eq(1)
  end

  it 'An artist can have many albums' do
    # artist=Artist.create(name: Faker::Name.name)
    10.times{ Album.create(name: Faker::Name.name)}
    Album.all.each{|a| 
      @artist.albums << a
      @artist.save
      }
    expect(@artist.albums.count).to eq(10)
  end

  it 'An artist can have many songs' do
    assert false
  end




end
