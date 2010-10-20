require 'spec/spec_helper'

# Ensures that the Extension initializes correctly
describe LayoutsExtension do
  
  context 'activate' do
    
    describe 'nested layouts' do
      it 'should extend Page base methods' do
        Page.included_modules.include?(NestedLayouts::Tags::Core).should be_true
      end
    end
    
  end

end