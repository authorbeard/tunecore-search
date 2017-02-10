require 'rails_helper'
require 'capybara/rails'

RSpec.describe SearchController do 
  before :all do
      @artist1 = Artist.create(name: "beach boys")
      @artist2 = Artist.create(name: "beastie boys")
      @artist3 = Artist.create(name: "boys II men")
      @artist4 = Artist.create(name: "beach house")
      @artist5 = Artist.create(name: "The Dreamers")
      @album1 = Album.create(name: "Teenage Daydream")
      @album2 = Album.create(name: "Dream River")
      @album3 = Album.create(name: "A River Runs Through It")
      @album4 = Album.create(name: "Thirteen Songs")
      @song1 = Song.create(name: "I've Been Waiting")
      @song2 = Song.create(name: "Dream River")
      @song3 = Song.create(name: "A River Runs Through It")
      @song4 = Song.create(name: "Thirteen Songs")
      @song5 = Song.create(name: "Waiting Room")
      @song6 = Song.create(name: "Beach Boys Song")
    end


  describe "#search" do

    it "Responds to JSON requests" do
      post :search, params: {:q=>{:search_opts=>"default", :query_string => "whut"}}, :format=>:json
      expect(response.content_type).to eq("application/json")
    end

    it "Responds with 200 status code to legitimate posts" do
      post :search, params: {:q=> {:search_opts=>"default", :query_string => "whut"}}, :format=>:json
      expect(response.status).to eq(200)
    end

    it "sends a 400 if it gets sent bad params" do
      post :search, params: {:q=>{:bad_param=>"bad"}}
      expect(response.status).to eq(400)
    end

    it "Returns the correct objects for default search" do
      post :search, params: {:q=> {:search_opts=>"default", :query_string => "dream"}}, :format=>:json
      results=JSON.parse(response.body)
      expect(results.length).to eq(1)
    end

    it "Includes songs by matching artists in default search" do
      @artist6 = Artist.create(name: "Dream Theater")
      @artist6.albums << Album.create(name: "Epic Rock Nonsense")
      @artist6.albums.first.songs << Song.create(name: "Silent Lucidity Is All I Remember")
      @artist6.save

      post :search, params: {:q=> {:search_opts=>"default", :query_string => "dream"}}, :format=>:json
      results = JSON.parse(response.body)

      expect(results.length).to eq(2)
      expect(results.all?{|song| song["name"].downcase.include?("dream")}).to be(false)
    end

    it "Includes songs from matching albums in default search" do
      @album4.songs << Song.create(name: "Waiting Room")
      @album4.save

      post :search, params: {:q=> {:search_opts=>"default", :query_string => "thirteen"}}, :format=>:json
      results = JSON.parse(response.body)

      expect(results.length).to eq(2)
      expect(results.all?{|song| song["name"].downcase.include?("thirteen")}).to be(false)
    end

    it "Doesn't include any artists or albums when there are no matches" do
      post :search, params: {:q=> {:search_opts=>"default", :query_string => "through"}}, :format=>:json
      results = JSON.parse(response.body)

      expect(results.length).to eq(1)
      expect(results.any?{|r| r["album"] != nil }).to be(false)
    end

    it "Searches the correct tables for inclusive search" do
      post :search, params: {:q=> {:search_opts=>"custom", :query_string => "dream", :includes=>["artist", "song"]}}, :format=>:json
      results=JSON.parse(response.body)

      expect(results.length).to eq(1)
      expect(results.none?{|r| r['album'] != nil }).to be true

      @album3.songs << @song1
      @artist5.albums << @album3
      @artist5.save

      post :search, params: {:q=> {:search_opts=>"custom", :query_string => "dream", :includes=>["artist", "song"]}}, :format=>:json
      results=JSON.parse(response.body)

      expect(results.length).to eq(2)
      expect(results.none?{|r| r['album'] != nil }).to be false
    end

    it "Correctly narrows queries by artist or by album" do
      @album1.songs << @song1
      @artist1.albums << @album1
      @artist1.save

      @album4.songs << @song5
      @artist4.albums << @album4
      @artist4.save

      post :search, params: {:q=> {:search_opts=>"custom", :query_string => "waiting", :narrow_by=>"artist", :narrow_query=>"beach boys"}}, :format=>:json
      results = JSON.parse(response.body)

      expect(results.length).to eq(1)
      expect(results.first['name']).to eq("I've Been Waiting")
      expect(results.first['name']).to_not eq("Waiting Room")
      
      post :search, params: {:q=> {:search_opts=>"custom", :query_string => "waiting", :narrow_by=>"album", :narrow_query=>"thirteen songs"}}, :format=>:json
      results = JSON.parse(response.body)

      expect(results.length).to eq(1)
      expect(results.first['name']).to eq("Waiting Room")

    end

  end




  
end