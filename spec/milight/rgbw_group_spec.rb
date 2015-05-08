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
      expect(commander).to receive(:send_command).with(0x4E, 3)
      subject.brightness 10
    end

    it 'is chainable' do
      expect(subject.brightness(10)).to eq subject
    end
  end

  describe '.new' do
    it 'can have the colour helper overridden' do
      helper = double(Milight::Colour)
      group = described_class.new commander, 1, colour_helper: helper
      expect(helper).to receive(:of).with(10).and_return(10)
      group.colour 10
    end

    it 'can have the brightness helper overridden' do
      helper = double(Milight::Brightness)
      group = described_class.new commander, 1, brightness_helper: helper
      expect(helper).to receive(:percent).with(10).and_return(10)
      group.brightness 10
    end
  end
end
