require "middleman-smusher"

### 
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Helpers
###

helpers do
  def javascript_include_project_tag(file_name)
    "<script type='text/javascript' src='javascripts/#{file_name}.js'></script>"
  end
end

set :css_dir, "stylesheets"
set :js_dir, "javascripts"
set :images_dir, "images"
set :fonts_dir, "fonts"

if ENV['HOME'] === true
  set :build_dir, "build/public"
else
  set :build_dir, "tmp"
end

###
# Features
###

module Middleman::Features::ProjectJS
  class << self
    def registered(app)
      app.compass_config do |config|
        config.fonts_dir = :fonts_dir
      end
    end
    alias :included :registered
  end
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :relative_assets
  activate :smusher
  # activate :favicon_maker
end