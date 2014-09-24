require 'spec_helper'

describe Zertico::Service do
  let(:admin_service) { Admin::UserService.new }
  let(:gifts_service) { Person::GiftsService.new }
  let(:profile_service) { Person::ProfileService.new }
  let(:object) { Object.new }
  let(:users_service) { UsersService.new }
  let(:user) { User.new }

  describe '#interface_id' do
    context 'when passed to initialize' do
      before :each do
        @gifts_service = Person::GiftsService.new(:interface_id => 'teste')
      end

      it 'should return it' do
        expect(@gifts_service.send(:interface_id)).to eq('teste')
      end
    end

    context 'on a pluralized service' do
      it 'should return id' do
        expect(users_service.send(:interface_id)).to eq('id')
      end
    end

    context 'on a namespaced service and interface model' do
      it 'should return id with the model name' do
        expect(profile_service.send(:interface_id)).to eq('person_profile_id')
      end
    end

    context 'on a namespaced service and non namespaced interface model' do
      it 'should return id with the model name' do
        expect(admin_service.send(:interface_id)).to eq('user_id')
      end
    end

    context 'on a non namespaced service and non namespaced interface model' do
      it 'should return id' do
        expect(users_service.send(:interface_id)).to eq('id')
      end
    end

    context 'when defined on class' do
      before :each do
        Person::GiftsService.instance_variable_set('@interface_id', 'abc')
        @gifts_service = Person::GiftsService.new
      end

      it 'should return the defined value' do
        expect(@gifts_service.send(:interface_id)).to eq('abc')
      end
    end
  end

  describe '#interface_name' do
    context 'when passed to initialize' do
      before :each do
        @gifts_service = Person::GiftsService.new(:interface_name => 'teste')
      end

      it 'should return it' do
        expect(@gifts_service.send(:interface_name)).to eq('teste')
      end
    end

    it 'should return the interface name' do
      expect(users_service.send(:interface_name)).to eq('user')
    end

    context 'when defined on class' do
      before :each do
        Person::GiftsService.instance_variable_set('@interface_name', 'abc')
        @gifts_service = Person::GiftsService.new
      end

      it 'should return the defined value' do
        expect(@gifts_service.send(:interface_name)).to eq('abc')
      end
    end
  end

  describe '#interface_class' do
    context 'when passed to initialize' do
      before :each do
        @gifts_service = Person::GiftsService.new(:interface_class => User)
      end

      it 'should return it' do
        expect(@gifts_service.send(:interface_class)).to eq(User)
      end
    end

    context 'on a pluralized service' do
      it 'should find the interface model' do
        expect(users_service.send(:interface_class)).to eq(User)
      end
    end

    context 'on a namespaced service and interface model' do
      it 'should find the interface model' do
        expect(profile_service.send(:interface_class)).to eq(Person::Profile)
      end
    end

    context 'on a namespaced service and non namespaced interface model' do
      it 'should find the interface model' do
        expect(admin_service.send(:interface_class)).to eq(User)
      end
    end

    context 'on a non namespaced service and non namespaced interface model' do
      it 'should find the interface model' do
        expect(users_service.send(:interface_class)).to eq(User)
      end
    end

    context 'when defined on class' do
      before :each do
        Person::GiftsService.instance_variable_set('@interface_class', User)
        @gifts_service = Person::GiftsService.new
      end

      it 'should return the defined value' do
        expect(@gifts_service.send(:interface_class)).to eq(User)
      end
    end
  end
end