require 'action_controller/metal/responder'

module Zertico
  class Responder < ActionController::Responder
    autoload :ForceRedirect, 'zertico/responder/force_redirect'
    autoload :Pjax, 'zertico/responder/pjax'

    class << self
      include Rails.application.routes.url_helpers

      def default_url_options; {} end

      %w(index new edit create update show destroy).each do |method_name|
        define_method("#{method_name}_options=") do |options|
          instance_variable_set("@#{method_name}_options", options)
        end

        define_method("#{method_name}_options") do |controller|
          return {} unless instance_variable_defined?("@#{method_name}_options")
          instance_variable_get("@#{method_name}_options").call(controller)
        end
      end
    end
  end
end