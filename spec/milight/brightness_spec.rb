require 'spec_helper'
require production_code

describe Milight::Brightness do
  describe '.percent' do
    it 'returns a scalled brightness number' do
      expect(described_class.percent 100).to eq 59
      expect(described_class.percent  75).to eq 44
      expect(described_class.percent   0).to eq  0
    end

    it 'raises an exception for invalid numbers' do
      expect{described_class.percent 101}.to raise_error ArgumentError
    end
  end
end
