<b><u>A simple x86 bootloader</u></b>
when you turn on comp the processor looks for address 0xFFFFFFF0 for bios code
which is in a ROM secrion in the computer
The bios posts in search of a boot medium a medium is said to be bootable if the
the first 512bytes are readable and ends exactly with 0x55AA
if the bios deems a given drive bootable it loads the first 512bytes in memory address
0x007C00 and transfers controll to this address through a jump instruction to the processor.
check on MBR(master boot record)

processor will be running in real mode rather than protected mode
in real mode memory is addressed as logical address rather than physical address therefore
we will use segment registers(which are used to store the beggining of a 64k segment of memory.)

