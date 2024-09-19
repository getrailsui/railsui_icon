require "railsui_icon/version"
require "railsui_icon/engine"
require "railsui_icon/railtie"
require "railsui_icon/helpers"
require "railsui_icon/icon"
require "railsui_icon/configuration"

module RailsuiIcon
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def root
      File.dirname(__dir__)
    end
  end
end
