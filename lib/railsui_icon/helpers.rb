# frozen_string_literal: true

module RailsuiIcon
  module Helpers
    include ActionView::Helpers::AssetUrlHelper

    def icon(name, options = {})
      options[:variant] ||= :outline
      options[:class] = options.fetch(:class, nil)
      custom_path = resolve_custom_path(options[:custom_path])

      result = RailsuiIcon::Icon.render(name: name, variant: options[:variant], options: options, custom_path: custom_path)

      result.html_safe
    end

    private

    def resolve_custom_path(path)
      return unless path

      if Rails.application.config.assets.paths.any? { |p| path.to_s.start_with?(p.to_s) }
        path.to_s
      else
        ActionController::Base.helpers.asset_path(path.to_s)
      end
    end
  end
end
