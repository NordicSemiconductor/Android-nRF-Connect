nRF Master Control Panel
========================

Application
---
The nRF Master Control Panel is an application designed for Bluetooth Smart developers. It allows for scanning for BLE devices and communicating with them.

The applicaiton requires Android version 4.3 or later and is available on Google Play:

https://play.google.com/store/apps/details?id=no.nordicsemi.android.mcp

Features
---
1. Scanning for Bluetooth Smart devices in range
2. Displaying the RSSI graph and exporting to CSV or EXCEL
3. Connecting to multiple devices at the same time
4. Showing device services and characteristics
5. Reading and writing characteristics
6. Logging events and packets to nRF Logger app
7. Device Firmware Update (DFU)
8. NEW - Automated tests

DFU - Device Firmware Update
---
The Device Firmware Update BLE protocol may be used to update the Soft Device, Bootloader or application Over-the-Air on nRF51 device. The full DFU documentation may be found on http://developer.nordicsemi.com/.

Since SDK 6.1 the DFU does not require physical intereaction with the device (f.e. pressing a button). A 'buttonless' DFU is available. The application, that supports the buttonless DFU should have the DFU Service present in its services list. See the SDK for samples.

The DFU Bootloader from SDK 7.0+ requires the extended init packet. The init packet should be provided in a DAT file and should match the matching HEX or BIN file. Please, check the Init packet handling documentation http://developer.nordicsemi.com/nRF51_SDK/doc/7.1.0/s110/html/a00065.html or How to create the init packet.

Automated testing
---
The new nRF Master Control Panel version 2.1 allows for executing XML scripts with test suites. A sample XML for testing the HRM-DFU sample is copied to /Nordic Semiconductor folder on the phone's/tablet's local storage when the application is first launched. It contains the full documentation about the currently available features. Copy this file and the *test.bat* script from your phone (or from here) to your PC.

To start the test run the *test.bat* script:

    test.bat [-d device_id] [-E KEY EXTRA]* test.xml

You may specify key-value pairs in execution or inside the test using 

    <set name="KEY" value="VALUE" />
    
and then use them as ${KEY} (see the sample_test_hrm.xml).

Read mode about the test suite syntax in the documentation.
