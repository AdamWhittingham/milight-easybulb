require 'milight/colour'
require 'milight/brightness'

module Milight
  class RgbwAll

    ALL_OFF  = 0x41
    ALL_ON   = 0x42
    WHITE = 0xC2
    COLOUR = 0x40
    BRIGHTNESS = 0x4E

    def initialize commander
      @commander = commander
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

    def colour colour
      colour_value = Milight::Colour.of(colour)
      @commander.send_command COLOUR, colour_value
      self
    end

    def brightness value
      brightness_value = Milight::Brightness.percent(value)
      @commander.send_command BRIGHTNESS, brightness_value
      self
    end

  end
end
