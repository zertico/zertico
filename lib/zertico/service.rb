module Zertico
  class Service
    class << self
      attr_reader :resource_source
    end

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
      instance_variable_set("@#{interface_name}", resource_source.create(params[interface_name.to_sym]))
    end

    def update(params)
      show(params)
      instance_variable_get("@#{interface_name}").update_attributes(params[interface_name.to_sym])
      instance_variable_get("@#{interface_name}")
    end

    def destroy(params)
      show(params)
      instance_variable_get("@#{interface_name}").destroy
      instance_variable_get("@#{interface_name}")
    end

    def options
      {}
    end

    def resource_source
      self.class.resource_source || interface_class
    end

    def self.resource_source=(resource_chain = [])
      @resource_source = resource_chain.shift
      @resource_source = @resource_source.constantize if @resource_source.respond_to?(:constantize)
      resource_chain.each do |resource|
        @resource_source = @resource_source.send(resource)
      end
    end

    def interface_id
      if self.class.name.chomp('Controller').split('::').size > 1
        "#{interface_name.gsub('/', '_')}_id"
      else
        'id'
      end
    rescue NameError
      'id'
    end

    def interface_name
      self.interface_class.name.singularize.underscore
    end

    def interface_class
      begin
        self.class.name.chomp('Service').singularize.constantize
      rescue NameError
        self.class.name.chomp('Service').split('::').last.singularize.constantize
      end
    end
  end
end