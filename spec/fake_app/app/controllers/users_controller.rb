require File.join(File.dirname(__FILE__), '../responders/users_responder')

class UsersController < ApplicationController
  self.responder = UsersResponder

  attr_reader :user, :users
end