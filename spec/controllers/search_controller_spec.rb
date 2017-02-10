require 'rails_helper'
require 'capybara/rails'

RSpec.describe SearchController do 
  before :all do
      @album1 = Album.create(name: "Teenage Daydream")
      @album2 = Album.create(name: "Dream River")
      @album3 = Album.create(name: "A River Runs Through It")
      @album4 = Album.create(name: "Thirteen Songs")
      @artist1 = Artist.create(name: "beach boys")
      @artist2 = Artist.create(name: "beastie boys")
      @artist3 = Artist.create(name: "boys II men")
      @artist4 = Artist.create(name: "beach house")
      @artist5 = Artist.create(name: "The Dreamers")
      @song1 = Song.create(name: "I've Been Waiting")
      @song2 = Song.create(name: "Dream River")
      @song3 = Song.create(name: "A River Runs Through It")
      @song4 = Song.create(name: "Thirteen Songs")
      @song5 = Song.create(name: "Waiting Room")
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

    it "Returns the correct objects for default search" do
      post :search, params: {:q=> {:search_opts=>"default", :query_string => "dream"}}, :format=>:json
      results=JSON.parse(response.body)

      expect(results["songs"].any?{|song| song["name"] == "Dream River"}).to be(true)
      expect(results["songs"].any?{|song| song["name"] == "Teenage Daydream"}).to be(false)
      expect(results["albums"].any?{|album| album["name"] == "Teenage Daydream"}).to be(true)  
    end

    it "Searches the correct tables for inclusive search" do
      post :search, params: {:q=> {:search_opts=>"custom", :query_string => "dream", :includes=>["artist", "song"]}}, :format=>:json
      results=JSON.parse(response.body)
byebug
      expect(results.length).to eq(2)
      expect(results["albums"]).to be(nil)
      expect(results["songs"])
    end


  end




  
end