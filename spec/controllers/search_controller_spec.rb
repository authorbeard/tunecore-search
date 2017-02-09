require 'rails_helper'
require 'capybara/rails'

RSpec.describe SearchController do 

  describe "#search" do

    it "Responds to JSON requests" do
      post :search, {:q => {:query_string => "whut"}, :format=>:json}
      expect(response.content_type).to eq("application/json")
    end

  end




  
end