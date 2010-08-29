# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class LayoutsExtension < Radiant::Extension
  version "0.3.1"
  description "Allows Radiant layouts to be used as layouts for standard Rails actions. Includes http://github.com/moklett/radiant-nested-layouts-extension"
  url "http://github.com/squaretalent/radiant-layouts-extension"
  
  extension_config do |config|
    unless ENV["RAILS_ENV"] = "production"
      config.gem 'rspec',             :version => '1.3.0'
      config.gem 'rspec-rails',       :version => '1.3.2'
      config.gem 'cucumber',          :verison => '0.8.5'
      config.gem 'cucumber-rails',    :version => '0.3.2'
      config.gem 'database_cleaner',  :version => '0.4.3'
      config.gem 'ruby-debug',        :version => '0.10.3'
      config.gem 'webrat',            :version => '0.7.1'
    end
  end
  
  def activate
    RailsPage
    ActionController::Base.send :include, ShareLayouts::RadiantLayouts
    ActionView::Base.send :include, ShareLayouts::Helper
    Page.send :include, NestedLayouts::Tags
  end
  
end