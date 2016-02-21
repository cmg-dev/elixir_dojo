SOURCE_DIR=src/rpi_ws281x
priv/rpi_ws281x: $(SOURCE_DIR)/dma.c \
						$(SOURCE_DIR)/pwm.c \
						$(SOURCE_DIR)/ws2811.c \
						$(SOURCE_DIR)/main.c
	@mkdir -p priv
	$(CC) $(CFLAGS) -o $@ $^

SOURCE_DIR=src/unicorn_dance
priv/unicorn_dance: $(SOURCE_DIR)/board_info.c \
						$(SOURCE_DIR)/mailbox.c \
						$(SOURCE_DIR)/dma.c \
						$(SOURCE_DIR)/pwm.c \
						$(SOURCE_DIR)/ws2811.c \
						$(SOURCE_DIR)/main.c
	@mkdir -p priv
	$(CC) $(CFLAGS) -o $@ $^
