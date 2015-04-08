require 'socket'

module Milight
  class RGBW
    ON   = [0x42, 0x00, 0x55].pack('C*')
    OFF  = [0x41, 0x00, 0x55].pack('C*')

    def initialize(ip_address, port=8899)
      @socket = UDPSocket.new
      @ip_address = ip_address
      @port = port
    end

    def on
      @socket.send ON, 0, @ip_address, @port
    end

    def off
      @socket.send OFF, 0, @ip_address, @port
    end
  end
end
