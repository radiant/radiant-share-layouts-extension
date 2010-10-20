require 'spec/spec_helper'

describe NestedLayouts::Tags::Core do
  
  dataset :layouts_pages, :layouts_layouts
  
  describe '<r:inside_layout>, <r:layout>, <r:body /> and <r:content_for_layout>' do

    it 'should output tag within the body of class name for parent layout' do
      tag = %{<r:inside_layout name='parent'><h1>Hi</h1></r:inside_layout>}
      expected = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
  </head>
  <body class="site parent">
    <h1>Hi</h1>
  </body>
</html>
CONTENT
      pages(:parent).should render(tag).as(expected)
    end
    
    it 'should output tag within the body of class name for a child_layout' do
      tag = %{<r:inside_layout name='parent'><h1>Hi</h1></r:inside_layout>}
      expected = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
  </head>
  <body class="site child">
    <h1>Hi</h1>
  </body>
</html>
CONTENT
      pages(:child).should render(tag).as(expected)
    end
    
  end
    
  describe '<r:if_layout>' do
    
    it 'it should render the contents if true' do
      tag = %{<r:inside_layout name='parent'><r:if_layout name='parent'><h1>Hi</h1></r:if_layout></r:inside_layout>}
      expected = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
  </head>
  <body class="site parent">
    <h1>Hi</h1>
  </body>
</html>
CONTENT
      pages(:parent).should render(tag).as(expected)
    end
    
    it 'it should not render the contents if false' do
      tag = %{<r:inside_layout name='parent'><r:if_layout name='not parent'><h1>Hi</h1></r:if_layout></r:inside_layout>}
      expected = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
  </head>
  <body class="site parent">
    
  </body>
</html>
CONTENT
      pages(:parent).should render(tag).as(expected)
    end
    
  end
  
  describe '<r:unless_layout>' do

    it 'it should not render the contents if true' do
      tag = %{<r:inside_layout name='parent'><r:unless_layout name='parent'><h1>Hi</h1></r:unless_layout></r:inside_layout>}
      expected = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
  </head>
  <body class="site parent">
    
  </body>
</html>
CONTENT
      pages(:parent).should render(tag).as(expected)
    end

    it 'it should not render the contents if false' do
      tag = %{<r:inside_layout name='parent'><r:unless_layout name='not parent'><h1>Hi</h1></r:unless_layout></r:inside_layout>}
      expected = <<-CONTENT
<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
  </head>
  <body class="site parent">
    <h1>Hi</h1>
  </body>
</html>
CONTENT
      pages(:parent).should render(tag).as(expected)
    end

  end
  
end