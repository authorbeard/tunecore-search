require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb" do

  before :each do
    visit home_path
  end

  context "General layout" do

    it "Renders all page contents inside a container" do
      expect(page.all('body > *').length).to eq(1)
      expect(page.find('body > *').tag_name).to eq('div')
    end

    it "Container has two main areas, a form and a div" do
      Capybara.ignore_hidden_elements = false
      expect(page.all('div.container > *').length).to eq(2)
      container_contents = page.all('div.container > *')
      expect(container_contents[0].tag_name).to eq('form')
      expect(container_contents[1].tag_name).to eq('div')
      expect(container_contents[2]).to be(nil)
      Capybara.ignore_hidden_elements = true
    end

    it "Does not display the search results div on initial load" do
      Capybara.ignore_hidden_elements = false
      expect(page).to have_selector('.container  div', :visible => false)
      Capybara.ignore_hidden_elements = true
    end
  end

  context "Search form" do

    it "Has a label and keyword search box on top" do
      search_box = page.all('form > div').first
      expect(search_box).to have_selector('label', :count=>1)
      expect(search_box).to have_selector('input[type=search]', :count=>1)
    end

    it "The label refers correctly to the search box" do
      label = page.find('div#search-input-group label')
      search_box = page.find('div#search-input-group input')
      expect(label['for']).to eq(search_box['id'])
    end

    it "The label has responsive features" do
      expect(page.find('div#search-input-group')).to have_selector('label.col-sm-4.col-form-label')
    end

    it "The search box refers to the correct value" do 
      search_box = page.find('div#search-input-group input')
      expect(search_box['id']).to eq('query-string')
    end

    it "The search box uses uses Bootstrap's responsive classes" do
      search_box = page.find('input#query-string')
      expect(search_box['class']).to eq('form-control')
    end
 
    it "The search box has placeholder text with additional instructions" do
      expect(page).to have_content('To look for multiple words/phrases, separate them with a comma.')
    end

    it "The Search has radio buttons for the main search options" do
      expect(page).to have_selector('input[type=radio]', :count=>2)
    end

    it "The search options are in a responsive group" do
      search_opts = page.find('div.form-group.row#search-options')
      expect(search_opts).to_not be(nil)
    end

    it 'Uses Bootstrap form-check grouping' do
      search_opts = page.all('div.form-check')
      expect(
        search_opts.all?{|el|
          expect(el).to have_selector('label input.form-check-input')
        })
        .to be(true)

    end

    it 'Groups search option radios on one line' do
      expect(page.find('div#search-options')).to have_selector('div.form-check-inline', :count=>2)
    end

    it "Loads with the default search button selected" do
      search_opts = page.all('div.form-check')
      expect(search_opts[0].has_css?('input[checked]')).to be(true)
      expect(search_opts[1].has_css?('input[checked]')).to be(false)
    end

  end

  context "Search results" do
    
    it "The Search Results section follows grid design pattern" do
      expect(page).to have_selector('.container div.row#search-results', :visible=>false)
    end

  end

end










  #     it "The label always stacks atop the search box" do
  #       search = page.find('div#search-input-group')
  #       expect(search).to have_css('label.col-xs-4.col-form-label')
  #     end

  #     it "The label refers to the keyword input field box" do
  #       label = page.find('label[for=query-string]')
  #       expect(label).to have_content("Search terms:")
  #     end
  #   end

  #   context "Search Box" do
  #     it "Places the search input field in its own responsive column" do
  #       search = page.find('div#search-input-group')
  #       expect(search).to have_css('div.col-xs-10#search-box')
  #     end

  #     it "Renders the search box as an input element inside the div" do
  #       search = page.find('div#search-box')
  #       expect(search).to have_css('input')
  #     end

  #     it "Classifies the input field for form-control" do
  #       search = page.find('div#search-box')
  #       expect(search).to have_css('input.form-control')
  #     end

  #     it "Identifies the search-box as referring to the query-string" do
  #       search = page.find('div#search-box')
  #       expect(search).to have_css('input[for=query-string]')
  #       expect(search).to have_css('#query-string')
  #     end

  #     it "Has some placeholder text" do
  #       # search=page.find('input.form-control')
  #       expect(page).to have_selector("input[placeholder='Enter your search text here']")
  #     end
  #   end

  #   context "Search Button" do 
  #     it "The page has one submit button" do
  #       search = page.find("div#search-input-group")
  #       expect(search).to have_css("button[type=submit]", :count=>1)
  #     end

  #     it "The button is not in the same row as the input field" do
  #       search = page.find("div#search-input-group")
  #       expect(search.has_no_button?).to be(true)
  #     end

  #     it "The button is in its own row" do
  #       search = page.find("div.form-group")
  #       expect(search.inspect[1]).to be("div.form-group")
  #       expect(search.inspect[1].has_button?).to be(true)
  #     end
  #   end

  #   context "Search Options" do
  #     it "Has search options" do
  #       expect(page).to have_selector("fieldset", :count=>1)
  #     end

  #     it "Informs the user that there are options for the search" do
  #       opts = page.find("fieldset")
  #       expect(opts).to have_selector("legend")
  #       expect(opts.find("legend")).to have_content
  #     end

  #     it "Does not display options unless a button is clicked" do
  #       opts = page.find("fieldset div#search-options")
  #       expect(page).to have_selector("div#search-options", :visible => false)
  #     end

  #     it "Has a button to display search options" do
  #       expect(page).to have_css("i.fa-plus-circle")
  #     end 

  #     it "Defaults to search across Song, Artist & Album names" do
  #       page.click_on("i.fa-plus-circle")
  #       expect(page).to have_selector("div#search-options", :visible => true)
  #     end 

  #   end

  # end


