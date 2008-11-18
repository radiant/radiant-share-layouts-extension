require File.dirname(__FILE__) + "/../test_helper"

class ShareLayoutsHelperTest < Test::Unit::TestCase
  include ShareLayouts::Helper
  fixtures :layouts, :pages
  test_helper :page
  attr_accessor :request, :response
  
MAIN_RESULT = <<-TEXT
<html>
  <head>
    <title>My Title</title>
  </head>
  <body>
    something
  </body>
</html>
TEXT

  def setup
    @page = RailsPage.new(page_params(:class_name => "RailsPage"))
    @content_for_layout = "something"
    @radiant_layout = layouts(:main).name
    @request = OpenStruct.new(:path => "/some/page/")
  end
  
  def test_should_extract_content_captures_as_hash
    assert_equal({:body => "something"}, extract_captures)
    @content_for_sidebar = "sidebar"
    assert_equal({:body => "something", :sidebar => "sidebar"}, extract_captures)
  end
  
  # testing assignment of layout
  def test_should_assign_layout_of_page
    assign_attributes!(@page)
    assert_equal @page.layout, layouts(:main)
  end
  
  def test_should_assign_layout_of_page_when_missing
    previous_layout = @page.layout
    @radiant_layout = ''
    assign_attributes!(@page)
    assert_equal previous_layout, @page.layout
  end
  
  # testing assignment of page.title
  def test_should_assign_page_title_from_instance_var
    @title = "My title"
    assign_attributes!(@page)
    assert_equal "My title", @page.title
  end
  
  def test_should_assign_page_title_from_capture
    @content_for_title = "My title"
    assign_attributes!(@page)
    assert_equal "My title", @page.title
  end
  
  def test_should_assign_title_from_existing_page_title_when_not_specified
    assign_attributes!(@page)
    assert_equal 'New Page', @page.title
  end

  def test_should_assign_empty_title_if_missing
    @page.title = nil
    assert_nil @title
    assert_nil @content_for_title
    assert_nil @page.title
    assign_attributes!(@page)
    assert_equal '', @page.title
  end
  
  #testing assignment of page.breadcrumb
  def test_should_assign_page_breadcrumb_from_instance_var
    @breadcrumb = "My breadcrumb"
    assign_attributes!(@page)
    assert_equal "My breadcrumb", @page.breadcrumb
  end
  
  def test_should_assign_page_breadcrumb_from_capture
    @content_for_breadcrumb = "My breadcrumb"
    assign_attributes!(@page)
    assert_equal "My breadcrumb", @page.breadcrumb
  end
  
  def test_should_assign_breadcrumb_from_existing_breadcrumb_when_not_specified
    @page.breadcrumb = "existing breadcrumb"
    assign_attributes!(@page)
    assert_equal 'existing breadcrumb', @page.breadcrumb
  end

  def test_should_assign_breadcrumb_from_title_if_missing
    @page.title = "Title into BC"
    @page.breadcrumb = nil
    assert_nil @breadcrumb
    assert_nil @content_for_breadcrumb
    assert_nil @page.breadcrumb
    assign_attributes!(@page)
    assert_equal 'Title into BC', @page.breadcrumb
  end
  
  def test_should_assign_empty_breadcrumb_if_title_missing_too
    @page.title = nil
    assert_nil @title
    assert_nil @content_for_title
    assert_nil @page.title
    @page.breadcrumb = nil
    assert_nil @breadcrumb
    assert_nil @content_for_breadcrumb
    assert_nil @page.breadcrumb
    assign_attributes!(@page)
    assert_equal '', @page.breadcrumb
  end
  
  # testing assignment of page.breadcrumbs
  def test_should_assign_breadcrumbs_from_instance_var
    @breadcrumbs = "bc"
    assign_attributes!(@page)
    assert_equal "bc", @page.breadcrumbs
  end    
  
  def test_should_assign_breadcrumbs_from_capture
    @content_for_breadcrumbs = "bc"
    assign_attributes!(@page)
    assert_equal "bc", @page.breadcrumbs
  end    

  def test_should_leave_breadcrumbs_nil_if_missing
    @page.breadcrumbs = nil
    assert_nil @breadcrumbs
    assert_nil @content_for_breadcrumbs
    assert_nil @page.breadcrumbs
    assign_attributes!(@page)
    assert_equal nil, @page.breadcrumbs
  end

  # testing assigment of page.url
  def test_should_assign_url_from_request_path
    assign_attributes!(@page)
    assert_equal '/some/page/', @page.url
  end
  
  # testing assigment of page.slug
  def test_should_assign_slug_from_request_path
    assign_attributes!(@page)
    assert_equal 'page', @page.slug
  end
  
  # testing assignment of page.published_at
  def test_should_assign_published_at
    assign_attributes!(@page)
    assert_not_nil @page.published_at
  end
  
  def test_should_render_page
    @title = "My Title"
    assert_equal MAIN_RESULT.strip, radiant_layout.strip
  end
  
  def test_should_find_page
    @request.path = "/app/something/"
    assert_equal pages(:rails_page), find_page
    assert_kind_of RailsPage, find_page
    @request.path = "/some-other/url/"
    assert_not_equal pages(:rails_page), find_page
    assert_kind_of RailsPage, find_page
  end
end
