module Zertico
  class Interactor
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

    private

    def fail!(message = '')
      raise Zertico::Exceptions::RollbackException, message
    end
  end
end