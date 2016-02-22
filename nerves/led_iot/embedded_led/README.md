# EmbeddedLed

## Start the server

```bash
./start_app.sh
```

## Start a console

```bash
./start_console.sh
```

Edit the ```/etc/hosts``` on your local box and add the ip to nerves.fritz.box.

In the console type:
```Elixir
# Check the connection
Node.ping "led_iot@nerves.fritz.box"
#  result :pong (not :pang)

GenServer.cast({:led, :"led_iot@nerves.fritz.box"}, {:on, :led0})
```
