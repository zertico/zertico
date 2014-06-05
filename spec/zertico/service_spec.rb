require 'spec_helper'

describe Zertico::Service do
  let(:service) { UserService.new }
  let(:admin_service) { Admin::UserService.new }
  let(:gifts_service) { Person::GiftsService.new }
  let(:profile_service) { Person::ProfileService.new }
  let(:object) { Object.new }
  let(:users_service) { UsersService.new }
  let(:user) { User.new }

  before :each do
    User.stub(new: user)
  end

  context '#index' do
    it 'should return a collection of users' do
      users_service.index.should == [user, user]
    end

    before :each do
      users_service.index
    end

    it 'should save the collection in an instance variable' do
      users_service.users.should == [user, user]
    end
  end

  context '#new' do
    it 'should return a new user' do
      users_service.new.should == user
    end

    before :each do
      users_service.new
    end

    it 'should save the user in an instance variable' do
      users_service.user.should == user
    end
  end

  context '#show' do
    it 'should search for an user' do
      users_service.show({ :id => 1 }).should == user
    end

    before :each do
      users_service.show({ :id => 1 })
    end

    it 'should save the user found in an instance variable' do
      users_service.user.should == user
    end
  end

  context '#create' do
    it 'should search for an user' do
      users_service.create({ :user => {} }).should == user
    end

    before :each do
      users_service.create({ :user => {} })
    end

    it 'should save the created user in an instance variable' do
      users_service.user.should == user
    end
  end

  context '#update' do
    it 'should search for an user' do
      users_service.create({ :id => 1, :user => {} }).should == user
    end

    before :each do
      users_service.create({ :id => 1, :user => {} })
    end

    it 'should save the updated user in an instance variable' do
      users_service.user.should == user
    end
  end

  context '#destroy' do
    it 'should search for an user' do
      users_service.destroy({ :id => 1 }).should == user
    end

    before :each do
      users_service.destroy({ :id => 1 })
    end

    it 'should save the destroyed user in an instance variable' do
      users_service.user.should == user
    end
  end

  describe '#interface_id' do
    context 'on a pluralized service' do
      it 'should return id' do
        users_service.send(:interface_id).should == 'id'
      end
    end

    context 'on a namespaced service and interface model' do
      it 'should return id with the model name' do
        profile_service.send(:interface_id).should == 'person_profile_id'
      end
    end

    context 'on a namespaced service and non namespaced interface model' do
      it 'should return id with the model name' do
        admin_service.send(:interface_id).should == 'user_id'
      end
    end

    context 'on a non namespaced service and non namespaced interface model' do
      it 'should return id' do
        service.send(:interface_id).should == 'id'
      end
    end

    context 'on a namespaced service and an undefined interface model' do
      it 'should return id' do
        gifts_service.send(:interface_id).should == 'id'
      end
    end
  end

  describe '#interface_name' do
    it 'should return the interface name' do
      users_service.send(:interface_name).should == 'user'
    end
  end

  context 'on a pluralized service' do
    it 'should find the interface model' do
      users_service.send(:interface_class).should == User
    end
  end

  context 'on a namespaced service and interface model' do
    it 'should find the interface model' do
      profile_service.send(:interface_class).should == Person::Profile
    end
  end

  context 'on a namespaced service and non namespaced interface model' do
    it 'should find the interface model' do
      admin_service.send(:interface_class).should == User
    end
  end

  context 'on a non namespaced service and non namespaced interface model' do
    it 'should find the interface model' do
      service.send(:interface_class).should == User
    end
  end
end