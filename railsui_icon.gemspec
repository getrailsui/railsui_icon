require_relative "lib/railsui_icon/version"

Gem::Specification.new do |spec|
  spec.name = "railsui_icon"
  spec.version = RailsuiIcon::VERSION
  spec.authors = ["Andy Leverenz"]
  spec.email = ["andy@justalever.com"]
  spec.homepage = "https://github.com/getrailsui/railsui_icon"
  spec.summary = "Icons for Ruby or Rails apps"
  spec.description = "Helpers for rendering icons with or without Rails UI"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/getrailsui/railsui_icon"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 5.2"

  spec.add_development_dependency "standard"
  spec.add_development_dependency "sqlite3", "~> 1.4"
end
