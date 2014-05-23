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
          instance_variable_set("@#{instance_name(interactor_class)}", interactor_class.new.perform(@params))
        end
        true
      rescue Zertico::Exceptions::InteractorException
        rollback
      end
    end

    def rollback
      (0..@index-1).each do |i|
        @interactors_classes[i].new.rollback(instance_variable_get("@#{interactor_class.to_s.downcase}"))
      end
      false
    end

    private

    def instance_name(interactor_class)
      interactor_class.to_s.downcase!.gsub(/[a-z]*::/, '')
    end
  end
end