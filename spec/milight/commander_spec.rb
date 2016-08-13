require 'spec_helper'
require production_code

describe Milight::Commander do
  let(:socket)     { instance_double(UDPSocket) }
  let(:ip_address) { '127.0.0.1' }
  let(:port)       { 8080 }

  subject { described_class.new ip_address, port }

  before do
    allow(UDPSocket).to receive(:new).and_return(socket)
    allow(socket).to receive(:close)
  end

  describe '#send_command' do
    it 'sends the given bytes' do
      payload = [0x42, 0x00, 0x55].pack('C*')
      expect(socket).to receive(:send).with(payload, 0, ip_address, port)
      subject.send_command 0x42
    end

    it 'sends the given argument if one is given' do
      payload = [0x42, 0x01, 0x55].pack('C*')
      expect(socket).to receive(:send).with(payload, 0, ip_address, port)
      subject.send_command 0x42, 0x01
    end
  end

  describe '#command_delay' do
    it 'pauses for 100 milliseconds' do
      before = Time.now.utc
      subject.command_delay
      after = Time.now.utc
      expect(after - before).to be > 0.1
    end
  end
end
