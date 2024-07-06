module RailsuiIcon
  class Railtie < ::Rails::Railtie
    config.railsui_icon = ActiveSupport::OrderedOptions.new

    initializer "railsui_icon.configure" do |app|
      config_file = Rails.root.join("config", "initializers", "railsui_icon.rb")
      app.config.railsui_icon.config_file = config_file

      # Load the configuration file if it exists
      load_configuration(config_file)
    end

    def load_configuration(file_path)
      if File.exist?(file_path)
        config = Rails.application.config.railsui_icon
        config_contents = File.read(file_path)
        config.instance_eval(config_contents)
      end
    end

    rake_tasks do
      load "tasks/railsui_icon_tasks.rake"
    end

    initializer "railsui_icon.action_view" do
      ActiveSupport.on_load(:action_view) do
        include RailsuiIcon::Helpers
      end
    end

    def self.post_install_message
      puts "To configure, run: rails g railsui_icon:install"
    end
  end
end
