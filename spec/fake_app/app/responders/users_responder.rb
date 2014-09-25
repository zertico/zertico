require "#{File.join(File.dirname(__FILE__), '/application_responder')}"

class UsersResponder < ApplicationResponder
  include Pjax

  self.update_options = lambda { |controller| { :location => user_path(controller.user) } }
end