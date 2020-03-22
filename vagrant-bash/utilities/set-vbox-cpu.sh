#!/bin/bash -x
# https://superuser.com/questions/625648/virtualbox-how-to-force-a-specific-cpu-to-the-guest

export vm=vapoursynth-vbox
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000002/eax 0x65746e49
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000002/ebx 0x2952286c
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000002/ecx 0x726f4320
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000002/edx 0x4d542865
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000003/eax 0x43203229
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000003/ebx 0x20205550
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000003/ecx 0x20202020
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000003/edx 0x20202020
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000004/eax 0x30303636
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000004/ebx 0x20402020
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000004/ecx 0x30342e32
# vboxmanage setextradata $vm VBoxInternal/CPUM/HostCPUID/80000004/edx 0x007a4847

# https://forums.virtualbox.org/viewtopic.php?f=6&t=84423
#VBoxManage modifyvm $vm --cpu-profile "Intel Xeon X5482 3.20GHz"
# VBoxManage modifyvm $vm --cpu-profile "Intel Core i7-2635QM"
#VBoxManage modifyvm $vm --cpu-profile "Intel Core i7-3960X"
#VBoxManage modifyvm $vm --cpu-profile "Intel Core i5-3570"
# VBoxManage modifyvm $vm --cpu-profile "Intel Core i7-5600U"
# VBoxManage modifyvm $vm --cpu-profile "Intel Core i7-6700K"
VBoxManage modifyvm $vm --cpu-profile ""
