module Zertico
  class Form
    include ActiveModel::Model

    def self.has_one(klass, attributes = [], options = {}, &block)
      instance_name = (options[:instance_name] || klass.name.underscore)
      if block_given?
        (@parents ||= []).push(instance_name)
        yield
        @parents.pop
      end
      if @parents.any?
        as = options[:as] || @parents.last
        (@nested ||= []).push([@parents.last, instance_name, as])
      end
      (@resource_classes ||= []) << [klass, instance_name]
      attr_reader instance_name
      attributes.each do |attribute|
        delegate attribute, "#{attribute}=", to: instance_name, prefix: true, allow_nil: true
      end
    end

    def initialize(params = {})
      @resources = []
      resource_classes.each do |resource_class, resource_name|
        attributes = params.select { |key, value| key.to_s.start_with?(resource_name) }
        if attributes.any?
          instance_variable_set("@#{resource_name}", resource_class.new)
          @resources << resource_name
          attributes.each do |attribute_key, attribute_value|
            send("#{attribute_key}=", params[attribute_key])
          end
        end
      end
    end

    def valid?
      return false if resources.empty?
      nested.each do |parent, child, method_name|
        get_resource(child).send("#{method_name}=", get_resource(parent))
      end
      valid = resources.inject(true) { |sum, resource| sum & resource.valid? }
      resource_names.each do |resource_name|
        get_resource(resource_name).errors.each do |error_key, error_value|
          self.errors.add("#{resource_name}_#{error_key}", error_value)
        end
      end
      valid
    end

    def persisted?
      return false if resources.empty?
      resources.inject(true) { |sum, resource| sum & resource.persisted? }
    end

    def save
      resources.map(&:save) if valid?
    end

    def self.create(params = {})
      instance = new(params)
      instance.save
      instance
    end

    private

    def self.submit_to(klass)
      self.instance_variable_set('@_model_name',  ActiveModel::Name.new(klass))
    end

    def resource_classes
      self.class.instance_variable_get("@resource_classes")
    end

    def nested
      self.class.instance_variable_get("@nested")
    end

    def get_resource(resource_name)
      instance_variable_get("@#{resource_name}")
    end

    def resources
      @resources.map do |resource|
        get_resource(resource)
      end
    end

    def resource_names
      @resources
    end
  end
end