Updating SDK 11 -> 12.2 is not working.
After flashing the SD+BL the new BL erases memory from 0xE000 -> 0xE7F0 (SD space) 
despite that it was sent correctly and the correct bytes are in the bank.
Update 11 -> 11 works, so it is the BL from SDK 12.x that makes the problem.