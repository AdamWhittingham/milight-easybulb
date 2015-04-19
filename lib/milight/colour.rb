module Milight
  class Colour

    NAMED_COLOURS = {
      red:        170,
      magenta:    180,
      orange:     155,
      yellow:     140,
      green:      100,
      lime:       120,
      teal:        70,
      blue:        50,
      dark_blue:    0,
      purple:     210,
      lilac:      235,
      violet:     250,
    }

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
      name_sym = name.downcase.to_sym
      raise invalid_colour_name_error(name) unless valid_name? name_sym
      NAMED_COLOURS[name_sym]
    end

    def colour_numbered number
      raise invalid_colour_number_error unless valid_colour? number
      number
    end

    private

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
