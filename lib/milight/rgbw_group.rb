require 'milight/colour'

module Milight
  class RgbwGroup

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
      @commander.send_command GROUP_WHITE[@index]
      self
    end

    def hue(hue)
      colour_value = @colour_helper.new(hue).to_milight_colour
      select
      @commander.send_command COLOUR, colour_value
      self
    end

    def brightness(value)
      brightness_value = Milight::Brightness.new(value).to_milight_brightness
      select
      @commander.send_command BRIGHTNESS, brightness_value
      self
    end

    def colour(color)
      colour_value = @colour_helper.new(color)
      select
      @commander.send_command COLOUR, colour_value.to_milight_colour
      @commander.send_command BRIGHTNESS, colour_value.to_milight_brightness
      self
    end

    private

    def select
      on
      @commander.command_delay
    end

    def invalid_group_error
      ArgumentError.new('Group must be between 1 and 4')
    end

    def valid_group?(value)
      value.between?(1, 4)
    end

  end
end
