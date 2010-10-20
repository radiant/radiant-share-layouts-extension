if ENV["RAILS_ENV"] == "test"
  ActionController::Routing::Routes.draw do |map|
    map.connect ':controller/:action/:id'
  end
end