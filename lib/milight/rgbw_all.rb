require 'milight/colour'
require 'milight/brightness'

module Milight
  class RgbwAll

    ALL_OFF  = 0x41
    ALL_ON   = 0x42
    WHITE = 0xC2
    COLOUR = 0x40
    BRIGHTNESS = 0x4E

    def initialize(commander, colour_helper: Milight::Colour.new, brightness_helper: Milight::Brightness.new)
      @commander = commander
      @colour = colour_helper
      @brightness = brightness_helper
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
      hue_value = @colour.milight_code_for(hue)
      @commander.send_command COLOUR, hue_value
      self
    end

    def brightness(value)
      brightness_value = @brightness.percent(value)
      @commander.send_command BRIGHTNESS, brightness_value
      self
    end

    def colour(color)
      colour_value = @colour.milight_code_for(color)
      brightness_value = @brightness.for_colour(color)
      @commander.send_command COLOUR, colour_value
      @commander.send_command BRIGHTNESS, brightness_value
      self
    end

  end
end
