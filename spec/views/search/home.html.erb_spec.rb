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

    context "Query Input field & label" do
      it "Has a form group for the search box & label" do
        search = page.find('.container form#search-form')
        expect(search).to have_css('div.form-group')
      end

      it "Places the form group in a row" do
        search = page.find('div.container form#search-form')
        expect(search).to have_css('.form-group.row')
      end

      context "Label" do
        it "Has a label element for the keyword input field" do
          search = page.find('div#search-input-group')
          expect(search).to have_css('label', :count => 1)
        end

        it "The label has responsive classes for column, field reference" do
          search = page.find('div#search-input-group')
          expect(search).to have_css('label.col-xs-2.col-form-label')
          expect(search).to have_css('label[for=query-terms]', :count=>1)
        end

        it "The label refers to the keyword input field box" do
          label = page.find('label[for=query-terms]')
          expect(label).to have_content("Search terms:")
        end
      end
        
      context "Search Box" do
        it "Places the search input field in its own responsive column" do
          search = page.find('div#search-input-group')
          expect(search).to have_css('div.col-xs-10#search-box')
        end

        it "Renders the search box as an input element" do
          expect
        end
      end

    end



  end



  




end
