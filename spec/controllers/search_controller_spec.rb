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
      @song1 = Song.create(name: "I've Been Waiting")
      @song2 = Song.create(name: "Dream River")
      @song3 = Song.create(name: "A River Runs Through It")
      @song4 = Song.create(name: "Thirteen Songs")
      @song5 = Song.create(name: "Waiting Room")
    end


  describe "#search" do

    it "Responds to JSON requests" do
      post :search, {:q => {:search_opts=>"default", :query_string => "whut"}, :format=>:json}
      expect(response.content_type).to eq("application/json")
    end

    it "Responds with 200 status code " do
      post :search, {:q => {:search_opts=>"default", :query_string => "whut"}, :format=>:json}
      expect(response.status).to eq(200)
    end

  end




  
end