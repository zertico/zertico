require 'spec_helper'

describe Zertico::Delegator do
  let(:user) { User.new }
  let(:product) { Product.new }
  let(:user_delegator) { UserDelegator.new }

  context 'on a namespaced delegator and interface model' do
    it 'should find the interface model' do
      expect(Person::ProfileDelegator.send(:interface_class)).to eq(Person::Profile)
    end

    it 'should return a valid instance variable name' do
      expect(Person::ProfileDelegator.send(:interface_name)).to eq('profile')
    end
  end

  context 'on a namespaced delegator and non namespaced interface model' do
    it 'should find the interface model' do
      expect(Admin::UserDelegator.send(:interface_class)).to eq(User)
    end

    it 'should return a valid instance variable name' do
      expect(Admin::UserDelegator.send(:interface_name)).to eq('user')
    end
  end

  context 'on a non namespaced delegator and non namespaced interface model' do
    it 'should find the interface model' do
      expect(UserDelegator.send(:interface_class)).to eq(User)
    end

    it 'should return a valid instance variable name' do
      expect(UserDelegator.send(:interface_name)).to eq('user')
    end
  end

  describe '.new' do
    context 'without params' do
      it "should initialize an object based on delegator's name" do
        expect(UserDelegator.new.interface).to be_an_instance_of(User)
      end
    end

    context 'with an object as param' do
      it 'use this object' do
        expect(UserDelegator.new(product).interface).to be_an_instance_of(Product)
      end
    end
  end

  describe '.find' do
    before :each do
      allow(User).to receive(:find).and_return(user)
    end

    it 'should return an delegator' do
      expect(UserDelegator.find(3)).to be_an_instance_of(UserDelegator)
    end
  end

  describe '#interface' do
    before :each do
      allow(User).to receive(:find).and_return(user)
    end

    it 'should return the interface object' do
      expect(UserDelegator.find(3).interface).to eq(user)
    end
  end

  describe '#interface=' do
    before :each do
      user_delegator.interface = product
    end

    it 'should set the interface object' do
      expect(user_delegator.interface).to eq(product)
    end
  end

  describe '.interface_name' do
    it 'should return the interface name' do
      expect(UserDelegator.interface_name).to eq('user')
    end
  end

  describe '.interface_class' do
    it 'should return the interface name' do
      expect(UserDelegator.interface_class).to eq(User)
    end
  end

  describe '#interface_name' do
    it 'should return the interface name' do
      expect(user_delegator.send(:interface_name)).to eq('user')
    end
  end

  describe '#interface_class' do
    it 'should return the interface name' do
      expect(user_delegator.send(:interface_class)).to eq(User)
    end
  end
end