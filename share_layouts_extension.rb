# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class ShareLayoutsExtension < Radiant::Extension
  version "0.3.1"
  description "Allows Radiant layouts to be used as layouts for standard Rails actions."
  url "http://wiki.github.com/radiant/radiant/thirdparty-extensions"
  
  # I'm sure this can be done more elegantly, but without it, RSpec complains about routing errors
  if ENV["RAILS_ENV"] == "test"
    define_routes do |map|
      map.connect ':controller/:action/:id'
    end
  end

  def activate
    RailsPage
    ActionController::Base.send :include, ShareLayouts::RadiantLayouts
    ActionView::Base.send :include, ShareLayouts::Helper
  end
  
  def deactivate
  end
  
end
