require 'socket'

module Milight
  class RGBW
    ALL_OFF  = 0x41
    ALL_ON   = 0x42

    GROUP_ON = [0x45, 0x47, 0x49, 0x4B]
    GROUP_OFF = [0x46, 0x48, 0x4A, 0x4C]
    GROUP_ALL = 0x42

    GROUP_WHITE = [0xC5, 0xC7, 0xC9, 0xCB]
    WHITE_ALL = 0xC2

    DISCO_MODE = 0x4D
    DISCO_SLOWER = 0x43
    DISCO_FASTER = 0x44

    BRIGHTNESS_CMD = 0x4E
    COLOUR_CMD = 0x40

    def initialize(ip_address, port=8899)
      @ip_address = ip_address
      @port = port
    end

    def on
      send_command ALL_ON
      self
    end

    def off
      send_command ALL_OFF
      self
    end

    def group_on group
      raise invalid_group_error unless valid_group?(group)
      send_command GROUP_ON[group - 1]
      self
    end

    def group_off group
      raise invalid_group_error unless valid_group?(group)
      send_command GROUP_OFF[group - 1]
      self
    end

    def group group
      group_on group
      command_delay
      self
    end

    def select_all
      send_command GROUP_ALL
      command_delay
      self
    end

    def brightness percent
      raise invalid_percent_error unless valid_percent?(percent)
      level = 59 * percent / 100
      send_command BRIGHTNESS_CMD, level
      self
    end

    def colour colour
      raise invalid_colour_error unless valid_colour?(colour)
      send_command COLOUR_CMD, colour
      self
    end

    def all_white
      select_all
      send_command WHITE_ALL
      self
    end

    def group_white group
      raise invalid_group_error unless valid_group?(group)
      send_command GROUP_WHITE[group - 1]
      self
    end

    private

    def send_command cmd, arg1=0x00
      socket = UDPSocket.new
      socket.send [cmd, arg1, 0x55].pack('C*'), 0, @ip_address, @port
    end

    def command_delay
      sleep 0.1
    end

    def invalid_group_error
      ArgumentError.new('Group must be between 1 and 4')
    end

    def valid_group? value
      value.between?(1,4)
    end

    def invalid_percent_error
      ArgumentError.new('Percentages are generally between 0 and 100')
    end

    def valid_colour? value
      value.between?(0,255)
    end

    def invalid_colour_error
      ArgumentError.new('Colours must be between 0 and 255')
    end

    def valid_percent? value
      value.between?(0,100)
    end

  end
end
