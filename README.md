Milight
=======
A gem for controlling Milight Wifi bulbs

Usage
-----
1. Require the gem
2. Initialise a new controller with the IP address of your controller
3. Send commands to all groups, or just one

For example, connecting to a controller on `192.168.0.10`, turning on group 1 and setting it to a teal colour at 50% brightness:

```Ruby
require 'milight'

# Initialise a controller
lights = Milight::Controller.new '192.168.0.10'

# Turn a group of lights on and set their colour
lights.group(1).on
lights.group(1).colour '#ff00ff'

# Or chain the commands to one group
lights.group(1).on.hue('#f00').brightness(50)

# Go to bed after happily messing with lights!
lights.all.off
```

Take a look at [the example script](bin/example) for an example script using the gem.

Things you should know
----------------------
* Colours can be set using the `colour` method via a HEX colour code (for example, `#f00` or `#a0f060`)
* Brightness is given as a percentage (0-100)
* Hue can also be set using a hex code (but doesn't change the brightness)
* Everything is sent over UDP, as per the Milight spec. This means that some commands will get 'lost', especially if you send many in quick succession. The gem tries to account for this by adding very short delays between commands but it isn't guaranteed.
