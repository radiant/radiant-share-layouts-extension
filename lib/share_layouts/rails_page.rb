class ShareLayouts::RailsPage < Page
  attr_accessor :breadcrumbs

  def request_uri=(value)
    @url = URI.parse(value).path
    self.slug = @url.split("/").last
  end
  
  def url
    @url
  end
  
  def breadcrumb
    title
  end
   
  def build_parts_from_hash!(content)
    content.each do |k,v|
      parts << PagePart.new(:name => k.to_s, :content => v)
    end
  end 
  
  alias_method "tag:old_breadcrumbs", "tag:breadcrumbs"
  tag 'breadcrumbs' do |tag|
    if tag.locals.page.is_a? ShareLayouts::RailsPage
      tag.locals.page.breadcrumbs
    else
      render_tag('old_breadcrumbs', tag)
    end
  end
end
