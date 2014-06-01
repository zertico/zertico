require 'spec_helper'

describe Zertico::Organizer do
  let(:successful_organizer) { BuyProductOrganizer }
  let(:failed_organizer) { RegisterOrganizer }

  describe '.organize' do
    it 'should set the interactors to organize' do
      successful_organizer.interactors_classes.should == [ CreateProductInteractor, CreateInvoiceInteractor ]
    end
  end

  describe '.perform' do
    context 'with success' do
      it 'should return true' do
        successful_organizer.perform({}).should be_true
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