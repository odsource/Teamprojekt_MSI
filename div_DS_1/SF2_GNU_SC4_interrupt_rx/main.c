/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * CoreUARTapb interrupt driven receive example.
 *
 * Please refer to the file README.txt for further details about this example.
 * 
 * SVN $Revision: 8013 $
 * SVN $Date: 2015-10-13 13:15:00 +0530 (Tue, 13 Oct 2015) $
 */
#include "hal.h"
#include "platform.h"
#include "core_uart_apb.h"
#include "m2sxxx.h"

/******************************************************************************
 * Baud value to achieve a 57600 baud rate with a 50MHz system clock.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *****************************************************************************/
#define BAUD_VALUE_57600    53

/******************************************************************************
 * Maximum receiver buffer size.
 *****************************************************************************/
#define MAX_RX_DATA_SIZE    256

/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
UART_instance_t g_uart;

void uart_rx_isr( void );
/******************************************************************************
 * Cortex-M3 interrupt handler for external interrupt 3.
 * This function is called when the Cortex-M3 IRQ3 signal is asserted.
 *****************************************************************************/
void FabricIrq3_IRQHandler( void )
{
	uart_rx_isr();
}

/******************************************************************************
 * UART receiver interrupt service routine.
 * This function is called by the FabricIrq3_IRQHandler when the FabricIRQ3
 * signal is asserted.
 *****************************************************************************/
void uart_rx_isr( void )
{
    uint8_t rx_data[MAX_RX_DATA_SIZE];
    size_t rx_size;

    /**********************************************************************
     * Check for errors while receiving data, echo only when no errors.
     *********************************************************************/
    if(UART_APB_NO_ERROR == UART_get_rx_status( &g_uart ))
    {
        /**********************************************************************
         * Read data received by the UART.
         *********************************************************************/
        rx_size = UART_get_rx( &g_uart, rx_data, sizeof(rx_data) );

        /**********************************************************************
         * Echo back data received, if any.
         *********************************************************************/
        if ( rx_size > 0 )
        {
            UART_send( &g_uart, rx_data, rx_size );
        }
    }
}

/******************************************************************************
 * main function.
 *****************************************************************************/
int main( void )
{
    /**************************************************************************
     * Initialize CoreUARTapb with its base address, baud value, and line
     * configuration.
     *************************************************************************/
    UART_init( &g_uart, COREUARTAPB0_BASE_ADDR, BAUD_VALUE_57600, (DATA_8_BITS | NO_PARITY) );

    /**************************************************************************
     * Enable interrupts at the processor level
     *************************************************************************/
    NVIC_EnableIRQ(FabricIrq3_IRQn);

    /**************************************************************************
     * Infinite Loop.
     * This loop will be interrupted by calls to uart_rx_isr() when the UART's
     * RXRDY signal is asserted upon characters being received.
     *************************************************************************/
    while(1)
    {
        ;
    }
}
