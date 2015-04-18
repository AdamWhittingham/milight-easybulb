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

controller = Milight::Controller.new '192.168.0.10'
controller.group(1).on
controller.group(1).colour :teal
```

Take a look at [the example script](bin/example) for an example script using the gem.
