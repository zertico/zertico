module Zertico
  class Service
    attr_reader :name

    autoload :ClassMethods, 'zertico/service/class_methods'
    autoload :InstanceMethods, 'zertico/service/instance_methods'

    extend ClassMethods
    include InstanceMethods

    def initialize(controller_name = nil)
      @name = (controller_name or self.class.name).gsub('Controller', 'Service')
    end
  end
end