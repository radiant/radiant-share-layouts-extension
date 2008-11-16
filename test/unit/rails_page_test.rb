require File.dirname(__FILE__) + "/../test_helper"
require 'ostruct'

class RailsPageTest < Test::Unit::TestCase
  test_helper :render, :page
  fixtures :pages
  def setup
    @page = RailsPage.new(page_params(:class_name => "RailsPage"))
  end
  
  def test_should_redefine_breadcrumbs_tag
    assert_respond_to @page, "tag:old_breadcrumbs"
    assert_respond_to @page, "tag:breadcrumbs"

    @page.breadcrumbs = "some breadcrumbs"
    @page.save!
    assert_renders "some breadcrumbs", "<r:breadcrumbs />"
  end
  
  def test_breadcrumb_should_equal_title
    @page.title = "My Page"
    assert_equal "My Page", @page.breadcrumb
  end
  
  def test_should_build_parts_from_hash
    hash = {:body => "body", :sidebar => "sidebar"}
    @page.build_parts_from_hash!(hash)
    assert_equal hash.keys.size, @page.parts.size
    # Make sure we don't save them to the DB
    assert @page.parts.all?(&:new_record?)
  end
  
  def test_should_find_rails_page_for_sub_urls_that_do_not_match_an_existing_page
    assert_equal pages(:rails_page), Page.find_by_url('/app/')
    assert_equal pages(:rails_page), Page.find_by_url('/app/some-other-url/')
    assert_equal pages(:rails_page), Page.find_by_url('/app/some-other-url/sub-url/')
  end
  
  def test_should_find_page_if_sub_url_matches_one
    assert_equal pages(:rails_page_child), Page.find_by_url('/app/child-page/')
  end
  
  def test_should_find_page_for_non_sub_urls
    assert_equal pages(:other), Page.find_by_url('/other/')
  end
  
  def test_should_defer_to_default_url_when_not_initialized
    assert_equal '/app/', pages(:rails_page).url
  end
  
  def test_should_modify_existing_parts_but_not_save_them
    @page = pages(:rails_page)
    @page.parts.create(:name => "sidebar", :content => "This is the sidebar.")
    
    @page.build_parts_from_hash!(:body => "This is the body")
    assert_equal 'This is the sidebar.', @page.part(:sidebar).content
    
    @page.build_parts_from_hash!(:sidebar => "OVERRIDE")
    assert_equal 'OVERRIDE', @page.part(:sidebar).content
    assert_equal 'This is the sidebar.', @page.part(:sidebar).reload.content
  end
end
