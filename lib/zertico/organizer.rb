module Zertico
  module Organizer
    attr_reader :interactors_classes, :objects, :performed

    def organize(interactors)
      @performed = []
      @objects = {}
      @interactors_classes = Array(interactors)
    end

    def perform(params)
      interactors_classes.each do |interactor_class|
        interactor = interactor_class.new
        objects.each do |instance_name, instance_variable|
          interactor.instance_variable_set(instance_name, instance_variable)
        end
        interactor.perform(params)
        interactor.instance_variables.each do |instance_variable|
          objects.merge!({ instance_variable => interactor.instance_variable_get(instance_variable) })
        end
        performed << interactor
      end
      true
    rescue Zertico::Exceptions::RollbackException
      rollback
    end

    def rollback
      performed.map(&:rollback)
    end
  end
end