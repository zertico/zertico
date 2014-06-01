module Zertico
  class Interactor
    def fail!(message = '')
      raise Zertico::Exceptions::InteractorException, message
    end

    def perform(params)
      fail!('Need to overwrite this method!')
    end

    def rollback(params)
      # Should overwrite!
    end

    protected

    def self.instance_name
      self.class.to_s.chomp('Interactor').split('::').last
    end
  end
end