require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb" do

  before :each do
    visit home_path
  end

  it "renders all page contents inside a container" do
    expect(page.all('body > *').length).to eq(1)
  end

  it "Has a div to display search terms and a form for the search options" do
    container_contents = page.all('div.container > *')
    expect(container_contents.length).to eq(2)
    expect(container_contents[1]).to have_selector('div#search-terms')
    expect(container_contents[2]).to have_selector('form')
  end




  context "Query Input field & label" do
    it "Groups input field, label & button in a form-group" do
      search = page.find('.container form#search-form')
      expect(search).to have_css('div.form-group')
    end

    it "Places the form group in a row" do
      search = page.find('div.container form#search-form')
      expect(search).to have_css('.row')
    end

    context "Label" do
      it "Has a label element for the keyword input field" do
        search = page.find('div#search-input-group')
        expect(search).to have_css('label', :count => 1)
      end

      it "The label always stacks atop the search box" do
        search = page.find('div#search-input-group')
        expect(search).to have_css('label.col-xs-4.col-form-label')
      end

      it "The label refers to the keyword input field box" do
        label = page.find('label[for=query-string]')
        expect(label).to have_content("Search terms:")
      end
    end

    context "Search Box" do
      it "Places the search input field in its own responsive column" do
        search = page.find('div#search-input-group')
        expect(search).to have_css('div.col-xs-10#search-box')
      end

      it "Renders the search box as an input element inside the div" do
        search = page.find('div#search-box')
        expect(search).to have_css('input')
      end

      it "Classifies the input field for form-control" do
        search = page.find('div#search-box')
        expect(search).to have_css('input.form-control')
      end

      it "Identifies the search-box as referring to the query-string" do
        search = page.find('div#search-box')
        expect(search).to have_css('input[for=query-string]')
        expect(search).to have_css('#query-string')
      end

      it "Has some placeholder text" do
        # search=page.find('input.form-control')
        expect(page).to have_selector("input[placeholder='Enter your search text here']")
      end
    end

    context "Search Button" do 
      it "The page has one submit button" do
        search = page.find("div#search-input-group")
        expect(search).to have_css("button[type=submit]", :count=>1)
      end

      it "The button is not in the same row as the input field" do
        search = page.find("div#search-input-group")
        expect(search.has_no_button?).to be(true)
      end

      it "The button is in its own row" do
        search = page.find("div.form-group")
        expect(search.inspect[1]).to be("div.form-group")
        expect(search.inspect[1].has_button?).to be(true)
      end
    end

    context "Search Options" do
      it "Has search options" do
        expect(page).to have_selector("fieldset", :count=>1)
      end

      it "Informs the user that there are options for the search" do
        opts = page.find("fieldset")
        expect(opts).to have_selector("legend")
        expect(opts.find("legend")).to have_content
      end

      it "Does not display options unless a button is clicked" do
        opts = page.find("fieldset div#search-options")
        expect(page).to have_selector("div#search-options", :visible => false)
      end

      it "Has a button to display search options" do
        expect(page).to have_css("i.fa-plus-circle")
      end 

      it "Defaults to search across Song, Artist & Album names" do
        page.click_on("i.fa-plus-circle")
        expect(page).to have_selector("div#search-options", :visible => true)
      end 

    end

  end







  




end
