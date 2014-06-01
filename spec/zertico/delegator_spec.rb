require 'spec_helper'

describe Zertico::Delegator do
  let(:user) { User.new }
  let(:user_delegator) { UserDelegator.new(user) }

  context 'on a namespaced delegator and interface model' do
    it 'should find the interface model' do
      Person::ProfileDelegator.send(:interface_class).should == Person::Profile
    end

    it 'should return a valid instance variable name' do
      Person::ProfileDelegator.send(:interface_name).should == 'profile'
    end
  end

  context 'on a namespaced delegator and non namespaced interface model' do
    it 'should find the interface model' do
      Admin::UserDelegator.send(:interface_class).should == User
    end

    it 'should return a valid instance variable name' do
      Admin::UserDelegator.send(:interface_name).should == 'user'
    end
  end

  context 'on a non namespaced delegator and non namespaced interface model' do
    it 'should find the interface model' do
      UserDelegator.send(:interface_class).should == User
    end

    it 'should return a valid instance variable name' do
      UserDelegator.send(:interface_name).should == 'user'
    end
  end

  describe '.find' do
    before :each do
      User.stub(:find => user)
    end

    it 'should return an delegator' do
      UserDelegator.find(3).should be_an_instance_of(UserDelegator)
    end
  end

  describe '#interface' do
    before :each do
      User.stub(:find => user)
    end

    it 'should return the interface object' do
      UserDelegator.find(3).interface.should == user
    end
  end
end