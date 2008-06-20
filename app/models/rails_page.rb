class RailsPage < Page
  display_name "Application"
  attr_accessor :breadcrumbs

  def find_by_url(url, live=true, clean=true)
    url = clean_url(url) if clean
    self if url.starts_with?(self.url)
  end
  
  def request_uri=(value)
    @url = URI.parse(value).path
    self.slug = @url.split("/").last
  end
  
  def url
    @url || super
  end
  
  def breadcrumb
    title
  end
   
  def build_parts_from_hash!(content)
    parts.clear
    content.each do |k,v|
      parts.build(:name => k.to_s, :content => v)
    end
  end 
  
  alias_method "tag:old_breadcrumbs", "tag:breadcrumbs"
  tag 'breadcrumbs' do |tag|
    if tag.locals.page.is_a?(RailsPage) && tag.locals.page.breadcrumbs
      tag.locals.page.breadcrumbs
    else
      render_tag('old_breadcrumbs', tag)
    end
  end
end