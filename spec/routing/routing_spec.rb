require 'rails_helper'

RSpec.describe 'routing' do 

  it 'routes to "/home"' do
    expect(:get => '/home').to be_routable
  end

  it 'should have a home path' do
    expect(:get => home_path).to route_to(:controller => "search", :action => "home")
  end

  it 'root should route to home path' do
  byebug
    expect(:get => '/').to route_to(:controller => "search", :action => "home")
  end

  # it 'should only accept GET requests for home' do

  # end

  # it 'should route queries to search#search' do

  # end

  # it 'The search action should only accept post requests' do

  # end

  # it 'The search action should respond to json by default' do

  # end




end