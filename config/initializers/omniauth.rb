Rails.application.config.middleware.use OmniAuth::Builder do
  config = YAML.load_file("#{Rails.root}/config/oauth.yml")[Rails.env].symbolize_keys

  config.each do |provider, params|
    provider params.delete('name'), params.delete('app_id'), params.delete('app_secret'), params
  end

  Growth::Application::OAUTH_PROVIDERS = config
end
