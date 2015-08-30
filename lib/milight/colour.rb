require_relative 'colour/hsl'
require_relative 'brightness'

module Milight
  class Colour
    HUE_OFFSET = 170

    def initialize(value)
      @colour = case value
                when String
                  Milight::Colour::HSL.new.from_hex(value)
                when Array
                  Milight::Colour::HSL.new.from_rgb(*value)
                else
                  raise invalid_colour_error
                end
      self
    end

    def to_milight_colour
      hue = @colour.hue
      mod = (hue / 120) * 50
      (hue + HUE_OFFSET + mod).round % 255
    end

    def to_milight_brightness
      percent = [brightness_for_saturation, 100].min
      Milight::Brightness.new(percent).to_milight_brightness
    end

    private

    def brightness_for_saturation
      r,g,b = *@colour.to_rgb
      (Math.sqrt(r*r + g*g + b*b) / 2.55 ).round
    end

    def invalid_colour_error
      ArgumentError.new('Colours must be given as with a hex colour string or a RGB array: #{described_class}.new([r,g,b])')
    end

  end
end
