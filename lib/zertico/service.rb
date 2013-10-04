module Zertico
  module Service
    def all
      { interface_name.pluralize.to_sym => resource.all }
    end

    def build
      { interface_name.to_sym => resource.new }
    end

    def find(id)
      { interface_name.to_sym => resource.find(id) }
    end

    def generate(attributes = {})
      { interface_name.to_sym => resource.create(attributes) }
    end

    def modify(id, attributes = {})
      object = self.find(id)[interface_name.to_sym]
      object.update_attributes(attributes)
      { interface_name.to_sym => object }
    end

    def delete(id)
      object = self.find(id)[interface_name.to_sym]
      object.destroy
      { interface_name.to_sym => object }
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