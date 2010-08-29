ActionController::Routing::Routes.draw do |map|

  # I'm sure this can be done more elegantly, but without it, RSpec complains about routing errors
  map.connect ':controller/:action/:id' if ENV["RAILS_ENV"] == "test"

end