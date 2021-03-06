/*
 * TA0.c
 *
 *  Created on: 22.04.2018
 *      Author: Admin
 */

//#include <msp430.h>
#include "..\..\..\base.h"
#include "TA0.h"
#include "event.h"
#include "drivers/mss_timer/mss_timer.h"

void Timer1_IRQHandler( void );

/*
 * Man soll sich geeignete Datenstrukturen �berlegen,
 * die eine laufzeitefffiziente Auusf�hrung der ISR
 * erm�glichen.
 */
LOCAL UInt* LED_arr_ptr = &LEDarr1;
LOCAL UShort LEDcnt = 200;
LOCAL UShort array_length = 3;
LOCAL UShort hop = sizeof(UInt) / 2;

LOCAL UShort BTN1hyst = 0;
LOCAL UShort BTN2hyst = 0;

GLOBAL Void set_blink_muster(UInt arg) {
/*
 * Die Funktion muss so ertweitert werden,
 * dass ein Blinkmuster selektiert wird.
 */
    LED_arr_ptr = LED_arr[arg];
    if(arg LT 4) {
        array_length = 3;
    } else {
        if(arg EQ 4) {
            array_length = 5;
        }
        if(arg EQ 5) {
            array_length = 7;
        }
    }
    LEDcnt = *LED_arr_ptr;
}
/*
// Der Timer A0 ist bereits initialisiert
GLOBAL Void TA0_Init(Void) {
   TA0CCR0 = 0;                              // stopp Timer A
   CLRBIT(TA0CTL, TAIFG);                    // clear overflow flag
   CLRBIT(TA0CCR0, CCIFG);                   // clear CCI flag
   TA0CTL  = TASSEL__ACLK + MC__UP + ID__8;  // set up Timer A
   TA0EX0  = TAIDEX_7;                       // set up expansion register
   TA0CCR0 = 2*48;                           // set up CCR0 for 10 ms
   SETBIT(TA0CTL, TACLR);                    // clear and start Timer
   SETBIT(TA0CCTL0, CCIE);                   // enable Timer A interrupt
   TGLBIT(P1OUT, BIT2);
}
*/

void Timer1_IRQHandler( void )
{
   /*
    * Der Inhalt der ISR ist zu implementieren
    */
	uint32_t gpio_pattern;
	gpio_pattern = MSS_GPIO_get_outputs();
    if(--LEDcnt EQ 0) {
        LED_arr_ptr = LED_arr_ptr + hop;
        if(*LED_arr_ptr EQ 0) {
            if(tst_event(EVENT_BTN1)) {
                __low_power_mode_off_on_exit();
            }
            LED_arr_ptr = LED_arr_ptr - ((array_length - 1) * hop);
        }
        LEDcnt = *LED_arr_ptr;

		gpio_pattern ^= 0xFFFFFFFF;
		MSS_GPIO_set_outputs( gpio_pattern );
		MSS_TIM1_clear_irq();
    }
    if(TSTBIT(P1IN, BIT0)) {
        if(BTN1hyst LT HYSTMAX) {
            ++BTN1hyst;
            if(BTN1hyst EQ HYSTMAX) {
                set_event(EVENT_BTN1);
            }
        }
    } else if(BTN1hyst GT 0) {
        BTN1hyst--;
    }
    if(TSTBIT(P1IN, BIT1)) {
        if(BTN2hyst LT HYSTMAX) {
            ++BTN2hyst;
            if(BTN2hyst EQ HYSTMAX) {
                set_event(EVENT_BTN2);
                __low_power_mode_off_on_exit();
            }
        }
    } else if(BTN2hyst GT 0) {
        BTN2hyst--;
    }
}

