There is a bug in SDK 14 related to SD size that makes updating from pre-14 to 14 not possible.

Look for this:

#if NRF_DFU_WORKAROUND_PRE_SDK_14_1_0_SD_BL_UPDATE
    // This code is a configurable workaround for updating SD+BL from SDK 12.x.y - 14.1.0
    // SoftDevice size increase would lead to unaligned source address when comparing new BL in SD+BL updates.
    // This workaround is not required once BL is successfully installed with a version that is compiled SDK 14.1.0 
It arrived in 14.1


To fix it, add this in SDK 14:

#if defined(NRF52832_XXAA) && defined(BLE_STACK_SUPPORT_REQD)
    if ((p_bank->bank_code == NRF_DFU_BANK_VALID_SD_BL) &&
        (memcmp((void *)BOOTLOADER_START_ADDR, (void *)(src_addr - 0x4000), len) == 0))
    {
        ret_val = NRF_SUCCESS;
    }
#endif // defined(NRF52832_XXAA) 

like it is in SDK 14.1.

For this tests we will skip SDK 14, just do an update from 13 to 14.1  where this issue is fixed.