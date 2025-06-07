#!/usr/bin/env ruby

require 'pathname'

# run `ruby scripts/list_icons.rb` to list everything. There's a lot here...

# Get the gem root directory
gem_root = Pathname.new(__FILE__).dirname.parent
icons_base = gem_root.join('lib', 'railsui_icon', 'icons')

puts "=" * 80
puts "RAILSUI ICON - Available Icons"
puts "=" * 80
puts "Icons directory: #{icons_base}"
puts "Directory exists: #{icons_base.exist?}"

if icons_base.exist?
  icons_base.children.select(&:directory?).sort.each do |library_path|
    library_name = library_path.basename.to_s
    puts "\n📁 #{library_name.upcase} LIBRARY"
    puts "-" * 40

    # Check for SVG files directly in library folder (flat structure)
    svg_files = library_path.glob("*.svg")

    if svg_files.any?
      puts "Structure: Flat (no variants)"
      puts "Icons:"
      svg_files.sort.each do |file|
        puts "  • #{file.basename('.svg')}"
      end
    else
      # Check for variant folders (nested structure)
      variant_dirs = library_path.children.select(&:directory?)

      if variant_dirs.any?
        puts "Structure: Nested (with variants)"
        variant_dirs.sort.each do |variant_path|
          variant_name = variant_path.basename.to_s
          icons = variant_path.glob("*.svg").map { |f| f.basename('.svg').to_s }.sort

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
else
  puts "❌ Icons directory not found!"
end
