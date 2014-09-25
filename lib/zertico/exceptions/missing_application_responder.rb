module Zertico
  module Exceptions
    class MissingApplicationResponder < Exception
      def initialize
        super('You must define an ApplicationResponder!')
      end
    end
  end
end