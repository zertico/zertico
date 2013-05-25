require "action_controller"

module Zertico
  class Controller < ActionController::Base
    def initialize
      begin
        extend "::#{self.class.name.chomp("Controller").concat("Service")}".constantize
      rescue NameError
        extend Zertico::Service
      end
    end

    def index
      initialize_object all
    end

    def new
      initialize_object build
    end

    def show
      initialize_object find(params[:id])
    end

    def edit
      initialize_object find(params[:id])
    end

    def create
      initialize_object generate(params[interface_name.to_sym])
      respond_with(instance_variable_get(@object_name))
    end

    def update
      initialize_object modify(params[:id], params[interface_name.to_sym])
      respond_with(instance_variable_get(@object_name))
    end

    def destroy
      initialize_object delete(params[:id])
      respond_with(instance_variable_get(@object_name))
    end

    protected

    def initialize_object(object = {})
      object.each do |key, value|
        @object_name = "@#{key}"
        instance_variable_set(@object_name, value)
      end
    end
  end
end