require 'spec_helper'

describe Zertico::Service do
  let(:admin_service) { Admin::UserService.new }
  let(:gifts_service) { Person::GiftsService.new }
  let(:profile_service) { Person::ProfileService.new }
  let(:object) { Object.new }
  let(:users_service) { UsersService.new }
  let(:user) { User.new }

  before :each do
    allow(User).to receive(:new).and_return(user)
  end

  describe '#index' do
    it 'should return a collection of users' do
      expect(users_service.index).to eq([user, user])
    end

    before :each do
      users_service.index
    end

    it 'should save the collection in an instance variable' do
      expect(users_service.users).to eq([user, user])
    end
  end

  describe '#new' do
    it 'should return a new user' do
      expect(users_service.new).to eq(user)
    end

    before :each do
      users_service.new
    end

    it 'should save the user in an instance variable' do
      expect(users_service.user).to eq(user)
    end
  end

  describe '#show' do
    it 'should search for an user' do
      expect(users_service.show({ :id => 1 })).to eq(user)
    end

    before :each do
      users_service.show({ :id => 1 })
    end

    it 'should save the user found in an instance variable' do
      expect(users_service.user).to eq(user)
    end
  end

  describe '#create' do
    it 'should search for an user' do
      expect(users_service.create({ :user => {} })).to eq(user)
    end

    before :each do
      users_service.create({ :user => {} })
    end

    it 'should save the created user in an instance variable' do
      expect(users_service.user).to eq(user)
    end
  end

  describe '#update' do
    it 'should search for an user' do
      expect(users_service.update({ :id => 1, :user => {} })).to eq(user)
    end

    before :each do
      users_service.update({ :id => 1, :user => {} })
    end

    it 'should update the user' do
      expect(users_service.user.updated).to eq(true)
    end

    it 'should save the updated user in an instance variable' do
      expect(users_service.user).to eq(user)
    end
  end

  describe '#destroy' do
    it 'should search for an user' do
      expect(users_service.destroy({ :id => 1 })).to eq(user)
    end

    before :each do
      users_service.destroy({ :id => 1 })
    end

    it 'should destroy the user' do
      expect(users_service.user.destroyed).to eq(true)
    end

    it 'should save the destroyed user in an instance variable' do
      expect(users_service.user).to eq(user)
    end
  end

  describe '#resource_source' do
    context 'without a custom resource defined on class' do
      it 'should return it!' do
        expect(users_service.resource_source).to eq(User)
      end
    end

    context 'with a custom resource defined on class' do
      before :each do
        UsersService.resource_source = [ Person::Profile ]
      end

      it 'should return it!' do
        expect(users_service.resource_source).to eq(Person::Profile)
      end
    end
  end
end