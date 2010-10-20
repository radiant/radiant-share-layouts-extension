class LayoutsLayoutsDataset < Dataset::Base
  
  def load
    create_record :layout, :parent, 
      :name         => 'parent',
      :content_type => 'haml',
      :content      => <<-CONTENT
!!! 5
%html
  %head
    %title Title
  :plain
    <r:body class="site">
      <r:content_for_layout />
    </r:body>
CONTENT

    create_record :layout, :child,
      :name       => 'child',
      :content    => <<-CONTENT
<r:inside_layout name='parent'>
  <h1><r:layout /></h1>
</r:inside_layout>
CONTENT

    create_record :layout, :haml, 
      :name         => 'haml',
      :content_type => 'haml',
      :content      => <<-CONTENT
%r:inside_layout{:name=>"parent"}
  %h1
    %r:layout
CONTENT
  end
  
end