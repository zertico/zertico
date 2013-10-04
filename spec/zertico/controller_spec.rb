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

  context 'actions' do
    before :each do
      controller.instance_variable_set('@options', 'options')
      controller.stub(:respond_with).with('responder', 'options')
    end

    context '#index' do
      before :each do
        controller.stub(:all => 'responder')
      end

      after :each do
        controller.index
      end

      it 'should initialize a collection of objects' do
        controller.should_receive(:all)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end

    context '#new' do
      before :each do
        controller.stub(:build => 'responder')
      end

      after :each do
        controller.new
      end

      it 'should initialize an object' do
        controller.should_receive(:build)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end

    context '#show' do
      before :each do
        controller.stub(:find => 'responder')
      end

      after :each do
        controller.show
      end

      it 'should initialize an object' do
        controller.should_receive(:find)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end

    context '#edit' do
      before :each do
        controller.stub(:find => 'responder')
      end

      after :each do
        controller.edit
      end

      it 'should initialize an object' do
        controller.should_receive(:find)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end

    context '#create' do
      before :each do
        controller.stub(:generate => 'responder')
      end

      after :each do
        controller.create
      end

      it 'should initialize an object' do
        controller.should_receive(:generate)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end

    context '#update' do
      before :each do
        controller.stub(:modify => 'responder')
      end

      after :each do
        controller.update
      end

      it 'should initialize an object' do
        controller.should_receive(:modify)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end

    context '#destroy' do
      before :each do
        controller.stub(:delete => 'responder')
      end

      after :each do
        controller.destroy
      end

      it 'should initialize an object' do
        controller.should_receive(:delete)
      end

      it 'should respond correctly' do
        controller.should_receive(:respond_with).with('responder', 'options')
      end
    end
  end
end