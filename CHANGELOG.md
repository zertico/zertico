# CHANGELOG

## master

* Refactored Service to be a class instead of module. Added api to work instead of overwrite methods.
* Fixed some bugs.
* Improved Delegator, Interactor, Organizer.

## v1.3.0

* Deprecated Accessor in favor of Delegator.
* Created Delegator.
* Created Interactor and Organizer.

## v1.2.0

* Added ruby 1.8.7, 1.9.2, 1.9.3, 2.0.0, 2.1.1, ree and jruby official support(Travis build).
* Added rails 3.1, 3.2, 4.0, 4.1 support(Travis build).
* Added support for Jquery Pjax on Responder

## v1.1.1

* Fixed Service instance variable name conflict with Devise.

## v1.1.0

* Improved Controller and Service code and behavior.

## v1.0.0

* Improved Controller by letting Service choose which params to work instead of pass as arguments.
* Fixed Service instance variable name conflict with Rails one.
* Improved Accessor logic.
* Allowing full customization of Responder initialization params from Service.
* Created Responder to force redirects and selt flash messages.

## v0.6.1

* Fixed params working on Controller to work depending on each case.

## v0.6.0

* Added support for nested resource on Service.

## v0.5.6

* Fixed Controller `#interface_class` when name is pluralized.

## v0.5.5

* Fixed Accessor `#interface_name` and `#interface_class` bugs on namespaced interfaces.

## v0.5.4

* Fixed Accessor `#interface_name` and `#interface_class` when interface is namespaced.

## v0.5.3

* Fixed Service `#interface_name` and `#interface_class` when interface is namespaced.

## v0.5.2

* Specified Rails minimum version.

## v0.5.1

* Fixed path definition on Controller.

## v0.5.0

* Added possibility to define path to redirect on Controller.

## v0.4.0

* Added possibility to define object passed to Responder.

## v0.3.1

* Fixed `.find` method from Accessor.

## v0.3.0

* Created Accessor to encapsulate logic over interfaces.

## v0.2.0

* Improved Service to find Interface from Namespace Controller.

## v0.1.3

* Fixed Controller Initialization by executing superclass initialization.

## v0.1.2

* Fixed `#interface_name` method from Service.

## v0.1.1

* Fixed `#modify` and `#delete` methods from Service.

## v0.1.0

* Created Controller and Service to improve default Rails Controller.