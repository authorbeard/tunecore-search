require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb", :js=>true do
    context "Form interactions" do
      before :each do
        visit home_path
        page.choose("Custom")
      end

      it "Shows search options when User clicks on Custom search radio button", javascript:true do
        expect(page).to have_selector('div.search-opts', :count=>2)
      end

      it "Hides search options when User clicks back on Default search" do
        page.choose("Default")
        expect(page).to have_selector('div.search-opts', :count=>2, :visible=>false)
      end

      it "Clears narrowed-search options when any inclusive-search box is checked" do 
        page.fill_in('q_narrow_query', :with=>"test")  
        page.check("Artist Name")
        narrow_inputs = page.all('div#narrowed-search input')
        expect(narrow_inputs.first.selected?).to be(false)
        expect(narrow_inputs[2].text).to eq("")
      end

      it "Clears inclusive-search options when user types text into narrow-search field" do
        page.fill_in('q_narrow_query', :with=>"artist")
        inclusive_inputs = page.all('div#inclusive-search input')
        expect(inclusive_inputs.all?{|checkbox|
            checkbox.selected? == false
        }).to be(true)
      end
    end
end