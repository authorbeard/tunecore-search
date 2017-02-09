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

  context "Basic search" do

    it 'The model has a search method' do
      expect(Song.respond_to?(:search)).to be(true)
    end

    it "It accepts a string" do
      expect(Song.search("whut")).to be_truthy
    end

    it "It returns an array of Album objects" do
      Song.create([
          {name: "A Moon-Shaped Pool"},
          {name: "Marquee Moon"}
        ])

      search = Song.search('moon')
      expect(search).to be_an(Array)
      expect(search.length).to eq(2)
    end



    it "The search method returns the correct results" do 
      @song1 = Song.create(name: "Teenage Daydream")
      @song2 = Song.create(name: "Dream River")
      @song3 = Song.create(name: "A River Runs Through It")
      @song4 = Song.create(name: "Thirteen Songs")

      search1 = Song.search("dream")
      search2 = Song.search("teen")
      search3 = Song.search("river")

      expect(search1.length).to eq(2)
      expect(search1.include?(@song4)).to be(false)

      expect(search2.length).to eq(2)
      expect(search2.include?(@song4)).to be(true)

    end

    it "It can process multiple keywords" do
      Song.create([
          {name: "The Blueprint"},
          {name: "Nina Sings the Blues"},
          {name: "Black Messiah"},
          {name: "When Disaster Strikes"}
        ])
      keywords="blue, messiah"
      search = Song.search(keywords)
      expect(search.length).to eq(3)
      expect(search.include?(Song.find_by(name: "When Disaster Strikes"))).to be(false)
    end

  end



end
