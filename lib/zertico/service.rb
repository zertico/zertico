module Zertico
  class Service
    autoload :ClassMethods, 'zertico/service/class_methods'
    autoload :InstanceMethods, 'zertico/service/instance_methods'

    extend ClassMethods
    include InstanceMethods
  end
end