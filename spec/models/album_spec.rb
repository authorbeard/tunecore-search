require 'rails_helper'

RSpec.describe Album do
  before :each do 
    @album = Album.create(name: Faker::Name.name)
  end


  
end
