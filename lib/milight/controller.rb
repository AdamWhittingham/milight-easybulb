require 'milight/commander'
require 'milight/rgbw_group'
require 'milight/rgbw_all'

module Milight
  class Controller

    attr_reader :commander

    def initialize(ip_address, port = 8899)
      @commander = Milight::Commander.new ip_address, port
    end

    def all
      Milight::RgbwAll.new(@commander)
    end

    def group(channel)
      Milight::RgbwGroup.new(@commander, channel)
    end

  end
end
