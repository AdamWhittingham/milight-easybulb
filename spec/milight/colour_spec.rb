require 'spec_helper'
require 'ostruct'
require production_code

describe Milight::Colour do
  let(:red)   { OpenStruct.new(milight: 176, rgb: [255, 0, 0], hsl: [0.0, 1.0, 0.5]) }
  let(:green) { OpenStruct.new(milight:  85, rgb: [0, 255, 0], hsl: [120.0, 1.0, 0.5]) }
  let(:blue)  { OpenStruct.new(milight:   0, rgb: [0, 0, 255], hsl: [240.0, 1.0, 0.5]) }

  describe '#new' do
    it 'takes valid 6-digit hex codes' do
      expect(described_class.new('#FF0000').to_hsl).to eq red.hsl
      expect(described_class.new('#00FF00').to_hsl).to eq green.hsl
      expect(described_class.new('#0000FF').to_hsl).to eq blue.hsl
    end

    it 'takes valid 3-digit hex hsls' do
      expect(described_class.new('#0F0').to_hsl).to eq green.hsl
    end

    it 'takes valid hex hsls without a leading hash' do
      expect(described_class.new('0F0').to_hsl).to eq green.hsl
      expect(described_class.new('00ff00').to_hsl).to eq green.hsl
    end

    it 'raises an arguement error for invalid hex codes' do
      expect { described_class.new('#00112233') }.to raise_error ArgumentError
    end

    it 'takes an RGB array' do
      expect(described_class.new([255, 0,   0]).to_hsl).to eq red.hsl
      expect(described_class.new([0, 255,   0]).to_hsl).to eq green.hsl
      expect(described_class.new([0, 0, 255]).to_hsl).to eq blue.hsl
    end
  end

  describe '#to_milight_colour' do
    it 'converts hex codes to milight colour codes' do
      expect(described_class.new('#FF0000').to_milight_colour).to eq red.milight
    end

    it 'converts an array of RGB values to milight colour codes' do
      expect(described_class.new([255, 0, 0]).to_milight_colour).to eq red.milight
    end
  end

  describe '#to_milight_brightness' do
    it 'converts hex codes to milight brightness codes' do
      expect(described_class.new('#00FF00').to_milight_brightness).to eq 27
      expect(described_class.new('#008800').to_milight_brightness).to eq 15
      expect(described_class.new('#000000').to_milight_brightness).to eq 2
    end
  end

  describe '#to_rgb' do
    it 'outputs an array of RGB' do
      expect(described_class.new('#FF0000').to_rgb).to eq red.rgb
      expect(described_class.new('#00FF00').to_rgb).to eq green.rgb
      expect(described_class.new('#0000FF').to_rgb).to eq blue.rgb
    end
  end

  describe '#to_hsl' do
    it 'outputs an array of HSL' do
      expect(described_class.new('#FF0000').to_hsl).to eq red.hsl
      expect(described_class.new('#00FF00').to_hsl).to eq green.hsl
      expect(described_class.new('#0000FF').to_hsl).to eq blue.hsl
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
