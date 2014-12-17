# Init packet handling

The DFU bootloader from SDK 7.0+ requires an init packet containing additional data. Read more about the init packet in the documentation:

http://developer.nordicsemi.com/nRF51_SDK/doc/7.1.0/s110/html/a00065.html

For older versions of the DFU a init packet with only the 2-byte CRC may be specified.

## How to create Init Packet

Please, read the PDF file with the instruction: [PDF](How to generate the INIT file for DFU.pdf).

The [hex2bin.exe](hex2bin.exe) and [crc.exe](crc.exe) files may be downloaded our GitHub.

##### Sources

- The hex2bin program is available on SourceForge: http://sourceforge.net/projects/hex2bin/
- The crc.exe is available here: http://www.lammertbies.nl/comm/info/crc-calculation.html
