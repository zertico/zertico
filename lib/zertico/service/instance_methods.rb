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

      def update(params, instance_params)
        instance_variable_set("@#{interface_name}", resource_source.find(params[interface_id.to_sym]))
        instance_variable_get("@#{interface_name}").update_attributes(instance_params)
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

      def interface_class
        return self.class.interface_class unless self.class.interface_class.nil?
        name.chomp('Service').singularize.constantize
      rescue NameError
        name.chomp('Service').split('::').last.singularize.constantize
      end

      def interface_name
        return self.class.interface_name unless self.class.interface_name.nil?
        interface_class.name.singularize.underscore
      end

      def interface_id
        return self.class.interface_id unless self.class.interface_id.nil?
        if name.split('::').size > 1
          "#{interface_name.gsub('/', '_')}_id"
        else
          'id'
        end
      rescue NameError
        'id'
      end
    end
  end
end