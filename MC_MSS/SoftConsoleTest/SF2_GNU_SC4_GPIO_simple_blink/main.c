/*******************************************************************************
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
#include "drivers/mss_timer/mss_timer.h"
#include "base.h"
#include "event.h"
#include "TA0.h"

/*==============================================================================
  Private functions.
 */
//static void delay(void);
static void Timer_init();
//void Timer1_IRQHandler( void );

/*==============================================================================
 * main() function.
 */
int main()
{
	Int cnt = 0;
    /*
     * Initialize MSS GPIOs.
     */
    MSS_GPIO_init();
    
    /*
     * Configure MSS GPIOs.
     */
    MSS_GPIO_config( MSS_GPIO_0 , MSS_GPIO_OUTPUT_MODE );
    
    Timer_init();

    /*
     * Infinite loop.
     */
    for(;;)
    {
    	wait_for_event();
    	if (tst_event(EVENT_BTN1)) {
			clr_event(EVENT_BTN1);
			if (++cnt GT MUSTER6) {
			cnt = 0;
			}
			set_blink_muster(cnt);
		}
		if (tst_event(EVENT_BTN2)) {
			clr_event(EVENT_BTN2);
			uint32_t gpio_pattern;
			gpio_pattern = MSS_GPIO_get_outputs();
			gpio_pattern ^= 0xFFFFFFFF;
			MSS_GPIO_set_outputs( gpio_pattern );
		}
		// im Falle eines Event-Errors leuchtet die LED dauerhaft
		if (is_event_error()) {
			uint32_t gpio_pattern;
			gpio_pattern = 0xFFFFFFFF;
			MSS_GPIO_set_outputs( gpio_pattern );
		}
	}
}

/*==============================================================================
  Delay between displays of the watchdog counter value.
 */
/*

 static void delay(void)
{
    volatile uint32_t delay_count = SystemCoreClock / 128u;
    
    while(delay_count > 0u)
    {
        --delay_count;
    }
}
*/

static void Timer_init(void)
{
	MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
	MSS_TIM1_start();
	MSS_TIM1_enable_irq();
	MSS_TIM1_load_immediate(50000000);
}

/*
void Timer1_IRQHandler( void )
{
	uint32_t gpio_pattern;
	gpio_pattern = MSS_GPIO_get_outputs();
	gpio_pattern ^= 0xFFFFFFFF;
	MSS_GPIO_set_outputs( gpio_pattern );
	MSS_TIM1_clear_irq();
}
*/
