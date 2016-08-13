require_relative 'brightness'

module Milight
  class Colour

    attr_reader :hue, :saturation, :luminosity, :red, :green, :blue

    HUE_OFFSET = 176
    VALID_HEX_REGEX = /^#?([0-9a-f]{3}){,2}$/i

    def initialize(value)
      case value
      when String then from_hex(value)
      when Array  then from_rgb(*value)
      else
        raise invalid_colour_error
      end
    end

    def to_hsl
      [@hue, @saturation, @luminosity]
    end

    def to_rgb
      [@red, @green, @blue]
    end

    def to_milight_colour
      ((256 + HUE_OFFSET - (hue / 360.0 * 255.0)) % 256).to_i
    end

    def to_milight_brightness
      percent = [brightness_for_saturation, 100].min
      Milight::Brightness.new(percent).to_milight_brightness
    end

    def greyscale?
      @red == @green && @red == @blue
    end

    private

    def from_rgb(r, g, b)
      @red = r
      @green = g
      @blue = b
      @hue, @saturation, @luminosity = rgb_to_hsl(r, g, b)
    end

    def from_hex(hex)
      raise invalid_hex_colour_error unless valid_hex_colour? hex
      r, g, b = hex_to_rgb(hex)
      from_rgb(r, g, b)
    end

    def brightness_for_saturation
      r, g, b = *to_rgb
      (Math.sqrt(r * r + g * g + b * b) / 2.55).round
    end

    def hex_to_rgb(hex)
      hex.sub('#', '')
         .chars
         .each_slice(hex.length / 3)
         .map { |val| val.length == 1 ? val * 2 : val }
         .map(&:join)
         .map { |h| h.to_i(16) }
    end

    def rgb_to_hsl(r1, g1, b1)
      r, g, b = [r1, g1, b1].map { |c| c / 255.0 }
      h = rgb_to_hue(r, g, b)
      l = rgb_to_luminosity(r, g, b)
      s = rgbl_to_saturation(r, g, b, l)
      [h, s, l]
    end

    def rgb_to_hue(r, g, b)
      return 0 if greyscale?
      delta = delta(r, g, b)
      offset = case [r, g, b].max
               when r then ((g - b) / delta)
               when g then ((b - r) / delta) + 2
               when b then ((r - g) / delta) + 4
               end
      60 * offset % 360
    end

    def rgb_to_luminosity(r, g, b)
      [r, g, b].minmax.inject(:+) / 2
    end

    def rgbl_to_saturation(r, g, b, l)
      return 0 if greyscale?
      (delta(r, g, b) / 1 - (2 * l - 1)).abs
    end

    def delta(r, g, b)
      [r, g, b].minmax.reverse.inject(:-)
    end

    def valid_hex_colour?(value)
      value =~ VALID_HEX_REGEX
    end

    def invalid_colour_error
      ArgumentError.new(
        "Colours must be given as with a hex colour string ( #{self.class}.new('#11A401') )" \
        " or a RGB array ( #{self.class}.new([r,g,b]) )"
      )
    end

    def invalid_hex_colour_error
      ArgumentError.new('Hex colours codes must be 3 or 6 0-9 or a-f characters')
    end

  end
end
