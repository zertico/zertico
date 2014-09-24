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
        post :create, :user => { :name => 'name' }
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
        allow(User).to receive_messages(:create => user)
        allow(user).to receive_messages(:errors => ['asd'])
        post :create, :user => { :name => 'name' }
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
        allow(User).to receive_messages(:find => user)
        allow(user).to receive_messages(:id => 3)
        put :update, :id => 1, :user => { :name => 'name' }
      end

      it 'should have an HTTP status :found' do
        expect(response).to have_http_status(:found)
      end

      it 'should redirect to #show' do
        expect(response).to redirect_to(:action => :show, :id => 3)
      end
    end

    context 'when fail to save' do
      before :each do
        allow(User).to receive_messages(:find => user)
        allow(user).to receive_messages(:id => 3)
        allow(user).to receive_messages(:errors => ['asd'])
        put :update, :id => 1, :user => { :name => 'name' }
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

  %w(index new edit create show destroy).each do |method_name|
    describe "##{method_name}_options=" do
      it "should set an hash of options for #{method_name} action" do
        expect(controller.responder.send("#{method_name}_options", controller)).to eq({})
      end
    end

    describe "##{method_name}_options" do
      it "should return a hash of options for #{method_name} action" do
        expect(controller.responder.send("#{method_name}_options", controller)).to eq({})
      end
    end
  end
end