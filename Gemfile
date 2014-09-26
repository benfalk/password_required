source 'https://rubygems.org'
ruby '2.1.2'
gem 'sqlite3'

# Get the rails version for testing
rails_version = ENV['RAILS_VERSION'] || 'default'
puts rails_version
rails = case rails_version
        when 'master'
          { github: 'rails/rails' }
        when 'default'
          '~> 4.1'
        else
          "~> #{rails_version}"
        end

gem 'rails', rails

# Declare your gem's dependencies in password_required.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :development, :test do
  gem 'rubocop'
  gem 'faker'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rspec-its'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'quiet_assets'
  gem 'spring'
  gem 'pry'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
