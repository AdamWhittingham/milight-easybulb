Milight
=======
A gem for controlling Milight Wifi bulbs

Usage
-----
1. Require the gem
2. Initialise a new controller with the IP address of your controller
3. Send commands to all groups, or just one

For example, connecting to a controller on `192.168.0.10`, turning on group 1 and setting it to a light blue colour:

```Ruby
require 'milight'

# Initialise a controller
controller = Milight::Controller.new '192.168.0.10'

# Turn a group of lights on and set their colour
controller.group(1).on
controller.group(1).colour :teal

# Chain commands to one group
controller.group(2).on.white.brightness(30)

# Go to bed after happily messing with lights!
controller.all.off
```

Take a look at [the example script](bin/example) for an example script using the gem.

Things you should know
----------------------
* Brightness is given as a percentage (0-100)
* Colour can be given as a named colour (see [the colour helper](lib/milight/colour.rb) or as a number between 0-255. Sadly, the Milights do not seem to use conventional 8-bit colour; I'm looking to add better helper methods in the future.
* Everything is sent over UDP, as per the Milight spec. This means that some commands will get 'lost', especially if you send many in quick succession.
