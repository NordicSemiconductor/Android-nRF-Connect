# Automated Tests - MCU Manager

This folder contains files for testing MCU Manager feature in nRF Connect for Android.

MCU Manager allows updating supported devices over-the-air using Bluetooth Low Energy as transport.
nRF Connect is using the [Device Manager](https://github.com/NordicSemiconductor/Android-nRF-Connect-Device-Manager)
library under the hood.

## Content

1. 3 sets of test files:
   - *merged_peripheral_lbs_[type]_[version].hex - initial firmware for nRF52840 DK to be flashed on (using *nrfjprog* or the Programmer app in nRF Connect for Desktop)
   - *dfu_application_peripheral_lbs_[type]_[version].zip - 2 sets of update packages with increasing version numbers.
2. *sample_test_lbs_osinfo.xml* - a test file for Automated Tests.

### Firmware types

- *osinfo* - firmware with App Info command supported in the OS group.
- *w_revert* - MCUBoot in Direct XIP mode with revert.
- *wo_revert* - MCUBoot in Direct XIP mode without revert.

## Tests preparations

The sample test suite is verifying LBS (LED Button Service) feature on a first device advertising LBS Service UUID.
The second part of the test reads the slot information on the device, performs an update and verifies the update by reading slot information again.
As the slot information is different for each firmware, you may need to modify the XML and copy the correct bytes.

The attached XML file tests the *osinfo* type.

> [!NOTE]
> The ZIP file for an update must be transferred onto the phone before the test is started.

1. Make sure nRF Connect for Android and nRF Logger are installed on the phone.
2. Connect the Android phone with the PC for debugging (USB or Wi-Fi) and make sure ADB (Android Debug Bridge) app is in the PATH.
3. Flash the *merged_peripheral_lbs_osinfo_v100.hex* file onto nRF52840 DK.
4. Copy the *dfu_application_peripheral_lbs_osinfo_v200.zip* file with version 2.0.x to *sdcard/Android/data/no.nordicsemi.android.mcp/files/Test/*.
5. Start the test using:

  ```sh
  ./test.sh -e FILE /sdcard/Android/data/no.nordicsemi.android.mcp/files/Test/dfu_application_peripheral_lbs_osinfo_v200.zip sample_test_mcu.xml
  ```
6. The console should display:
  ```sh
  =================================================
  Nordic Semiconductor Automated Tests shell script
  =================================================
  Removing old result file...OK
  Copying "sample_test_mcu.xml" to /sdcard/Android/data/no.nordicsemi.android.mcp/files/Test...OK
  Starting test service...OK
  Test started...OK
  Waiting for the result...
  ```
7. When the test is complete the result file should be downloaded to the PC.

### Other firmware

To test other types than *osinfo* do the following:
1. Copy other ZIP files to the same location on the phone.
2. Run the *test.sh* or *test.bat* giving the correct file name.
3. The test will finish with a warning and an error, as Image List will produce different bytes.
4. Copy the received bytes to the XML file to **assert-notification** command.
5. Reflash the device with firmware version 1.0.x.
6. Repeat the test.