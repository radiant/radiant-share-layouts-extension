# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class LayoutsExtension < Radiant::Extension
  version "1.0.1"
  description "A set of useful extensions to standard Layouts."
  url "http://github.com/squaretalent/radiant-layouts-extension"
  
  def activate
    # Shared Layouts
    RailsPage
    ActionController::Base.send :include, ShareLayouts::Controllers::ActionController
    ActionView::Base.send :include, ShareLayouts::Helpers::ActionView
    
    # Nested Layouts
    Page.send   :include, NestedLayouts::Tags::Core
    
    # HAML Layouts
    Layout.send  :include, HamlLayouts::Models::Layout
    Page.send    :include, HamlLayouts::Models::Page
    HamlFilter
  end
  
end