module Milight
  class Colour
    class HSL
      attr_reader :hue, :saturation, :luminosity, :red, :green, :blue

      def from_rgb(r, g, b)
        @red, @green, @blue = r, g, b
        @hue, @saturation, @luminosity = rgb_to_hsl(r, g, b)
        self
      end

      def from_hsl(h, s, l)
        @hue        = h
        @saturation = s
        @luminosity = l
        self
      end

      def from_hex(hex)
        raise invalid_hex_colour_error unless valid_hex_colour? hex
        r,g,b = hex_to_rgb(hex)
        from_rgb(r,g,b)
        self
      end

      def to_hsl
        [@hue, @saturation, @luminosity]
      end

      def to_rgb
        [@red, @green, @blue]
      end

      def greyscale?(r, g, b)
        (r == g && g == b)
      end

      private

      def hex_to_rgb(hex)
        hex.sub('#', '')
          .chars
          .each_slice(hex.length / 3)
          .map{|val| val.length == 1 ? val * 2 : val }
          .map(&:join)
          .map { |h| h.to_i(16) }
      end

      def rgb_to_hsl(r, g, b)
        r /= 255.0
        g /= 255.0
        b /= 255.0
        h = rgb_to_hue(r, g, b)
        l = rgb_to_luminosity(r, g, b)
        s = rgbl_to_saturation(r, g, b, l)
        [h, s, l]
      end

      def rgb_to_hue(r, g, b)
        return 0 if greyscale?(r, g, b)
        delta = delta(r, g, b)
        offset = case [r, g, b].max
                 when r
                   ((g - b) / delta)
                 when g
                   ((b - r) / delta) + 2
                 when b
                   ((r - g) / delta) + 4
                 end
        60 * offset % 360
      end

      def rgbl_to_saturation(r, g, b, l)
        return 0 if greyscale?(r, g, b)
        delta(r, g, b) / 1 - (2 * l - 1).abs
      end

      def rgb_to_luminosity(r, g, b)
        [r, g, b].minmax.inject(:+) / 2
      end

      def delta(r, g, b)
        [r, g, b].minmax.reverse.inject(:-)
      end

      def valid_hex_colour?(value)
        value =~ /^#?([0-9a-f]{3}){,2}$/i
      end

      def invalid_hex_colour_error
        ArgumentError.new('Hex colours codes must be 3 or 6 0-9 or a-f characters')
      end

    end
  end
end
