module Zertico
  class Form
    class Hierarchy
      attr_reader :hierarchy, :klasses, :associations

      def initialize
        @hierarchy = []
        @klasses = []
        @associations = []
      end

      def push(klass, instance_name, method_name)
        instance_name ||= klass.name.underscore
        method_name ||= current
        associations.push(Association.new(current, instance_name, method_name)) unless root?
        klasses.push(Klass.new(klass, instance_name))
        hierarchy.push(instance_name)
      end

      def pop
        hierarchy.pop
      end

      def current
        hierarchy.last
      end

      def root?
        hierarchy.empty?
      end
    end
  end
end