require 'spec_helper'

describe Zertico::Interactor do
  let(:interactor) { Zertico::Interactor.new }

  describe '#perform' do
    it 'should raise a rollback exception' do
      expect { interactor.perform({}) }.to raise_error
    end
  end

  describe '#rollback' do
    it 'should return true' do
      interactor.rollback.should == true
    end
  end

  describe '#inject_instances' do
    before :each do
      interactor.inject_instances({ 'a' => 'B' })
    end

    it 'should create instances based on a hash' do
      interactor.instance_variable_get('@a').should == 'B'
    end
  end

  describe '#get_instances' do
    before :each do
      interactor.instance_variable_set('@a', 'A')
      interactor.instance_variable_set('@b', 'B')
      interactor.instance_variable_set('@z', 'Z')
    end

    it 'should return a hash with all instance variables name and value' do
      interactor.get_instances.should == { 'a' => 'A', 'b' => 'B', 'z' => 'Z' }
    end
  end

  describe '.interface_name' do
    it 'should return the interface name' do
      Zertico::Interactor.interface_name.should == 'Zertico'
    end
  end

  describe '#fail' do
    it 'should raise a rollback exception' do
      expect { interactor.fail! }.to raise_error
    end
  end
end