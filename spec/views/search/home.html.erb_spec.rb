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

    it "Renders the search form inside the container" do
      expect(page).to have_css('.container form')
    end

    it "Labels the form clearly" do
      expect(page).to have_css('div.container form#search-form')
    end

    it "Has a form group for the search box & label" do
      search = page.find('.container form#search-form')
      expect(search).to have_css('div.form-group')
    end

    it "Places the form group in a row" do
      search = page.find('div.container form#search-form')
      expect(search).to have_css('.form-group.row')
    end

    it "Labels the search-box clearly" do
      expect(page).to have_css('form#search-form div#search-box')
    end


  end



  




end
