require 'rails_helper'
require 'capybara/rails'


RSpec.describe "search/home.html.erb", :js=>true do
    context "Form interactions" do
      before :each do
        visit home_path
      end

      it "Shows search options when User clicks on Custom search radio button", javascript:true do
        page.choose("custom")
     byebug   
        expect(page).to have_selector('div.search-opts', :count=>2)
      end

      it "Hides search options when User clicks back on Default search" do
        page.choose("Custom")
        page.choose("Default")
        expect(page).to have_selector('div.search-opts', :count=>2, :visible=>false)
      end

      it "Clears narrowed-search options when any inclusive-search box is checked" do
        page.check("Artist")
        narrow_inputs = page.all('div#narrowed-search input')
        expect(narrow_inputs.all?{|input|
            input.value == nil
          }).to be(true)
      end

      it "Clears inclusive-search options when user types text into narrow-search field" do
        page.fill_in('input.narrow-query-string', :with=>"artist")
        inclusive_inputs = page.all('div#inclusive-search inut')
        expect(inc_search.has_checked_field?).to be(false)
      end



    end

end