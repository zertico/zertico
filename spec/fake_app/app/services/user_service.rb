class UserService < Zertico::Service
  use_interface Product
  use_as_id 'great_id'
  use_as_variable_name 'great_name'
end