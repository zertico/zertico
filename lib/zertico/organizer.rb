module Zertico
  class Organizer
    def define_interactors(interactors = [])
      @interactors_classes = interactors.flatten
    end

    def perform(params)
      @params = params
      begin
        @interactors_classes.each_with_index do |interactor_class, i|
          @index = i
          response_hash = interactor_class.new.perform(@params)
          @params.merge!(response_hash)
        end
        true
      rescue Zertico::Exceptions::InteractorException
        rollback
      end
    end

    def rollback
      (0..@index-1).each do |i|
        @interactors_classes[i].new.rollback(@params)
      end
      false
    end
  end
end