require 'spec_helper'

describe Zertico::Service do
  let(:user) { User.new }
  let(:service_class) { UserService }
  let(:service) { UserService.new }

  describe '.use_as_id' do
    it 'should define the id name' do
      expect(service_class.interface_id).to eq('great_id')
    end
  end

  describe '.use_as_variable_name' do
    it 'should define the variable name' do
      expect(service_class.interface_name).to eq('great_name')
    end
  end

  describe '.use_interface' do
    it 'should define the interface' do
      expect(service_class.interface_class).to eq(Product)
    end
  end

  describe '#resource_source=' do
    before :each do
      allow(User).to receive_messages(:all => [ user ])
      service_class.resource_source = %w(User all)
    end

    it 'should set the resource' do
      expect(service.resource_source).to eq([ user ])
    end
  end
end