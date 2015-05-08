require 'socket'

module Milight
  class Commander

    def initialize(ip_address, port = 8899)
      @ip_address = ip_address
      @port = port
    end

    def send_command(cmd, arg1 = 0x00)
      socket = UDPSocket.new
      socket.send [cmd, arg1, 0x55].pack('C*'), 0, @ip_address, @port
      socket.close
    end

    def command_delay
      sleep 0.1
    end

  end
end
