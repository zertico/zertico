require 'spec_helper'

describe Zertico::Organizer do
  let(:organizer) { Zertico::Organizer.new }

  describe '#define_interactors' do
    it 'should return a filled array' do
      organizer.define_interactors([Zertico::Interactor]).should == [Zertico::Interactor]
    end
  end

  describe '#perform' do
    context 'when it not raise an exception' do
      before :each do
        organizer.define_interactors([Zertico::Interactor])
        Zertico::Interactor.stub_chain(:new, :perform => {})
      end

      it 'should return true' do
        organizer.perform({}).should be_true
      end
    end

    context 'when it raise an exception' do
      before :each do
        organizer.define_interactors([Zertico::Interactor])
        Zertico::Organizer.stub(:rollback => false)
      end

      it 'should return false' do
        organizer.perform({}).should be_false
      end
    end
  end

  describe '#rollback' do
    context 'when it raise an exception' do
      before :each do
        organizer.define_interactors([Zertico::Interactor])
        organizer.instance_variable_set("@index", 0)
      end

      it 'should return false' do
        organizer.rollback.should be_false
      end
    end
  end
end