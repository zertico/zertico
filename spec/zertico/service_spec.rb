require 'spec_helper'

describe Zertico::Service do
  let(:controller) { UserController.new }
  let(:admin_controller) { Admin::UserController.new }
  let(:profile_controller) { Person::ProfileController.new }
  let(:object) { Object.new }
  let(:users_controller) { UsersController.new }

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

  context '#all' do
    before :each do
      User.stub(:all => [])
      controller.all
    end

    it 'should save a collection on an instance variable' do
      controller.instance_variable_get('@users').should == []
    end

    it 'should save the object on an instance variable to respond' do
      controller.instance_variable_get('@responder').should == []
    end

    it 'should save a hash with options on an instance variable' do
      controller.instance_variable_get('@options').should == {}
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
    
    it 'should save the object on an instance variable to respond' do
      controller.instance_variable_get('@responder').should == object
    end

    it 'should save a hash with options on an instance variable' do
      controller.instance_variable_get('@options').should == {}
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

    it 'should save the object on an instance variable to respond' do
      controller.instance_variable_get('@responder').should == object
    end

    it 'should save a hash with options on an instance variable' do
      controller.instance_variable_get('@options').should == {}
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

    it 'should save the object on an instance variable to respond' do
      controller.instance_variable_get('@responder').should == object
    end

    it 'should save a hash with options on an instance variable' do
      controller.instance_variable_get('@options').should == {}
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

    it 'should save the object on an instance variable to respond' do
      controller.instance_variable_get('@responder').should == object
    end

    it 'should save a hash with options on an instance variable' do
      controller.instance_variable_get('@options').should == {}
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

    it 'should save the object on an instance variable to respond' do
      controller.instance_variable_get('@responder').should == object
    end

    it 'should save a hash with options on an instance variable' do
      controller.instance_variable_get('@options').should == {}
    end
  end

  context '#resource' do
    context 'with no resource defined' do
      before :each do
        controller.stub(:interface_class => User)
      end

      it 'should return the resource' do
        controller.resource.should == User
      end
    end

    context 'with a resource defined' do
      before :each do
        controller.resource = %w(Person::Profile)
      end

      it 'should return the resource' do
        controller.resource.should == Person::Profile
      end
    end
  end

  context '#resource=' do
    before :each do
      User.stub(:all => [ object ])
      controller.resource = %w(User all)
    end

    it 'should set the resource' do
      controller.resource.should == [ object ]
    end
  end
end