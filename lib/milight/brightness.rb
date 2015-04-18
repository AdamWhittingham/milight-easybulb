module Milight
  class Brightness

    BRIGHTNESS_CMD = 0x4E

    def self.percent percent
      raise invalid_percent_error unless valid_percent?(percent)
      59 * percent / 100
    end

    private

    def self.invalid_percent_error
      ArgumentError.new('Percentages are generally between 0 and 100')
    end

    def self.valid_percent? value
      value.between?(0,100)
    end

  end
end
