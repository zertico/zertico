module Zertico
  module Service
    def all
      instance_variable_set("@#{interface_name.pluralize}", resource.all)
    end

    def build
      instance_variable_set("@#{interface_name}", resource.new)
    end

    def find
      instance_variable_set("@#{interface_name}", resource.find(params[interface_id.to_sym]))
    end

    def generate
      instance_variable_set("@#{interface_name}", resource.create(params[interface_name.to_sym]))
    end

    def modify
      find
      instance_variable_get("@#{interface_name}").update_attributes(params[interface_name.to_sym])
      instance_variable_get("@#{interface_name}")
    end

    def delete
      find
      instance_variable_get("@#{interface_name}").destroy
      instance_variable_get("@#{interface_name}")
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