require 'spec/spec_helper'

# Ensures that the Extension initializes correctly
describe LayoutsExtension do
  
  context 'activate' do
    
    describe 'share layouts' do
      it 'should have a RailsPage class to call' do
        RailsPage.should_not be_nil
      end
      it 'should extend ActionController base methods' do
        ActionController::Base.included_modules.include?(ShareLayouts::Controllers::ActionController).should be_true
      end
      it 'should extend ActionView helper methods' do
        ActionView::Base.included_modules.include?(ShareLayouts::Helpers::ActionView).should be_true
      end
    end
    
  end

end