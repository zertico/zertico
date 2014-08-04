require 'spec_helper'

describe Zertico::Controller do
  let(:controller) { UsersController.new }
  let(:user_controller) { UserController.new }
  let(:zertico_controller) { Zertico::Controller.new }
  let(:service) { Zertico::Service.new }

  context 'without a custom service' do
    it 'should initialize Zertico::Service' do
      zertico_controller.service.should be_an_instance_of(Zertico::Service)
    end
  end

  context 'with a custom service' do
    it 'should initialize it!' do
      controller.service.should be_an_instance_of(UsersService)
    end
  end
end