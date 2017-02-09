require 'rails_helper'
require 'capybara/rails'

RSpec.describe SearchController do 

  describe "#search" do

    it "Responds to JSON requests" do
      post :search, {:q => {:search_opts=>"default", :query_string => "whut"}, :format=>:json}
      expect(response.content_type).to eq("application/json")
    end

    it "Should instantiate the Search Service upon receiving a request" do
      post :search, {:q => {:search_opts=>"default", :query_string => "whut"}, :format=>:json}
      byebug
    end

  end




  
end