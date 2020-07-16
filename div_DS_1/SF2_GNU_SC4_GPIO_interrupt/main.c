/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * SmartFusion2 microcontroller subsystem (MSS) GPIO interrupt example.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 7923 $
 * SVN $Date: 2015-10-01 11:37:48 +0530 (Thu, 01 Oct 2015) $
 */
#include "drivers/mss_gpio/mss_gpio.h"
#include "CMSIS/system_m2sxxx.h"/*******************************************************************************
 * (c) Copyright 2009-2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * Simple SmartFusion2 microcontroller subsystem (MSS) GPIO example program.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 7923 $
 * SVN $Date: 2015-10-01 11:37:48 +0530 (Thu, 01 Oct 2015) $
 */
#include "drivers/mss_gpio/mss_gpio.h"
#include "CMSIS/system_m2sxxx.h"

/*==============================================================================
  Private functions.
 */
static void delay(void);

/*==============================================================================
 * main() function.
 */
int main()
{
    /*
     * Initialize MSS GPIOs.
     */
    MSS_GPIO_init();
    
    /*
     * Configure MSS GPIOs.
     */
    MSS_GPIO_config( MSS_GPIO_0 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_1 , MSS_GPIO_INPUT_MODE );
    
    // Enable interrupts
    MSS_GPIO_enable_irq(MSS_GPIO_1);

    /*
     * Infinite loop.
     */
    for(;;)
    {

    }
}

/*==============================================================================
  Delay between displays of the watchdog counter value.
 */
static void delay(void)
{
    volatile uint32_t delay_count = 10000000;

    while(delay_count > 0u)
    {
        --delay_count;
    }
}

/*==============================================================================
  GPIO 8 interrupt service routine.
 */
void GPIO1_IRQHandler(void)
{
	uint32_t gpio_pattern;
	/*
	 * Decrement delay counter.
	 */

	/*
	 * Toggle GPIO output pattern by doing an exclusive OR of all
	 * pattern bits with ones.
	 */
	gpio_pattern = MSS_GPIO_get_outputs();
	gpio_pattern ^= 0xFFFFFFFF;
	MSS_GPIO_set_outputs( gpio_pattern );

    MSS_GPIO_clear_irq(MSS_GPIO_1);
};

