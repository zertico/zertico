module Zertico
  module Organizer
    attr_reader :interactors_classes, :instances, :performed

    def organize(interactors)
      @interactors_classes = Array(interactors)
      @performed = []
      @instances = {}
    end

    def perform(params)
      interactors_classes.each do |interactor_class|
        interactor = interactor_class.new
        interactor.inject_instances(instances)
        interactor.perform(params)
        instances.merge!(interactor.get_instances)
        performed << interactor
      end
      true
    rescue Zertico::Exceptions::RollbackException
      rollback
    end

    def rollback
      performed.reverse.map(&:rollback)
    end
  end
end