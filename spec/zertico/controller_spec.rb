require 'spec_helper'

describe Zertico::Controller do
  let(:users_controller) { UsersController.new }
  let(:cars_controller) { CarsController.new }
  let(:zertico_controller) { Zertico::Controller.new }
  let(:service) { Zertico::Service.new }

  context 'without a custom service' do
    context 'on Zertico::Controller' do
      it 'should initialize Zertico::Service' do
        expect(zertico_controller.service).to be_an_instance_of(Zertico::Service)
      end
    end

    context 'on a custom controller' do
      it 'should initialize Zertico::Service' do
        expect(cars_controller.service).to be_an_instance_of(Zertico::Service)
      end
    end
  end

  context 'with a custom service' do
    it 'should initialize it!' do
      expect(users_controller.service).to be_an_instance_of(UsersService)
    end
  end

  context 'without a custom responder' do
    it 'should initialize Zertico::Responder' do
      expect(zertico_controller.responder).to be == Zertico::Responder
    end
  end

  context 'with a custom responder' do
    it 'should initialize it!' do
      expect(users_controller.responder).to be == UsersResponder
    end
  end

  context 'without a custom permitted_params' do
    before :each do
      allow(zertico_controller).to receive(:params).and_return({})
      zertico_controller.send(:initialize_permitted_params)
    end

    it 'should initialize Zertico::PermittedParams' do
      expect(zertico_controller.permitted_params).to be_an_instance_of(Zertico::PermittedParams)
    end
  end

  context 'with a custom permitted_params' do
    before :each do
      allow(users_controller).to receive(:params).and_return({})
      users_controller.send(:initialize_permitted_params)
    end

    it 'should initialize it!' do
      expect(users_controller.permitted_params).to be_an_instance_of(UsersPermittedParams)
    end
  end
end