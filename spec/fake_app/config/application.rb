require 'rails'
require 'action_controller/railtie'

module RailsApplication
  class Application < Rails::Application
    config.root = "#{config.root}/spec/fake_app"
    config.logger = nil
  end
end
