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
      @commander.send_command WHITE
      self
    end

    def hue(hue)
      hue_value = @colour_helper.new(hue).to_milight_colour
      @commander.send_command COLOUR, hue_value
      self
    end

    def brightness(percent)
      brightness_value = Milight::Brightness.new(percent).to_milight_brightness
      @commander.send_command BRIGHTNESS, brightness_value
      self
    end

    def colour(colour)
      colour_value = @colour_helper.new(colour)
      colour_value.greyscale? ? white : set_hue_from_colour(colour_value)
      set_brightness_from_colour(colour_value)
      self
    end

    private

    def set_hue_from_colour colour
      @commander.send_command COLOUR, colour.to_milight_colour
    end

    def set_brightness_from_colour colour
      @commander.send_command BRIGHTNESS, colour.to_milight_brightness
    end

  end
end
