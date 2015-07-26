require 'spec_helper'
require production_code

describe Milight::Brightness do
  describe '#percent' do
    it 'returns a scalled brightness number' do
      expect(subject.percent 100).to eq 27
      expect(subject.percent 75).to eq 20
      expect(subject.percent 0).to eq 2
    end

    it 'raises an exception for invalid numbers' do
      expect { subject.percent 101 }.to raise_error ArgumentError
    end
  end

  describe '#for_colour' do
    it 'returns 100% for a milight colour code' do
      expect(subject.for_colour(10)).to eq 27
    end

    it 'returns 100% for a named colour' do
      expect(subject.for_colour(:blue)).to eq 27
    end

    it 'returns the level of luminosity for a hex code' do
      expect(subject.for_colour('#880088')).to eq 20
    end
  end
end
