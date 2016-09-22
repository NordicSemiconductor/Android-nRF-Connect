@echo off
rem Copyright (c) 2014 Nordic Semiconductor. All Rights Reserved.
rem   
rem The information contained herein is property of Nordic Semiconductor ASA.
rem Terms and conditions of usage are described in detail in NORDIC SEMICONDUCTOR STANDARD SOFTWARE LICENSE AGREEMENT.
rem Licensees are granted free, non-transferable use of the information. NO WARRANTY of ANY KIND is provided. 
rem This heading must NOT be removed from the file.
rem 
rem Description:
rem ------------
rem The script allows to run automated tests using Android phone.
rem The script may be run on Windows.
rem
rem Requirements:
rem -------------
rem 1. Android device with Android version 4.3+ connected by USB cable with the PC
rem 2. The path to Android platform-tools directory must be added to %PATH% environment variable, f.e: C:\Program Files\Android ADT Bundle\sdk\platform-tools
rem 3. nRF Connect (previously nRF Master Control Panel) (2.1.0+) application installed on the Android device
rem 4. "Developer options" and "USB debugging" must be enabled on the Android device
rem
rem Usage:
rem ------
rem 1. Open command line
rem 2. Type "test -?" and press ENTER
rem
rem Android Debug Bridge (adb):
rem ---------------------------
rem You must have Android platform tools installed on the computer or the files: adb.exe, AdbWinApi.dll copied to the same directory.
rem Go to http://developer.android.com/sdk/index.html for more information how to install it on the computer.
rem You do not need the whole ADT Bundle (with Eclipse or Android Studio). Only SDK Tools with Platform Tools are required.
rem 
rem ==================================================================================
setlocal
set PROGRAM=%~0
set DEVICE=
set S_DEVICE=
set EXTRAS=

rem ==================================================================================
rem Check ADB

call adb devices > nul 2>&1
if errorLevel 1 (
	call :info
	echo Error: adb is not recognized as an external command.
	echo        Add [Android Bundle path]/sdk/platform-tools to %%PATH%%
	goto error
)

rem ==================================================================================
rem Check help
if "%~1"=="" goto usage
if "%~1"=="-?" goto usage
if "%~1"=="/?" goto usage

rem ==================================================================================
rem Read the target device id
if /I "%~1"=="-d" set TARGET_DEVICE_SET=1
if defined TARGET_DEVICE_SET (
	if not "%~1"=="" (
		set DEVICE=%~2
		set S_DEVICE=-s %~2
		shift
		shift
	) else goto usage
)

rem Read optional extra parameters
:read_extras
if /I "%~1"=="-e" set EXTRAS_SET=1
if defined EXTRAS_SET (
	if not "%~1"=="" (
		set EXTRAS=%EXTRAS% -e %~2 "%~3"
		shift
		shift
		shift
	) else goto usage
)
rem More extras?
if /I "%~1"=="-e" goto :read_extras

rem ==================================================================================
rem Write intro
call :info

rem Read file name and fully qualified path name to the XML file
if "%~1"=="" (
	echo Error: Test script file name not specified.
	goto error
)
set XML_FILE=%~nx1
set RESULT_FILE=%~n1_result.txt
set XML_PATH="%~f1"
if not exist %XML_PATH% (
	echo Error: The given test script file has not been found.
	goto error
)

rem ==================================================================================
if "%DEVICE%"=="" (
	rem Check if there is only one device connected
	for /f "delims=" %%a in ('call adb devices ^| findstr "device unauthorized emulator" ^| find /c /v "devices"') do (
		if "%%a"=="0" (
			echo Error: No device connected.
			goto error
		)
		if not "%%a"=="1" (
			echo Error: More than one device connected.
			echo        Specify the device serial number using -d option:
			call adb devices
			goto usage_only
			goto error
		)
	)
) else (
	rem Check if specified device is connected
	for /f "delims=" %%a in ('call adb devices ^| find /c "%DEVICE%"') do (
		if "%%a"=="0" (
			echo Error: Device with serial number "%DEVICE%" is not connected.
			call adb devices
			goto error
		)
	)
)

rem ==================================================================================
rem Remove old result file (if exists)
echo|set /p=Removing old result file...
call adb shell rm "/sdcard/Nordic\ Semiconductor/Test/%RESULT_FILE%" > nul 2>&1
if errorLevel 1 (
	echo NOT FOUND
) else echo OK

rem Copy selected file onto the device
echo|set /p=Copying "%XML_FILE%" to /sdcard/Nordic Semiconductor/Test...
call adb %S_DEVICE% push %XML_PATH% "/sdcard/Nordic Semiconductor/Test/%XML_FILE%" > nul 2>&1
if errorLevel 1 (
	echo FAIL
	echo Error: Device not found.
	goto error
) else echo OK

rem Start test service on the device
echo|set /p=Starting test service...
call adb %S_DEVICE% shell am startservice -a no.nordicsemi.android.action.START_TEST^
 %EXTRAS% -e no.nordicsemi.android.test.extra.EXTRA_FILE_PATH "/sdcard/Nordic\ Semiconductor/Test/%XML_FILE%" > nul 2>&1
if errorLevel 1 (
	echo FAIL
	echo Error: Required application not installed.
	goto error
) else (
	echo OK
	echo Test started...OK
)

rem Try to obtain the result. Wait 10 seconds before every try.
echo|set /p=Waiting for the result...
:read_result
rem Wait 10 sec, this IP address is reserved and does not exist
ping 192.0.2.3 -n 1 -w 10000 > nul
call adb %S_DEVICE% pull "/sdcard/Nordic Semiconductor/Test/%RESULT_FILE%" "%RESULT_FILE%" > nul 2>&1
if errorLevel 1 goto :read_result

echo OK
echo Result saved in "%RESULT_FILE%".

goto exit

rem ==================================================================================
:info
echo =================================================
echo Nordic Semiconductor Automated Tests batch script
echo =================================================
goto eof

rem ==================================================================================
:usage
call :info
:usage_only
echo Usage:
echo %PROGRAM% [-D device_id] [-E key value] script.xml
echo Info:
echo device_id - Call: "adb devices" to get list of serial numbers
echo key=value - You may pass 0+ parameters to the Test Service, f.e. 
echo             -E EXTRA_ADDRESS "AA:BB:CC:DD:EE:FF" -E SOMETHING "important" 
echo             and use them in the script.xml file as f.e. 
echo             ..address="${EXTRA_ADDRESS}"...
goto exit

rem ==================================================================================
:error
set errorLevel=1

rem ==================================================================================
:exit
endlocal

:eof