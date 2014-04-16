module Zertico
  class Form
    class Klass
      attr_reader :constant, :name

      def initialize(constant, name)
        @constant = constant
        @name = name
      end

      def instantiate(attributes = {})
        constant.new(attributes)
      end
    end
  end
end