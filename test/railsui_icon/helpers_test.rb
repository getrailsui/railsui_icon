require "test_helper"

class HelpersTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  setup do
    @dummy_class = Class.new do
      include RailsuiIcon::Helpers
    end
    @dummy_instance = @dummy_class.new
  end

  test "icon helper renders with default options" do
    rendered_icon = @dummy_instance.icon("star")
    assert_includes rendered_icon, '<svg'
  end

  test "icon helper resolves custom path" do
    custom_path = "/icons/custom_user.svg"
    rendered_icon = @dummy_instance.icon("star", custom_path: custom_path)
    assert_includes rendered_icon, custom_path
  end
end
