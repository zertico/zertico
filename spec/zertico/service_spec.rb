require 'spec_helper'

describe Zertico::Service do
  let(:controller) { UserController.new }
  let(:admin_controller) { Admin::UserController.new }
  let(:profile_controller) { Person::ProfileController.new }
  let(:object) { Object.new }
  let(:users_controller) { UsersController.new }

  context '#all' do
    before :each do
      User.stub(:all => [])
      controller.all
    end

    it 'should save a collection on an instance variable' do
      controller.instance_variable_get('@users').should == []
    end

    it 'should return a collection' do
      controller.all.should == []
    end
  end

  context '#build' do
    before :each do
      User.stub(:new => object)
      controller.build
    end

    it 'should save an object on an instance variable' do
      controller.instance_variable_get('@user').should == object
    end

    it 'should return an object' do
      controller.build.should == object
    end
  end

  context '#find' do
    before :each do
      User.stub(:find => object)
      controller.stub(:params => { :id => 1 })
      controller.find
    end

    it 'should save an object on an instance variable' do
      controller.instance_variable_get('@user').should == object
    end

    it 'should return an object' do
      controller.find.should == object
    end
  end

  context '#generate' do
    before :each do
      User.stub(:create => object)
      controller.stub(:params => { :user => {} })
      controller.generate
    end

    it 'should save an object on an instance variable' do
      controller.instance_variable_get('@user').should == object
    end

    it 'should return an object' do
      controller.generate.should == object
    end
  end

  context '#modify' do
    before :each do
      User.stub(:find => object)
      controller.stub(:params => { :id => 1, :user => {} })
      object.stub(:update_attributes).with({}).and_return(true)
      controller.modify
    end

    it 'should save an object on an instance variable' do
      controller.instance_variable_get('@user').should == object
    end

    it 'should return an object' do
      controller.modify.should == object
    end
  end

  context '#delete' do
    before :each do
      User.stub(:find => object)
      controller.stub(:params => { :id => 1 })
      object.stub(:destroy => true)
      controller.delete
    end

    it 'should save an object on an instance variable' do
      controller.instance_variable_get('@user').should == object
    end

    it 'should return an object' do
      controller.delete.should == object
    end
  end

  context '#resource_source' do
    context 'with no resource defined' do
      before :each do
        controller.stub(:interface_class => User)
      end

      it 'should return the resource' do
        controller.resource_source.should == User
      end
    end

    context 'with a resource defined' do
      before :each do
        controller.resource_source = %w(Person::Profile)
      end

      it 'should return the resource' do
        controller.resource_source.should == Person::Profile
      end
    end
  end

  context '#resource=' do
    before :each do
      User.stub(:all => [ object ])
      controller.resource_source = %w(User all)
    end

    it 'should set the resource' do
      controller.resource_source.should == [ object ]
    end
  end

  describe '#interface_id' do
    context 'on a pluralized controller' do
      it 'should return id' do
        users_controller.send(:interface_id).should == 'id'
      end
    end

    context 'on a namespaced controller and interface model' do
      it 'should return id with the model name' do
        profile_controller.send(:interface_id).should == 'person_profile_id'
      end
    end

    context 'on a namespaced controller and non namespaced interface model' do
      it 'should return id with the model name' do
        admin_controller.send(:interface_id).should == 'user_id'
      end
    end

    context 'on a non namespaced controller and non namespaced interface model' do
      it 'should return id' do
        controller.send(:interface_id).should == 'id'
      end
    end
  end

  describe '#interface_name' do
    it 'should return the interface name' do
      users_controller.send(:interface_name).should == 'user'
    end
  end

  context 'on a pluralized controller' do
    it 'should find the interface model' do
      users_controller.send(:interface_class).should == User
    end
  end

  context 'on a namespaced controller and interface model' do
    it 'should find the interface model' do
      profile_controller.send(:interface_class).should == Person::Profile
    end
  end

  context 'on a namespaced controller and non namespaced interface model' do
    it 'should find the interface model' do
      admin_controller.send(:interface_class).should == User
    end
  end

  context 'on a non namespaced controller and non namespaced interface model' do
    it 'should find the interface model' do
      controller.send(:interface_class).should == User
    end
  end
end