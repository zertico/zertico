module Zertico
  class Service
    module ClassMethods
      attr_reader :interface_id, :interface_name, :interface_class, :resource_source

      def use_as_id(id)
        @interface_id = id
      end

      def use_as_variable_name(variable_name)
        @interface_name = variable_name
      end

      def use_interface(interface)
        @interface_class = interface
      end

      alias_method :use_model, :use_interface

      def resource_source=(resource_chain = [])
        @resource_source = Array(resource_chain).shift
        @resource_source = @resource_source.constantize if @resource_source.respond_to?(:constantize)
        resource_chain.each do |resource|
          @resource_source = @resource_source.send(resource)
        end
      end
    end
  end
end