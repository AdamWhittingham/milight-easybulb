require 'milight/colour'

module Milight
  class RgbwGroup

    attr_reader :commander

    GROUP_ON = [0x45, 0x47, 0x49, 0x4B]
    GROUP_OFF = [0x46, 0x48, 0x4A, 0x4C]
    GROUP_WHITE = [0xC5, 0xC7, 0xC9, 0xCB]

    BRIGHTNESS = 0x4E
    COLOUR = 0x40

    def initialize(commander, group, colour_helper: Milight::Colour)
      raise invalid_group_error unless valid_group? group
      @index = group - 1
      @commander = commander
      @colour_helper = colour_helper
    end

    def on
      @commander.send_command GROUP_ON[@index]
      self
    end

    def off
      @commander.send_command GROUP_OFF[@index]
      self
    end

    def white
      send_white_cmd
      self
    end

    def hue(hue)
      colour = @colour_helper.new(hue)
      send_colour_cmd colour
      self
    end

    def brightness(value)
      brightness = Milight::Brightness.new(value)
      send_brightness_cmd brightness
      self
    end

    def colour(colour)
      colour_value = @colour_helper.new(colour)
      colour_value.greyscale? ? send_white_cmd : send_colour_cmd(colour_value)
      send_brightness_cmd colour_value
      self
    end

    private

    def send_white_cmd
      @commander.send_command GROUP_WHITE[@index]
    end

    def send_colour_cmd colour
      select
      @commander.send_command COLOUR, colour.to_milight_colour
    end

    def send_brightness_cmd colour
      select
      @commander.send_command BRIGHTNESS, colour.to_milight_brightness
    end

    def select
      on
    end

    def invalid_group_error
      ArgumentError.new('Group must be between 1 and 4')
    end

    def valid_group?(value)
      value.between?(1, 4)
    end

  end
end
