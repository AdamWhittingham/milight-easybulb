require 'milight/colour'

module Milight
  class RgbwAll

    ALL_OFF  = 0x41
    ALL_ON   = 0x42
    WHITE = 0xC2
    COLOUR = 0x40
    BRIGHTNESS = 0x4E

    def initialize(commander, colour_helper: Milight::Colour)
      @commander = commander
      @colour_helper = colour_helper
    end

    def on
      @commander.send_command ALL_ON
      self
    end

    def off
      @commander.send_command ALL_OFF
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
      @commander.send_command WHITE
    end

    def send_colour_cmd colour
      @commander.send_command COLOUR, colour.to_milight_colour
      self
    end

    def send_brightness_cmd brightness
      @commander.send_command BRIGHTNESS, brightness.to_milight_brightness
      self
    end

  end
end
