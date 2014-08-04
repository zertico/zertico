begin 
  require 'action_controller/parameters'
rescue LoadError
end

module Zertico
  class PermittedParams < Delegator
  	alias_method :params, :interface
    def self.interface_class
      self.name.chomp('PermittedParams').singularize.constantize
    rescue NameError
      self.name.chomp('PermittedParams').split('::').last.singularize.constantize
    end
  end
end