require "test_helper"

class RailsuiIconTest < ActiveSupport::TestCase
  test "configuration defaults" do
    config = RailsuiIcon::Configuration.new
    assert_equal :heroicons, config.default_library
    assert_equal :outline, config.default_variant
  end

  test "icon helper exists" do
    assert_respond_to ActionView::Base.new, :icon
  end
end
