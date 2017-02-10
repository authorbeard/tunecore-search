require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb", :js => true do 
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
    @album1.songs << @song1
    @artist1.albums << @album1
    @artist1.save
    @album4.songs << @song5
    @artist4.albums << @album4
    @artist4.save
  end

    describe "Executing Searches" do  
      before :each do
        visit home_path
      end

      it "Displays the search results div after user submits query" do
        expect(page).to_not have_content('Search Results:')
        fill_in('q_query_string', :with=>"whut")
        click_on("Search")
        expect(page).to have_content('Search Results:')

      end

      it "Displays album, title and artist information for matches" do
        fill_in('q_query_string', :with=>"dream")
        click_on("Search")
        expect(page.all('div.results p').count).to eq(9)

      end
    end



  
end