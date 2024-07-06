require "test_helper"

class RailsuiIconTest < ActiveSupport::TestCase
  test "RailsuiIcon is a module" do
    assert_kind_of Module, RailsuiIcon
  end

  test "RailsuiIcon has a version" do
    assert_kind_of String, RailsuiIcon::VERSION
  end

  test "RailsuiIcon engine isolates namespace" do
    assert_equal "railsui_icon", RailsuiIcon::Engine.engine_name
  end

  test "RailsuiIcon sets root to current directory" do
    assert_equal Pathname.new(Dir.pwd).to_s, RailsuiIcon.root.to_s
  end
end
