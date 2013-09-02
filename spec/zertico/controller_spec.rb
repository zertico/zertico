require 'spec_helper'

describe Zertico::Controller do
  let(:controller) { Zertico::Controller.new }
  let(:user_controller) { UserController.new }
  let(:admin_controller) { Admin::UserController.new }

  context 'not being nested' do
    it 'should find on the correct id' do
      user_controller.send(:interface_id).should  == 'id'
    end
  end

  context 'being nested' do
    it 'should find on the correct id' do
      admin_controller.send(:interface_id).should  == 'user_id'
    end
  end

  context 'without a custom service' do
    it 'should extend Zertico::Service' do
      controller.should respond_to :all
    end
  end

  context 'with a custom service' do
    it 'should extend Zertico::Service' do
      user_controller.should respond_to :all
    end

    it 'should extend it!' do
      user_controller.should respond_to :user
    end
  end

  context 'with a custom object to respond' do
    before :each do
      controller.stub(:all).and_return({ :user => 'user', :responder => 'admin' })
      controller.stub(:respond_with)
      controller.index
    end

    it 'should intialize an object with it' do
      controller.instance_variable_get('@responder').should == 'admin'
    end
  end

  context 'with a custom location to redirect' do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
      controller.stub(:params).and_return({ :user => 'user' })
      controller.stub(:generate => { :user => 'user', :location => 'admin_location' } )
      controller.stub(:respond_with)
      controller.create
    end

    it 'should intialize an object with it' do
      controller.instance_variable_get('@location').should == 'admin_location'
    end
  end

  context '#index' do
    before :each do
      controller.stub(:all).and_return({ :user => 'user' })
      controller.stub(:respond_with)
      controller.index
    end

    it 'should initialize a collection of objects' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end

  context '#new' do
    before :each do
      controller.stub(:build).and_return({ :user => 'user' })
      controller.stub(:respond_with)
      controller.new
    end

    it 'should initialize an object' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end

  context '#show' do
    before :each do
      controller.stub(:params).and_return({ :id => 1 })
      controller.stub(:find).and_return({ :user => 'user' })
      controller.stub(:respond_with)
      controller.show
    end

    it 'should initialize an object' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end

  context '#edit' do
    before :each do
      controller.stub(:params).and_return({ :id => 1 })
      controller.stub(:find).and_return({ :user => 'user' })
      controller.stub(:respond_with)
      controller.edit
    end

    it 'should initialize an object' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end

  context '#create' do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
      controller.stub(:params).and_return({ :user => 'user' })
      controller.stub(:generate => { :user => 'user' } )
      controller.stub(:respond_with)
      controller.create
    end

    it 'should create an object' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end

  context '#update' do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
      controller.stub(:params).and_return({ :id => 1, :user => 'user' })
      controller.stub(:modify => { :user => 'user' })
      controller.stub(:respond_with)
      controller.update
    end

    it 'should update an object' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end

  context '#destroy' do
    before :each do
      controller.stub(:params).and_return({:id => 1})
      controller.stub(:delete => { :user => 'user' })
      controller.stub(:respond_with)
      controller.destroy
    end

    it 'should destroy an object' do
      controller.instance_variable_get('@user').should == 'user'
    end
  end
end