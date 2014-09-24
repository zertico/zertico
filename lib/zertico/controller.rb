require 'action_controller'

module Zertico
  class Controller < ActionController::Base
    attr_reader :service

    def initialize
      initialize_service
      set_responder
      super
    end

    def index
      instance_variable_set("@#{service.interface_name.pluralize}", service.index)
      respond_with(instance_variable_get("@#{service.interface_name.pluralize}"), responder.index_options(self))
    end

    def new
      instance_variable_set("@#{service.interface_name}", service.new)
      respond_with(instance_variable_get("@#{service.interface_name}"), responder.new_options(self))
    end

    def show
      instance_variable_set("@#{service.interface_name}", service.show(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), responder.show_options(self))
    end

    def edit
      instance_variable_set("@#{service.interface_name}", service.show(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), responder.edit_options(self))
    end

    def create
      permitted_params = "::#{self.class.name.chomp('Controller').concat('PermittedParams')}".constantize.new(params).create rescue params[service.interface_name.to_sym]
      instance_variable_set("@#{service.interface_name}", service.create(permitted_params))
      respond_with(instance_variable_get("@#{service.interface_name}"), responder.create_options(self))
    end

    def update
      permitted_params = "::#{self.class.name.chomp('Controller').concat('PermittedParams')}".constantize.new(params).update rescue params[service.interface_name.to_sym]
      instance_variable_set("@#{service.interface_name}", service.update(permitted_params))
      respond_with(instance_variable_get("@#{service.interface_name}"), responder.update_options(self))
    end

    def destroy
      instance_variable_set("@#{service.interface_name}", service.destroy(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), responder.destroy_options(self))
    end

    private

    def initialize_service
      @service = "::#{self.class.name.gsub('Controller', 'Service')}".constantize.new
    rescue NameError
      @service = Zertico::Service.new(self.class.name)
    end

    def set_responder
      self.class.responder = "::#{self.class.name.gsub('Controller', 'Responder')}".constantize
    rescue NameError
      self.class.responder = Zertico::Responder
    end
  end
end