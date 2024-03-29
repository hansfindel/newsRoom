# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'local_test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
#require 'capybara/poltergeist'
#Capybara.javascript_driver = :poltergeist
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
#  config.include Mongoid::Matchers

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Clean up the database
  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    #DatabaseCleaner.clean
  end

end

##### methods to login 
def login_as_admin
  @admin ||= (User.where(role: 1).first || create(:user_admin))
  visit log_in_path
  fill_in "email", :with => @admin.email
  fill_in "password", :with => "1234"#@user.password
  click_button "Log in"
end

def login_as_editor
  @admin ||= (User.where(role: 4).first || create(:editor))
  visit log_in_path
  fill_in "email", :with => @admin.email
  fill_in "password", :with => "1234"#@user.password
  click_button "Log in"
end

def login_as_journalist
  @journalist ||= (User.where(role: 2).first || create(:journalist))
  visit log_in_path
  fill_in "email", :with => @journalist.email
  fill_in "password", :with => "1234"#@user.password
  click_button "Log in"
end

def login_as_chief_editor
  @chief ||= (User.where(role: 8).first || create(:chief_editor))
  visit log_in_path
  fill_in "email", :with => @chief.email
  fill_in "password", :with => "1234"
  click_button "Log in"
end

def login_as_chief_editor_country
  @ecountry ||= (User.where(role: 16).first || create(:chief_editor_country))
  visit log_in_path
  fill_in "email", :with => @ecountry.email
  fill_in "password", :with => "1234"
  click_button "Log in"
end