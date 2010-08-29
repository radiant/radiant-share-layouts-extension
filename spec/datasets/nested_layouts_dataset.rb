class NestedLayoutsDataset < Dataset::Base
  def load
    create_record :layout, :parent, 
      :name       => 'parent',
      :content    => <<-CONTENT
<html>
  <body class="<r:layout />">
    <r:content_for_layout />
  </body>
</html>
CONTENT
    
    create_record :layout, :child,
      :name       => 'child',
      :content    => <<-CONTENT
<r:inside_layout name='parent'>
  <h1>child</h1>
</r:inside_layout>
CONTENT
    
    create_record :page, :parent_layout,
      :title      => 'child layout',
      :layout_id  => layouts(:parent).id,
      :breadcrumb => 'Homepage',
      :slug => '/',
      :status_id => 100,
      :published_at => '2008-01-01 08:00:00'
    
    create_record :page, :child_layout,
      :title      => 'child layout',
      :layout_id  => layouts(:child).id,
      :breadcrumb => 'Homepage',
      :slug => '/',
      :status_id => 100,
      :published_at => '2008-01-01 08:00:00'
    
  end
end