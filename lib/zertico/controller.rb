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
      all
      respond_with(@responder, @options)
    end

    def new
      build
      respond_with(@responder, @options)
    end

    def show
      find
      respond_with(@responder, @options)
    end

    def edit
      find
      respond_with(@responder, @options)
    end

    def create
      generate
      respond_with(@responder, @options)
    end

    def update
      modify
      respond_with(@responder, @options)
    end

    def destroy
      delete
      respond_with(@responder, @options)
    end
  end
end