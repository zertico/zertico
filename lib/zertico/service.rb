module Zertico
  module Service
    def all
      { interface_name.pluralize.to_sym => interface_class.all }
    end

    def build
      { interface_name.to_sym => interface_class.new }
    end

    def find(id)
      { interface_name.to_sym => interface_class.find(id) }
    end

    def generate(attributes = {})
      { interface_name.to_sym => interface_class.create(attributes) }
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

    protected

    def interface_name
      self.class.name.chomp('Controller').split('::').last.singularize.underscore
    end

    def interface_class
      self.interface_name.camelize.constantize
    end
  end
end