module RailsuiIcon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer_file
        template "railsui_icon.rb", "config/initializers/railsui_icon.rb"
      end

      def update_tailwind_config
        tailwind_config_path = Rails.root.join("tailwind.config.js")
        return unless File.exist?(tailwind_config_path)

        insert_into_file tailwind_config_path.to_s, after: /content: \[\n/ do
          "    \"./config/initializers/railsui_icon.rb\",\n"
        end
      end
    end
  end
end
