module Zertico
  class Form
    autoload :Association, 'zertico/form/association'
    autoload :Klass, 'zertico/form/klass'
    autoload :Hierarchy, 'zertico/form/hierarchy'
    autoload :Resources, 'zertico/form/resources'

    include ActiveModel::Model

    def self.has_one(klass, attributes = [], options = {}, &block)
      if block_given?
        hierarchy.push(klass, options[:instance_name], options[:as])
        yield
        hierarchy.pop
      end
      attr_reader instance_name
      attributes = attributes + attributes.map { |attribute| "#{attribute}=" }
      delegate attributes, to: instance_name, prefix: true, allow_nil: true
    end

    def initialize(params = {})
      klasses.each do |klass|
        attributes = params.select { |key, value| key.to_s.start_with?(klass.name) }
        if attributes.any?
          resources.add(klass.name, klass.instantiate(attributes))
        end
      end
      associations.each do |association|
        resources.associate(association.child, association.parent, association.method_name)
      end
    end

    def valid?
      return false if resources.all.empty?
      valid = resources.inject(true) { |sum, resource| sum & resource.valid? }
      klasses.each do |klass|
        next unless resource_defined?(klass)
        get_resource(klass.name).errors.each do |error_key, error_value|
          self.errors.add("#{klass.name}_#{error_key}", error_value)
        end
      end
      valid
    end

    def persisted?
      return false if resources.all.empty?
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

    def self.hierarchy
      @hierarchy ||= Hierarchy.new
    end

    def klasses
      self.class.hierarchy.klasses
    end

    def associations
      self.class.hierarchy.associations
    end

    def resources
      @resources ||= Resources.new
    end
  end
end