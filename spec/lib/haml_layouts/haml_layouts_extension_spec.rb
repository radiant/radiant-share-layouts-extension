require 'spec/spec_helper'

# Ensures that the Extension initializes correctly
describe LayoutsExtension do
  
  context 'activate' do
    
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