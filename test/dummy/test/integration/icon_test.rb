require "test_helper"

class IconTest < ActionDispatch::IntegrationTest
  test "icon helper renders svg" do
    get icons_path
    assert_response :success
    assert_select "svg"
  end
end
