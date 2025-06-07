# frozen_string_literal: true

module RailsuiIcon
  class Configuration
    attr_accessor :default_variant, :default_library, :default_class

    def initialize
      @default_variant = :outline
      @default_library = :heroicons
      @default_class = {}
    end

    def default_library=(library)
      unless [:boxicons, :feather, :heroicons, :lucide, :solar, :phosphoric].include?(library.to_sym)
        raise ArgumentError, "Invalid library: #{library}. Must be one of: boxicons, feather, heroicons, lucide, or solar"
      end
      @default_library = library.to_sym
    end

    # Helper method to get default class for a library/variant combination
    def default_class_for(library, variant)
      return "" unless @default_class.is_a?(Hash)

      # Support both nested (library -> variant) and flat (variant) structures
      if @default_class.key?(library.to_sym)
        library_config = @default_class[library.to_sym]
        return library_config[variant.to_sym] if library_config.is_a?(Hash) && library_config.key?(variant.to_sym)
      end

      # Fallback to flat structure for backward compatibility
      @default_class[variant.to_sym] || ""
    end
  end
end
