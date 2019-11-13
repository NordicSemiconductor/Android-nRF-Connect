@echo off

set FIRMWARE_PATH=Android/data/no.nordicsemi.android.mcp/files/Test

rem Copy required firmware
adb push "SDK 12.2\zip\nrf52832_sdk_12.2_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_app.zip"
adb push "SDK 12.2\zip\nrf52832_sdk_12.2_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_bl_2.zip"
adb push "SDK 12.2\zip\nrf52832_sdk_12.2_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_sd.zip"
adb push "SDK 12.2\zip\nrf52832_sdk_12.2_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_sd_bl_1.zip"
adb push "SDK 12.2\zip\nrf52832_sdk_12.2_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_sd_bl_app_3.zip"

adb push "SDK 13\zip\nrf52832_sdk_12.2_to_13_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_12.2_to_13_all_in_one.zip"
adb push "SDK 13\zip\nrf52832_sdk_13_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_app.zip"
adb push "SDK 13\zip\nrf52832_sdk_13_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_bl_2.zip"
adb push "SDK 13\zip\nrf52832_sdk_13_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_sd.zip"
adb push "SDK 13\zip\nrf52832_sdk_13_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_sd_bl_1.zip"
adb push "SDK 13\zip\nrf52832_sdk_13_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_sd_bl_app_3.zip"

adb push "SDK 14.1\zip\nrf52832_sdk_13_to_14.1_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_13_to_14.1_all_in_one.zip"
adb push "SDK 14.1\zip\nrf52832_sdk_14.1_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_14.1_app.zip"
adb push "SDK 14.1\zip\nrf52832_sdk_14.1_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_14.1_bl_2.zip"
adb push "SDK 14.1\zip\nrf52832_sdk_14.1_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_14.1_sd.zip"
adb push "SDK 14.1\zip\nrf52832_sdk_14.1_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_14.1_sd_bl_1.zip"
adb push "SDK 14.1\zip\nrf52832_sdk_14.1_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_14.1_sd_bl_app_3.zip"

adb push "SDK 15\zip\nrf52832_sdk_14.1_to_15_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_14.1_to_15_all_in_one.zip"
adb push "SDK 15\zip\nrf52832_sdk_15_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15_app.zip"
adb push "SDK 15\zip\nrf52832_sdk_15_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15_bl_2.zip"
adb push "SDK 15\zip\nrf52832_sdk_15_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15_sd.zip"
adb push "SDK 15\zip\nrf52832_sdk_15_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15_sd_bl_1.zip"
adb push "SDK 15\zip\nrf52832_sdk_15_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15_sd_bl_app_3.zip"

adb push "SDK 15.2\zip\nrf52832_sdk_15_to_15.2_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15_to_15.2_all_in_one.zip"
adb push "SDK 15.2\zip\nrf52832_sdk_15.2_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.2_app.zip"
adb push "SDK 15.2\zip\nrf52832_sdk_15.2_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.2_bl_2.zip"
adb push "SDK 15.2\zip\nrf52832_sdk_15.2_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.2_sd.zip"
adb push "SDK 15.2\zip\nrf52832_sdk_15.2_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.2_sd_bl_1.zip"
adb push "SDK 15.2\zip\nrf52832_sdk_15.2_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.2_sd_bl_app_3.zip"

adb push "SDK 15.3\zip\nrf52832_sdk_15.2_to_15.3_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.2_to_15.3_all_in_one.zip"
adb push "SDK 15.3\zip\nrf52832_sdk_15.3_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.3_app.zip"
adb push "SDK 15.3\zip\nrf52832_sdk_15.3_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.3_bl_2.zip"
adb push "SDK 15.3\zip\nrf52832_sdk_15.3_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.3_sd.zip"
adb push "SDK 15.3\zip\nrf52832_sdk_15.3_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.3_sd_bl_1.zip"
adb push "SDK 15.3\zip\nrf52832_sdk_15.3_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.3_sd_bl_app_3.zip"

adb push "SDK 16\zip\nrf52832_sdk_15.3_to_16_all_in_one.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_15.3_to_16_all_in_one.zip"
adb push "SDK 16\zip\nrf52832_sdk_16_app.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_16_app.zip"
adb push "SDK 16\zip\nrf52832_sdk_16_bl_2.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_16_bl_2.zip"
adb push "SDK 16\zip\nrf52832_sdk_16_sd.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_16_sd.zip"
adb push "SDK 16\zip\nrf52832_sdk_16_sd_bl_1.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_16_sd_bl_1.zip"
adb push "SDK 16\zip\nrf52832_sdk_16_sd_bl_app_3.zip" "/sdcard/%FIRMWARE_PATH%/nrf52832_sdk_16_sd_bl_app_3.zip"

rem Start testing
call ..\test.bat -E FIRMWARE_PATH "/%FIRMWARE_PATH%" test_nRF52832.xml