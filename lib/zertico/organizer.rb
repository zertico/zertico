module Zertico
  class Organizer
    attr_reader :interactors_classes, :performed

    def define_interactors(interactors)
      @performed = []
      @interactors_classes = Array(interactors)
    end

    def perform(params)
      @params = params
      interactors_classes.each do |interactor_class|
        instance_variable_set("@#{interactor_class.instance_name}", interactor_class.new.perform(@params))
        performed << interactor_class
      end
      true
    rescue Zertico::Exceptions::InteractorException
      rollback
    end

    def rollback
      performed.each do |interactor_class|
        interactors_class.new.rollback(instance_variable_get("@#{interactor_class.to_s.downcase}"))
      end
      false
    end
  end
end