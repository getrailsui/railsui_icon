require "nokogiri"

module RailsuiIcon
  class Icon
    VALID_VARIANTS = %i[solid outline mini micro].freeze

    attr_reader :name, :variant, :options, :custom_path

    def initialize(name:, variant: RailsuiIcon.configuration.default_variant, options: {}, custom_path: nil)
      @name = name
      @variant = validate_variant(variant)
      @options = options
      @custom_path = custom_path
    end

    def render
      if custom_path
        render_custom_path(custom_path)
      else
        render_standard_icon
      end
    rescue StandardError => e
      Rails.logger.error "Failed to render icon: #{e.message}"
      warning
    end

    private

    def render_standard_icon
      return warning unless file_exists?

      doc = parse_file
      svg = doc.at_css "svg"

      return warning unless svg

      update_svg_attributes(svg)
      apply_default_class(svg)

      doc.to_html
    end

    def render_custom_path(custom_path)
      return warning if custom_path.blank?

      # Extract file name from custom_path
      file_name = File.basename(URI.parse(custom_path).path)

      # Attempt to find the asset in subdirectories of app/assets/images
      asset_path = find_asset_path(file_name)

      raise ArgumentError, "Asset path cannot be found" if asset_path.nil?

      # Read the SVG content
      svg_content = File.read(asset_path)
      doc = Nokogiri::HTML::DocumentFragment.parse(svg_content)
      svg = doc.at_css('svg')

      return warning unless svg

      update_svg_attributes(svg)
      apply_default_class(svg)

      doc.to_html
    rescue StandardError => e
      Rails.logger.error "Failed to render icon: #{e.message}"
      warning
    end

    private

    def find_asset_path(file_name)
      # Check in the main app/assets/images directory
      path = Rails.root.join('app/assets/images', file_name)
      return path.to_s if File.exist?(path)

      # Check in any subdirectories within app/assets/images
      Dir[Rails.root.join('app/assets/images/**/*', file_name)].first
    end
    private

    def find_asset_path(file_name)
      # Check in the main app/assets/images directory
      path = Rails.root.join('app/assets/images', file_name)
      return path.to_s if File.exist?(path)

      # Check in any subdirectories within app/assets/images
      Dir[Rails.root.join('app/assets/images/**/*', file_name)].first
    end

    def file_path
      File.join(RailsuiIcon.root, "lib/railsui_icon/icons/#{variant}/#{name}.svg")
    end

    def file_exists?
      File.exist?(file_path)
    end

    def parse_file
      Nokogiri::HTML::DocumentFragment.parse(File.read(file_path).force_encoding("UTF-8"))
    end

    def update_svg_attributes(svg)
      update_svg_options(svg)
    end

    def update_svg_options(svg)
      options.each do |key, value|
        svg[key.to_s.dasherize] = value
      end
    end

    def apply_default_class(svg)
      return if disable_default_class?

      default_classes = combine_classes_with_default_class
      svg[:class] = default_classes if default_classes.present?
    end

    def combine_classes_with_default_class
      default_class_list.concat(additional_class_list).uniq.join(" ")
    end

    def default_class_list
      default_class.split.compact
    end

    def additional_class_list
      (options[:class] || "").split.compact
    end

    def default_class
      config_default_class = RailsuiIcon.configuration.default_class
      config_default_class.is_a?(Hash) ? config_default_class[variant] : config_default_class.to_s
    end

    def disable_default_class?
      options.delete(:disable_default_class)
    end

    def validate_variant(provided_variant)
      unless VALID_VARIANTS.include?(provided_variant.to_sym)
        raise ArgumentError, "Invalid variant: #{provided_variant}. Valid variants are: #{VALID_VARIANTS.join(', ')}"
      end

      provided_variant.to_sym
    end

    def warning
      "<svg><text>Icon not found: #{name}</text></svg>"
    end

    class << self
      def render(**kwargs)
        new(**kwargs).render
      end
    end
  end
end
