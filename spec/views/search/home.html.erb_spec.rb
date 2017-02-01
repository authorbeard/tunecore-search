require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb" do

  before :each do
    visit home_path
  end

  it "Welcomes the User" do
    expect(page).to have_content("Welcome to Tunecore Search") 
  end

  context "It has a responsive grid layout" do
    it "renders page contents inside a container" do
      expect(page).to have_css('div.container')
    end

    it "renders the search form inside the container" do
      expect(page).to have_css('.container form.search-form')
    
    end
  end



  




end
