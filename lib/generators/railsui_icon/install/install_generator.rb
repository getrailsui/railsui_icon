module RailsuiIcon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer_file
        template "railsui_icon.rb", "config/initializers/railsui_icon.rb"
      end
    end
  end
end
