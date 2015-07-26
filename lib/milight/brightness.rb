require_relative 'colour/hsl'

module Milight
  class Brightness
    MIN =  2
    MAX = 27

    def percent(percent)
      raise invalid_percent_error unless valid_percent?(percent)
      MIN + ((MAX-MIN) * percent / 100).round
    end

    def for_colour(colour)
      if colour.is_a? String
        r,g,b = Milight::Colour::HSL.new.hex_to_rgb(colour)
        brightness_for_saturation = (Math.sqrt(r*r + g*g + b*b) / 2.55 ).round
        bright = [brightness_for_saturation, 100].min
        percent(bright)
      else
        percent(100)
      end
    end

    private

    def invalid_percent_error
      ArgumentError.new('Percentages are generally between 0 and 100')
    end

    def valid_percent?(value)
      value.between?(0, 100)
    end

  end
end
