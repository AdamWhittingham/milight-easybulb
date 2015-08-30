require 'spec_helper'
require production_code

describe Milight::Colour do
  let(:red_code)   { 170 }
  let(:green_code) { 85 }
  let(:blue_code)  { 0 }

  describe '#to_milight_colour' do
    it 'converts hex codes to milight colour codes' do
      expect(described_class.new('#FF0000').to_milight_colour ).to eq red_code
    end

    it 'converts an array of RGB values to milight colour codes' do
      expect(described_class.new( [255, 0 ,0 ]).to_milight_colour ).to eq red_code
    end

  end

  describe '#to_milight_brightness' do
    it 'converts hex codes to milight brightness codes' do
      expect(described_class.new('#00FF00').to_milight_brightness ).to eq 27
      expect(described_class.new('#008800').to_milight_brightness ).to eq 15
      expect(described_class.new('#000000').to_milight_brightness ).to eq  2
    end
  end

  describe '#greyscale?' do
    it 'returns true for greyscale colours' do
      expect(described_class.new('#aaa').greyscale?).to eq true
    end

    it 'returns false for non-greyscale colours' do
      expect(described_class.new('#f0f').greyscale?).to eq false
    end
  end

end
