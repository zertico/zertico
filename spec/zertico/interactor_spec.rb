require 'spec_helper'

describe Zertico::Interactor do
  let(:interactor) { Zertico::Interactor.new }

  describe '#fail' do
    it 'should raise the interactor exception' do
      expect { interactor.fail! }.to raise_error
    end
  end
end