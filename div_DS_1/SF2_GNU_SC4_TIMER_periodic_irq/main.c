/*******************************************************************************
 * (c) Copyright 2009-2015 Microsemi SoC Products Group.  All rights reserved.
 * 
 * SmartFusion2 microcontroller subsystem timer example demonstrating the use of
 * a 32 bit timer in periodic mode.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 7901 $
 * SVN $Date: 2015-09-30 15:42:42 +0530 (Wed, 30 Sep 2015) $
 */
#include "drivers/mss_timer/mss_timer.h"
#include "drivers/mss_gpio/mss_gpio.h"
#include "CMSIS/system_m2sxxx.h"
/*
 * LEDs masks used to switch on/off LED through GPIOs.
 */
#define LEDS_MASK   (uint32_t)0xAAAAAAAA

/*
 * LEDs pattern
 */
volatile uint32_t g_gpio_pattern = LEDS_MASK;

/*==============================================================================
 * main function.
 */
int main()
{
    uint32_t timer1_load_value;
    
    /*--------------------------------------------------------------------------
     * Ensure the CMSIS-PAL provided g_FrequencyPCLK0 global variable contains
     * the correct frequency of the APB bus connecting the MSS timer to the
     * rest of the system.
     */
    SystemCoreClockUpdate();
    
    /*--------------------------------------------------------------------------
     * Configure GPIOs
     */
    MSS_GPIO_init();
    
    MSS_GPIO_config(MSS_GPIO_0, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config(MSS_GPIO_1, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config(MSS_GPIO_2, MSS_GPIO_OUTPUT_MODE);
    MSS_GPIO_config(MSS_GPIO_3, MSS_GPIO_OUTPUT_MODE);
    
    MSS_GPIO_set_outputs(g_gpio_pattern);
    
    /*--------------------------------------------------------------------------
     * Configure Timer1
     */
    /* 
     * Use the timer input frequency as load value to achieve a one second
     * periodic interrupt.
     */
    timer1_load_value = g_FrequencyPCLK0;
    MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
    MSS_TIM1_load_immediate(timer1_load_value);
    MSS_TIM1_start();
    MSS_TIM1_enable_irq();

    /*--------------------------------------------------------------------------
     * Foreground loop.
     */
    for(;;)
    {
        ;
    }
}

/*==============================================================================
 * Toggle LEDs on TIM1 interrupt.
 */
void Timer1_IRQHandler(void)
{
    /*
     * Toggle GPIO output pattern by doing an exclusive OR of all
     * pattern bits with ones.
     */
    g_gpio_pattern = MSS_GPIO_get_outputs();
    g_gpio_pattern ^= 0xFFFFFFFFu;
    MSS_GPIO_set_outputs(g_gpio_pattern);
    
    /* Clear TIM1 interrupt */
    MSS_TIM1_clear_irq();
}

