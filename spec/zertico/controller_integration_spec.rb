require 'spec_helper'
require 'rspec/rails'

describe UsersController, :type => :controller do
  let(:user) { User.new }
  
  context '#index' do
    before :each do
      get :index
    end

    it 'should initialize a collection of users' do
      expect(assigns(:users)).to be_an_instance_of(Array)
    end

    it 'should initialize a collection with two itens' do
      expect(assigns(:users).size).to be_equal 2
    end
  end

  context '#new' do
    before :each do
      get :new
    end

    it 'should initialize an user' do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  context '#show' do
    before :each do
      get :show, :id => 1
    end

    it 'should find and initialize an user' do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  context '#edit' do
    before :each do
      get :edit, :id => 1
    end

    it 'should find and initialize an user' do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  context '#create' do
    before :each do
      post :create, :user => { :name => 'name' }
    end

    it 'should pass the right parameters to the model' do
      expect(User).to receive(:create).with(:first_name => 'name').and_return(user)
      post :create, :user => { :first_name => 'name' }
    end

    it 'should create a new user' do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  context '#update' do
    before :each do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:id).and_return(3)
      put :update, :id => 1, :user => { :last_name => 'teste' }
    end

    it 'should pass the right parameters to the model' do
      expect(user).to receive(:update_attributes).with('last_name' => 'teste').and_return(true)
      put :update, :id => 1, :user => { :last_name => 'teste' }
    end

    it 'should update an user' do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  context '#destroy' do
    before :each do
      delete :destroy, :id => 1
    end

    it 'should destroy the user' do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end
end