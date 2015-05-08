require 'spec_helper'
require production_code

describe Milight::Controller do
  let(:commander) { instance_double(Milight::Commander) }

  subject { described_class.new '127.0.0.1', 8080 }

  before { allow(Milight::Commander).to receive(:new).and_return(commander) }

  describe '#all' do
    it 'returns an RGBW all object' do
      expect(subject.all).to be_a Milight::RgbwAll
    end
  end

  describe '#group' do
    it 'returns a RGBW group object' do
      expect(subject.group(1)).to be_a Milight::RgbwGroup
    end
  end
end
