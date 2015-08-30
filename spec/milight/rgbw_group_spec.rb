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

  describe '#hue' do
    it 'sends a COLOUR packet for the given group' do
      expect(commander).to receive(:send_command).with(0x40, 170)
      subject.hue '#f00'
    end

    it 'is chainable' do
      expect(subject.hue('#f00')).to eq subject
    end
  end

  describe '#brightness' do
    it 'sends the BRIGHTNESS packet for the given group' do
      expect(commander).to receive(:send_command).with(0x4E, 4)
      subject.brightness 10
    end

    it 'is chainable' do
      expect(subject.brightness(10)).to eq subject
    end
  end

  describe '#colour' do
    before do
      allow(commander).to receive(:send_command).with(0x40, anything)
      allow(commander).to receive(:send_command).with(0x4E, anything)
    end

    it 'sets the hue' do
      expect(commander).to receive(:send_command).with(0x40, 85)
      subject.hue '#880088'
    end

    it 'sets the brightness' do
      expect(commander).to receive(:send_command).with(0x40, 85)
      subject.hue '#880088'
    end
  end

  describe '.new' do
    it 'can have the colour helper overridden' do
      helper = double(Milight::Colour)
      group = described_class.new commander, 1, colour_helper: helper
      expect(helper).to receive_message_chain(:new, :to_milight_colour).and_return(10)
      expect(helper).to receive_message_chain(:new, :to_milight_brightness).and_return(10)
      group.colour '#f00'
    end

  end
end
