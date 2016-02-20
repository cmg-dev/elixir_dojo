# nerves: ip in /etc/hosts eingetragen
# params for vm <project-root>/rel/vm.args

remote_name = :"ethernet_led@nerves"

# led_key's for bbb: :led0, :led1, :led2, :led3
# led_key's for rpi2: :red, :green

pid = Node.spawn_link remote_name, fn -> RemoteLed.led_on(:led1) end

pid = Node.spawn_link remote_name, fn -> RemoteLed.led_off(:led1) end
