require 'rails_helper'

RSpec.describe Song do
  before :each do
    @song = Song.new(name: Faker::Commerce.product_name)
  end

  it 'song can be persisted with only a name' do
    expect(@song.save).to_not eq(false)
  end

  it 'Can be associated to an artist' do
    @song.artist = Artist.create(name: "Black Star")
    @song.save
    expect(@song.artist).to_not be(nil) 
  end

  it 'Has a search method' do
    expect(Song.respond_to?(:search)).to be(true)
  end


end
