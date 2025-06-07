# frozen_string_literal: true

module RailsuiIcon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_initializer
        config_file = "config/initializers/railsui_icon.rb"

        if File.exist?(Rails.root.join(config_file))
          say "Existing Rails UI Icon configuration found.", :yellow
          if yes?("Do you want to backup and regenerate the configuration file? (y/n)")
            copy_file "railsui_icon.rb.tt", "#{config_file}.backup"
            say "Backed up existing config to #{config_file}.backup", :green
            template "railsui_icon.rb.tt", config_file, force: true
          else
            say "Skipping configuration file generation. Your existing config will continue to work.", :blue
          end
        else
          template "railsui_icon.rb.tt", config_file
        end
      end
    end
  end
end
