require 'dragonfly'

S3 = YAML::load_file(File.join(Rails.root, "config/s3.yml"))[Rails.env]

Dragonfly.app.configure do
  plugin :imagemagick
  plugin :avatarmagick, size: '200x200'

  secret "9876aa41eada4448865977a7e3c8f722503a529b96d6d5de754e05f1f6b846b7"

  url_format "/media/:job/:name"

  if Rails.env.development? || Rails.env.test?
    datastore :file,
              root_path: Rails.root.join('public/uploads'),
              server_root: Rails.root.join('public')
  else
    datastore :s3,
              bucket_name: S3['bucket'],
              access_key_id: S3['key'],
              secret_access_key: S3['secret'],
              url_scheme: 'https'
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
