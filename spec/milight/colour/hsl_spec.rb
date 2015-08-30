require 'spec_helper'
require production_code

describe Milight::Colour::HSL do
  let(:red_hsl)   { [ 0.0,   1.0, 0.5] }
  let(:green_hsl) { [ 120.0, 1.0, 0.5] }
  let(:blue_hsl)  { [ 240.0, 1.0, 0.5] }

  describe '#from_hsl' do
    it 'returns the milight colour code for the given HSL values' do
      expect(subject.from_hsl(0, 1.0, 0.5).to_hsl).to eq red_hsl
      expect(subject.from_hsl(120, 1.0, 0.5).to_hsl).to eq green_hsl
      expect(subject.from_hsl(240, 1.0, 0.5).to_hsl).to eq blue_hsl
    end
  end

  describe '#greyscale?' do
    it 'is true for greys' do
      expect(subject.greyscale?(10, 10, 10)).to eq true
    end

    it 'is false for colours' do
      expect(subject.greyscale?(0, 100, 0)).to eq false
    end
  end

  describe '#from_hex' do
    it 'takes valid 6-digit hex codes' do
      expect(subject.from_hex('#FF0000').to_hsl).to eq red_hsl
    end

    it 'takes valid 3-digit hex hsls' do
      expect(subject.from_hex('#0F0').to_hsl).to eq green_hsl
    end

    it 'takes valid hex hsls without a leading hash' do
      expect(subject.from_hex('0F0').to_hsl).to eq green_hsl
      expect(subject.from_hex('00ff00').to_hsl).to eq green_hsl
    end

    it 'raises an arguement error for invalid hex codes' do
      expect { subject.from_hex('#00112233') }.to raise_error ArgumentError
    end

  end

  describe '#from_rgb and #to_hsl' do
    it 'converts the RGB colour to HSL' do
      expect(subject.from_rgb(255,   0,   0).to_hsl).to eq [0, 1.0, 0.5]
      expect(subject.from_rgb(0, 255,   0).to_hsl).to eq [120, 1.0, 0.5]
      expect(subject.from_rgb(0,   0, 255).to_hsl).to eq [240, 1.0, 0.5]
      expect(subject.from_rgb(255,   0, 255).to_hsl).to eq [300, 1.0, 0.5]
    end
  end
end
