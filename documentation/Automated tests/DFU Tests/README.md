# DFU Tests

This folder contains files used for DFU Library testing using Automated Tests module in nRF Connect for Android.

### Requirements

1. Newest nRF Connect (older versions in general will also work, but some issues may occure).
2. Optional: nRF Logger - shows log progress.
3. A phone connected to a PC running Windows with ADB (Android Debug Bridge) in PATH.

### How to start

1. Connect your Android phone using USB to the PC (currently only BAT scripts are provided so Windows is required).
2. Make sure nRF Conect and nRF Logger (optionally) are installed from Google Play or GitHub using APK.
3. Flash your DK (Development Kit) using the proper HEX from *output* folder from the highest SDK for given platform (for example nRF840).
4. Start test using run_test.bat. Make sure that nRF Connect is closed before (quit with BACK button), as it may intercept the connection if running in foreground.
5. A notification will be shown on the phone. Tap it to open nRF Logger and see progress.
6. When done test result will be pulled to the PC. You may find success results in devices' folders.

### Private key

The private and public key provided here were created to generate the bootloader.hex for SDKs 12.2+.
Please, don't be that excited that's is a private key on GitHub. Don't use it for any other purpose than this as it is no that private anymore :)

Public key generated using: 

```nrfutil keys display --key pk --format code private.pem > dfu_public_key.c```

See https://github.com/NordicSemiconductor/pc-nrfutil/

