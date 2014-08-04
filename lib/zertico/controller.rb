require 'action_controller'

module Zertico
  class Controller < ActionController::Base
    attr_reader :service

    def initialize
      @service ||= "::#{self.class.name.chomp('Controller').concat('Service')}".constantize.new
    rescue NameError
      @service ||= Zertico::Service.new
    ensure
      super
    end

    def index
      instance_variable_set("@#{service.interface_name.pluralize}", service.index)
      respond_with(instance_variable_get("@#{service.interface_name.pluralize}"), service.responder_settings_for_index)
    end

    def new
      instance_variable_set("@#{service.interface_name}", service.new)
      respond_with(instance_variable_get("@#{service.interface_name}"), service.responder_settings_for_new)
    end

    def show
      instance_variable_set("@#{service.interface_name}", service.show(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.responder_settings_for_show)
    end

    def edit
      instance_variable_set("@#{service.interface_name}", service.show(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.responder_settings_for_edit)
    end

    def create
      permitted_params = "::#{self.class.name.chomp('Controller').concat('PermittedParams')}".constantize.new(params).create rescue params
      instance_variable_set("@#{service.interface_name}", service.create(permitted_params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.responder_settings_for_create)
    end

    def update
      permitted_params = "::#{self.class.name.chomp('Controller').concat('PermittedParams')}".constantize.new(params).update rescue params
      instance_variable_set("@#{service.interface_name}", service.update(permitted_params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.responder_settings_for_update)
    end

    def destroy
      instance_variable_set("@#{service.interface_name}", service.destroy(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.responder_settings_for_destroy)
    end
  end
end