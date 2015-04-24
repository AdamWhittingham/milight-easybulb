module Milight
  class Colour

    NAMED_COLOURS = {
      red:        170,
      magenta:    180,
      orange:     155,
      yellow:     140,
      green:       85,
      lime:       120,
      teal:        70,
      blue:        50,
      dark_blue:    0,
      purple:     210,
      lilac:      235,
      violet:     250,
    }

    MILIGHT_HUE_OFFSET = 170

    def of value
      case value
      when Symbol, String
        return colour_named(value)
      when Fixnum
        return colour_numbered(value)
      else
        raise invalid_colour_error
      end
    end

    def colour_named name
      name_sym = name.to_s.downcase.gsub(/ +/,'_').to_sym
      raise invalid_colour_name_error(name) unless valid_name? name_sym
      NAMED_COLOURS[name_sym]
    end

    def colour_numbered number
      raise invalid_colour_number_error unless valid_colour? number
      number
    end

    def rgb r, g, b
      h = rgb_to_hsl(r,g,b).first
      hsl(h, 1.0, 0.5)
    end

    def hsl h,s,l
      mod = (h / 120) *  50
      (h + MILIGHT_HUE_OFFSET + mod) % 255
    end

    def rgb_to_hsl(r, g, b)
      r /= 255.0
      g /= 255.0
      b /= 255.0
      h = hue(r,g,b)
      l = luminosity(r,g,b)
      s = saturation(r,g,b,l)
      [h,s,l]
    end

    def greyscale? r, g, b
      (r == g && g == b)
    end

    private

    def delta r,g,b
      [r,g,b].minmax.reverse.inject(:-)
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

    def invalid_colour_error
      ArgumentError.new('Colours must be a symbol or a number between 0 and 255')
    end

    def invalid_colour_name_error name
      ArgumentError.new("#{name} is not a known colour")
    end

    def invalid_colour_number_error
      ArgumentError.new('Colours numbers must be between 0 and 255')
    end

    def valid_colour? value
      value.between?(0,255)
    end

    def valid_name? name
      NAMED_COLOURS.keys.include?(name)
    end

  end
end
