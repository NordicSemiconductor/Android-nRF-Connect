@echo off

set FIRMWARE_PATH=Android/data/no.nordicsemi.android.mcp/files/Test

rem Copy required firmware
adb push "SDK 13\zip\nrf52840_sdk_13_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52840_sdk_13_app.zip"

rem Start testing
call ..\test.bat -E FIRMWARE_PATH "/%FIRMWARE_PATH%" test_nRF52840.xml