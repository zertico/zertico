module Zertico
  class Form
    class Resources
      def add(resource_instance, resource_name)
        instance_variable_set("@#{resource_name}", resource_instance)
      end

      def get(resource_name)
        instance_variable_get("@#{resource_name}")
      end

      def defined?(resource_name)
        instance_variable_defined?("@#{resource_name}")
      end

      def all
        instance_variables
      end

      def associate(child, parent, method_name)
        get(child).send("#{method_name}=", get(parent))
      end

      def method_missing(method_name)
        resource_name = method_name.split('_').first
        return super unless resource_name.respond_to?(method_name)
        get(resource_name).send(method_name)
      end
    end
  end
end