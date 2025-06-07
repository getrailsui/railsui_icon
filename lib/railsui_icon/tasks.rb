# frozen_string_literal: true

namespace :railsui_icon do
  desc "List all available icons by library and variant"
  task :list do
    puts "=" * 80
    puts "RAILSUI ICON - Available Icons"
    puts "=" * 80

    # Get the gem's icon directory
    gem_spec = Gem::Specification.find_by_name('railsui_icon')
    icons_base = File.join(gem_spec.gem_dir, 'lib', 'railsui_icon', 'icons')

    unless Dir.exist?(icons_base)
      puts "❌ Icons directory not found at: #{icons_base}"
      return
    end

    Dir.glob(File.join(icons_base, "*")).sort.each do |library_path|
      next unless File.directory?(library_path)

      library_name = File.basename(library_path)
      puts "\n📁 #{library_name.upcase} LIBRARY"
      puts "-" * 40

      # Check if it's a flat structure (like Lucide)
      svg_files = Dir.glob(File.join(library_path, "*.svg"))

      if svg_files.any?
        # Flat structure
        puts "Structure: Flat (no variants)"
        puts "Icons:"
        svg_files.sort.each do |file|
          icon_name = File.basename(file, ".svg")
          puts "  • #{icon_name}"
        end
      else
        # Nested structure with variants
        variants = Dir.glob(File.join(library_path, "*")).select { |f| File.directory?(f) }

        if variants.any?
          puts "Structure: Nested (with variants)"
          variants.sort.each do |variant_path|
            variant_name = File.basename(variant_path)
            icons = Dir.glob(File.join(variant_path, "*.svg")).map { |f| File.basename(f, ".svg") }.sort

            puts "\n  📂 #{variant_name} variant:"
            if icons.any?
              icons.each { |icon| puts "    • #{icon}" }
            else
              puts "    (no icons found)"
            end
          end
        else
          puts "  (no variants or icons found)"
        end
      end
    end

    puts "\n" + "=" * 80
    puts "USAGE EXAMPLES"
    puts "=" * 80
    puts
    puts "Basic usage:"
    puts '  <%= icon "star" %>'
    puts
    puts "Specify library and variant:"
    puts '  <%= icon "star", library: :heroicons, variant: :solid %>'
    puts '  <%= icon "star", library: :solar, variant: :linear %>'
    puts '  <%= icon "star", library: :lucide %>'
    puts
    puts "Path-based naming:"
    puts '  <%= icon "heroicons/solid/star" %>'
    puts '  <%= icon "solar/linear/star" %>'
    puts
    puts "With custom classes:"
    puts '  <%= icon "star", class: "size-8 text-red-500" %>'
    puts
  end

  desc "Generate markdown documentation of all available icons"
  task :docs do
    gem_spec = Gem::Specification.find_by_name('railsui_icon')
    icons_base = File.join(gem_spec.gem_dir, 'lib', 'railsui_icon', 'icons')

    unless Dir.exist?(icons_base)
      puts "❌ Icons directory not found at: #{icons_base}"
      return
    end

    File.open("ICONS.md", "w") do |f|
      f.puts "# RailsUI Icon - Available Icons"
      f.puts
      f.puts "This document lists all available icons in the RailsUI Icon gem."
      f.puts
      f.puts "## Libraries"
      f.puts

      Dir.glob(File.join(icons_base, "*")).sort.each do |library_path|
        next unless File.directory?(library_path)

        library_name = File.basename(library_path)
        f.puts "### #{library_name.capitalize}"
        f.puts

        # Check if it's a flat structure
        svg_files = Dir.glob(File.join(library_path, "*.svg"))

        if svg_files.any?
          # Flat structure
          f.puts "**Structure:** Flat (no variants)"
          f.puts
          f.puts "**Available Icons:**"
          f.puts
          svg_files.sort.each do |file|
            icon_name = File.basename(file, ".svg")
            f.puts "- `#{icon_name}`"
          end
          f.puts
          f.puts "**Usage:**"
          f.puts ""
          f.puts "<%= icon \"#{svg_files.first ? File.basename(svg_files.first, '.svg') : 'icon_name'}\", library: :#{library_name} %>"
          f.puts ""
        else
          # Nested structure
          f.puts "**Structure:** Nested (with variants)"
          f.puts

          variants = Dir.glob(File.join(library_path, "*")).select { |f| File.directory?(f) }

          variants.sort.each do |variant_path|
            variant_name = File.basename(variant_path)
            icons = Dir.glob(File.join(variant_path, "*.svg")).map { |f| File.basename(f, ".svg") }.sort

            f.puts "#### #{variant_name.capitalize} Variant"
            f.puts

            if icons.any?
              f.puts "**Available Icons:**"
              f.puts
              icons.each { |icon| f.puts "- `#{icon}`" }
              f.puts
              f.puts "**Usage:**"
              f.puts ""
              f.puts "<%= icon \"#{icons.first}\", library: :#{library_name}, variant: :#{variant_name} %>"
              f.puts "<%= icon \"#{library_name}/#{variant_name}/#{icons.first}\" %>"
              f.puts ""
            else
              f.puts "*No icons found in this variant.*"
            end
            f.puts
          end
        end
        f.puts "---"
        f.puts
      end
    end

    puts "✅ Documentation generated: ICONS.md"
  end

  desc "Show icon directory path"
  task :path do
    gem_spec = Gem::Specification.find_by_name('railsui_icon')
    icons_base = File.join(gem_spec.gem_dir, 'lib', 'railsui_icon', 'icons')
    puts "Icons directory: #{icons_base}"
    puts "Directory exists: #{Dir.exist?(icons_base)}"

    if Dir.exist?(icons_base)
      puts "\nLibraries found:"
      Dir.glob(File.join(icons_base, "*")).each do |path|
        if File.directory?(path)
          puts "  📁 #{File.basename(path)}"
        end
      end
    end
  end
end
