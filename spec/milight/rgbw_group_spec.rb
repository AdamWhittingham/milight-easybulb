require 'spec_helper'
require 'milight/commander'
require production_code

describe Milight::RgbwGroup do
  let(:commander) { double Milight::Commander, send_command: true, command_delay: true }

  subject { described_class.new commander, 1 }

  describe '#on' do
    it 'sends the ON packet for the given group' do
      expect(commander).to receive(:send_command).with(0x45)
      subject.on
    end

    it 'is chainable' do
      expect(subject.on).to eq subject
    end
  end

  describe '#off' do
    it 'sends the OFF packet for the given group' do
      expect(commander).to receive(:send_command).with(0x46)
      subject.off
    end

    it 'is chainable' do
      expect(subject.off).to eq subject
    end
  end

  describe '#white' do
    it 'sends the WHITE packet for the given group' do
      expect(commander).to receive(:send_command).with(0xC5)
      subject.white
    end

    it 'is chainable' do
      expect(subject.white).to eq subject
    end
  end

  describe '#colour' do
    it 'sends the COLOUR packet for the given group' do
      expect(commander).to receive(:send_command).with(0x40, 10)
      subject.colour 10
    end

    it 'is chainable' do
      expect(subject.colour(10)).to eq subject
    end
  end

  describe '#brightness' do
    it 'sends the BRIGHTNESS packet for the given group' do
      expect(commander).to receive(:send_command).with(0x4E, 5)
      subject.brightness 10
    end

    it 'is chainable' do
      expect(subject.brightness(10)).to eq subject
    end
  end

end
