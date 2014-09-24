module Zertico
  class Service
    module InstanceMethods
      def index
        instance_variable_set("@#{interface_name.pluralize}", resource_source.all)
      end

      def new
        instance_variable_set("@#{interface_name}", resource_source.new)
      end

      def show(params)
        instance_variable_set("@#{interface_name}", resource_source.find(params[interface_id.to_sym]))
      end

      def create(params)
        instance_variable_set("@#{interface_name}", resource_source.create(params))
      end

      def update(params)
        show(params)
        instance_variable_get("@#{interface_name}").update_attributes(params)
        instance_variable_get("@#{interface_name}")
      end

      def destroy(params)
        show(params)
        instance_variable_get("@#{interface_name}").destroy
        instance_variable_get("@#{interface_name}")
      end

      def resource_source
        self.class.resource_source || interface_class
      end
    end
  end
end