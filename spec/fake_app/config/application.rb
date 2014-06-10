require 'rails'
require 'action_controller/railtie'

module RailsApplication
  class Application < Rails::Application
    config.root = "#{config.root}/spec/fake_app"
    config.logger = nil
    config.secret_key_base = YAML.load(File.open("#{Rails.root}/config/secrets.yml"))[Rails.env]['secret_key_base']
  end
end
