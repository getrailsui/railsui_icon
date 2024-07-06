# frozen_string_literal: true

module RailsuiIcon
  module Helpers
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

      if path.start_with?("/")
        Rails.root.join("app", "assets", path)
      else
        path
      end
    end
  end
end
