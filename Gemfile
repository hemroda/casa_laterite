source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# AWS SDK for Ruby on Rails Plugin (https://github.com/aws/aws-sdk-rails)
gem "aws-sdk-rails", "~> 3.7.1"

# Boot large ruby/rails apps faster (https://github.com/Shopify/bootsnap)
gem "bootsnap", require: false

# Bundle and process CSS with Tailwind, Bootstrap, PostCSS, Sass in Rails via Node.js. (https://github.com/rails/cssbundling-rails)
gem "cssbundling-rails"

# Flexible authentication solution for Rails with Warden (https://github.com/heartcombo/devise)
gem "devise", "~> 4.8.1"

# ActiveRecord soft-deletes done right (https://github.com/jhawthorn/discard)
gem "discard", "~> 1.2.1"

# Rails View Helpers for Heroicons. (https://github.com/bharget/heroicon)
gem "heroicon", "~> 1.0.0"

# High-level wrapper for processing images for the web with ImageMagick or libvips. (https://github.com/janko/image_processing)
gem "image_processing", "~> 1.2"

# Create JSON structures via a Builder-style DSL (https://github.com/rails/jbuilder)
gem "jbuilder"

# Bundle and transpile JavaScript in Rails with esbuild, rollup.js, or Webpack. (https://github.com/rails/jsbundling-rails)
gem "jsbundling-rails"

# The kick-ass pagination ruby gem (https://github.com/ddnexus/pagy)
gem "pagy", "~> 6.0.0"

# Pg is the Ruby interface to the PostgreSQL RDBMS (https://github.com/ged/ruby-pg)
gem "pg", "~> 1.1"

# Puma is a simple, fast, threaded, and highly parallel HTTP 1.1 server for Ruby/Rack applications (https://puma.io)
gem "puma", "~> 5.0"

# Full-stack web application framework. (https://rubyonrails.org)
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# Object-based searching for Active Record. (https://github.com/activerecord-hackery/ransack)
gem "ransack", "~> 3.2.1"

# Markdown that smells nice (https://github.com/vmg/redcarpet)
gem "redcarpet", "~> 3.6.0"

# A Ruby client library for Redis (https://github.com/redis/redis-rb)
gem "redis", "~> 4.0"

# Simple, efficient background processing for Ruby (https://sidekiq.org)
gem "sidekiq", "~> 7.0.4"

# Forms made easy! (https://github.com/heartcombo/simple_form)
gem "simple_form", "~> 5.1.0"

# Sprockets Rails integration (https://github.com/rails/sprockets-rails)
gem "sprockets-rails"

# A modest JavaScript framework for the HTML you already have. (https://stimulus.hotwired.dev)
gem "stimulus-rails"

# The speed of a single-page web application without having to write any JavaScript. (https://github.com/hotwired/turbo-rails)
gem "turbo-rails"

# Timezone Data for TZInfo (https://tzinfo.github.io)
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Use Sass to process CSS
# gem "sassc-rails"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

group :development do
  # Annotates Rails Models, routes, fixtures, and others based on the database schema. (http://github.com/ctran/annotate_models)
  gem "annotate", "~> 3.2.0"

  # Better error page for Rails and other Rack apps (https://github.com/BetterErrors/better_errors)
  gem "better_errors", "~> 2.9.1"

  # Retrieve the binding of a method's caller, or further up the stack. (https://github.com/banister/binding_of_caller)
  gem "binding_of_caller", "~> 1.0.0"

  # Preview mail in browser instead of sending. (https://github.com/ryanb/letter_opener)
  gem "letter_opener", "~> 1.8.1"

  # A debugging tool for your Ruby on Rails applications. (https://github.com/rails/web-console)
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # RSpec for Rails (https://github.com/rspec/rspec-rails)
  gem "rspec-rails", "~> 6.0.1"
end

group :development, :test do
  # help to kill N+1 queries and unused eager loading. (https://github.com/flyerhzm/bullet)
  gem "bullet", "~> 7.0.7", require: true

  # Debugging functionality for Ruby (https://github.com/ruby/debug)
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer (https://github.com/thoughtbot/factory_bot_rails)
  gem "factory_bot_rails", "~> 6.2.0"

  # Easily generate fake data (https://github.com/faker-ruby/faker)
  gem "faker", "~> 2.19.0"
end
