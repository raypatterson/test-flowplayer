require 'yaml'
require "middleman"
require "middleman/builder"
require "rack"
require "rack/request"
require 'rack/mobile-detect'
require "rack/contrib/try_static"

# Get Rack environment key value.
environment = ENV["RACK_ENV"].to_s

# Load YAML config file.
yml = YAML::load(File.open("config.yaml"))

# Try to set config object --> or default to production.
config = yml[environment] || yml["production"]

# Check for mobile devices and perform redirect.
use Rack::MobileDetect, :redirect_to => config["urls"]["mobile"]

# Perform Middleman build to "tmp" dir.
Middleman::Builder.start

# Serve static files from "tmp" dir.
use Rack::TryStatic,
  :root => "tmp",
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']

# Pretty sure this doesn't actually work.
run lambda { |env|
  [
    404,
    {
      'Content-Type' => 'text/html'
    },
    File.open('/404.html', File::RDONLY)
  ]
}
