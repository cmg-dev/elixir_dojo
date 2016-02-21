# EmbeddedLed

## Start the server

```bash
./start_app.sh
```

## Start a console

```bash
./start_console.sh
```

In the console type:
```Elixir
GenServer.cast({:led, :"led_iot@<full-hostname>"}, {:on, :led0})
```
