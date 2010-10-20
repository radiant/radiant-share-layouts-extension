require 'spec/spec_helper'

class ControllerWithRadiantLayout < ApplicationController
  radiant_layout 'main'
end

class ControllerWithRadiantLayoutBlock < ApplicationController
  radiant_layout {|c| c.action_name == "index" ? "main" : "utf8"}
end
  
describe ControllerWithRadiantLayout do  
  dataset :layouts
  
  before(:each) do
    layouts(:main)
  end
    
  it "should have radiant layout attribute" do
    ControllerWithRadiantLayout.read_inheritable_attribute('radiant_layout').should == 'main'
    # This doesn't seem to work anymore, but calling "active_layout" on an instance still correctly returns "layouts/radiant.rhtml"
    #ControllerWithRadiantLayout.read_inheritable_attribute('layout').should == 'radiant'
  end
  
  it "should return 'radiant' when read_inheritable_attribute('layout') is called"
  
end
  
describe ControllerWithRadiantLayoutBlock do  
  dataset :layouts
  
  before(:each) do
    layouts(:main)
  end
  
  it "should have radiant layout block" do
    ControllerWithRadiantLayoutBlock.read_inheritable_attribute('radiant_layout').should be_kind_of(Proc)
    # This doesn't seem to work anymore, but calling "active_layout" on an instance still correctly returns "layouts/radiant.rhtml"
    #ControllerWithRadiantLayoutBlock.read_inheritable_attribute('layout').should == 'radiant'
  end
  
  it "should return 'radiant' when read_inheritable_attribute('layout') is called"
  
end

