#!/usr/bin/env ruby

require 'fileutils'
require 'heroku'

ROOT = File.expand_path "."
ENV_PROD = "production"
ENV_STAGING = "staging"
ENV_DEV = "dev"
ENV_REVIEW = "review"
HEROKU_APP_DELIMITER = "-"
HEROKU_APP_DOMAIN = "audi-performance"
HEROKU_APP_SUBDOMAIN = ""
MASTER_BRANCH = "master"

LOCALHOST = "http://localhost:"
port_mm = 8888
port_heroku = 9999
 
# Build Tasks
desc "Build clean"
task :build do
  sh %{middleman build -c}
end
 
desc "Build Fast"
task :fast do
  sh %{middleman build}
end
 
desc "Server start"
task :mm, [:port] do |t, args| 
  port_mm = args.port || port_mm
  sh %{middleman server -p #{port_mm}}
end
 
# Deploy
desc "Deploy PROD"
task :deploy_prod do
  Rake::Task[:deploy].invoke ENV_PROD
end
 
desc "Deploy STAGING"
task :deploy_staging do
  Rake::Task[:deploy].invoke ENV_STAGING
end
 
desc "Deploy DEV"
task :deploy_dev do
  Rake::Task[:deploy].invoke ENV_DEV
end

desc "Deploy"
task :deploy, [:env] => [] do |t, args|
  deploy args.env
end
 
def deploy (env = ENV_DEV)
  puts "Deploying : #{env}"
  sh %{cap #{env} deploy}
end
 
# Heroku
desc "Heroku Local App"
task :heroku_local do
  sh %{foreman start}
end

desc "Heroku Create Apps"
task :heroku_create_apps do
  heroku_create_app ENV_DEV
  heroku_create_app ENV_REVIEW
  sh %{git remote -v}
end

desc "Heroku Add Remotes"
task :heroku_add_remotes do
  heroku_add_remote ENV_DEV
  heroku_add_remote ENV_REVIEW
  sh %{git remote -v}
end

desc "Heroku Deploy DEV"
task :heroku_deploy_dev, [:branch] do |t, args|
  heroku_deploy ENV_DEV, args.branch
end

desc "Heroku Deploy REVIEW"
task :heroku_deploy_review, [:branch] do |t, args|
  heroku_deploy ENV_REVIEW, args.branch
end

def heroku_create_app (env)
  app_name = heroku_get_app_name env
  # sh %{heroku apps:destroy --confirm #{app_name}}
  sh %{heroku apps:create -r #{env} -s cedar #{app_name}}
end

def heroku_add_remote (env)
  app_name = heroku_get_app_name env
  remote_url = "git@heroku.com:#{app_name}.git"
  # sh %{git remote rm #{env}}
  sh %{git remote add #{env} #{remote_url}}
end

def heroku_deploy (env, branch)
  branch ||= MASTER_BRANCH
  sh %{git push #{env} #{branch}:master}
end

def heroku_get_app_name (env)
  return "#{HEROKU_APP_SUBDOMAIN}#{HEROKU_APP_DELIMITER}#{env}#{HEROKU_APP_DELIMITER}#{HEROKU_APP_DOMAIN}"
end

# Utils
desc "Find Process on Port"
task :find_port, [:port] do |t, args|
  sh %{lsof -w -n -i tcp:#{args.port}}
end
 
# Open browsers
desc "Open Chrome"
task :chrome do
  sh %{open /Applications/Google\ Chrome.app #{LOCALHOST}#{port_mm}}
end
 
desc "Open FF"
task :ff do
  sh %{open -a Firefox #{LOCALHOST}#{port_mm}}
end
 
desc "Open Safari"
task :safari do
  sh %{open -a Safari #{LOCALHOST}#{port_mm}}
end