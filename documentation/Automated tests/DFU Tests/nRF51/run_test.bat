@echo off

set FIRMWARE_PATH=Android/data/no.nordicsemi.android.mcp/files/Test

rem Copy required firmware

rem Update the app on SDK 12.2
adb push "SDK 12.2\zip\nrf51422_sdk_12.2_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_12.2_app.zip"
rem Downgrade to SDK 11. iOS Library requires the same DFU type (Legacy or Secure) for both updates, so 2 ZIP files must be used
adb push "SDK 11\zip\nrf51422_sdk_12.2_to_11_all_in_one_android_only.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_12.2_to_11_all_in_one_android_only.zip"
rem And update SDK 11 app
adb push "SDK 11\zip\nrf51422_sdk_11_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_11_app.zip"
rem Or update SD+BL+app on SDK 11
adb push "SDK 11\zip\nrf51422_sdk_11_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_11_all_in_one.zip"
rem Downgrade to SDK 8 app
adb push "SDK 8\zip\nrf51422_sdk_8_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_8_all_in_one.zip"
rem And update SDK 8 app
adb push "SDK 8\zip\nrf51422_sdk_8_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_8_app.zip"
rem Downgrade to SDK 6.1 app
adb push "SDK 6.1\zip\nrf51422_sdk_6.1_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_6.1_all_in_one.zip"
rem And update SDK 6.1 app
adb push "SDK 6.1\zip\nrf51422_sdk_6.1_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_6.1_app.zip"
rem Downgrade to SDK 6.0 bl only
adb push "SDK 6\zip\nrf51422_sdk_6.0_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_6.0_all_in_one.zip"
rem And update SDK 6.0 app
adb push "SDK 6\zip\nrf51422_sdk_6.0_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf51422_sdk_6.0_app.zip"

rem Start testing
call ..\test.bat -E FIRMWARE_PATH "/%FIRMWARE_PATH%" test_nRF51422.xml