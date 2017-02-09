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

  it 'Correctly associates artists & songs' do
    @album.artist = Artist.create(name: Faker::Commerce.product_name)
    song = Song.create(name: Faker::Commerce.product_name)
    @album.songs << song
    @album.save
    expect(@album.songs.first.artist).to eq(@album.artist)
  end

  context "Basic search" do

    it 'The model has a search method' do
      expect(Album.respond_to?(:search)).to be(true)
    end

    it "It accepts a string" do
      expect(Album.search("whut")).to be_truthy
    end

    it "It returns an array of Album objects" do
      Album.create([
          {name: "A Moon-Shaped Pool"},
          {name: "Marquee Moon"}
        ])

      search = Album.search('head')
      expect(search).to be_an(Array)
      expect(search.length).to eq(2)
    end



    it "The search method returns the correct results" do 
      @album1 = Album.create(name: "Teenage Daydream")
      @album2 = Album.create(name: "Dream River")
      @album3 = Album.create(name: "A River Runs Through It")
      @album4 = Album.create(name: "Thirteen Songs")

      search1 = Album.search("dream")
      search2 = Album.search("teen")
      search3 = Album.search("river")

      expect(search1.length).to eq(2)
      expect(search1.include?(@album4)).to be(false)

      expect(search2.length).to eq(2)
      expect(search2.include?(@album2)).to be(true)

    end

    it "It can process multiple keywords" do
      Album.create([
          {name: "The Blueprint"},
          {name: "Nina Sings the Blues"},
          {name: "Black Messiah"},
          {name: "When Disaster Strikes"}
        ])
      keywords="blue, messiah"
      search = Artist.search(keywords)
      expect(search.length).to eq(3)
      expect(search.include?(Album.find_by(name: "When Disaster Strikes"))).to be(false)
    end

  end
  
end
