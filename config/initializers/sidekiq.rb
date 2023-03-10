require 'sidekiq/web'

Sidekiq::Web.set :sessions, false

Sidekiq.configure_server do |config|
  config.redis = { host: ENV['REDIS_HOST'] || 'localhost', port: ENV['REDIS_PORT'] || '6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { host: ENV['REDIS_HOST'] || 'localhost', port: ENV['REDIS_PORT'] || '6379' }
end
