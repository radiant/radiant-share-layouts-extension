require 'spec/spec_helper'

describe HamlLayouts::Models::Page do
  
  dataset :layouts_layouts, :layouts_pages
  
  describe 'parse_object' do
    context 'haml filter type' do
      it 'should render haml radius tags' do
        @part = PagePart.new({
          :content   => '%r:title',
          :filter_id => 'Haml'
        })
        @page = pages(:parent)
        
        @page.parse_object(@part).should === "#{@page.title}\n"
      end
      
      it 'should render textile radius tags' do
        @part = PagePart.new({
          :content   => 'h1. <r:title />',
          :filter_id => 'Textile'
        })
        @page = pages(:parent)
        
        @page.parse_object(@part).should === "<h1>#{@page.title}</h1>"
      end
      
      it 'should render non filtered tags' do
        @part = PagePart.new({
          :content   => '<r:title />'
        })
        @page = pages(:parent)
        
        @page.parse_object(@part).should === @page.title
      end
    end
  end
  
end