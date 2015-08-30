require 'spec_helper'
require production_code

describe Milight::Brightness do
  describe '#to_milight_brightness' do
    it 'returns a scalled brightness number' do
      expect(described_class.new(100).to_milight_brightness).to eq 27
      expect(described_class.new( 75).to_milight_brightness).to eq 20
      expect(described_class.new(  0).to_milight_brightness).to eq 2
    end

    it 'raises an exception for invalid numbers' do
      expect { described_class.new(101) }.to raise_error ArgumentError
    end
  end
end
