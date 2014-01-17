module Zertico
  class Accessor
    def initialize(object)
      instance_variable_set("@#{interface_name}", object)
    end

    def self.find(id)
      new(interface_class.find(id))
    end

    def interface
      instance_variable_get("@#{interface_name}")
    end

    def method_missing(method_name, *args)
      if interface.respond_to?(method_name)
        return interface.send(method_name, *args)
      end
      super
    end

    if RUBY_VERSION == '1.8.7'
      def respond_to?(method_name, include_private = false)
        return true if self.interface.respond_to?(method_name)
        super
      end
    else
      def respond_to_missing?(method_name, include_private = false)
        return true if self.interface.respond_to?(method_name)
        super
      end
    end

    protected

    def self.interface_name
      self.interface_class.name.split('::').last.singularize.underscore
    end

    def self.interface_class
      begin
        self.name.chomp('Accessor').constantize
      rescue NameError
        self.name.chomp('Accessor').split('::').last.constantize
      end
    end

    def interface_name
      self.class.interface_name
    end

    def interface_class
      self.class.interface_class
    end
  end
end