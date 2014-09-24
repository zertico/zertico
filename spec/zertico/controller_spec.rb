require 'spec_helper'

describe Zertico::Controller do
  let(:controller) { UsersController.new }
  let(:zertico_controller) { Zertico::Controller.new }
  let(:service) { Zertico::Service.new }

  context 'without a custom service' do
    it 'should initialize Zertico::Service' do
      expect(zertico_controller.service).to be_an_instance_of(Zertico::Service)
    end
  end

  context 'with a custom service' do
    it 'should initialize it!' do
      expect(controller.service).to be_an_instance_of(UsersService)
    end
  end

  context 'without a custom responder' do
    it 'should initialize Zertico::Responder' do
      expect(zertico_controller.responder).to be == Zertico::Responder
    end
  end

  context 'with a custom responder' do
    it 'should initialize it!' do
      expect(controller.responder).to be == UsersResponder
    end
  end
end