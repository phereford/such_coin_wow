ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/rails'
require 'factory_girl_rails'
require 'capybara/poltergeist'
require 'vcr'
require 'webmock/rspec'
require 'coveralls'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

Coveralls.wear! 'rails'
SimpleCov.start 'rails'
Capybara.javascript_driver = :poltergeist
DatabaseCleaner.strategy = :truncation
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

VCR.configure do |config|
  config.cassette_library_dir = 'fixutres/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { :record => :new_episodes, :erb => true }
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
  config.include CoinHelper, type: :model
  config.include DynamicCoinKlassHelper
end
