require 'spec_helper'

describe Zertico::Accessor do
  let(:user) { User.new }

  describe '.initialize' do
    it 'should initialize the interface object on a instance variable' do
      UserAccessor.new(user).instance_variable_get('@user').should == user
    end
  end

  describe '.find' do
    before :each do
      User.stub(:find => user)
    end

    it 'should initialize the interface object on a instance variable' do
      UserAccessor.find(3).instance_variable_get('@user').should == user
    end
  end

  describe '#method_missing' do
    it 'should pass the method to the interface model if it responds to it' do
      UserAccessor.new(user).should respond_to(:name)
    end
  end
end