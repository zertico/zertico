require 'spec_helper'
require 'rspec/rails'

describe UsersController, :type => :controller do
  let(:user) { User.new }
  
  context '#index' do
    before :each do
      get :index
    end

    it 'should initialize a collection of users' do
      assigns(:users).should be_an_instance_of(Array)
    end

    it 'should initialize a collection with two itens' do
      assigns(:users).size.should be_equal 2
    end
  end

  context '#new' do
    before :each do
      get :new
    end

    it 'should initialize an user' do
      assigns(:user).should be_an_instance_of(User)
    end
  end

  context '#show' do
    before :each do
      get :show, :id => 1
    end

    it 'should find and initialize an user' do
      assigns(:user).should be_an_instance_of(User)
    end
  end

  context '#edit' do
    before :each do
      get :edit, :id => 1
    end

    it 'should find and initialize an user' do
      assigns(:user).should be_an_instance_of(User)
    end
  end

  context '#create' do
    before :each do
      post :create, :user => { :name => 'name' }
    end

    it 'should create a new user' do
      assigns(:user).should be_an_instance_of(User)
    end
  end

  context '#update' do
    before :each do
      put :update, :id => 1, :user => { :name => 'name' }
    end

    it 'should update an user' do
      assigns(:user).should be_an_instance_of(User)
    end
  end

  context '#destroy' do
    before :each do
      delete :destroy, :id => 1
    end

    it 'should destroy the user' do
      assigns(:user).should be_an_instance_of(User)
    end
  end
end