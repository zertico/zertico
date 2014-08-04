require 'spec_helper'

describe Zertico::PermittedParams do
  let(:user) { User.new }
  let(:params) { ActionController::Parameters.new(:user => { :id => 1, :name => "name" }) }
  let(:user_permitted_params) { UsersPermittedParams.new(params) }

  describe '#create' do
    it "should ignore the id" do
      user_permitted_params.create.should == { 'name' => 'name' }
    end
  end

  describe '#update' do
    it "should ignore the name" do
      user_permitted_params.update.should == { 'id' => 1 }
    end
  end

  describe '.interface_class' do
    it 'should return the interface singular name ' do
      UsersPermittedParams.interface_class.should == User
    end
  end
end