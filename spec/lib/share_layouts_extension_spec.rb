require File.dirname(__FILE__) + '/../spec_helper'

describe ShareLayoutsExtension do
    
  it "should initialize" do
    ShareLayoutsExtension.root.should == File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'share_layouts')
    ShareLayoutsExtension.extension_name.should == 'Share Layouts'
  end
  
  it "should add controller hooks" do
    ActionController::Base.should respond_to(:radiant_layout)
    ActionController::Base.new.should respond_to(:set_radiant_layout)
  end
  
  it "should add helper" do
    ActionView::Base.included_modules.include?(ShareLayouts::Helper).should be_true
  end
end
