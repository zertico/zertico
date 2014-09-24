class UsersResponder < Zertico::Responder
  include Pjax

  self.update_options = lambda { |controller| { :location => user_path(controller.user) } }
end