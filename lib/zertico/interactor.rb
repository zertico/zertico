module Zertico
  class Interactor
    def fail!(message = '')
      raise Zertico::Exceptions::InteractorException, message
    end

    def perform(params)
      fail!('You should overwrite this method!')
    end

    def rollback
      true
    end

    protected

    def self.instance_name
      self.class.to_s.chomp('Interactor').split('::').last
    end
  end
end