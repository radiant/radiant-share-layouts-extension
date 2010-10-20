require 'spec/spec_helper'

describe HamlLayouts::Models::Layout do
  
  dataset :layouts_layouts, :layouts_pages
  
  describe 'content' do
    context 'a haml layout' do
      it 'should return html rendered' do
        expected = <<-CONTENT
<r:inside_layout name='parent'>
  <h1>
    <r:layout></r:layout>
  </h1>
</r:inside_layout>
CONTENT
        layouts(:haml).content.should === expected
      end
    end
  end
  
  describe 'is_haml?' do
    context 'layout has a content type of haml' do
      it 'should return true' do
        layouts(:haml).is_haml?.should be_true
      end
    end
    
    context 'layout does not have a content type of haml' do
      it 'should return false' do
        layouts(:child).is_haml?.should be_false
      end
    end
  end
  
end