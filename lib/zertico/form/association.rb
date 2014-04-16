module Zertico
  class Form
    class Association
      attr_reader :parent, :child, :method_name

      def initialize(parent, child, method_name)
        @parent = parent
        @child = child
        @method_name = method_name
      end
    end
  end
end