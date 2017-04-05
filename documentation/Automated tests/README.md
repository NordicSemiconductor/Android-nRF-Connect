# Automated tests

Automated tests allow you to configure and run set of tests foor your Bluetooth Smart device using an Android 4.3+ phone. Fill free to submit comments, bugs or feature ideas.

## Resources

1. [test.bat](test.bat) - the Windows script that may be used to run the test on the Android device.
2. [sample_test_hrm.xml](sample_test_hrm.xml) - one of the sample tests. It covers almost all features of the automated tests, except those added in nRF Connect 4.3 or later. It can be run on the HRS_DFU sample application from the SDK. You may modify it to match your application.
3. [sample_test_scanning.xml](sample_test_scanning.xml) - the second sample test. Covers new scanning feature in automated tests added in nRF Connect v. 4.3.

## How to begin

The automated tests should work with any Bluetooth Smart device that comunicates over the GATT protocol. A test XML can be created to test it the services, characteristics and descriptors have the correct values and behaviour. A Device Firmware Update (DFU) also may be performed. 

To make an easy start the *sample_test_hrm.xml* file contains a test that can be used with the HRS_DFU sample from the SDK. The instruction below describes steps that should be performed to successfully run this test. 

**Note:** Starting from the SDK 8.0 the bootloader, in case the buttonless update is NOT being used, advertises with a device address increased by 1. Therefore, the test may fail in the first run if you have just the Soft Device and Bootloader flashed on the device. After flashing the HRS application onto it, it will start to advertise with a different address and a timeout will be thrown during connection attempt. But the test should work for the second time as the bootloader uses the same address if buttonless update is in use.

1. nRF Connect (nRF Master Control Panel v2.1 or newer) will create the above files in your phone's file system in */Nordic Semiconductor* folder. **Note:** newly created files may not be visible on the PC when connected with USB. This is beacuse Android must perform a scan of media files. Get the files from GitHub or trigger the media scanner manually: restart the phone/tablet or install and launch the *Rescan SD* application (or similar) from Google Play.
2. Copy those files to your PC. You will use the *test.bat* to start the testing service. The sample may be used as a demo or a starting point.
3. To prepare the nRF51 DK for the test flash the Soft Device and the DFU bootloader.
  1. Flash the Soft Device s110 version 8.0 or newer (for example using nRF Go Studio)
  2. Flash the DFU Bootloader from SDK 9.0 or newer (both SD and Bootloader are available on http://developer.nordicsemi.com website)
    - If you want to use the buttonless update in DFU bootloader from SDK 7.1, modify the *dfu_transport_ble.c* file in your bootloader source (you may have to unlock the file in Explorer first as it's READ ONLY by default). 
    - Increase the **APP_DIRECTED_ADV_TIMEOUT** value to 50 (it's 5 by default) in line 62: `#define APP_DIRECTED_ADV_TIMEOUT             50`
    - Compile the modified Bootloader and flash the new HEX.
    - This change is required for the Android to reconnect to the bootloader after switching the device to bootloader mode. By default, the bootloader advertises for 6 seconds (5 * 1.28s) which is shorter than the disconnection timeout on Android. The Android, after sending *jump* command, waits for the disconnection event about 22 seconds, depending on the device model. Value 50 (1 minute) should be more than enough.
    - Note: this change is not be required for newer versions of the DFU bootloader.
4. Connect your Android device to the PC, enable USB debugging on it and install required drivers and ADB (Android Debug Bridge) on the PC. Add the ABD to the PATH global variable or copy it (and dlls) to the same folder.
5. Try the ADB by writing `adb devices` command in the command line. A list of connected Android devices should be shown.
6. Find out the address of your device. You may use the nRF Connect to do that. Your device should advertise as a DFU Targ. Make sure you are not connected with the bootloader.
7. Optional: install the [nRF Logger](https://play.google.com/store/apps/details?id=no.nordicsemi.android.log) application to get more information about the test progress and syntax errors.
8. Start the sample test with the following command. Use your device address, f.e. AA:BB:CC:DD:EE:FF instead of address*. The -d option is required only when more than one Android device is connected and configured for USB debugging.

    `test.bat [-d your_android_device_id] -E EXTRA_ADDRESS address* sample_test_hrm.xml`

9. A *Test in progress...* notification will be shown. If you had the nRF Logger installed click the notification to display the test progress.
10. When test is completed the *sample_test_hrm_result.txt* file will be created in the script location. The result of the sample HRM test is [here](sample_test_hrm_result.txt).

To test the HRM sample test on nRF52 device you have to modify the XML script and either remove the run-test with id **dfu**, or modify the FIRMWARE_PATH constant to ```/Nordic Semiconductor/Board/pca10040/ble_app_hrm_dfu_s132_v2_0_0_sdk_11_0.zip``` and make sure the Soft Device 2.0.0 and HRM_DFU app is flashed.

**Scanning sample test** - the second test does not require providing the device address. The test service will perform a BLE scan and find a device that advertises with HRM service UUID, connect and do some basic operations just to prove it works.

## Documentation

The test suite is defined in XML in the **test-suite** node. The basic test suite structure is shown below:

```xml
<test-suite>
  <!-- Definitions (0+) -->
  <set name="KEY" value="VALUE" /> 
  ...
  <!-- Target(s) (0+) -->
  <target id="TARGET_ID" name="TARGET_NAME" [address="AA:DD:DR:RE:ES:SS"] />
  ...
  <!-- Test definition(s) (1+) -->
  <test id="TEST_ID" description="DESCRIPTION" [target="TARGET_ID"]>
    ...
  </test>
  ...
  
  <!-- Run test command(s) (1+) -->
  <run-test ref="TEST_ID" description="DESCRIPTION">
    <!-- Optional constants redefinition (0+) -->
    <set name="KEY" value="OTHER_VALUE" />
  </run-test>
  ...
</test-suite>
```

### Targets

A test suite may test one or more devices. A default target may be set for the test and/or specified for each operation (see below). The operation's target, if specified, overwrites the test target. Since version 4.3 defining a target is not required (as **scan** operation does not require it). If set, the address may not be specified, as the new **scan-for** command may bind the target with an advertising device based on defined filters.

### Operation expected result

Each operation in the test may end with SUCCESS, WARNING or FAIL. If the operation fails the test is aborted and the device is being disconnected. Warning does not abort the test but the cause of the warning is logged. In addition, the expected result for each operation may be specified using **expected** attribute. Using this attribute a test can check some conditions that should not happen. This attribute may have one of the following values:

- SUCCESS                 - success is required to go on (default),
- SUCCESS_WARNING_ON_FAIL - a warning will be logged in the result file but the test will continue,
- FAIL                    - a fail is required to proceed,
- FAIL_WARNING_ON_SUCCESS - a fail is expected but in case of a success a warning will be logged to the result file. 

If **expected** attribute is set to FAIL the tag may also specify the exected error code using **expectedErrorCode** attribute. For example, it writing to a characteritistic should fail because of its CCCD not being enabled the **read** tag may contain ```expected="FAIL" expectedErrorCode="253"``` (GATT CCCD CFG ERROR, 0xFD). This attribute has been added in nRF Connect v.4.11.

### Timeouts

Each operation, except **dfu** may have the timeout specified. The default timeout for each is set to 5000ms and may be changed using the **timeout="NUMBER"** attribute. The number is in milliseconds.

### Operations

The fillowing operations are currently supported:

##### Scan

```xml
<scan [description="DESCRIPTION"] [rssi="RSSI_VALUE"] [name="NAME"] [data="ADV_PACKET_FILTER"] [target="TARGET_ID"] [timeout="NUMBER"] />
```

The **scan** command will perform a BLE scan for exactly the time given by a **timeout** attribute (default 5000 ms) and will list all received advertising packets matching filters in a format: ```TIME ADDRESS RSSI(decimal) DATA(hex)``` (one line per packet), for example:

```12:34:56.123 11:22:33:44:55:66 -45 0B094E6F726469635F48524D0319410302010607030D180F180A18```

Attributes **address**, **rssi**, **data** and/or **target** MAY be specified to filter packets by address or advertising data:
 - **address** - scan will log packets from a device with given Bluetooth address.
 - **rssi**    - scan will log packets with RSSI value greater or equal to specified is received.
               RSSI values vary from around -100 dBm (far) to approx -40 dBm (very close).
 - **name**    - scan will log packets from a device with given Complete or Shortened Local Name.
 - **data**    - scan log packets matching given data in received advertising packet.
               Matching is done using Pattern#find(String) method after converting the adv. packet to an uppercase HEX string representation.
               This means, that if a device advertises with "020104" a data="10" will be found.
               The **data** attribute SHOULD contain only HEX characters, otherwise it will for 100% not match any HEX data.
 - **target**  - scan will log packets from a device with the same address as the target is found. The target must be bound before.

##### Scan-For

```xml
<scan-for [description="DESCRIPTION"] [rssi="RSSI_VALUE"] [name="NAME"] [data="ADV_PACKET_FILTER"] [target="TARGET_ID"] [bind-target="TARGET_ID"] [timeout="NUMBER"] />
```

The **scan-for** command will perform a BLE scan and finish when a device matching given filter parameters (address, rssi and/or advertising data) is found, or the timeout specified by the **timeout** attribute occur.

Attributes **address**, **rssi**, **data** and/or **target** MAY be specified to filter packets by address or advertising data:
 - **address** - scan will continue until a device with given Bluetooth address.
 - **rssi**    - scan will continue until a packet with RSSI value greater or equal to specified is received.
               RSSI values vary from around -100 dBm (far) to approx -40 dBm (very close).
 - **name**    - scan will log packets from a device with given Complete or Shortened Local Name.
 - **data**    - scan will continue until given data will be found in received advertising packet.
               Matching is done using Pattern#find(String) method after converting the adv. packet to an uppercase HEX string representation.
               This means, that if a device advertises with "020104" a data="10" will be found.
               The **data** attribute SHOULD contain only HEX characters, otherwise it will for 100% not match any HEX data.
 - **target**  - scan will continue until a device with the same address as the target is found. The target must be bound before.

Attribute **bind-target** MAY be used to bind the first matching device with given target identifier. A target may be bound multiple times (but only when it's not connected), so you may reuse the test using multiple **run-test** commands with different filters.

##### Connect

```xml
<connect [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] />
```

This operation must be defined if a test should connect to the device. The only operations that do not need the connection are **bond** and **dfu**. If you forget to add the **connect** tag an error will occur and the test ask you whether you did not forget to connect.

The **connect** operation is folowed by 1 second break to give Android some time before the next operation. This seconds may be used f.e. for re-establishing bond and/or starting the service discovery.

##### Service Discovery

```xml
<discover-services [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] />
```

To be able to assert, read or write characteristics a **discover-services** operation must be specified. This will cause the service discovery on the device. However, if services are already known and cached, the cached list will be returned. Please, use the **refresh** operation to clear the cache.

##### Refresh

```xml
<refresh [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] />
```

This operation clears the device services cache. It's using the hidden Android method *BluetoothGatt#refresh()* which may be removed from the API in the future. It may be useful when multiple different BLE applications are being flashed on the same Bluetooth Smart device (e.g. DK).

This method must be called after the device has been connected at least once in the test using the **connect** operation. Otherwise an error message will be shown. This is because it is being invoked on a *BluetoothGatt* object which is created using *connectGatt(..)* method.

The **refresh** operation is folowed by 1 second break to give Android some time before the next operation. The break may be used to start the Android-internal service discovery.

##### Disconnect

```xml
<disconnect [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] />
```

Each device used in the test is automatically disconnected when the test ends (no matter the result). However, when a diconnection is to be a part of the test this operation may be used.

##### Assert services and characteristics

```xml
<assert-service [description="DESCRIPTION"] [target="TARGET_ID"] uuid="SERVICE_UUID" [instance-id="INSTANCE_ID"] [target="TARGET_ID"] [expected="SUCCESS"] >
  <!-- Assert the characteristic in this service -->
  <assert-characteristoc [description="DESCRIPTION"] [target="TARGET_ID"] uuid="CHAR_UUID" [instance-id="INSTANCE_ID"] [expected="SUCCESS"]>
    <!-- Assert characteristic properties -->
    <property name="NOTIFY" [requirement="MANDATORY"] />
    <!-- It may also have some other properties (this section may be skipped as this is does not do any checking -->
    <property name="READ" requirement="OPTIONAL" />
    <!-- But for sure it must not have those properties -->
    <property name="WRITE" requirement="EXCLUDED" />
    <property name="WRITE_WITHOUT_RESPONSE" requirement="EXCLUDED" />
    <!-- 
			Property name is case-sensitive and must be one of the following: 
				- BROADCAST
				- READ
				- WRITE
				- WRITE_WITHOUT_RESPONSE
				- NOTIFY
				- INDICATE
				- SIGNED_WRITE
				- EXTENDED_PROPERTIES

			Requirement name is also case-sensitive and must be one of the following:
				- MANDATORY (default)
				- OPTIONAL
				- EXCLUDED
    -->
    <property name="SIGNED_WRITE" requirement="EXCLUDED" />
    <!-- This characteristic should have the CCCD descriptor. Attribute 'instance-id' is optional -->
    <assert-descriptor [description="Checking ${DESC_NAME} descriptor"] uuid="${CCCD_UUID}" [expected="SUCCESS"] />
    <!-- We may also check if the characteristic has Client Characteristic Configuration with assert-cccd command -->
    <assert-cccd [description="Another way of checking only the CCCD"] [expected="SUCCESS"]>
      <!-- And even check the value of any descriptor, including the CCCD -->
      <assert-value [description="Check if notifications are disabled by default"] value="BYTES"|value-string="TEXT" [expected="SUCCESS"] />
    </assert-cccd>
    <!-- 
			The following descriptor should not be in this characteristic.

			An 'expected' attribute may be set to all operations (except 'property' and 'sleep') to specify the expected result.
			Expected result may be one of the following:
				- SUCCESS                 - success is required to go on (default)
				- SUCCESS_WARNING_ON_FAIL - a warning will be logged in the result file but the test will continue
				- FAIL                    - a fail is required to proceed
				- FAIL_WARNING_ON_SUCCESS - a fail is expected but in case of a success a warning will be logged to the result file.
	-->
    <assert-descriptor [description="This descriptor should not be found"] uuid="00002906-0000-1000-8000-00805f9b34fb" [expected="FAIL"] />
  </assert-characteristic>
</assert-service>
```

The **assert-service** operation and its child nodes may be used to validate the proper configuration of the device. For all assert operations an **expected** attribute may be specified (see above).

Remember that before you read the characteristic its value is *null* (null is equal to 00+, as on the example above or to an empty string). The only exception are the CCCD descriptors for bonded devices. When notifications or indications were enabled in the previuos connection the value of the descriptor is saved in application's database and will not change. However, there is no guarantee that that is the real value of the descriptor on the target device unless the **read-descriptor** operation will be executed.

The value may be given in bytes using the **value** attribute, or as a string using **value-string**.

##### Bond

```xml
<bond [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"] />
```

Bonds to the device. This operation may be called even when the device is not connected.

##### Unbond

```xml
<unbond [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"] />
```

Removes the bond information from the phone/tablet. This operation may be called even when the device is not connected and will cause disconnection when invoked on connected device.

##### Read characteristic

```xml
<read [description="DESCRIPTION"] service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CIU"] [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]>
  <!-- Assert characteristic value -->
  <assert-value [description="DESCRIPTION"] value="BYTES"|value-string="TEXT" [expected="SUCCESS"] />
</read>
```

The **read** operation reads the value of the characteristic. A value assertion may be defined as a child node.

The instance-id attributes are optional and set to 0 by default.

##### Read descriptor

```xml
<read-descriptor [description="DESCRIPTION"] uuid="DESCRIPTOR_UUID" service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CII"] [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]>
  <!-- Assert characteristic value -->
  <assert-value [description="DESCRIPTION"] value="BYTES"|value-string="TEXT" [expected="SUCCESS"] />
</read-descriptor>
```

Reads the value of the descriptor with given UUID and asserts its value.

The instance-id attributes are optional and set to 0 by default.

##### Write characteristic

```xml
<!-- 
  The type value is case-sensitive and may have one of the following values:
  - WRITE_REQUEST (default) - Write With Response
  - WRITE_COMMAND - Write Without Response
-->
<write [description="DESCRIPTION"] service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CII"] [type="TYPE"] value="BYTES"|value-string="TEXT" [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"] />
```

Writes the given value to the characteristic.

The instance-id attributes are optional and set to 0 by default.

##### Write descriptor

```xml
<write-descriptor [description="DESCRIPTION"] uuid="DESCRIPTOR_UUID" service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CII"] value="BYTES"|value-string="TEXT" [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"] />
```

Writes the given value to the descriptor.

The instance-id attributes are optional and set to 0 by default.

##### Notifications / indications

```xml
<assert-notification [description="DESCRIPTION"] service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CII"] [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]>
  <!--
    Before the notification will be received you may want to send or read a characteristic or descriptor.
    By doing it here you ensure that the notification listener will be initiated before sending the value, as the reply may be too fast.
    If the 'write' operation was executed before calling the 'assert-notification', the notification could have been
    received before this operation was started and thous the test could fail.

    The following operations may be called here: write, write-descriptor, read, read-descriptor.
    Example:
  -->
  <!--<write description="Write notification trigger" service-uuid="some UUID" characteristic-uuid="some other UUID" value="012345" />-->

  <!-- Assert characteristic value -->
  <assert-value [description="DESCRIPTION"] value="BYTES"|value-string="TEXT" [expected="SUCCESS"] />
</assert-notification>
```

Waits NUMBER of milliseconds for a notification from a characteristic with given parameters. A value assertion may be used to check its value.

The instance-id attributes are optional and set to 0 by default.

To ensure the notification is sent after another command is executed put this command inside the notification tag. The following operations are supported (since nRF MCP 4.1): **write**, **write-descriptor**, **read**, **read-descriptor**.

##### Read RSSI while connected

```xml
<read-rssi [description="DESCRIPTION"] [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]>
  <!-- Assert RSSI value range -->
  <assert-value [description="DESCRIPTION"] value="NUMBER (e.g. -50)|LESS THNN (e.g. -50-)|GREATER THAN (e.g. -50+)" [expected="SUCCESS"] />
</read-rssi>
```

Reads the RSSI value of the given (or default) target. The RSSI value may be validated using the **assert-value** tag. In order to check whether the device signal is strong use ```value="-50+"``` attribute. The test will pass if the RSSI is higher (the signal is stronger) than -50 dBm. Be aware that the RSSI value may vary from test to test. Using a expected="SUCCESS_WARNING_ON_FAIL" is recommended.

The device must be connected. To read RSSI from not connected devices use **scan** operation.

##### Request MTU change

```xml
<request-mtu [description="DESCRIPTION"] value="MTU" [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]/>
```

Sends a MTU change request to the peripheral. MTU value must be between 23 and 517 inclusive.

*Note:* Supported only on Android 5 and never devices.

##### Request Connection Priority change

```xml
<!-- 
  Property type is case-sensitive and must be one of the following: 
  - LOW_POWER (Conn interval: 100-125ms, slave latency: 2, supervision timeout multiplier: 20)
  - BALANCED (default) (Conn interval: 30-55ms, slave latency: 0, supervision timeout multiplier: 20)
  - HIGH (Conn interval: 11.25-15ms on Android 6+ or 7.5-10ms before, slave latency: 0, supervision timeout multiplier: 20)
-->
<request-connection-priority [description="DESCRIPTION"] type="TYPE" [target="TARGET_ID"] [expected="SUCCESS"]/>
```

Requests the change of connection priority. Only the 3 given values are supported by Android API. 

This is not an asynchronuous method and will always end with a success, unless a serious problem occur. It does not mean that the requested 
parameters has been set.

*Note:* Supported only on Android 5 and never devices.

##### Sleep

```xml
<sleep [description="DESCRIPTION"] [timeout="NUMBER"] />
```

Waits a NUMBER value of milliseconds without doing anything. Always results with SUCCESS.

##### Sleep If

```xml
<sleep-if [description="DESCRIPTION"] service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CII"] value="BYTES"|value-string="TEXT" [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]/>
```

Waits if value of the given characteristic is equal to the given one. Timeout may be set to force stop waiting. The default timeout equals 0 (no timeout). A value containing only 0s is equal to no value. If the characteristic value was different than given one when operation started the operation ends immediately. Notifications should be enabled for given characteristic (otherwise value can't change).

##### Sleep Until

```xml
<sleep-until [description="DESCRIPTION"] service-uuid="SERVICE_UUID" [service-instance-id="SII"] characteristic-uuid="CHAR_UUID" [characteristic-instance-id="CII"] value="BYTES"|value-string="TEXT" [timeout="NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"]/>
```

Waits until value of the given characteristic is equal to the given one. Timeout may be set to force stop waiting. The default timeout equals 0 (no timeout). A value containing only 0s is equal to no value. If the characteristic value was equal to than given one when operation started the operation ends immediately. Notifications should be enabled for given characteristic (otherwise value can't change).

##### DFU - Device Firmware Update

```xml
<!-- 
  You may upload an application, bootloader, soft device or multiple files. Use 'type="X"' attribute where X may be one of the following:
  * 1 - for SoftDevice
  * 2 - for Bootloader
  * 4 - for Application
  * 0 - for auto (all from ZIP or an application) (default)
-->
<dfu [description="DFU operation"] file="${FIRMWARE_PATH}" [initFile="${FIRMWARE_INIT_PATH}"] [type="TYPE_NUMBER"] [target="TARGET_ID"] [expected="SUCCESS"] />
```

The **dfu** operation sends the firmware Over-the-Air to the target using DFU. In case of a DFU Bootloader from SDK 7.0+ the init file is required. Check the [How to create Init file for DFU](../init packet handling/README.md) for details.

The script may send the Soft Device, Bootloader or the application, or any combinations of those packed in a ZIP file. The new Distribution packets (recommended) are recommended since nRF Connect version 3.0 (known as nRF Master Control Panel at that time), however you may also use the ZIP file that contains the following content in order to be parsed correctly:

![ZIP content](../images/zip.png)
