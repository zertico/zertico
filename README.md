# Zertico

[![Gem Version](https://badge.fury.io/rb/zertico.png)](http://badge.fury.io/rb/zertico) [![Build Status](https://travis-ci.org/zertico/zertico.png)](https://travis-ci.org/zertico/zertico) [![Coverage Status](https://coveralls.io/repos/zertico/zertico/badge.png?branch=master)](https://coveralls.io/r/zertico/zertico) [![Code Climate](https://codeclimate.com/github/zertico/zertico.png)](https://codeclimate.com/github/zertico/zertico)

Easy Rails development using the Zertico Way.
Rails is a great framework, but is not a great idea to let your tests depend on any part of it.
Zertico let you develop what most important: your business logic. Also, your tests will not depend
of rails at all.

## Installation

Add this line to your application's Gemfile:

    gem 'zertico'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zertico

## Basic Usage

First, alter your ApplicationController and extend Zertico::Controller

```ruby
class ApplicationController < Zertico::Controller
end
```

Now, define the routes you need as follow:

```ruby
resources :entries
```

And thats all. All the logic is already defined on the controller. Happy coding. =D

## Advanced Usage

The Zertico::Controller doesn't cover all cases. For those that are not covered you will have to
create a service with the same name of the controller, as follows:

```ruby
class UsersController < ApplicationController
```

```ruby
module UserService
    include Zertico::Service
end
```

Your service must be a module and include Zertico::Service to grant access to all the methods already defined.
Then you will have to redefine all the methods you need. Each action of the controller is mapped to a method.
The method has to return a hash. The key must be the name of the global variable you want to use on the views.

## Conventions

To work with the gem, you will need to follow some conventions. Your model ( called interface here ) need to
have the same name of your controller, without the 'Controller' substring. The Service need to replace the
'Controller' substring with 'Service' like:

```ruby
class UserController < Zertico::Controller
end

module UserService
    include Zertico::Service
end

class User < ActiveRecord::Base
end
```

It is good to put the services on a separate folder called services.

## Mantainers

[@plribeiro3000](https://github.com/plribeiro3000)

[@mfbmina](https://github.com/mfbmina)

[@silviolrjunio](https://github.com/silviolrjunior)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
