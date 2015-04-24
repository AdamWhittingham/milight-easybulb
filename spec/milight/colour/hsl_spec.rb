require 'spec_helper'
require production_code

describe Milight::Colour::HSL do
  let(:red_code)   { 170 }
  let(:green_code) { 85 }
  let(:blue_code)  { 0 }

  describe '#greyscale?' do
    it 'is true for greys' do
      expect(subject.greyscale?(10, 10, 10)).to eq true
    end

    it 'is false for colours' do
      expect(subject.greyscale?(0, 100, 0)).to eq false
    end
  end

  describe '#from_rgb and #to_hsl' do
    it 'converts the RGB colour to HSL' do
      expect(subject.from_rgb(255,   0,   0).to_hsl).to eq [0,1.0,0.5]
      expect(subject.from_rgb(  0, 255,   0).to_hsl).to eq [120,1.0,0.5]
      expect(subject.from_rgb(  0,   0, 255).to_hsl).to eq [240,1.0,0.5]
      expect(subject.from_rgb(255,   0, 255).to_hsl).to eq [300,1.0,0.5]
    end
  end

  describe '#from_hsl and #to_milight' do
    it 'returns the milight colour code for the given HSL values' do
      expect(subject.from_hsl(  0, 1.0, 0.5).to_milight).to eq red_code
      expect(subject.from_hsl(120, 1.0, 0.5).to_milight).to eq green_code
      expect(subject.from_hsl(240, 1.0, 0.5).to_milight).to eq blue_code
    end
  end
end
