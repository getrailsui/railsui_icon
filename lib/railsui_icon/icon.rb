# frozen_string_literal: true

module RailsuiIcon
  class Icon
    attr_reader :name, :variant, :library, :custom_path, :options

    def initialize(name, variant: nil, library: nil, custom_path: nil, **options)
      @name = name.to_s.downcase  # Normalize case
      @variant = (variant || RailsuiIcon.configuration.default_variant).to_sym
      @library = (library || RailsuiIcon.configuration.default_library).to_sym
      @custom_path = custom_path
      @options = options
    end

    def to_svg
      svg_content = fetch_svg_content
      return default_svg if svg_content.nil?

      apply_options_to_svg(svg_content)
    end

    private

    def fetch_svg_content
      cache_key = "#{@library}/#{@variant}/#{@name}"

      if defined?(Rails) && Rails.env.production? && Rails.cache
        Rails.cache.fetch("railsui_icon/#{cache_key}") do
          read_svg_content
        end
      else
        read_svg_content
      end
    end

    def read_svg_content
      # This bypasses the security validation in resolve_custom_path
      if @custom_path
        return File.read(@custom_path) if File.exist?(@custom_path)
      end

      # Try path-based resolution (e.g., "heroicons/solid/home")
      custom_resolved_path = resolve_path_based_name
      return File.read(custom_resolved_path) if custom_resolved_path && File.exist?(custom_resolved_path)

      # Check if this library uses flat structure
      if library_uses_flat_structure?(@library)
        svg_path = flat_icon_path(@library)
        if svg_path && File.exist?(svg_path)
          if File.size(svg_path) > 1.megabyte
            Rails.logger.warn "RailsuiIcon: Icon file too large: #{svg_path}" if defined?(Rails)
            return nil
          end
          return File.read(svg_path)
        end
      else
        # Try the configured library and requested variant
        svg_path = icon_path(@library, @variant)
        return File.read(svg_path) if File.exist?(svg_path)

        # Fallback: try other variants in the same library
        fallback_variants.each do |fallback_variant|
          svg_path = icon_path(@library, fallback_variant)
          return File.read(svg_path) if File.exist?(svg_path)
        end
      end

      nil
    rescue => e
      Rails.logger.warn "RailsuiIcon: Error reading icon #{@name} (#{@library}/#{@variant}): #{e.message}" if defined?(Rails)
      nil
    end

    def gem_root_path
      # Find the gem root by looking for the gemspec file
      current_dir = File.dirname(__FILE__)

      # Keep going up directories until we find the gemspec
      while current_dir != "/" && current_dir != "."
        if Dir.glob(File.join(current_dir, "*.gemspec")).any?
          return current_dir
        end
        current_dir = File.dirname(current_dir)
      end

      # Fallback to the old method
      File.expand_path("../../..", __FILE__)
    end

    def icons_base_path
      # This file is at: lib/railsui_icon/icon.rb
      # Icons are at: lib/railsui_icon/icons/
      File.join(File.dirname(__FILE__), "icons")
    end

    def icon_path(library, variant)
      # First try the Rails app directory (for user customization)
      if defined?(Rails) && Rails.root
        app_path = Rails.root.join("app", "assets", "icons", library.to_s, variant.to_s, "#{@name}.svg")
        return app_path if File.exist?(app_path)
      end

      # Then try the gem's icons directory
      gem_path = File.join(icons_base_path, library.to_s, variant.to_s, "#{@name}.svg")
      return gem_path if File.exist?(gem_path)

      # Return the app path as fallback
      defined?(Rails) && Rails.root ? Rails.root.join("app", "assets", "icons", library.to_s, variant.to_s, "#{@name}.svg") : gem_path
    end

    def flat_icon_path(library)
      # First try the Rails app directory
      if defined?(Rails) && Rails.root
        app_path = Rails.root.join("app", "assets", "icons", library.to_s, "#{@name}.svg")
        return app_path if File.exist?(app_path)
      end

      # Then try the gem's icons directory
      gem_path = File.join(icons_base_path, library.to_s, "#{@name}.svg")
      return gem_path if File.exist?(gem_path)

      defined?(Rails) && Rails.root ? Rails.root.join("app", "assets", "icons", library.to_s, "#{@name}.svg") : gem_path
    end

    def library_uses_flat_structure?(library)
      # Check Rails app directory first
      if defined?(Rails) && Rails.root
        app_library_path = Rails.root.join("app", "assets", "icons", library.to_s)
        if Dir.exist?(app_library_path)
          return Dir.glob(File.join(app_library_path, "*.svg")).any?
        end
      end

      # Check gem directory
      gem_library_path = File.join(icons_base_path, library.to_s)
      return false unless Dir.exist?(gem_library_path)

      Dir.glob(File.join(gem_library_path, "*.svg")).any?
    end

    def resolve_path_based_name
      # Handle explicit paths in the name (e.g., "heroicons/solid/home")
      if @name.include?("/")
        parts = @name.split("/")
        if parts.length == 3
          # Format: library/variant/icon_name
          library, variant, icon_name = parts
          icon_name = icon_name.sub(/\.svg$/, '')

          # Try Rails app first
          if defined?(Rails) && Rails.root
            app_path = Rails.root.join("app", "assets", "icons", library, variant, "#{icon_name}.svg")
            return app_path if File.exist?(app_path)
          end

          # Try gem directory
          gem_path = File.join(icons_base_path, library, variant, "#{icon_name}.svg")
          return gem_path if File.exist?(gem_path)

        elsif parts.length == 2
          # Format: variant/icon_name (using configured library)
          variant, icon_name = parts
          icon_name = icon_name.sub(/\.svg$/, '')

          # Try Rails app first
          if defined?(Rails) && Rails.root
            app_path = Rails.root.join("app", "assets", "icons", @library.to_s, variant, "#{icon_name}.svg")
            return app_path if File.exist?(app_path)
          end

          # Try gem directory
          gem_path = File.join(icons_base_path, @library.to_s, variant, "#{icon_name}.svg")
          return gem_path if File.exist?(gem_path)
        end
      end

      nil
    end

    def fallback_variants
      case @library
      when :feather
        [] # Flat structure, no variants
      when :boxicons
        [:outline, :solid] - [@variant]
      when :phosphoric
        [:bold, :duotone, :fill, :light, :regular, :thin] - [@variant]
      when :solar
        [:linear, :outline, :broken, :bold, :bold_duotone, :line_duotone] - [@variant]
      when :heroicons
        [:outline, :solid, :mini, :micro] - [@variant]
      when :lucide
        [] # Flat structure, no variants
      else
        [:outline, :solid, :linear] - [@variant]
      end
    end

    def apply_options_to_svg(svg_content)
      doc = Nokogiri::HTML::DocumentFragment.parse(svg_content)
      svg = doc.at_css("svg")

      return svg_content unless svg

      # Basic XSS protection - remove script tags and event handlers
      svg.xpath(".//script").remove
      svg.xpath(".//*[@*[starts-with(name(), 'on')]]").each do |node|
        node.attributes.each { |name, attr| node.remove_attribute(name) if name.start_with?('on') }
      end

      # Apply CSS classes
      css_classes = build_css_classes
      svg["class"] = css_classes if css_classes.present?

      # Apply other HTML attributes
      @options.each do |key, value|
        next if key == :class
        svg[key.to_s] = value.to_s
      end

      doc.to_html.html_safe
    end

    def build_css_classes
      classes = []

      # Add this check
      return @options[:class].to_s if @options[:disable_default_class]

      # For flat libraries, use the library name as the variant for class lookup
      lookup_variant = library_uses_flat_structure?(@library) ? @library : @variant

      # Add default classes for this library/variant
      default_class = RailsuiIcon.configuration.default_class_for(@library, lookup_variant)
      classes << default_class if default_class.present?

      # Add custom classes from options
      classes << @options[:class] if @options[:class].present?

      classes.join(" ").strip
    end

    def default_svg
      %(<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 3.75h.008v.008H12v-.008Z" /></svg>).html_safe
    end
  end
end
