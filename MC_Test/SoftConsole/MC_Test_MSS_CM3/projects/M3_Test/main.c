#include "../../../../firmware/drivers/mss_gpio/mss_gpio.h"

static void delay(void);

int main()
{
	MSS_GPIO_init();
	MSS_GPIO_config( MSS_GPIO_0 , MSS_GPIO_OUTPUT_MODE);

	for(;;)
	{
		uint32_t gpio_pattern;
		delay();
		gpio_pattern = MSS_GPIO_get_outputs();
		gpio_pattern ^= 0xFFFFFFFF;
		MSS_GPIO_set_outputs(gpio_pattern);
	}
	return 0;
}

static void delay(void)
{
	volatile uint32_t delay_count = SystemCoreClock / 128u;

	while (delay_count > 0u)
	{
		--delay_count;
	}
}

