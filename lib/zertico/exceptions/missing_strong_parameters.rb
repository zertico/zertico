module Zertico
  module Exceptions
    class MissingStrongParameters < Exception
      def initialize
        super('This class depends of strong_parameters gem!')
      end
    end
  end
end