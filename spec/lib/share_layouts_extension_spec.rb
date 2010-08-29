require 'spec/spec_helper'

describe LayoutsExtension do
  
  context 'activate' do
    
    it 'should have a RailsPage class to call' do
      RailsPage.should_not be_nil
    end
    
    it 'should extend ActionController base methods' do
      ActionController::Base.included_modules.include?(ShareLayouts::RadiantLayouts).should be_true
    end
    
    it 'should extend ActionView helper methods' do
      ActionView::Base.included_modules.include?(ShareLayouts::Helper).should be_true
    end

    it 'should extend Page base methods' do
      Page.included_modules.include?(NestedLayouts::Tags).should be_true
    end
    
  end

end