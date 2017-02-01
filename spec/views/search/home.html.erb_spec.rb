require 'rails_helper'
require 'capybara/rails'

RSpec.describe "search/home.html.erb" do

  it "Welcomes the User" do
    visit home_path
    expect(page).to have_content("Welcome to Tunecore Search") 
  end

  context "Before a user has searched for anything" do
    it "Has a responsive grid" do
      assert false
    end






  end


  




end
