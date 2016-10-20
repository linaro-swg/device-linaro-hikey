Bootloader is build with ArmTF and UEFI from sources located at:
  device/linaro/bootloader
To build fip.bin and l-loader.bin do:
  $ cd device/linaro/hikey/bootloader
  $ make
Results will be in out/dist

To build a bootloader with OPTEE support enabled set the TARGET_TEE_IS_OPTEE
make flag:
  $ make TARGET_TEE_IS_OPTEE=true

We can also generate ptable (needs root privilege) with below commands:
  $ cd device/linaro/hikey/l-loader/
  $ make ptable.img
