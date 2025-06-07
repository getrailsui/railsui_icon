# frozen_string_literal: true

module RailsuiIcon
  module Helpers
    include ActionView::Helpers::AssetUrlHelper

    # Renders an SVG icon
    #
    # @param name [String] The icon name
    # @param variant [Symbol] The icon variant (:solid, :outline, etc.)
    # @param library [Symbol] The icon library (:heroicons, :solar, :lucide)
    # @param options [Hash] Additional HTML attributes
    # @return [String] HTML-safe SVG markup
    def icon(name, variant: nil, library: nil, **options)
      # Handle custom_path option if provided
      custom_path = resolve_custom_path(options[:custom_path]) if options[:custom_path]

      # Use passed library or fall back to configured default
      library = library || RailsuiIcon.configuration.default_library

      icon = RailsuiIcon::Icon.new(name, variant: variant, library: library, custom_path: custom_path, **options)
      icon.to_svg
    end

    # Keep the old method name for backward compatibility
    alias_method :railsui_icon, :icon

    private

    def resolve_custom_path(path)
      return unless path

      # Use Rails asset pipeline consistently
      if path.to_s.start_with?('/')
        Rails.root.join('app', 'assets', 'images', path.to_s.sub(/^\//, ''))
      else
        ActionController::Base.helpers.asset_path(path.to_s)
      end
    end
  end
end
