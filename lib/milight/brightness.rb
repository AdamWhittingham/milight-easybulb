module Milight
  class Brightness

    MIN = 2
    MAX = 27

    def initialize percent
      raise invalid_brightness unless valid_brightness?(percent)
      @percent = percent
    end

    def to_milight_brightness
      MIN + ((MAX - MIN) * @percent / 100).round
    end

    private

    def invalid_brightness
      ArgumentError.new 'Brightness must be given as a percentage (0 - 100)'
    end

    def valid_brightness? percentage
      percentage >= 0 && percentage <= 100
    end

  end
end
