/*******************************************************************************
 * (c) Copyright 2012-2015 Microsemi SoC Products Group.  All rights reserved.
 *
 *  Simple SmartFusion2 microcontroller subsystem UART example program
 *  transmitting a greeting message using UART1. Any characters received on
 *  UART1 are echoed back. The UART configuration is specified as part of the
 *  call to MSS_UART_init().
 *
 * SVN $Revision: 7985 $
 * SVN $Date: 2015-10-12 12:26:08 +0530 (Mon, 12 Oct 2015) $
 */
#include "drivers/mss_uart/mss_uart.h"

/*------------------------------------------------------------------------------
  UART selection.
  Replace the line below with this one if you want to use UART1 instead of
  UART0:
  mss_uart_instance_t * const gp_my_uart = &g_mss_uart1;
 */
mss_uart_instance_t * const gp_my_uart = &g_mss_uart0;

/*==============================================================================
 * main function.
 */
int main()
{
    size_t rx_size;
    uint8_t rx_buff[1];
    
    /* Turn off the watchdog */
    SYSREG->WDOG_CR = 0;
    
    /*--------------------------------------------------------------------------
     * Initialize and configure UART.
     */
    MSS_UART_init(gp_my_uart,
                  MSS_UART_57600_BAUD,
                  MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

    /*--------------------------------------------------------------------------
     * Send greeting message over the UART.
     */
    MSS_UART_polled_tx_string(gp_my_uart,(const uint8_t*)"Characters typed will be echoed back.\n\r");

    /*--------------------------------------------------------------------------
     * Echo back any characters received.
     */
    for (;;)
    {
        rx_size = MSS_UART_get_rx(gp_my_uart, rx_buff, sizeof(rx_buff));
        if( rx_size > 0 )
        {
            MSS_UART_polled_tx(gp_my_uart, rx_buff, sizeof(rx_buff));
        }
    }
}


