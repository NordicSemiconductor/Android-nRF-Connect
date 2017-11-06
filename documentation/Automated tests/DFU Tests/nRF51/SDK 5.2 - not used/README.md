## Information

SDK 5.2 is not used in the DFU test as the bootloader has a different starting memory address and it didn't work after simply setting the address to the same value as Secure DFU bootlaoder, like it did for other SDKs <= 11. When updating a bootloader using DFU the starting address of the old and the new one must be the same.

However, using the *output/nrf51422_sdk_5.2_all_in_one.hex* and the ZIP file, the app may be updated and it should work with all DFU library versions. Keep in mind, that the old DFU had somewhat slow procedure to save data to the flash, and it may fail on newer phones when PRNs (Packet Receipt Notifications) are disabled or set to value higher than few. PRNs slow down the rate of sending data by ensuring that the target device received the already sent data.

## How to use

1. Connect your nRF51 DK or other board with nRF51 chip to the PC and flash the all-in-one HEX.
2. There was no buttonless service in SDK 5.2, so you have to switch to the bootloader mode using a button. When using nRF51 DK, press and hold the Button 3 and reset the board. 3 LEDs: 1, 2, 3 should light up.
3. Connect the the device using nRF Connect and flash the ZIP file using DFU.