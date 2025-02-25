source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
# gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end

gem "litestream", "~> 0.10.1"

gem "sitepress-rails", "~> 4.0"
gem "sitepress-pagefind"

gem "importmap-rails", "~> 2.0"

gem "markdown-rails", "~> 2.1"

gem "rouge", "~> 4.2"

gem "sitemap_generator", "~> 6.3"

gem "active_hash", "~> 3.3"

gem "heroicon", "~> 1.0"

gem "meta-tags", "~> 2.21"
# Ensure all SQLite connections are properly configured
gem "activerecord-enhancedsqlite3-adapter", "~> 0.8.0"
# Add Solid Queue for background jobs
gem "solid_queue", "~> 1.0"
# Add a web UI for Solid Queue
gem "mission_control-jobs", "~> 0.3"
# Add Solid Cache as an Active Support cache store
gem "solid_cache", "~> 1.0"
# Add Solid Cable for web sockets
gem "solid_cable", "~> 3.0"
# Add Solid Errors for error monitoring
gem "solid_errors", "~> 0.5"

gem "authentication-zero", "~> 4.0"
# Use OmniAuth to support multi-provider authentication [https://github.com/omniauth/omniauth]
gem "omniauth"
# Provides a mitigation against CVE-2015-9284 [https://github.com/cookpad/omniauth-rails_csrf_protection]
gem "omniauth-rails_csrf_protection"

# authenticate via omniauth
gem "omniauth-patreon"

# build a Patreon client
gem "httparty"
gem "ahoy_matey"

gem "pundit", "~> 2.4"
