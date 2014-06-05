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
      respond_with(instance_variable_get("@#{service.interface_name.pluralize}"), service.options)
    end

    def new
      instance_variable_set("@#{service.interface_name}", service.new)
      respond_with(instance_variable_get("@#{service.interface_name}"), service.options)
    end

    def show
      instance_variable_set("@#{service.interface_name}", service.show(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.options)
    end

    def edit
      instance_variable_set("@#{service.interface_name}", service.show(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.options)
    end

    def create
      instance_variable_set("@#{service.interface_name}", service.create(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.options)
    end

    def update
      instance_variable_set("@#{service.interface_name}", service.update(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.options)
    end

    def destroy
      instance_variable_set("@#{service.interface_name}", service.destroy(params))
      respond_with(instance_variable_get("@#{service.interface_name}"), service.options)
    end
  end
end