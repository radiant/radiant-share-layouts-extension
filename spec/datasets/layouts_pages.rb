class LayoutsPagesDataset < Dataset::Base

  uses :layouts_layouts
  
  def load
    create_record :page, :parent,
      :title        => 'Parent',
      :layout_id    => layouts(:parent).id,
      :breadcrumb   => 'parent',
      :slug         => '/',
      :status_id    => 100
    
    create_record :page, :child,
      :title        => 'Child',
      :layout_id    => layouts(:child).id,
      :parent_id    => pages(:parent).id,
      :breadcrumb   => 'child',
      :slug         => '/child',
      :status_id    => 100
      
    create_record :page, :rails,
      :title        => 'App page',
      :breadcrumb   => 'App page',
      :slug         => 'app',
      :class_name   => 'RailsPage',
      :status_id    => 100,
      :parent_id    => pages(:parent).id

    create_record :page, :rails_child,
      :title        => 'Child',
      :breadcrumb   => 'Child',
      :slug         => 'child-page',
      :status_id    => 100,
      :parent_id    => pages(:rails).id

    create_record :page, :other,
      :title        => 'Other',
      :breadcrumb   => 'Other',
      :slug         => 'other',
      :status_id    => 100,
      :parent_id    => pages(:parent).id
  end
end