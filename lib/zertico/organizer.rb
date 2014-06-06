require 'pry'

module Zertico
  module Organizer
    attr_reader :interactors_classes, :objects, :performed

    def organize(interactors)
      @performed = []
      @objects = []
      @interactors_classes = Array(interactors)
    end

    def perform(params)
      interactors_classes.each do |interactor_class|
        interactor = interactor_class.new
        objects << interactor.perform(params, objects)
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