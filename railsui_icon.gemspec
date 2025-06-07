require_relative "lib/railsui_icon/version"

Gem::Specification.new do |spec|
  spec.name = "railsui_icon"
  spec.version = RailsuiIcon::VERSION
  spec.authors = ["Andy Leverenz"]
  spec.email = ["info@railsui.com"]
  spec.homepage = "https://github.com/getrailsui/railsui_icon"
  spec.summary = "Icon helper for Rails applications"
  spec.description = "Render Heroicons, Solar Icons, and Lucide Icons in Rails applications"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/getrailsui/railsui_icon"

  # Include the icon assets in the gem
  spec.files = Dir["{lib}/**/*", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", ">= 1.6"
  spec.add_dependency "rails", ">= 6.0"

  spec.add_dependency "logger" if RUBY_VERSION >= "3.4"
  spec.add_dependency "benchmark" if RUBY_VERSION >= "3.4"

  spec.add_development_dependency "standard"
  spec.add_development_dependency "sqlite3", "~> 1.4"
end
