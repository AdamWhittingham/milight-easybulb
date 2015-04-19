module Milight
  class Brightness

    def percent percent
      raise invalid_percent_error unless valid_percent?(percent)
      0x1F * percent / 100
    end

    private

    def invalid_percent_error
      ArgumentError.new('Percentages are generally between 0 and 100')
    end

    def valid_percent? value
      value.between?(0,100)
    end

  end
end
