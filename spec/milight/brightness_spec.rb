require 'spec_helper'
require production_code

describe Milight::Brightness do
  describe '#percent' do
    it 'returns a scalled brightness number' do
      expect(subject.percent 100).to eq 0x1F
      expect(subject.percent  75).to eq 0x17
      expect(subject.percent   0).to eq 0x00
    end

    it 'raises an exception for invalid numbers' do
      expect{subject.percent 101}.to raise_error ArgumentError
    end
  end
end
