require "test_helper"
require "fileutils"

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
    custom_path = Rails.root.join("app", "assets", "icons")
    FileUtils.mkdir_p(custom_path)

    custom_file = custom_path.join("custom_user.svg")
    File.write(custom_file, '<svg><path d="..."/></svg>')
    rendered_icon = @dummy_instance.icon("star", custom_path: custom_file.to_s)
    assert_includes rendered_icon, '<svg'

    File.delete(custom_file) # Clean up the dummy file
    FileUtils.rmdir(custom_path) # Clean up the directory if it's empty
  end
end
