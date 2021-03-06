require 'rails_helper'

RSpec.describe 'routing' do 

  it 'routes to "/home"' do
    expect(:get => '/home').to be_routable
  end

  it 'should have a home path' do
    expect(:get => home_path).to route_to(:controller => "search", :action => "home")
  end

  it 'root should route to home path' do
    expect(:get => '/').to route_to(:controller => "search", :action => "home")
  end

  it 'should only accept GET requests for home' do
    expect(:post => '/home').not_to be_routable
  end

  it 'routes to /search' do
    expect(:post => '/search').to be_routable
  end

  it 'has a search_path' do
    expect(:post => search_path).to route_to(:controller => "search", :action => "search")
  end

  it 'The search action should only accept post requests' do
    expect(:get => search_path).to_not be_routable
  end


end