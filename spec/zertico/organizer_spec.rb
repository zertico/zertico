require 'spec_helper'

describe Zertico::Organizer do
  let(:successful_organizer) { BuyProductOrganizer }
  let(:failed_organizer) { RegisterOrganizer }

  describe '.organize' do
    it 'should set the interactors to organize' do
      successful_organizer.interactors_classes.should == [ CreateProductInteractor, CreateInvoiceInteractor ]
    end

    it 'should initialize the performed interactors array' do
      successful_organizer.performed.should == []
    end

    it 'should initialize the instance objects hash' do
      successful_organizer.instances.should == {}
    end
  end

  describe '.perform' do
    context 'with success' do
      it 'should return true' do
        successful_organizer.perform({}).should == true
      end

      before :each do
        @organizer = successful_organizer
        @organizer.perform({})
      end

      it 'should set the pass the instances to the interactors' do
        @organizer.performed.last.instance_variable_get('@product').should be_an_instance_of(Product)
      end
    end

    context 'with failure' do
      it "should return a mapping with the interactor's rollback results" do
        failed_organizer.perform({}).should == [true]
      end
    end
  end

  describe '#rollback' do
    context 'when it raise an exception' do
      it "should return a mapping with the interactor's rollback results" do
        failed_organizer.rollback.should == [true]
      end
    end
  end
end