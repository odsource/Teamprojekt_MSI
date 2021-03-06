================================================================================
               SmartFusion2 MSS Timer periodic interrupt example
================================================================================

This example project demonstrates the use of the SmartFusion2 MSS timer in 32
bit timer in periodic mode. This example uses timer 1 to periodically generate
an interrupt every second to toggle the state of the LEDs.

--------------------------------------------------------------------------------
                            How to use this example
--------------------------------------------------------------------------------
Execute this project on a SmartFusion2 Eval Kit programmed with a design
as described in the "Target Hardware" section below. You will see LEDs toggling
on/off every second.

--------------------------------------------------------------------------------
                                Target hardware
--------------------------------------------------------------------------------
PIN assignment must be done depending on the on board port used.

SmartFusion2 Development Kit:
It expects MSS GPIO 0 to MSS GPIO 3 to be configured as outputs and connected to
LEDs 1 to 4 as follows:
    MSS_GPIO0:  connected to LED1 using SmartFusion2 pin A18
    MSS_GPIO1:  connected to LED2 using SmartFusion2 pin B18
    MSS_GPIO2:  connected to LED3 using SmartFusion2 pin D18
    MSS_GPIO3:  connected to LED4 using SmartFusion2 pin E18

SmartFusion2 EVAL Kit:
    MSS_GPIO0:  connected to LED1 using SmartFusion2 pin E1
    MSS_GPIO1:  connected to LED2 using SmartFusion2 pin F4
    MSS_GPIO2:  connected to LED3 using SmartFusion2 pin F3
    MSS_GPIO3:  connected to LED4 using SmartFusion2 pin G7
   
The example project is built for a design using a SmartFusion2 MSS APB clock
frequency of 83MHz. Executing this example project on a different design will
result in a different LED flashing rate..

This example project can be used with another design using a different clock
configuration. This can be achieved by overwriting the content of this example
project's "drivers_config/sys_config" folder with the one generated by Libero
as part of your design's creation.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                          Silicon revision dependencies
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
This example is built to execute on an M2S090 die. You will need to overwrite
this example project's "drivers_config/sys_config" and "CMSIS" folders with the
one generated by Libero for your hardware design if using a newer silicon 
revision.
The "drivers_config/sys_config" folder contains information about your hardware
design. This information is used by the CMSIS to initialize clock frequencies
global variables which are used by the SmartFusion2 drivers to derive baud
rates. The CMSIS boot code may also complete the device's clock configuration
depending on silicon version. The "CMSIS" and "drivers_config/sys_config" for
your design can be found in the "firmware" folder of your Libero design.

