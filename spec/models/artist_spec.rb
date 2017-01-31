require 'rails_helper'

RSpec.describe Artist do

  it 'Each artist has a name' do
    artist = Artist.create(name: "David Bowie")
    expect(artist.name).to eq("David Bowie")
  end

  it 'An artist can have many albums' do
    artist = Artist.create(name: "David Bowie")
    artist.albums << Album.new(name: "Black Star")
    expect(artist.albums.count).to eq(1)
  end



end
