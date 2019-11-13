# Init packet handling

Use https://github.com/NordicSemiconductor/pc-nrfutil to create distribution packets (ZIP) for DFU.

For Legacy DFU use *0_5_x* branch. For Secure DFU use the latest version from master branch. The tool is available using **pip**.

The DFU bootloader from SDK 7.0+ requires an init packet containing additional data. Read more about the init packet in infocenter: https://infocenter.nordicsemi.com/index.jsp

For older versions of the Legacy DFU an init packet with only the 2-byte CRC may be used (optionally).

Secure DFU uses new format of the init packet.

##### Sources and home pages

- The hex2bin program is available on SourceForge: http://sourceforge.net/projects/hex2bin/
- The crc.exe is available here: http://www.lammertbies.nl/comm/info/crc-calculation.html

- hex2bin.exe SHA1 hash: 51db618cb72d30d5ef3151e59a47aa47c4ee1a93
- crc.exe SHA1 hash: e96180fc2f1dba5d5f7fe98da1d531495de52dcb
