# Settings
# ========
source 'http://rubygems.org'

# Rails
# =====
gem 'rails', '~> 3.2.14' # Because it makes sense, and bundler fails otherwise
gem 'unicorn'

# Database
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'sprockets'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
end
group :production do
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

# Development
# ===========
group :development do
  # RDoc
  gem 'rdoc'

  gem 'quiet_assets'

  #####################################################
  # Capistrano Deployment
  #####################################################

  gem 'capistrano'#, '~> 3.4.0' # deployment
  gem 'capistrano-bundler', require: false # deployment bundler hooks
  gem 'capistrano-rails', require: false # deployment rails hooks
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'

end

group :test, :development do
  # Framework
  gem 'rspec-rails'

  # Matchers/Helpers
  gem 'shoulda-matchers'
  gem 'json_spec'

  # Fixtures
  gem 'factory_girl_rails'
  gem 'database_cleaner'

  # Browser
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'

  # Console
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
end

# Standard helpers
# ================
gem 'haml-rails'

# Navigation
gem 'simple-navigation'

# Styling
gem 'lyb_sidebar'
gem 'anjlab-bootstrap-rails', '~>2.1.0', :require => 'bootstrap-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-will_paginate'

# Form framework
gem 'simple_form'
gem 'select2-rails'

# CRUD
gem 'will_paginate'
gem 'inherited_resources'
gem 'has_scope'
gem 'i18n_rails_helpers'
gem 'responders'

# Access Control
gem 'devise', '~>3.0.4' # Config changes
gem 'omniauth-google-oauth2'
gem 'faraday'
gem 'cancancan'
gem 'lyb_devise_admin'
gem 'apartment'

# API
gem 'versionist'
gem 'active_model_serializers'

gem 'api_taster'

# Data dump/restore
gem 'yaml_db'

# Date/Time handling
gem 'validates_timeliness'

gem 'show_for'

# Locale setting
gem 'routing-filter'

# Application Settings
gem 'ledermann-rails-settings'

# Bookyt
# ======
# Accounting
gem 'has_accounts'
gem 'has_accounts_engine', '~> 3.0.0.beta5'

# Addresses
gem 'has_vcards'

# Uploads
gem 'carrierwave'

# In-Place Edit
gem 'best_in_place'

# PDF generation
gem 'pdfkit'
gem 'wkhtmltopdf-binary'

gem 'prawn', '~> 0.12' # API incompatible
gem 'prawn_rails'

# Raiffeisen BookingImport
gem 'csv-mapper'

gem 'mt940_parser', :git => 'http://github.com/CyTeam/mt940_parser.git', :require => 'mt940'

# ESR support
gem 'aasm', '~> 3.0' # API incompatible
gem 'vesr'

# Search
gem 'pg_search'

# Tagging
gem 'acts-as-taggable-on', '~> 2.4.1' # API incompatible

# Plugins
# =======
# Uncomment to enable plugins
gem 'bookyt_pos'
gem 'bookyt_salary'
gem 'bookyt_stock'
gem 'bookyt_projects'

# Monitoring
# ==========
gem 'settingslogic'



# SILVERMIND EXTENSIONS
# =====================

# Traffic
gem 'rack-google_analytics'

# Performance
gem 'newrelic_rpm'

# Exceptions
gem 'rollbar'

