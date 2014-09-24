require 'spec_helper'

describe Zertico::Service do
  describe '#initialize' do
    context 'with a custom controller' do
      it 'should save the name based on the controller name' do
        expect(Zertico::Service.new('UsersController').name).to eq('UsersService')
      end
    end

    context 'without a custom controller' do
      it 'should save the name of the service' do
        expect(Zertico::Service.new.name).to eq('Zertico::Service')
      end
    end
  end
end