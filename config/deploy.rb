require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'
require 'mina/multistage'

set :application, 'ghm'
set :user, 'rbdev'
set :deploy_to, '/var/www/ghm'
set :repository, 'git@github.com:artshpakov/ghm.git'
set :forward_agent, true

set :shared_paths, [
  'config/database.yml',
  'config/s3.yml',
  'config/oauth.yml',
  'config/secrets.yml',
  'public/uploads',
  'log',
  'tmp'
]


task :environment do
  invoke :'rbenv:load'
end


task setup: :environment do
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]
end


task deploy: :environment do
  to :before_hook do
  end

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'puma:phased_restart'
    end
  end
end
