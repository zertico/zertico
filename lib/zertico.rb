require 'zertico/version'
require 'active_support/core_ext/string'

module Zertico
  autoload :Controller, 'zertico/controller'
  autoload :Service, 'zertico/service'
  autoload :Accessor, 'zertico/accessor'
  autoload :Responder, 'zertico/responder'
  autoload :Organizer, 'zertico/organizer'
  autoload :Interactor, 'zertico/interactor'
  autoload :Exceptions, 'zertico/exceptions'
end