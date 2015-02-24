# Init packet handling

The DFU bootloader from SDK 7.0+ requires an init packet containing additional data. Read more about the init packet in the documentation:

http://developer.nordicsemi.com/nRF51_SDK/doc/7.2.0/s110/html/a00065.html

For older versions of the DFU a init packet with only the 2-byte CRC may be specified.

## How to create Init Packet

Please, read the PDF file with the instruction: [PDF](How to generate the INIT file for DFU.pdf).

The [hex2bin.exe](hex2bin.exe) and [crc.exe](crc.exe) files may be downloaded from our GitHub page.

- hex2bin.exe SHA1 hash: 51db618cb72d30d5ef3151e59a47aa47c4ee1a93
- crc.exe SHA1 hash: e96180fc2f1dba5d5f7fe98da1d531495de52dcb

##### Sources and home pages

- The hex2bin program is available on SourceForge: http://sourceforge.net/projects/hex2bin/
- The crc.exe is available here: http://www.lammertbies.nl/comm/info/crc-calculation.html
