require 'rails_helper'

RSpec.describe Artist do

  before :each do
    @artist = Artist.new(name: Faker::Name.name)
  end

  it 'Artist can be persisted' do
    expect(@artist.save).to_not eq(false)
  end

  it 'An artist can have an album' do
    @artist.albums << Album.create(name: "Black Star")
    @artist.save
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

  context "Basic search" do

    it 'The model has a search method' do
      expect(Artist.respond_to?(:search)).to be(true)
    end

    it "It accepts a string" do
      expect(Artist.search("whut")).to be_truthy
    end

    it "It returns an array of objects" do
      keywords=["zeppelin", "jay-z", "kanye"]
      expect(Artist.search(keywords)).to be_an(Array)
      expect(Artist.search("bea")).to be_an(Array)
    end

    it "The search method returns the correct results" do 
      @artist1 = Artist.create(name: "beach boys")
      @artist2 = Artist.create(name: "beastie boys")
      @artist3 = Artist.create(name: "boys II men")
      @artist4 = Artist.create(name: "beach house")

      search1 = Artist.search("bea")
      search2 = Artist.search("boys")
      search3 = Artist.search("beach")

      expect(search1.length).to eq(3)
      expect(search2.length).to eq(3)
      expect(search3.length).to eq(2)
      expect(search1.include?(@artist3)).to be(false)

    end

    it "It can process multiple keywords" do
      keywords=["zeppelin", "jay-z", "kanye"]
      expect(Artist.search(keywords)).to_not raise_error
    end

  end








end
