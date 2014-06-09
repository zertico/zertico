require 'spec_helper'
require 'rspec/rails'

describe UsersController, :type => :controller do
  let(:controller) { Zertico::Controller.new }
  let(:user_controller) { UserController.new }
  let(:service) { Zertico::Service.new }
  let(:user) { User.new }

  before :each do
    User.stub(:new => user)
  end

  context 'without a custom service' do
    it 'should initialize Zertico::Service' do
      controller.service.should be_an_instance_of(Zertico::Service)
    end
  end

  context 'with a custom service' do
    it 'should initialize it!' do
      user_controller.service.should be_an_instance_of(UserService)
    end
  end

  context '#index' do
    before :each do
      get :index
    end

    it 'should initialize a collection of users' do
      assigns(:users).should == [user, user]
    end
  end

  context '#new' do
    before :each do
      get :new
    end

    it 'should initialize an user' do
      assigns(:user).should == user
    end
  end

  context '#show' do
    before :each do
      get :show, :id => 1
    end

    it 'should find and initialize an user' do
      assigns(:user).should == user
    end
  end

  context '#edit' do
    before :each do
      get :edit, :id => 1
    end

    it 'should find and initialize an user' do
      assigns(:user).should == user
    end
  end

  context '#create' do
    before :each do
      post :create, :user => {}
    end

    it 'should create a new user' do
      assigns(:user).should == user
    end
  end

  context '#update' do
    before :each do
      put :update, :id => 1, :user => {}
    end

    it 'should update an user' do
      assigns(:user).should == user
    end
  end

  context '#destroy' do
    before :each do
      delete :destroy, :id => 1
    end

    it 'should destroy the user' do
      assigns(:user).should == user
    end
  end
end