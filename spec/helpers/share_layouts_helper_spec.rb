require File.dirname(__FILE__) + "/../spec_helper"

describe ShareLayouts::Helper do
  include ShareLayouts::Helper
  dataset :layouts, :pages, :share_layouts_pages
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

  before(:each) do
    @page = RailsPage.new(page_params(:class_name => "RailsPage"))
    @content_for_layout = "something"
    @radiant_layout = layouts(:main).name
    @request = OpenStruct.new(:path => "/some/page/")
  end
  
  it "should extract_content_captures_as_hash" do
    extract_captures.should == {:body => "something"}
    @content_for_sidebar = "sidebar"
    extract_captures.should == {:body => "something", :sidebar => "sidebar"}
  end
  
  # testing assignment of layout
  it "should assign_layout_of_page" do
    assign_attributes!(@page)
    @page.layout.should == layouts(:main)
  end
  
  it "should assign_layout_of_page_when_missing" do
    previous_layout = @page.layout
    @radiant_layout = ''
    assign_attributes!(@page)
    previous_layout.should == @page.layout
  end
  
  # testing assignment of page.title
  it "should assign_page_title_from_instance_var" do
    @title = "My title"
    assign_attributes!(@page)
    @page.title.should == "My title"
  end
  
  it "should assign_page_title_from_capture" do
    @content_for_title = "My title"
    assign_attributes!(@page)
    @page.title.should == "My title"
  end
  
  it "should assign_title_from_existing_page_title_when_not_specified" do
    assign_attributes!(@page)
    @page.title.should =~ /Page \d+$/ # was 'New Page' before. I assume this changed in Radiant 0.8
  end

  it "should assign_empty_title_if_missing" do
    @page.title = nil
    @title.should be_nil
    @content_for_title.should be_nil
    @page.title.should be_nil
    assign_attributes!(@page)
    @page.title.should == ''
  end
  
  #testing assignment of page.breadcrumb
  it "should assign_page_breadcrumb_from_instance_var" do
    @breadcrumb = "My breadcrumb"
    assign_attributes!(@page)
    @page.breadcrumb.should == "My breadcrumb"
  end
  
  it "should assign_page_breadcrumb_from_capture" do
    @content_for_breadcrumb = "My breadcrumb"
    assign_attributes!(@page)
    @page.breadcrumb.should == "My breadcrumb"
  end
  
  it "should assign_breadcrumb_from_existing_breadcrumb_when_not_specified" do
    @page.breadcrumb = "existing breadcrumb"
    assign_attributes!(@page)
    @page.breadcrumb.should == 'existing breadcrumb'
  end

  it "should assign_breadcrumb_from_title_if_missing" do
    @page.title = "Title into BC"
    @page.breadcrumb = nil
    @breadcrumb.should be_nil
    @content_for_breadcrumb.should be_nil
    @page.breadcrumb.should be_nil
    assign_attributes!(@page)
    @page.breadcrumb.should == 'Title into BC'
  end
  
  it "should assign_empty_breadcrumb_if_title_missing_too" do
    @page.title = nil
    @title.should be_nil
    @content_for_title.should be_nil
    @page.title.should be_nil
    @page.breadcrumb = nil
    @breadcrumb.should be_nil
    @content_for_breadcrumb.should be_nil
    @page.breadcrumb.should be_nil
    assign_attributes!(@page)
    @page.breadcrumb.should == ''
  end
  
  # testing assignment of page.breadcrumbs
  it "should assign_breadcrumbs_from_instance_var" do
    @breadcrumbs = "bc"
    assign_attributes!(@page)
    @page.breadcrumbs.should == 'bc'
  end    
  
  it "should assign_breadcrumbs_from_capture" do
    @content_for_breadcrumbs = "bc"
    assign_attributes!(@page)
    @page.breadcrumbs.should == 'bc'
  end    

  it "should leave_breadcrumbs_nil_if_missing" do
    @page.breadcrumbs = nil
    @breadcrumbs.should be_nil
    @content_for_breadcrumbs.should be_nil
    @page.breadcrumbs.should be_nil
    assign_attributes!(@page)
    @page.breadcrumbs.should be_nil
  end

  # testing assigment of page.url
  it "should assign_url_from_request_path" do
    assign_attributes!(@page)
    @page.url.should == '/some/page/'
  end
  
  # testing assigment of page.slug
  it "should assign_slug_from_request_path" do
    assign_attributes!(@page)
    @page.slug.should == 'page'
  end
  
  # testing assignment of page.published_at
  it "should assign_published_at" do
    assign_attributes!(@page)
    @page.published_at.should_not be_nil
  end
  
  it "should render_page" do
    @title = "My Title"
    radiant_layout.strip.should == MAIN_RESULT.strip
  end
  
  it "should find_page" do
    @request.path = "/app/something/"
    find_page.should == pages(:rails_page)
    find_page.should be_a_kind_of(RailsPage)
    @request.path = "/some-other/url/"
    find_page.should_not == pages(:rails_page)
    find_page.should be_a_kind_of(RailsPage)
  end
end
