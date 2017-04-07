@echo off

rem -- Load local vars --
call vars.bat

mkdir %SRC_FOLDER%

rem copy bootloader
copy /Y %BL_SOURCE% %SRC_FOLDER%\%BOOTLOADER_HEX%

rem copy app
if not "%APP_SOURCE%"=="" (
	copy /Y %APP_SOURCE% %SRC_FOLDER%\%APP_HEX%
)

rem copy SD
copy /Y %SD_SOURCE% %SRC_FOLDER%\%SOFTDEVICE_HEX%

call "..\..\gen output.bat"
call "..\..\gen zips.bat"