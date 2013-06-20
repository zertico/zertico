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
      if instance_variable_get("@#{interface_name}").respond_to?(method_name)
        return instance_variable_get("@#{interface_name}").send(method_name, *args)
      end
      super
    end

    def respond_to_missing?(method_name, include_private = false)
      return true if interface_class.respond_to?(method_name)
      super
    end

    protected

    def self.interface_name
      self.name.chomp('Accessor').singularize.underscore
    end

    def interface_name
      self.class.name.chomp('Accessor').singularize.underscore
    end

    def self.interface_class
      self.interface_name.camelize.constantize
    end

    def interface_class
      self.interface_name.camelize.constantize
    end
  end
end