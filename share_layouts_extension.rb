# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class ShareLayoutsExtension < Radiant::Extension
  version "0.3.1"
  description "Allows Radiant layouts to be used as layouts for standard Rails actions."
  url "http://wiki.radiantcms.org/Thirdparty_Extensions"

  def activate
    RailsPage
    ActionController::Base.send :include, ShareLayouts::RadiantLayouts
    ActionView::Base.send :include, ShareLayouts::Helper
  end
  
  def deactivate
  end
  
end
