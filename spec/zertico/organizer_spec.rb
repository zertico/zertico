require 'spec_helper'

describe Zertico::Organizer do
  let(:successful_organizer) { BuyProductOrganizer }
  let(:failed_organizer) { RegisterOrganizer }

  describe '.organize' do
    it 'should set the interactors to organize' do
      expect(successful_organizer.interactors_classes).to eq([ CreateProductInteractor, CreateInvoiceInteractor ])
    end

    it 'should initialize the performed interactors array' do
      expect(successful_organizer.performed).to eq([])
    end

    it 'should initialize the instance objects hash' do
      expect(successful_organizer.instances).to eq({})
    end
  end

  describe '.perform' do
    context 'with success' do
      it 'should return true' do
        expect(successful_organizer.perform({})).to eq(true)
      end

      before :each do
        @organizer = successful_organizer
        @organizer.perform({})
      end

      it 'should set the pass the instances to the interactors' do
        expect(@organizer.performed.last.instance_variable_get('@product')).to be_an_instance_of(Product)
      end
    end

    context 'with failure' do
      it "should return a mapping with the interactor's rollback results" do
        expect(failed_organizer.perform({})).to eq([true])
      end
    end
  end

  describe '#rollback' do
    context 'when it raise an exception' do
      it "should return a mapping with the interactor's rollback results" do
        expect(failed_organizer.rollback).to eq([true])
      end
    end
  end
end