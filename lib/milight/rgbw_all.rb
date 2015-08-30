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
      @colour = colour_helper
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
      @commander.send_command WHITE
      self
    end

    def hue(hue)
      hue_value = @colour.new(hue).to_milight_colour
      @commander.send_command COLOUR, hue_value
      self
    end

    def brightness(percent)
      brightness_value = Milight::Brightness.new(percent).to_milight_brightness
      @commander.send_command BRIGHTNESS, brightness_value
      self
    end

    def colour(colour)
      colour_helper = @colour.new(colour)
      @commander.send_command COLOUR, colour_helper.to_milight_colour
      @commander.send_command BRIGHTNESS, colour_helper.to_milight_brightness
      self
    end

  end
end
