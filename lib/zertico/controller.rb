require 'action_controller'

module Zertico
  class Controller < ActionController::Base
    def initialize
      begin
        extend "::#{self.class.name.chomp('Controller').concat('Service')}".constantize
      rescue NameError
        extend Zertico::Service
      end
      super
    end

    def index
      initialize_object all
      respond_with(instance_variable_get('@responder'))
    end

    def new
      initialize_object build
      respond_with(instance_variable_get('@responder'))
    end

    def show
      initialize_object find(params[:id])
      respond_with(instance_variable_get('@responder'))
    end

    def edit
      initialize_object find(params[:id])
      respond_with(instance_variable_get('@responder'))
    end

    def create
      initialize_object generate(params[interface_name.to_sym])
      if instance_variable_defined?('@path')
        respond_with(instance_variable_get('@responder'), :path => instance_variable_get('@path'))
      else
        respond_with(instance_variable_get('@responder'))
      end
    end

    def update
      initialize_object modify(params[:id], params[interface_name.to_sym])
      if instance_variable_defined?('@path')
        respond_with(instance_variable_get('@responder'), :path => instance_variable_get('@path'))
      else
        respond_with(instance_variable_get('@responder'))
      end
    end

    def destroy
      initialize_object delete(params[:id])
      if instance_variable_defined?('@path')
        respond_with(instance_variable_get('@responder'), :path => instance_variable_get('@path'))
      else
        respond_with(instance_variable_get('@responder'))
      end
    end

    protected

    def initialize_object(objects = {})
      objects.each do |key, value|
        instance_variable_set("@#{key}", value)
        instance_variable_set('@responder', value) unless @responder
      end
    end
  end
end