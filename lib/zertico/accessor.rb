module Zertico
  class Accessor < Delegator
    def initialize(object)
      warn "[DEPRECATION] `Zertico::Accessor` is deprecated.  Please use `Zertico::Delegator` instead."
      super
    end
  end
end