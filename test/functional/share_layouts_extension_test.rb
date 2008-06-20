require File.dirname(__FILE__) + '/../test_helper'

class ShareLayoutsExtensionTest < Test::Unit::TestCase
    
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'share_layouts'), ShareLayoutsExtension.root
    assert_equal 'Share Layouts', ShareLayoutsExtension.extension_name
  end
  
  def test_should_add_controller_hooks
    assert_respond_to ActionController::Base, :radiant_layout
    assert_respond_to ActionController::Base.new, :set_radiant_layout
  end
  
  def test_should_add_helper
    assert ApplicationController.master_helper_module.included_modules.include?(ShareLayouts::Helper)
  end
end
