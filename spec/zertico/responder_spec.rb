require 'spec_helper'
require 'rspec/rails'

describe UsersResponder, :type => :controller do
  let(:controller) { UsersController.new }
  let(:user) { User.new }

  before :each do @controller = controller; end

  render_views

  describe '#index' do
    before :each do
      get :index
    end

    it 'should have an HTTP status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render template index' do
      expect(response).to render_template(:index)
    end
  end

  describe '#new' do
    before :each do
      get :show, :id => 1
    end

    it 'should have an HTTP status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render template new' do
      expect(response).to render_template(:show)
    end
  end

  describe '#show' do
    before :each do
      get :show, :id => 1
    end

    it 'should have an HTTP status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render template show' do
      expect(response).to render_template(:show)
    end
  end

  describe '#edit' do
    before :each do
      get :edit, :id => 1
    end

    it 'should have an HTTP status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render template edit' do
      expect(response).to render_template(:edit)
    end
  end

  describe '#create' do
    context 'when successfull saving' do
      before :each do
        post :create
      end

      it 'should have an HTTP status :found' do
        expect(response).to have_http_status(:found)
      end

      it 'should redirect to #show' do
        expect(response).to redirect_to(:action => :index)
      end
    end

    context 'when fail to save' do
      before :each do
        User.stub(:create => user)
        user.stub(:errors => ['asd'])
        post :create
      end

      it 'should have an HTTP status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should render template new' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    context 'when successfull updating' do
      before :each do
        put :update, :id => 1
      end

      it 'should have an HTTP status :found' do
        expect(response).to have_http_status(:found)
      end

      it 'should redirect to #index' do
        expect(response).to redirect_to(:action => :index)
      end
    end

    context 'when fail to save' do
      before :each do
        User.stub(:find => user)
        user.stub(:update_attributes => false)
        user.stub(:errors => ['asd'])
        put :update, :id => 1
      end

      it 'should have an HTTP status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should render template edit' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    before :each do
      delete :destroy, :id => 1
    end

    it 'should have an HTTP status :found' do
      expect(response).to have_http_status(:found)
    end

    it 'should render template edit' do
      expect(response).to redirect_to(:action => :index)
    end
  end
end