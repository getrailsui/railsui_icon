# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [File.expand_path("fixtures", __dir__)]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures", __dir__) + "/files"
  ActiveSupport::TestCase.fixtures :all
end

# Add your engine's test path to autoload paths
$LOAD_PATH.unshift File.expand_path("../lib", __dir__) # Adjust path as necessary

# Load RailsuiIcon engine files
require "railsui_icon/version"
require "railsui_icon/engine"
require "railsui_icon/railtie"
require "railsui_icon/helpers"
require "railsui_icon/configuration"
require "railsui_icon/icon"
