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
      expect { subject.of 256 }.to raise_error ArgumentError
    end

    it 'takes a symbol for named colours' do
      expect(subject.of :dark_blue).to eq blue_code
    end

    it 'raises an exception for invalid names' do
      expect { subject.of :grellow }.to raise_error ArgumentError
    end

    it 'balks at arguments which are not a valid number or name' do
      expect { subject.of 0.2 }.to raise_error ArgumentError
    end

    it 'takes valid 6-digit HEX codes' do
      expect(subject.of '#FF0000').to eq red_code
    end

    it 'takes valid HEX codes without a leading hash' do
      expect(subject.of '0F0').to eq green_code
      expect(subject.of '00ff00').to eq green_code
    end

    it 'takes valid 3-digit HEX codes' do
      expect(subject.of '#0F0').to eq green_code
    end

    it 'raises an exception for invalid HEX codes' do
      expect { subject.of '#00112233' }.to raise_error ArgumentError
    end
  end

  describe '#rgb' do
    it 'returns the milight colour code for the given RGB values' do
      expect(subject.rgb 255,   0,   0).to eq red_code
      expect(subject.rgb 0,   255,   0).to eq green_code
      expect(subject.rgb 0,     0, 255).to eq blue_code
    end
  end
end
