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
      respond_with(all, options)
    end

    def new
      respond_with(build, options)
    end

    def show
      respond_with(find, options)
    end

    def edit
      respond_with(find, options)
    end

    def create
      respond_with(generate, options)
    end

    def update
      respond_with(modify, options)
    end

    def destroy
      respond_with(delete, options)
    end

    def options
      @options || {}
    end
  end
end