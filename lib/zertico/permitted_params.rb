begin
  if Rails.version >= '4'
    require 'action_controller/metal/strong_parameters'
  else
    require 'action_controller/parameters'
  end
rescue LoadError
  raise Zertico::Exceptions::MissingStrongParameters
end

module Zertico
  class PermittedParams < Delegator
    alias_method :params, :interface

    def create
      params[self.class.interface_class.name.underscore.to_sym]
    end

    def update
      params[self.class.interface_class.name.underscore.to_sym]
    end
    
    def self.interface_class
      name.chomp('PermittedParams').singularize.constantize
    rescue NameError
      name.chomp('PermittedParams').split('::').last.singularize.constantize
    end
  end
end