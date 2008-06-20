require File.dirname(__FILE__) + "/../test_helper"

class RadiantLayoutsTest < Test::Unit::TestCase
  fixtures :layouts

  class ControllerWithRadiantLayout < ApplicationController
    radiant_layout 'main'
  end
  
  class ControllerWithRadiantLayoutBlock < ApplicationController
    radiant_layout {|c| c.action_name == "index" ? "main" : "utf8" }
  end
  
  def test_should_have_radiant_layout_attribute
    assert_equal 'main', ControllerWithRadiantLayout.read_inheritable_attribute('radiant_layout')
    assert_equal 'radiant', ControllerWithRadiantLayout.read_inheritable_attribute('layout')
  end
  
  def test_should_have_radiant_layout_block
    assert_kind_of Proc, ControllerWithRadiantLayoutBlock.read_inheritable_attribute('radiant_layout')
    assert_equal 'radiant', ControllerWithRadiantLayoutBlock.read_inheritable_attribute('layout')
  end
end
