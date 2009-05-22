require File.dirname(__FILE__) + '/../spec_helper'


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
  
  no_login_required

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

describe ShareController do
  dataset :layouts

  before(:each) do
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

  it "should render normal erb in radiant layout" do
    get :normal_erb_in_radiant_layout
    response.should be_success
    @response.body.strip.should == "Content: #{@erb_content}"
  end

  it "should normal_erb_with_no_layout" do
    get :normal_erb_with_no_layout
    response.should be_success
    @response.body.strip.should == @erb_content
  end

  it "should normal_erb_with_different_radiant_layout" do
    get :normal_erb_with_different_radiant_layout
    response.should be_success
    @response.body.strip.should == "Different: #{@erb_content}"
  end

  it "should normal_erb_with_different_erb_layout" do
    get :normal_erb_with_different_erb_layout
    response.should be_success
    @response.body.should =~ /#{@erb_content}/
  end

  it "should should_assign_request" do
    get :with_request_layout
    response.should be_success
    @response.body.should =~ /Request: .*Request$/
  end

  it "should should_assign_response" do
    get :with_response_layout
    response.should be_success
    @response.body.should =~ /Response: .*Response$/
  end

end
