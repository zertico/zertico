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
      respond_with(@responder, @options)
    end

    def new
      initialize_object build
      respond_with(@responder, @options)
    end

    def show
      initialize_object find(params[interface_id.to_sym])
      respond_with(@responder, @options)
    end

    def edit
      initialize_object find(params[interface_id.to_sym])
      respond_with(@responder, @options)
    end

    def create
      initialize_object generate(params[interface_name.to_sym])
      respond_with(@responder, @options)
    end

    def update
      initialize_object modify(params[interface_id.to_sym], params[interface_name.to_sym])
      respond_with(@responder, @options)
    end

    def destroy
      initialize_object delete(params[interface_id.to_sym])
      respond_with(@responder, @options)
    end

    protected

    def initialize_object(objects = {}, options = {})
      @options = options
      objects.each do |key, value|
        instance_variable_set("@#{key}", value)
        instance_variable_set('@responder', value) unless @responder
      end
    end
  end
end