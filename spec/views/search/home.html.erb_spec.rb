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

    it "Displays the search button at the bottom of the form" do
      button = page.all('form > *').last
      expect(button['type']).to eq('Submit')
    end
  end

  context "Search form" do
    context "Search box and label" do
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
        expect(page.find('div#search-input-group')).to have_selector('label.col-form-label')
      end

      it "The label has some content" do 
        expect(page.find('label[for=query-string]').text).to_not eq("")
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
        search_box = page.find('input#query-string')
        expect(search_box['placeholder']).to_not be(nil)
      end

      it "Contains input instructions below the search box" do
        expect(page).to have_selector('small#input-instructions')
        instructions = page.find('small')
        expect(instructions.text).to eq('Separate each search term or phrase with a comma.')
        expect(page.all('#search-input-group').last).to have_selector('small')
      end
    end

    context "Search option Selectors" do
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

    context "Inclusive search options" do
      before :context do 
        Capybara.ignore_hidden_elements = false
      end

      after :context do
        Capybara.ignore_hidden_elements = true
      end

      it "Form should have a section to specify which models to search" do       
        expect(page.find('form')).to have_selector('div#inclusive-search')
      end

      it "Inclusive search options should be in their own form group" do
        expect(page).to have_selector('div.form-group.row#inclusive-search')
      end

      it "Inclusive search should include check boxes for each model" do
        inc_search=page.find('div#inclusive-search')
        expect(inc_search).to have_selector('input.form-check-input[type=checkbox]', :count=>3)
      end

      it "Check boxes should use responsive classes and render inline" do
        inc_search=page.find('div#inclusive-search')
        expect(inc_search).to have_selector('div.form-check-inline', :count=>3)

        form_checks = inc_search.all('div.form-check-inline')
        form_checks.each{|div| 
          expect(div).to have_selector('label.form-check-label')
          expect(div).to have_selector('label input.form-check-input')
        }
      end

      it "Labels should list all available search fields" do
        labels = page.all('div#inclusive-search label')   
        expect(labels.first.text).to eq("Artist Name")
        expect(labels[1].text).to eq("Album Title")
        expect(labels[2].text).to eq("Song Title")      
      end

      it "Check boxes should actually refer to fields" do
        checkboxes = page.all('div#inclusive-search label')
        checkboxes.each {|box|  
          expect(box.find('input')['id']).to eq(box.text.parameterize)
          expect(box.find('input')['value']).to eq(box.text.parameterize)
        }
      end

      it "The inclusive search checkboxes should be invisible on load" do   
        expect(page.find('div#inclusive-search').visible?).to be(false)
      end
    end
  end

  context "Narrowed search options" do
      before :context do 
        Capybara.ignore_hidden_elements = false
      end

      after :context do
        Capybara.ignore_hidden_elements = true
      end

      it "The form has fields for narrowed search" do 
        expect(page).to have_selector("div#narrowed-search")
      end

      it "Tells the user that this search cannot be used with inclusive search" do
        expect(page.find('div#narrowed-search h1:nth-child(1)')).to have_content('OR')
        expect(page).to have_content('Narrow your search by album or artist')
      end

      it "The narrowed search fields use responsive classes" do
        expect(page).to have_selector('div.form-group.row#narrowed-search')
      end

      it "Has at least one responsive area to narrow search" do
        expect(page.find('div#narrowed-search')).to have_selector('div.form-group.row')
      end

      it "Has instructions" do
        n_search = page.find('div#narrowed-search')
        expect(n_search).to have_selector("legend.col-form-legend")
        expect(n_search).to have_content("Leave the keyword box blank to find all songs by artist, album or both.")
        expect(n_search).to have_content("Search within:")
      end

      it "Contains radio buttons to narrow by artist or album" do
        first_narrow = page.find("div#first-parameter")
        expect(first_narrow).to have_selector('input[type=radio]', :count=>2)
      end

      it "The radio buttons render inline" do
        n_search = page.find('div#narrowed-search')
        expect(n_search).to have_selector('.form-check-inline', :count=>2)
      end

      it "The radio buttons are labeled and responsive" do
        first_param = page.find('div.form-group#first-parameter')
        expect(first_param).to have_selector('label.form-check-label')
      end

      it "Contains a text box to search for album or artist name" do
        first_narrow = page.find("div#first-parameter")
        expect(first_narrow).to have_selector('input[type=search]')
      end

      it "Uses autocomplete in search parameter box" do
        expect(page.all('input#first-parameter')['autocomplete']).to_not be(nil)
      end










    end

  context "Search results" do
    
    it "The Search Results section follows grid design pattern" do
      expect(page).to have_selector('.container div.row#search-results', :visible=>false)
    end

  end

end


