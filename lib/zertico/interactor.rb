module Zertico
  class Interactor
    def perform(params)
      fail!('You should overwrite this method!')
    end

    def rollback
      true
    end

    def inject_instances(instances = {})
      instances.each do |instance_name, instance_variable|
        instance_variable_set("@#{instance_name}", instance_variable)
      end
    end

    def get_instances
      instance_variables.inject({}) do |instances, instance_variable|
        instances[instance_variable.to_s.gsub('@', '')] = instance_variable_get(instance_variable)
        instances
      end
    end

    protected

    def self.interface_name
      self.to_s.chomp('Interactor').split('::').last
    end

    private

    def fail!(message = '')
      raise Zertico::Exceptions::RollbackException, message
    end
  end
end