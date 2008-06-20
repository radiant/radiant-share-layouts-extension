require File.dirname(__FILE__) + '/../test_helper'

class ShareLayoutsTest < Test::Unit::TestCase

  module TestShareLayoutsTags
    include Radiant::Taggable

    desc 'some tag'
    tag 'test_has_request' do |tag|
      tag.locals.page.request.class
    end

    desc 'some tag'
    tag 'test_has_response' do |tag|
      tag.locals.page.response.class
    end

  end

  Page.send(:include, TestShareLayoutsTags)

  class ShareController < ApplicationController
    radiant_layout 'Default'

    def no_login_required? ; true ; end

    def normal_erb_in_radiant_layout
      @name = 'Chester McTester'
      render :inline => 'Hello there, <%= @name %>', :layout => true
    end

    def normal_erb_with_no_layout
      @name = 'Chester McTester'
      render :inline => 'Hello there, <%= @name %>', :layout => false
    end

    def normal_erb_with_different_radiant_layout
      @radiant_layout = 'Different'

      @name = 'Chester McTester'
      render :inline => 'Hello there, <%= @name %>', :layout => true
    end

    def normal_erb_with_different_erb_layout
      @name = 'Chester McTester'
      render :inline => 'Hello there, <%= @name %>', :layout => 'application'
    end

    def with_request_layout
      @radiant_layout = 'Test Request'

      render :inline => '', :layout => true
    end

    def with_response_layout
      @radiant_layout = 'Test Response'

      render :inline => '', :layout => true
    end

  end

  fixtures :layouts

  def setup
    @controller = ShareController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    @erb_content = "Hello there, Chester McTester"

    layout = "Content: <r:content />"
    Layout.create!(:name => 'Default', :content => layout)

    layout = "Different: <r:content />"
    Layout.create!(:name => 'Different', :content => layout)

    layout = "Request: <r:test_has_request />\nContent: <r:content />"
    Layout.create!(:name => 'Test Request', :content => layout)

    layout = "Response: <r:test_has_response />\nContent: <r:content />"
    Layout.create!(:name => 'Test Response', :content => layout)
  end

  def test_normal_erb_in_radiant_layout
    get :normal_erb_in_radiant_layout
    assert_response :success
    assert_equal "Content: #{@erb_content}", @response.body.strip
  end

  def test_normal_erb_with_no_layout
    get :normal_erb_with_no_layout
    assert_response :success
    assert_equal @erb_content, @response.body.strip
  end

  def test_normal_erb_with_different_radiant_layout
    get :normal_erb_with_different_radiant_layout
    assert_response :success
    assert_equal "Different: #{@erb_content}", @response.body.strip
  end

  def test_normal_erb_with_different_erb_layout
    get :normal_erb_with_different_erb_layout
    assert_response :success
    assert_match "#{@erb_content}", @response.body
  end

  def test_should_assign_request
    get :with_request_layout
    assert_response :success
    assert_match /Request: .*Request$/, @response.body
  end

  def test_should_assign_response
    get :with_response_layout
    assert_response :success
    assert_match /Response: .*Response$/, @response.body
  end

end
