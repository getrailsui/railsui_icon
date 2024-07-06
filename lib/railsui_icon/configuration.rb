# frozen_string_literal: true

module RailsuiIcon
  class Configuration
    attr_accessor :default_class, :default_variant, :custom_icon_paths

    def initialize
      @default_class = ""
      @default_variant = :outline
      @custom_icon_paths = []
    end
  end
end
