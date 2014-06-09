# Zertico

[![Gem Version](https://badge.fury.io/rb/zertico.svg)](http://badge.fury.io/rb/zertico) [![Build Status](https://travis-ci.org/zertico/zertico.svg?branch=master)](https://travis-ci.org/zertico/zertico) [![Dependency Status](https://gemnasium.com/zertico/zertico.svg)](https://gemnasium.com/zertico/zertico) [![Coverage Status](https://img.shields.io/coveralls/zertico/zertico.svg?branch=master)](https://coveralls.io/r/zertico/zertico?branch=master) [![Code Climate](https://codeclimate.com/github/zertico/zertico.png)](https://codeclimate.com/github/zertico/zertico)

Increase your Rails development speed using patterns that will make your code even more easy to read and maintain.

## Installation

Add this line to your application's Gemfile:

    gem 'zertico'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zertico
    
## Tools

### Zertico::Accessor

It is deprecated. Please use `Zertico::Delegator` instead.
    
### Zertico::Controller
    
The `Zertico::Controller` define behavior of a common Rails Controller. By Extending it, your controllers will be more smart,
    they will know which model instantiate and where to redirect when needed.
     
All you need to do is extend ith with you `ApplicationController` and you will get the benefit of it.     
      
```ruby
class ApplicationController < ZerticoController
    respond_to :html
end
```  
    
After that all your controllers will look like this:
    
```ruby
class CarsController < ApplicationController
end
```    

### Zertico::Delegator

The `Zertico::Delegator` is a delegator with some extra tools to work with `ActiveRecord`. It will try to guess your model,
    and initialize it. It can be used as a Decorator.
    
```ruby
class UserDelegator < Zertico::Delegator
    def name
        interface.name.downcase
    end
end

user = UserDelegator.find(2)
puts user.interface.name
puts user.name

# 'User Name'
# 'user name'
```

### Zertico::Interactor

The `Zertico::Interactor` defines a single call on a transaction at the ruby interpreter level. It can be used to define a
    database call, api call, sending of an email or calculate some data based on another interactor.
    
```ruby
class CreateUserInteractor < Zertico::Interactor
    def perform(params)
        @user = User.create(params)
    end
    
    def rollback
        @user.destroy
    end
end
```
        
It should define its `perform` logic and `rollback` logic in case some other interactor fails.

### Zertico::Organizer

The `Zertico::Organizer` is responsible for calling a pack of interactors, and in case of some failure, send a
    rollback signal for all other interactors already executed.
    
```ruby
module CreateProduct
    extend Zertico::Organizer
    
    organize [ CreateProductInteractor, CreateInvoiceInteractor ]
end
```

In this example, it something goes wrong with the Invoice Creation, it will rollback the Product Creation.

### Zertico::Responder

`Zertico::Responder` its a custom Rails Responder with [pjax](https://github.com/defunkt/jquery-pjax) support and an 
    option to force a redirect no matter what.
    
```ruby
class ApplicationResponder < ActionController::Responder
    # custom responder behavior implemented by [responders](https://github.com/plataformatec/responders)
    include Responders::FlashResponder
    include Responders::HttpCacheResponder
    include Responders::CollectionResponder
    
    # add this line to get the Zertico::Responder behavior
    include Zertico::Responder
end
```

You will also need to define your custom Responder inside your ApplicationController:

```ruby
class ApplicationController < ActionController::Base
    self.responder = ApplicationResponder
    
    respond_to :html
end
```

To force a redirect do as follows:

```ruby
UsersController < ApplicationController
    def create
        @user = User.create(params[:user])
        respond_with(@user, force_redirect: true) # It will redirect even on failure
    end
end
```

### Zertico::Service

When using `Zertico::Controller` your controllers will try to find a service with the same name as your controller. 
    If it can't find, it will initialize and `Zertico::Service` class. Creating the service, you can define which class to use on that controller.
    
```ruby
class AdminController < ApplicationController
end

class AdminService < Zertico::Service
    use_interface User
    # or
    use_model User
    
    use_as_variable_name 'epic_user'
end
```

In the example above, the controller will use the model User instead of the model Admin he would have guessed.

### Extra Tips

Its is a good idea to separate each of the patterns you use in his own folder. If you choose to use all patterns here,
    you would have this:
    
    app/
        controllers/
        delegators/
        interactors/
        organizers/
        responders/
        services/
        
## Thanks
        
The `Interactor` and `Organizer` idea was taken from [interactor](https://github.com/collectiveidea/interactor) by
        [collectiveidea](https://github.com/collectiveidea). 

## Mantainers

[@plribeiro3000](https://github.com/plribeiro3000)

[@mfbmina](https://github.com/mfbmina)

[@silviolrjunior](https://github.com/silviolrjunior)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request