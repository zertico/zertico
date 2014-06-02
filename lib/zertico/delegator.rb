require 'delegate'

module Zertico
  class Delegator < SimpleDelegator
    def initialize(object = nil)
      object ||= interface_class.new
      super(object)
    end

    def self.find(id)
      new(interface_class.find(id))
    end

    def interface
      __getobj__
    end

    def interface=(object)
      __setobj__(object)
    end

    protected

    def self.interface_name
      self.interface_class.name.split('::').last.singularize.underscore
    end

    def self.interface_class
      self.name.chomp('Delegator').constantize
    rescue NameError
      self.name.chomp('Delegator').split('::').last.constantize
    end

    def interface_name
      self.class.interface_name
    end

    def interface_class
      self.class.interface_class
    end
  end
end