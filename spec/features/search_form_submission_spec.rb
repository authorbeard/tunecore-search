require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb", :js => true do 

  it "Displays the search results div after user submits query" do
    visit home_path
    expect(page).to_not have_content('Search Results:')
    fill_in('q_query-string', :with=>"whut")
    click_on("Search")
    expect(page).to have_content('Search Results:')

  end



  
end