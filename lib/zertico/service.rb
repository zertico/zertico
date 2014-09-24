module Zertico
  class Service
    attr_reader :interface_class, :interface_name, :interface_id

    autoload :ClassMethods, 'zertico/service/class_methods'
    autoload :InstanceMethods, 'zertico/service/instance_methods'

    extend ClassMethods
    include InstanceMethods

    def initialize(options = {})
      @interface_class = options.fetch(:interface_class, self.class.interface_class)
      @interface_class ||= custom_interface_class
      @interface_name = options.fetch(:interface_name, self.class.interface_name)
      @interface_name ||= interface_class.name.singularize.underscore
      @interface_id = options.fetch(:interface_id, self.class.interface_id)
      @interface_id ||= custom_interface_id
    end

    private

    def custom_interface_class
      self.class.name.chomp('Service').singularize.constantize
    rescue NameError
      self.class.name.chomp('Service').split('::').last.singularize.constantize
    end

    def custom_interface_id
      if self.class.name.chomp('Controller').split('::').size > 1
        "#{interface_name.gsub('/', '_')}_id"
      else
        'id'
      end
    rescue NameError
      'id'
    end
  end
end