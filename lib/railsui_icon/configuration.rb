# frozen_string_literal: true

module RailsuiIcon
  class Configuration
    attr_accessor :default_class, :default_variant

    def initialize
      @default_class = ""
      @default_variant = :outline
    end
  end
end
