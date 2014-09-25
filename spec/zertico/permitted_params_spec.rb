require 'spec_helper'

describe Zertico::PermittedParams do
  let(:user) { User.new }
  let(:params) { ActionController::Parameters.new(:user => { :id => 1, :name => "name" }) }
  let(:user_permitted_params) { UsersPermittedParams.new(params) }
  let(:zertico_permitted_params) { Zertico::PermittedParams.new(:zertico => { :id => 1, :name => "name" }) }

  describe '#create' do
    context 'on a custom PermittedParams' do
      it "should ignore the id" do
        expect(user_permitted_params.create).to eq({ 'name' => 'name' })
      end
    end

    context 'on Zertico::PermittedParams' do
      it "should accept all attributes of the hash" do
        expect(zertico_permitted_params.create).to eq({ :id => 1, :name => 'name' })
      end
    end
  end

  describe '#update' do
    context 'on a custom PermittedParams' do
      it "should ignore the name" do
        expect(user_permitted_params.update).to eq({ 'id' => 1 })
      end
    end

    context 'on Zertico::PermittedParams' do
      it "should accept all attributes of the hash" do
        expect(zertico_permitted_params.update).to eq({ :id => 1, :name => 'name' })
      end
    end
  end

  describe '.interface_class' do
    it 'should return the interface singular name ' do
      expect(UsersPermittedParams.interface_class).to eq(User)
    end
  end
end