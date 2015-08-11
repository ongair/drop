require 'dragonfly'
require 'dragonfly/s3_data_store'

Dragonfly.app.configure do
  plugin :imagemagick
  secret "e8c16ce703f49e5e5cbfjd68cghjklcb2f742311359156ee34a01234520af92"
  
  url_format "/media/:job/:name"
  datastore :s3,
    bucket_name: 'bbcdrop',
    access_key_id: Rails.application.secrets.s3_access_key_id,
    secret_access_key: Rails.application.secrets.s3_secret_access_key

  binding.pry
end


# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end

