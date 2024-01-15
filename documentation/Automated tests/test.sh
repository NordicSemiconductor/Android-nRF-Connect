#!/bin/bash
# Copyright (c) 2024, Nordic Semiconductor
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of nRF Toolbox nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Description:
# ------------
# The script allows to run automated tests using Android phone.
# The script may be run on Unix / Mac / Linux.
#
# Requirements:
# -------------
# 1. Android device with Android version 4.3+ connected by USB cable with the PC
# 2. The path to Android platform-tools directory must be added to %PATH% environment variable
# 3. nRF Connect (2.1.0+) application installed on the Android device
# 4. "Developer options" and "USB debugging" must be enabled on the Android device
#
# Usage:
# ------
# 1. Open console
# 2. Type "./test.sh --help" and press ENTER
#
# Android Debug Bridge (adb):
# ---------------------------
# You must have Android platform tools installed on the computer.
# Go to http://developer.android.com/sdk/index.html for more information how to install it on the computer.
# You do not need the whole ADT Bundle (with Eclipse or Android Studio). Only SDK Tools with Platform Tools are required.

# Set variables
PROGRAM="$0"
DEVICE=""
S_DEVICE=""
EXTRAS=""

# Check ADB
if ! command -v adb > /dev/null 2>&1; then
    echo "Error: adb is not recognized as an external command."
    echo "       Add [Android Bundle path]/sdk/platform-tools to \$PATH"
    exit 1
fi

# Check help
if [ -z "$1" ] || [ "$1" = "--help" ]; then
    echo "Usage: $PROGRAM [-D device_id] [-E key value] script.xml"
    echo "Info:"
    echo "device_id - Call: \"adb devices\" to get a list of serial numbers"
    echo "key value - You may pass 0+ parameters to the Test Service, e.g.,"
    echo "            -E EXTRA_ADDRESS \"AA:BB:CC:DD:EE:FF\" -E SOMETHING \"important\""
    echo "            and use them in the script.xml file as e.g.:"
    echo "            ..address=\"\${EXTRA_ADDRESS}\"..."
    exit 1
fi

# Read target device id
if [ "$1" = "-d" ]; then
    TARGET_DEVICE_SET=1
    shift
    DEVICE="$1"
    S_DEVICE="-s $1"
    shift
fi

# Read optional extra parameters
while [ "$1" = "-e" ]; do
    EXTRAS_SET=1
    shift
    EXTRAS="$EXTRAS -e $1 \"$2\""
    shift 2
done

# Write intro
echo "================================================="
echo "Nordic Semiconductor Automated Tests shell script"
echo "================================================="

# Read file name and fully qualified path name to the XML file
if [ -z "$1" ]; then
    echo "Error: Test script file name not specified."
    exit 1
fi

XML_FILE=$(basename "$1")
RESULT_FILE="${1%.*}_result.txt"
XML_PATH=$(realpath "$1")

if [ ! -e "$XML_PATH" ]; then
    echo "Error: The given test script file has not been found."
    exit 1
fi

# Check if there is only one device connected
if [ -z "$DEVICE" ]; then
    DEVICE_COUNT=$(adb devices | grep -v "devices" | grep -c "device\|unauthorized\|emulator")
    echo $DEVICE_COUNT
    if [ "$DEVICE_COUNT" -eq 0 ]; then
        echo "Error: No device connected."
        exit 1
    elif [ "$DEVICE_COUNT" -gt 1 ]; then
        echo "Error: More than one device connected."
        echo "       Specify the device serial number using -D option:"
        adb devices
        exit 1
    fi
else
    # Check if specified device is connected
    if ! adb devices | grep -q "$DEVICE"; then
        echo "Error: Device with serial number \"$DEVICE\" is not connected."
        adb devices
        exit 1
    fi
fi

# Remove old result file (if exists)
echo -n "Removing old result file..."
adb $S_DEVICE shell rm "/sdcard/Android/data/no.nordicsemi.android.mcp/files/Test/$RESULT_FILE" > /dev/null 2>&1
echo "OK"

# Copy selected file onto the device
echo -n "Copying \"$XML_FILE\" to /sdcard/Android/data/no.nordicsemi.android.mcp/files/Test..."
adb $S_DEVICE push "$XML_PATH" "/sdcard/Android/data/no.nordicsemi.android.mcp/files/Test/$XML_FILE" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "FAIL"
    echo "Error: Device not found."
    exit 1
else
    echo "OK"
fi

# Start test service on the device
echo -n "Starting test service..."
adb $S_DEVICE shell am start-foreground-service -a no.nordicsemi.android.action.START_TEST $EXTRAS -e no.nordicsemi.android.test.extra.EXTRA_FILE_PATH "/sdcard/Android/data/no.nordicsemi.android.mcp/files/Test/$XML_FILE" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "FAIL"
    echo "Error: Required application not installed."
    exit 1
else
    echo "OK"
    echo "Test started...OK"
fi

# Try to obtain the result. Wait 10 seconds before every try.
echo -n "Waiting for the result..."
while true; do
    # Wait 10 sec, this IP address is reserved and does not exist
    sleep 10
    adb $S_DEVICE pull "/sdcard/Android/data/no.nordicsemi.android.mcp/files/Test/$RESULT_FILE" "$RESULT_FILE" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        break
    fi
done
echo "OK"
echo "Result saved in \"$RESULT_FILE\"."
exit 0