# !/bin/bash
##########################################################################
#Copyright 2019 SKYHAWK RECOVERY PROJECT
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
##########################################################################

# Get current working dir
#
dir="$(pwd)"
target="/data/local/twrp-install/boot.img"
#
# SHRP VARIABLES
SHRP_MAINTAINER_TMP=$(sed -n '1p' "$(pwd)/build/shrp/variables")
SHRP_DEVICE_TMP=$(sed -n '2p' "$(pwd)/build/shrp/variables")
SHRP_EDL_MODE_TMP=$(sed -n '3p' "$(pwd)/build/shrp/variables")
SHRP_EXTERNAL_TMP=$(sed -n '4p' "$(pwd)/build/shrp/variables")
SHRP_INTERNAL_TMP=$(sed -n '5p' "$(pwd)/build/shrp/variables")
SHRP_OTG_TMP=$(sed -n '6p' "$(pwd)/build/shrp/variables")
SHRP_FLASH_TMP=$(sed -n '7p' "$(pwd)/build/shrp/variables")
SHRP_FLASH_MAX_BRIGHTNESS_TMP=$(sed -n '8p' "$(pwd)/build/shrp/variables")
SHRP_FONP_1_TMP=$(sed -n '9p' "$(pwd)/build/shrp/variables")
SHRP_FONP_2_TMP=$(sed -n '10p' "$(pwd)/build/shrp/variables")
SHRP_FONP_3_TMP=$(sed -n '11p' "$(pwd)/build/shrp/variables")

SHRP_MAINTAINER=$SHRP_MAINTAINER_TMP
SHRP_DEVICE=$SHRP_DEVICE_TMP
SHRP_EDL_MODE=$SHRP_EDL_MODE_TMP
SHRP_EXTERNAL=$SHRP_EXTERNAL_TMP
SHRP_INTERNAL=$SHRP_INTERNAL_TMP
SHRP_OTG=$SHRP_OTG_TMP
SHRP_FLASH=$SHRP_FLASH_TMP
SHRP_FLASH_MAX_BRIGHTNESS=$SHRP_FLASH_MAX_BRIGHTNESS_TMP
SHRP_FONP_1=$SHRP_FONP_1_TMP
SHRP_FONP_2=$SHRP_FONP_2_TMP
SHRP_FONP_3=$SHRP_FONP_3_TMP

tool="/data/local/twrp-install/magiskboot"

cat > "${dir}"/build/shrp/update-binary-b <<EOF
ui_print("                                            _ _ __");
ui_print("   __ __ __  _ __ _  __ _            __   /_ _   /");
ui_print("  / _ _// / / / __ \/ __ \   __     / /   _ __/ / ");
ui_print("  \__ \/ /_/ / /_/ / /_/ /   \ \   / /  / _ _ _/  ");
ui_print(" ___/ / __  / _, _/ ____/     \ \_/ /  / /_ _     ");
ui_print("/__ _/_/ /_/_/ |_/_/           \__ /  /__ __/     ");
ui_print("                                                  ");
ui_print("                                                  ");
ui_print("                                                  ");
sleep(2);
ui_print("Skyhawk Recovery Project                          ");
ui_print("--------------------------------------------------");
ui_print("Details-                                          ");
ui_print("SHRP version - 2.2 Beta                           ");
ui_print("Device - $SHRP_DEVICE");
ui_print("Maintainer - $SHRP_MAINTAINER");
ui_print("                                                  ");
ui_print("                                                  ");
ui_print("Installing Addons...");
ui_print("--------------------------------------------------");
delete_recursive("/sdcard/SHRP");
package_extract_dir("Files", "/sdcard/");
set_progress(0.500000);
ui_print("                                                  ");
ui_print("                                                  ");
sleep(2);
ui_print("Flashing Recovery...");
ui_print("--------------------------------------------------");

EOF

cat > "${dir}"/build/shrp/update-binary-c <<EOF
tool="/data/local/twrp-install/magiskboot"
dd if=/dev/block/bootdevice/by-name/boot_a "of=$target"
"$tool" unpack -h boot.img
cp -f ramdisk-recovery.cpio ramdisk.cpio
"$tool" repack boot.img new-boot.img
dd if=new-boot.img of=/dev/block/bootdevice/by-name/boot_a
rm boot.img
rm dtb
rm kernel
rm new-boot.img
rm ramdisk.cpio
ui_print("Running boot image patcher on slot B...");
dd if=/dev/block/bootdevice/by-name/boot_b "of=$target"
"$tool" unpack -h boot.img
cp -f ramdisk-recovery.cpio ramdisk.cpio
"$tool" repack boot.img new-boot.img
dd if=new-boot.img of=/dev/block/bootdevice/by-name/boot_b
sleep(1);

EOF

cat > "${dir}"/build/shrp/update-binary-d <<EOF
ui_print("                                                  ");
ui_print("                                                  ");
set_progress(0.700000);
ui_print("Installation Completed                            ");
ui_print("--------------------------------------------------");
ui_print("                                                  ");
ui_print("                                                  ");
ui_print("Credits,                                          ");
ui_print("--------------------------------------------------");
ui_print("                                                  ");
ui_print("epicX | Dni9 | Giovix92 | osmOsis | Teamwin | VR25");
ui_print("                                                  ");
ui_print("                                                  ");
ui_print("Special thanks to,                                ");
ui_print("--------------------------------------------------");
ui_print("                                                  ");
ui_print("Pritish joshi | Kirill | Others                   ");
ui_print("                                                  ");
ui_print("                                                  ");
ui_print("Contact Us,                       ");
ui_print("--------------------------------------------------");
ui_print("Our Website- http://shrp.cf                       ");
ui_print("Our Telegram Group- t.me/sky_hawk                 ");
ui_print("YT Channel- youtube.com/epicspicy                 ");
set_progress(1.000000);
ui_print("");

EOF
