# = Gemfile containing requirements for this app =
#     see http://gembundler.com/ for more on how to use this file
# source (there are others but whatever)
source 'https://rubygems.org'

# session store
group :memcached do
  gem 'dalli', :require => 'rack/session/dalli'
  gem 'kgio'
end

# server
gem 'unicorn'

# sinatra
group :sinatra do
  gem 'sinatra'
  gem 'dm-postgres-adapter'
  gem 'data_mapper'
  gem 'sinatra-flash', :require => %w(sinatra/flash)
  gem 'sinatra-contrib', :require => %w(
    sinatra/namespace
    sinatra/content_for
  )
end

group :assorted do
  gem 'pygments.rb', :git => 'git://github.com/mvj3/pygments.rb.git'
  gem 'awesome_print'
  gem 'json' # email
  gem 'pony' # email
  gem 'erubis' # faster better stronger
  gem 'escape_utils', :require => %w(
    escape_utils
    escape_utils/html/erb
    escape_utils/html/rack
    escape_utils/url/erb
    escape_utils/url/rack
    escape_utils/url/uri
  )
end

# assets
group :assets do
  gem 'susy'
  gem 'coffee-script'
end

# sprockets galore
group :sprockets do
  gem 'uglifier'
  gem 'sprockets'
  gem 'sprockets-sass'
  gem 'sprockets-helpers'
end
