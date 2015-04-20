require 'spec_helper'
require production_code

describe Milight::Colour do
  let(:red_code)   { 170 }
  let(:green_code) { 85 }
  let(:blue_code)  { 0 }

  describe '#of' do
    it 'returns a valid colour number' do
      expect(subject.of 255).to eq 255
    end

    it 'raises an exception for invalid numbers' do
      expect{subject.of 256}.to raise_error ArgumentError
    end

    it 'takes a symbol for named colours' do
      expect(subject.of :dark_blue).to eq blue_code
    end

    it 'takes a string for named colours' do
      expect(subject.of 'Dark Blue').to eq blue_code
    end

    it 'raises an exception for invalid names' do
      expect{subject.of :grellow}.to raise_error ArgumentError
    end

    it 'balks at arguments which are not a valid number or name' do
      expect{subject.of 0.2}.to raise_error ArgumentError
    end
  end

  describe '#rgb' do
    it 'returns the milight colour code for the given RGB values' do
      expect(subject.rgb 255,   0,   0).to eq red_code
      expect(subject.rgb 0,   255,   0).to eq green_code
      expect(subject.rgb 0,     0, 255).to eq blue_code
    end
  end

  describe '#hsl' do
    it 'returns the milight colour code for the given HSL values' do
      expect(subject.hsl   0, 1.0, 0.5).to eq red_code
      expect(subject.hsl 120, 1.0, 0.5).to eq green_code
      expect(subject.hsl 240, 1.0, 0.5).to eq blue_code
    end
  end

  describe '#rgb_to_hsl' do
    it 'converts the RGB colour to HSL' do
      expect(subject.rgb_to_hsl(255,   0,   0)).to eq [0,1.0,0.5]
      expect(subject.rgb_to_hsl(  0, 255,   0)).to eq [120,1.0,0.5]
      expect(subject.rgb_to_hsl(  0,   0, 255)).to eq [240,1.0,0.5]
      expect(subject.rgb_to_hsl(255,   0, 255)).to eq [300,1.0,0.5]
    end
  end

  describe '#greyscale?' do
    it 'is true for greys' do
      expect(subject.greyscale?(10, 10, 10)).to eq true
    end

    it 'is true for white' do
      expect(subject.greyscale?(255, 255, 255)).to eq true
    end

    it 'is true for black' do
      expect(subject.greyscale?(0, 0, 0)).to eq true
    end

    it 'is false for colours' do
      expect(subject.greyscale?(0, 100, 0)).to eq false
    end
  end
end
