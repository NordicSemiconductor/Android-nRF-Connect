@echo off

set FIRMWARE_PATH=Android/data/no.nordicsemi.android.mcp/files/Test

rem Copy required firmware

rem Only update SDK 13 app
adb push "SDK 13\zip\nrf52832_sdk_13_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_app.zip"
rem Downgrade to SDK 12.2
adb push "SDK 12.2\zip\nrf52832_sdk_13_to_12.2_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_to_12.2_all_in_one.zip"
rem Update the app on SDK 12.2
adb push "SDK 12.2\zip\nrf52832_sdk_12.2_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_app.zip"
rem Downgrade to SDK 11
adb push "SDK 11\zip\nrf52832_sdk_12.2_to_11_all_in_one_android_only.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_to_11_all_in_one_android_only.zip"
rem And update SDK 11 app
adb push "SDK 11\zip\nrf52832_sdk_11_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_11_app.zip"
rem Or update SD+BL+app on SDK 11
adb push "SDK 11\zip\nrf52832_sdk_11_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_11_all_in_one.zip"

rem Start testing
call ..\test.bat -E FIRMWARE_PATH "/%FIRMWARE_PATH%" test_nRF52832.xml