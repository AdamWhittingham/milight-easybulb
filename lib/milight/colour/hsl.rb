module Milight
  class Colour
    class HSL

      MILIGHT_HUE_OFFSET = 170

      def from_rgb r,g,b
        @h,@s,@l = rgb_to_hsl(r,g,b)
        self
      end

      def from_hsl h,s,l
        @h,@s,@l = h,s,l
        self
      end

      def to_milight
        mod = (@h / 120) * 50
        (@h + MILIGHT_HUE_OFFSET + mod) % 255
      end

      def to_hsl
        [@h,@s,@l]
      end

      def greyscale? r, g, b
        (r == g && g == b)
      end

      private

      def rgb_to_hsl(r, g, b)
        r /= 255.0
        g /= 255.0
        b /= 255.0
        h = hue(r,g,b)
        l = luminosity(r,g,b)
        s = saturation(r,g,b,l)
        [h,s,l]
      end

      def hue r, g, b
        return 0 if greyscale?(r,g,b)
        delta = delta(r,g,b)
        offset = case [r,g,b].max
                 when r
                   ((g - b)/delta)
                 when g
                   ((b - r)/delta) + 2
                 when b
                   ((r - g)/delta) + 4
                 end
        60 * offset % 360
      end

      def saturation r,g,b, l
        return 0 if greyscale?(r,g,b)
        delta(r,g,b) / 1 - (2 * l - 1).abs
      end

      def luminosity r,g,b
        [r,g,b].minmax.inject(:+) / 2
      end

      def delta r,g,b
        [r,g,b].minmax.reverse.inject(:-)
      end

    end
  end
end
