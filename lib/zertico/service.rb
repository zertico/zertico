module Zertico
  module Service
    def all
      @responder = resource.all
      instance_variable_set("@#{interface_name.pluralize}", @responder)
      @options = {}
    end

    def build
      @responder = resource.new
      instance_variable_set("@#{interface_name}", @responder)
      @options = {}
    end

    def find
      @responder = resource.find(params[interface_id.to_sym])
      instance_variable_set("@#{interface_name}", @responder)
      @options = {}
    end

    def generate
      @responder = resource.create(params[interface_name.to_sym])
      instance_variable_set("@#{interface_name}", @responder)
      @options = {}
    end

    def modify
      find
      @responder.update_attributes(params[interface_name.to_sym])
      @options = {}
    end

    def delete
      find
      @responder.destroy
      @options = {}
    end

    def resource
      @resource_object ||= interface_class
    end

    def resource=(resource_chain = [])
      @resource_object = resource_chain.shift
      @resource_object = @resource_object.constantize if @resource_object.respond_to?(:constantize)
      resource_chain.each do |resource|
        @resource_object = @resource_object.send(resource)
      end
    end

    protected

    def interface_id
      begin
        return "#{interface_name}_id" if self.class.name.chomp('Controller').split('::').size > 1
      rescue NameError
        'id'
      end
      'id'
    end

    def interface_name
      self.interface_class.name.singularize.underscore
    end

    def interface_class
      begin
        self.class.name.chomp('Controller').singularize.constantize
      rescue NameError
        self.class.name.chomp('Controller').split('::').last.singularize.constantize
      end
    end
  end
end