require 'spec_helper'
require 'milight/commander'
require production_code

describe Milight::RgbwAll do
  let(:commander) { double Milight::Commander, send_command: true, command_delay: true }

  subject { described_class.new commander }

  describe '#on' do
    it 'sends the ON packet for the given group' do
      expect(commander).to receive(:send_command).with(0x42)
      subject.on
    end

    it 'is chainable' do
      expect(subject.on).to eq subject
    end
  end

  describe '#off' do
    it 'sends the OFF packet for the given group' do
      expect(commander).to receive(:send_command).with(0x41)
      subject.off
    end

    it 'is chainable' do
      expect(subject.off).to eq subject
    end
  end

  describe '#white' do
    it 'sends the WHITE packet for the given group' do
      expect(commander).to receive(:send_command).with(0xC2)
      subject.white
    end

    it 'is chainable' do
      expect(subject.white).to eq subject
    end
  end

  describe '#colour' do
    it 'sends the COLOUR packet' do
      expect(commander).to receive(:send_command).with(0x40, 10)
      subject.colour 10
    end

    it 'is chainable' do
      expect(subject.colour(10)).to eq subject
    end
  end

  describe '#brightness' do
    it 'sends the BRIGHTNESS packet' do
      expect(commander).to receive(:send_command).with(0x4E, 3)
      subject.brightness 10
    end

    it 'is chainable' do
      expect(subject.brightness(10)).to eq subject
    end
  end
end
