set APP_SOURCE="C:\Nordic\nRF5_SDK_12.2.0_f012efa\examples\ble_peripheral\experimental_ble_app_buttonless_dfu\pca10028\s130\arm5_no_packs\_build\nrf51422_xxac.hex"
set BL_SOURCE="C:\Nordic\nRF5_SDK_12.2.0_f012efa\examples\dfu\bootloader_secure\pca10028\arm5_no_packs\_build\nrf51422_xxac_s130.hex"
set SD_SOURCE="C:\Nordic\nRF5_SDK_12.2.0_f012efa\components\softdevice\s130\hex\s130_nrf51_2.0.1_softdevice.hex"

set CHIP=nrf51422

rem 51 or 52
set SECURE_HW_VERSION=51
set SECURE_BL_VERSION=101

rem NRF51 or NRF52 or NRF52840 for Secure DFU, empty for Legacy DFU
set FAMILY=NRF51
set SDK=12.2
set SD_ID=0x87

rem NRF51 or NRF52 or NRF52840 for Secure DFU, empty for Legacy DFU or if no next SDK exist
set FROM_FAMILY=
set FROM_SDK=
set FROM_SD_ID=

rem -- Don't change --
set SECURE_APP_VERSION=1
set SECURE_BL_SETTINGS_VERSION=1
set LEGACY_APP_VERSION=0xFFFFFFFF
set LEGACY_DEV_TYPE=0xFFFF
set LEGACY_DEV_REVISION=0xFFFF
set LEGACY_SD_ID_ALL=0xFFFE

set LOCAL_BL_SETTINGS_HEX=bl_settings.hex

rem -- Import global --
call ..\..\vars.bat