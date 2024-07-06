require_relative "lib/railsui_icon/version"

Gem::Specification.new do |spec|
  spec.name = "railsui_icon"
  spec.version = RailsuiIcon::VERSION
  spec.authors = ["Andy Leverenz"]
  spec.email = ["andy@justalever.com"]
  spec.homepage = "https://github.com/getrailsui/railsui_icon"
  spec.summary = "Rails UI Icon simplifies integrating svg icons into Ruby on Rails apps for seamless UI development."
  spec.description = "Rails UI Icon is a gem designed to integrate SVG icons into Ruby on Rails applications. It provides a rich library of SVG icons, helpers, and options making it a drop-in easy-to-use tool."
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
