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
      interactor.rollback.should be_true
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