require 'spec_helper'
require 'rspec/rails'

describe UsersResponder, :type => :controller do
  let(:controller) { UsersController.new }
  let(:user) { User.new }

  before :each do @controller = controller; end

  render_views

  describe '#index' do
    context 'from normal requisition' do
      before :each do
        get :index
      end

      it 'should have an HTTP status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should render template index' do
        expect(response).to render_template(:index)
      end

      it 'should render the application layout' do
        expect(response).to render_template(:layout => 'application')
      end
    end

    context 'from pjax' do
      before :each do
        request.env['X-PJAX'] = 'true' # For Rails 3.2
        request.headers['X-PJAX'] = 'true'
        get :index
      end

      it 'should not render any layout' do
        expect(response).to render_template(:layout => false)
      end
    end
  end

  describe '#new' do
    context 'from normal requisition' do
      before :each do
        get :new
      end

      it 'should have an HTTP status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should render template new' do
        expect(response).to render_template(:new)
      end

      it 'should render the application layout' do
        expect(response).to render_template(:layout => 'application')
      end
    end

    context 'from pjax' do
      before :each do
        request.env['X-PJAX'] = 'true' # For Rails 3.2
        request.headers['X-PJAX'] = 'true'
        get :new
      end

      it 'should not render any layout' do
        expect(response).to render_template(:layout => false)
      end
    end
  end

  describe '#show' do
    context 'from normal requisition' do
      before :each do
        get :show, :id => 1
      end

      it 'should have an HTTP status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should render template show' do
        expect(response).to render_template(:show)
      end

      it 'should render the application layout' do
        expect(response).to render_template(:layout => 'application')
      end
    end

    context 'from pjax' do
      before :each do
        request.env['X-PJAX'] = 'true' # For Rails 3.2
        request.headers['X-PJAX'] = 'true'
        get :show, :id => 1
      end

      it 'should not render any layout' do
        expect(response).to render_template(:layout => false)
      end
    end
  end

  describe '#edit' do
    context 'from normal requisition' do
      before :each do
        get :edit, :id => 1
      end

      it 'should have an HTTP status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should render template edit' do
        expect(response).to render_template(:edit)
      end

      it 'should render the application layout' do
        expect(response).to render_template(:layout => 'application')
      end
    end

    context 'from pjax' do
      before :each do
        request.env['X-PJAX'] = 'true' # For Rails 3.2
        request.headers['X-PJAX'] = 'true'
        get :edit, :id => 1
      end

      it 'should not render any layout' do
        expect(response).to render_template(:layout => false)
      end
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