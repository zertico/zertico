require 'spec_helper'

describe Zertico::Accessor do
  let(:user) { User.new }
  let(:user_accessor) { UserAccessor.new(user) }

  describe '.initialize' do
    it 'should initialize the interface object on a instance variable' do
      UserAccessor.new(user).instance_variable_get('@user').should == user
    end
  end

  describe '.find' do
    before :each do
      User.stub(:find => user)
      UserAccessor.stub(:new => user_accessor)
    end

    it 'should return an accessor' do
      UserAccessor.find(3).should == user_accessor
    end
  end

  describe '#interface' do
    before :each do
      User.stub(:find => user)
    end

    it 'should return the interface object' do
      UserAccessor.find(3).interface.should == user
    end
  end

  describe '#method_missing' do
    it 'should pass the method to the interface model if it responds to it' do
      UserAccessor.new(user).should respond_to(:name)
    end
  end
end