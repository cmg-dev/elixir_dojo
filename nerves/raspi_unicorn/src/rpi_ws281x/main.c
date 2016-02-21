#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#include "clk.h"
#include "gpio.h"
#include "dma.h"
#include "pwm.h"

#include "ws2811.h"

#define DMA_CHANNEL           5

#define UNICORN_HAT_WIDTH         8
#define UNICORN_HAT_HEIGHT        8
#define UNICORN_HAT_LED_COUNT     (UNICORN_HAT_WIDTH * UNICORN_HAT_HEIGHT)
#define WIDTH                     (UNICORN_HAT_WIDTH)
#define HEIGHT                    (UNICORN_HAT_HEIGHT)
#define COUNT                     (UNICORN_HAT_LED_COUNT)

/**
 * This stores a local copy of the matrix
 */
ws2811_led_t matrix[WIDTH][HEIGHT];

//void matrix_render(ws2811_t & ledstring)
//{
//  int x, y;
//
//  for (x = 0; x < WIDTH; x++ ) {
//    for (y = 0; y < HEIGHT; y++) {
//        ledstring.channel[0].leds[(y * WIDTH) + x] = matrix[x][y];
//    }
//  }
//}

void matrix_raise(void)
{
  int x, y;

  for (y = 0; y < (HEIGHT - 1); y++) {
    for (x = 0; x < WIDTH; x++) {
        matrix[x][y] = matrix[x][y + 1];
    }
  }
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
    fprintf(stdout, "Usage: %s <GPIO Pin> <LED Count>\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  uint8_t gpio_pin = atoi(argv[1]);
  uint32_t led_count = strtol(argv[2], NULL, 10);

  if( led_count > UNICORN_HAT_LED_COUNT ) {
    led_count= UNICORN_HAT_LED_COUNT;
  }

  ws2811_t ledstring = {
    .freq = WS2811_TARGET_FREQ,
    .dmanum = DMA_CHANNEL,
    .channel = {
      [0] = {
        .gpionum = gpio_pin,
        .count = led_count,
        .invert = 0,
        .brightness = 100,
      },
      [1] = {
        .gpionum = 0,
        .count = 0,
        .invert = 0,
        .brightness = 0,
      },
    },
  };

  ws2811_led_t *base_ptr = ledstring.channel[0].leds;
  *base_ptr = (uint32_t)(255 << 16 | 155 << 8 | 55);

  if (ws2811_init(&ledstring)) {
    exit(EXIT_FAILURE);
  }

  freopen(NULL, "rb", stdin);

  uint32_t leds_read;
  uint8_t colors[] = {255, 0, 0};

  while (1) {
    ws2811_led_t *ptr = ledstring.channel[0].leds;

    for(leds_read = 0; leds_read < led_count; leds_read++, ptr++) {
      fprintf(stdout, "reading on stin\n");
      fread(colors, 3 * sizeof(uint8_t), 1, stdin);
      fprintf(stdout, "colors: %i %i %i \n", colors[0], colors[1], colors[2]);
      *ptr = (uint32_t)(colors[0] << 16 | colors[1] << 8 | colors[2]);
    }

    if (ws2811_render(&ledstring)) {
      break;
    }
  }

  ws2811_fini(&ledstring);
  exit(EXIT_FAILURE);
}

