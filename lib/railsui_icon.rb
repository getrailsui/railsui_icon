require "nokogiri"
require "railsui_icon/version"
require "railsui_icon/configuration"
require "railsui_icon/icon"
require "railsui_icon/helpers"
require "railsui_icon/railtie" if defined?(Rails)

module RailsuiIcon
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end

    # Add this for thread safety
    def reset_configuration!
      @configuration = nil
    end
  end
end
