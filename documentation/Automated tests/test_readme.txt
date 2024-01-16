-----------------------
    R E A D    M E
-----------------------

The README file contains information about the following files:
(1) test.bat / test.sh
(2) sample_test_hrm.xml
(3) sample_text_scanning.xml

------------------------
   Automated testing 
------------------------
Starting from version 2.1 the nRF Connect may be used to perform automated tests on
Bluetooth Low Energy devices.
An Android phone or a tablet, that will be used to perform tests, must be connected with a USB cable to
the PC and drivers must be installed. The location of ADB must be in the global PATH variable. 
USB debugging must be enabled in Android settings.

To start automatic test a test suite must be created.

-------------------------
   Files
-------------------------
1. TEST.BAT / TEST.SH

The script that initializes the test service. It copies the test suite XML file onto Android device and starts the test.

Execute "test -?" or "./test.sh --help" in the command line for usage.

Android 4.3+ device nRF Connect (2.1.0+) is required.

2. SAMPLE_TEST_HRM.XML

A sample test suite with the full documentation included as comments. It contains almost all features of the test engine.

3. SAMPLE_TEST_SCANNING.XML

A sample test suite with the full documentation included as comments. It contains the rest of all features of the test engine.
Both sample XMLs contains the full features explained.

-------------------------
   Change log
-------------------------
nRF MCP 2.0 - The beta version released
nRF Connect 4.3 - <scan> and <scan-for> commands added, logging time and device information
nRF Connect 4.10 - <sleep-if> and <sleep-until> commands added
nRF Connect 4.21 - reading and requesting PHY, reliable write, requesting connection priority has now timeout parameter
nRF Connect 4.28 - <mcu> command added for FOTA update using Mcu Manager
 
-------------------------
   Development kit
-------------------------
Go to https://www.nordicsemi.com/Software-and-tools/Development-Kits for more 
information about the Development Kit.
