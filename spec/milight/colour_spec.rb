require 'spec_helper'
require production_code

describe Milight::Colour do
  describe '.of' do
    it 'returns a valid colour number' do
      expect(subject.of 255).to eq 255
    end

    it 'raises an exception for invalid numbers' do
      expect{subject.of 256}.to raise_error ArgumentError
    end

    it 'takes a symbol for named colours' do
      expect(subject.of :blue).to eq 50
    end

    it 'takes a string for named colours' do
      expect(subject.of 'Blue').to eq 50
    end

    it 'raises an exception for invalid names' do
      expect{subject.of :grellow}.to raise_error ArgumentError
    end

    it 'balks at arguments which are not a valid number or name' do
      expect{subject.of 0.2}.to raise_error ArgumentError
    end
  end
end
