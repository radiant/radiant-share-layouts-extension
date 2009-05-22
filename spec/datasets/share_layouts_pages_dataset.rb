class ShareLayoutsPagesDataset < Dataset::Base
  def load
    create_record :page, :homepage, :id => 1, 
      :title => 'Homepage',
      :breadcrumb => 'Homepage',
      :slug => '/',
      :status_id => 100,
      :published_at => '2008-01-01 08:00:00'
      
    create_record :page, :rails_page,
      :id => 2,
      :title => 'App page',
      :breadcrumb => 'App page',
      :slug => 'app',
      :class_name => 'RailsPage',
      :status_id => 100,
      :parent_id => 1,
      :published_at => '2008-01-01 08:00:00'
    
    create_record :page, :rails_page_child,
      :id => 3,
      :title => 'Child',
      :breadcrumb => 'Child',
      :slug => 'child-page',
      :status_id => 100,
      :parent_id => 2,
      :published_at => '2008-01-01 08:00:00'
    
    create_record :page, :other,
      :id => 4,
      :title => 'Other',
      :breadcrumb => 'Other',
      :slug => 'other',
      :status_id => 100,
      :parent_id => 1,
      :published_at => '2008-01-01 08:00:00'
  end
end