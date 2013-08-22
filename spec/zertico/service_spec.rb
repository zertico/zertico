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
      controller.stub_chain(:interface_name, :pluralize, :to_sym).and_return(:users)
      controller.stub_chain(:interface_class, :all).and_return([])
    end

    it 'should return a collection of objects' do
      controller.all.should == { :users => [] }
    end
  end

  context '#build' do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:person)
      controller.stub_chain(:interface_class, :new).and_return(object)
    end

    it 'should return a new object' do
      controller.build.should == { :person => object }
    end
  end

  context '#find' do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:person)
      controller.stub_chain(:interface_class, :find).with(1).and_return(object)
    end

    it 'should return the specified object' do
      controller.find(1).should == { :person => object }
    end
  end

  context '#generate' do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:person)
      controller.stub_chain(:interface_class, :create).with({}).and_return(object)
    end

    it 'should return the created object' do
      controller.generate({}).should == { :person => object }
    end
  end

  context '#modify' do
    before :each do
      controller.stub(:find).with(1).and_return({ :person => object })
      object.stub(:update_attributes).with({}).and_return(true)
      controller.stub_chain(:interface_name, :to_sym).and_return(:person)
    end

    it 'should return the updated object' do
      controller.modify(1, {}).should == { :person => object }
    end
  end

  context '#delete' do
    before :each do
      controller.stub(:find).with(1).and_return({ :person => object })
      object.stub(:destroy).and_return(true)
      controller.stub_chain(:interface_name, :to_sym).and_return(:person)
    end

    it 'should return the destroyed object' do
      controller.delete(1).should == { :person => object }
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