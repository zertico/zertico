module Zertico
  module Exceptions
    autoload :MissingApplicationResponder, 'zertico/exceptions/missing_application_responder'
    autoload :MissingStrongParameters, 'zertico/exceptions/missing_strong_parameters'
    autoload :RollbackException, 'zertico/exceptions/rollback_exception'
  end
end