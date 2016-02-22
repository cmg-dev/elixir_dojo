# configuration for Beaglebone Black (target bbb)

use Mix.Config

config :embedded_led, led_list: [ :led0, :led1, :led2, :led3 ]

config :embedded_led, names: [
  led0: "beaglebone:green:usr0",
  led1: "beaglebone:green:usr1",
  led2: "beaglebone:green:usr2",
  led3: "beaglebone:green:usr3"
]
