require 'spec_helper'

describe Zertico::Service do
  let(:user) { User.new }
  let(:service_class) { UserService }
  let(:service) { UserService.new }

  describe '.use_as_id' do
    it 'should define the id name' do
      service_class.interface_id.should == 'great_id'
    end
  end

  describe '.use_as_variable_name' do
    it 'should define the variable name' do
      service_class.interface_name.should == 'great_name'
    end
  end

  describe '.use_interface' do
    it 'should define the interface' do
      service_class.interface_class.should == Product
    end
  end

  describe '#resource_source=' do
    before :each do
      User.stub(:all => [ user ])
      service_class.resource_source = %w(User all)
    end

    it 'should set the resource' do
      service.resource_source.should == [ user ]
    end
  end
end