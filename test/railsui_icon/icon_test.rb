require "test_helper"
require 'minitest/autorun'
require 'railsui_icon/icon'

class IconTest < Minitest::Test
  def setup
    RailsuiIcon.configure do |config|
      config.default_variant = :outline
      config.custom_icon_paths = ['/custom/icon/path']
    end
  end

  def test_render_existing_icon
    icon = RailsuiIcon::Icon.new(name: 'star')
    rendered_html = icon.render

    refute_nil rendered_html
    assert_includes rendered_html, '<svg'
  end

  def test_render_with_custom_path
    icon = RailsuiIcon::Icon.new(name: 'star', custom_path: '/custom/icon/path/outline/user.svg')
    rendered_html = icon.render

    refute_nil rendered_html
    assert_includes rendered_html, '<svg'
  end

  def test_render_with_options
    icon = RailsuiIcon::Icon.new(name: 'star', options: { class: 'custom-class', fill: 'red' })
    rendered_html = icon.render

    assert_includes rendered_html, 'class="custom-class"'
    assert_includes rendered_html, 'fill="red"'
  end

  def test_render_with_invalid_variant_raises_error
    assert_raises ArgumentError do
      RailsuiIcon::Icon.new(name: 'user', variant: :invalid_variant)
    end
  end
end
