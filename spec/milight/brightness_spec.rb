require 'spec_helper'
require production_code

describe Milight::Brightness do
  describe '#to_milight_brightness' do

    {
      100 => 27,
       75 => 20,
       50 => 14,
       25 =>  8,
        0 =>  2,
    }.each do |percent, milight|
      it "converts #{percent}% to the milight code #{milight}" do
        expect(described_class.new(percent).to_milight_brightness).to eq milight
      end
    end

    it 'raises an exception for invalid numbers' do
      expect { described_class.new(101) }.to raise_error ArgumentError
    end
  end
end
