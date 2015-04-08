require 'spec_helper'
require production_code

describe Milight::RGBW do
  let(:socket)     { instance_double(UDPSocket) }
  let(:on_packet)  { [0x42, 0x00, 0x55].pack('C*') }
  let(:off_packet) { [0x41, 0x00, 0x55].pack('C*') }

  subject { described_class.new '127.0.0.1', 8080 }

  before { allow(UDPSocket).to receive(:new).and_return(socket) }

  describe '#on' do
    it 'sends the packet for turning the light on' do
      allow(socket).to receive(:send).with(on_packet, 0, '127.0.0.1', 8080)
      subject.on
    end
  end

  describe '#off' do
    it 'sends the packet for turning the light off' do
      allow(socket).to receive(:send).with(off_packet, 0, '127.0.0.1', 8080)
      subject.off
    end
  end
end
