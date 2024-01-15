# nRF Connect

The nRF Connect for Mobile is an application designed for Bluetooth Low Energy developers. It allows for scanning for BLE devices and communicating with them.

The nRF Connect for Android application requires Android version 4.3 or later and is available on Google Play or [releases](https://github.com/NordicSemiconductor/Android-nRF-Connect/releases), in case Google Play is not available. We recommend to install the application using Google Play as it will get automatic updates.

<a href='https://play.google.com/store/apps/details?id=no.nordicsemi.android.mcp'><img alt='Get it on Google Play' height='80' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

> [!IMPORTANT]
> The **source code** of nRF Connect is not available. This repo proveds only documentation and Issue tracker.

## Features

1. Scanning for Bluetooth LE devices in range
1. Displaying the RSSI graph with an option to export to CSV or EXCEL
1. Displaying detailed packet history with RSSI, packet changes and advertising intervals
1. Displaying advertisements of mutliple devices on a timeline
1. Connecting to multiple devices at the same time
1. Showing device services and characteristics
1. Reading and writing characteristics
1. Configuring GATT Server
1. Peripheral mode (BLE advertising) (newest Android 5+ devices only)
1. Logging events and packets to nRF Logger app (available on Google Play)
1. Device Firmware Update (DFU) (read below)
1. Automated tests (read below)
1. Recording and playing macros to automate operations
1. Parsing most of Bluetooth SIG adopted characteristics + some proprietary ones
1. Support for Eddystone (parsing, decrypting EID, Eddystone Config Service)

## DFU - Device Firmware Update

nRF Connect supports the following DFU proptocols:

Name | SDK | Supported Devices | Documentation
-----|-----|---------|--------------
Legacy DFU | nRF5 SDK | nRF51, nRF52 | [Link](https://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v11.0.0/examples_ble_dfu.html?cp=9_5_13_4_3_1)
Secure DFU | nRF5 SDK | nRF52 | [Link](https://infocenter.nordicsemi.com/topic/sdk_nrf5_v17.1.0/lib_bootloader_modules.html?cp=9_1_3_5)
McuManager | nRF Connect SDK, Zephyr, Mynewt | nRF52, nRF53, nRF54, ... | [Link](https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/config_and_build/dfu/index.html)

## Automated testing

The nRF Connect allows for executing XML scripts with test suites. Two sample XMLs for testing: the HRM-DFU sample and HRM-Scanning sample are 
available in [documentation](documentation/Automated%20tests). They contains the full documentation of the currently available features. 
Copy those files and the *test.bat* script to your PC and run. Currently only Windows batch script is available, but **adb** commands can
be called from Mac and Linux as well.

To start the test run the *test.bat* script:
```batch
test.bat [-d device_id] [-E KEY EXTRA] test.xml
```
or **test.sh** script:
```sh
./test.sh [-d device_id] [-E KEY EXTRA] test.xml 
```
You may specify key-value pairs in execution or inside the test using 

    <set name="KEY" value="VALUE" />
    
and then use them as `${KEY}` (see the sample_test_hrm.xml).

Read mode about the test suites in the [documentation](documentation/Automated%20tests/README.md).

## Macros

Starting from version 4.4.0 it is now possible to automate operations using macros. Macros can be recorded, or imported from a XML file.

Read more about macros in the [macros documentation](documentation/Macros/README.md).
