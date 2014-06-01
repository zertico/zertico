module Zertico
  module Organizer
    attr_reader :interactors_classes, :performed

    def organize(interactors)
      @performed = []
      @interactors_classes = Array(interactors)
    end

    def perform(params)
      @params = params
      interactors_classes.each do |interactor_class|
        interactor = interactor_class.new
        interactor.perform(@params)
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