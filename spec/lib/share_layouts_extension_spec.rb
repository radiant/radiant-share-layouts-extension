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
    
    describe 'nested layouts' do
      it 'should extend Page base methods' do
        Page.included_modules.include?(NestedLayouts::Tags::Core).should be_true
      end
    end
    
    describe 'haml layouts' do
      it 'should have a HamlFilter class to call' do
        HamlFilter.should_not be_nil
      end
      it 'should extend Layout base methods' do
        Layout.included_modules.include?(HamlLayouts::Models::Layout).should be_true
      end
      it 'should extend Page base methods' do
        Page.included_modules.include?(HamlLayouts::Models::Page).should be_true
      end
    end
    
  end

end