require_relative '../lib/milight'

l = Milight::RGBW.new '192.168.0.10'

l.off
sleep 0.5
l.on

l.all_white
sleep 0.5

@color = 250
@brightness = 100

7.times do

  l.colour @color
  l.brightness @brightness
  @color -= 30
  @brightness -= 10
  sleep 1

end
