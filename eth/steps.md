## 以太网在不接电源的时候重启后不能上网

### TL,DR
* 笔记本：`ThinkPad E570`
* 网卡：`04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)`

* 以太网使用电池时不能上以太网
* 加入`pcie_aspm=force`参数后可以
* 问题：看到这个参数不能随便加，得符合条件，查得不符合添加的条件。
* 寻求的帮助：
1. 是否是因为 `ASPM` 的因素导致不能上网，以及为什么。
2. 是否可以加这个参数，后果是什么。
3. 有没有别的优雅的解决办法。


### 详细操作
1. `dhcpcd` 超时，尝试重新载入模块
```sh
modprobe -r r8169
modprobe r8169
```
`dmesg`发现的可能有问题的是这行
```dmesg
[  152.718320] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
```
2. 上网搜到了gentoo上的这篇[文章](https://forums.gentoo.org/viewtopic-t-1061944-start-0.html)，然后加上了`pcie_aspm=force`这个内核参数，就可以了。
3. 但是在[这里](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/power_management_guide/aspm)又说要注意
```
If pcie_aspm=force is set, hardware that does not support ASPM can cause the system to stop responding. Before setting pcie_aspm=force, ensure that all PCIe hardware on the system supports ASPM.
```
4. [这里又说](https://wiki.archlinux.org/index.php/ASUS_Zenbook_UX31E)如果有下面这行，就不要添加这个内核参数，我有[捂脸]。

```
ACPI FADT declares the system does not support PCIe ASPM, so disable it.
```

### 其他详细信息
#### `lspci -vvk`
```
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)
	Subsystem: Lenovo Device 505b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at c000 [size=256]
	Region 2: Memory at f4204000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at f4200000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: r8169
	Kernel modules: r8169
```

#### `dmesg` 详细
##### 未加`pcie_aspm=force`内核参数的 `dmesg`

```dmesg
[    0.000000] microcode: microcode updated early to revision 0xde, date = 2020-05-27
[    0.000000] Linux version 5.9.14-arch1-1 (linux@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Sat, 12 Dec 2020 14:37:12 +0000
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux root=UUID=bdc8b6ae-23bf-4301-aefe-bb42097a1aac rw loglevel=3 quiet audit=0 resume=UUID=a9954611-ed3c-457e-a4c6-a172842483e1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b0dfcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b0dfd000-0x00000000b0dfdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b0dfe000-0x00000000b0dfefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0dff000-0x00000000ba764fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ba765000-0x00000000ba816fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ba817000-0x00000000bbe49fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bbe4a000-0x00000000bbe4afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bbe4b000-0x00000000bbe4bfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bbe4c000-0x00000000bbe99fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bbe9a000-0x00000000bbefefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bbeff000-0x00000000bbefffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bbf00000-0x00000000bf7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: SMBIOS=0xbba45000 SMBIOS 3.0=0xbba43000 ACPI=0xbbefe000 ACPI 2.0=0xbbefe014 ESRT=0xbaa78000 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20H5A000CD/20H5A000CD, BIOS R0DET84W (1.84 ) 07/21/2017
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.001609] tsc: Detected 2699.909 MHz TSC
[    0.001609] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001613] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001626] last_pfn = 0x23f800 max_arch_pfn = 0x400000000
[    0.001633] MTRR default type: write-back
[    0.001634] MTRR fixed ranges enabled:
[    0.001637]   00000-9FFFF write-back
[    0.001638]   A0000-BFFFF uncachable
[    0.001640]   C0000-FFFFF write-protect
[    0.001641] MTRR variable ranges enabled:
[    0.001644]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001646]   1 base 00BE000000 mask 7FFE000000 uncachable
[    0.001648]   2 base 00BD000000 mask 7FFF000000 uncachable
[    0.001649]   3 disabled
[    0.001650]   4 disabled
[    0.001651]   5 disabled
[    0.001652]   6 disabled
[    0.001653]   7 disabled
[    0.001654]   8 disabled
[    0.001655]   9 disabled
[    0.002524] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002962] last_pfn = 0xbbf00 max_arch_pfn = 0x400000000
[    0.021548] esrt: Reserving ESRT space from 0x00000000baa78000 to 0x00000000baa78060.
[    0.021559] check: Scanning 1 areas for low memory corruption
[    0.021567] Using GB pages for direct mapping
[    0.022683] Secure boot could not be determined
[    0.022685] RAMDISK: [mem 0x36a03000-0x374f8fff]
[    0.022696] ACPI: Early table checksum verification disabled
[    0.022700] ACPI: RSDP 0x00000000BBEFE014 000024 (v02 LENOVO)
[    0.022711] ACPI: XSDT 0x00000000BBECE188 0000D4 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022726] ACPI: FACP 0x00000000BBEF7000 0000F4 (v05 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022736] ACPI: DSDT 0x00000000BBEDF000 01316C (v02 LENOVO TP-R0D   00000840 INTL 20160422)
[    0.022742] ACPI: FACS 0x00000000BBE76000 000040
[    0.022746] ACPI: UEFI 0x00000000BBE8C000 000042 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022751] ACPI: SSDT 0x00000000BBEF9000 003245 (v02 LENOVO SaSsdt   00003000 INTL 20160422)
[    0.022756] ACPI: SSDT 0x00000000BBEF8000 00075C (v02 LENOVO PerfTune 00001000 INTL 20160422)
[    0.022761] ACPI: HPET 0x00000000BBEF6000 000038 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022766] ACPI: APIC 0x00000000BBEF5000 0000BC (v03 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022771] ACPI: MCFG 0x00000000BBEF4000 00003C (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022775] ACPI: ECDT 0x00000000BBEF3000 000052 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022780] ACPI: SSDT 0x00000000BBEDC000 002DED (v01 LENOVO SataAhci 00001000 INTL 20160422)
[    0.022785] ACPI: BOOT 0x00000000BBEDB000 000028 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022789] ACPI: BATB 0x00000000BBEDA000 00004A (v02 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022794] ACPI: SSDT 0x00000000BBED9000 000EE0 (v02 LENOVO CpuSsdt  00003000 INTL 20160422)
[    0.022799] ACPI: SSDT 0x00000000BBED8000 0004FC (v02 LENOVO CtdpB    00001000 INTL 20160422)
[    0.022804] ACPI: DBGP 0x00000000BBED7000 000034 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022808] ACPI: DBG2 0x00000000BBED6000 000054 (v00 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022813] ACPI: MSDM 0x00000000BBED5000 000055 (v03 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022817] ACPI: SSDT 0x00000000BBED4000 00006C (v01 LENOVO NvOptTbl 00001000 INTL 20160422)
[    0.022822] ACPI: SSDT 0x00000000BBED2000 001728 (v02 LENOVO SgUlt    00001000 INTL 20160422)
[    0.022827] ACPI: SSDT 0x00000000BBED1000 000024 (v02 LENOVO SgPch    00001000 INTL 20160422)
[    0.022832] ACPI: DMAR 0x00000000BBED0000 0000A8 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022836] ACPI: FPDT 0x00000000BBECF000 000044 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022841] ACPI: UEFI 0x00000000BBE4D000 00013E (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022854] ACPI: Local APIC address 0xfee00000
[    0.022965] No NUMA configuration found
[    0.022967] Faking a node at [mem 0x0000000000000000-0x000000023f7fffff]
[    0.022972] NODE_DATA(0) allocated [mem 0x23f7fa000-0x23f7fdfff]
[    0.023017] Zone ranges:
[    0.023018]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.023021]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.023022]   Normal   [mem 0x0000000100000000-0x000000023f7fffff]
[    0.023024]   Device   empty
[    0.023026] Movable zone start for each node
[    0.023027] Early memory node ranges
[    0.023029]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.023030]   node   0: [mem 0x0000000000059000-0x000000000008bfff]
[    0.023031]   node   0: [mem 0x0000000000100000-0x00000000b0dfcfff]
[    0.023033]   node   0: [mem 0x00000000b0dff000-0x00000000ba764fff]
[    0.023034]   node   0: [mem 0x00000000bbeff000-0x00000000bbefffff]
[    0.023035]   node   0: [mem 0x0000000100000000-0x000000023f7fffff]
[    0.023427] Zeroed struct page in unavailable ranges: 24850 pages
[    0.023429] Initmem setup node 0 [mem 0x0000000000001000-0x000000023f7fffff]
[    0.023432] On node 0 totalpages: 2072302
[    0.023433]   DMA zone: 64 pages used for memmap
[    0.023435]   DMA zone: 72 pages reserved
[    0.023436]   DMA zone: 3978 pages, LIFO batch:0
[    0.023476]   DMA32 zone: 11870 pages used for memmap
[    0.023478]   DMA32 zone: 759652 pages, LIFO batch:63
[    0.030914]   Normal zone: 20448 pages used for memmap
[    0.030915]   Normal zone: 1308672 pages, LIFO batch:63
[    0.043741] Reserving Intel graphics memory at [mem 0xbd800000-0xbf7fffff]
[    0.044186] ACPI: PM-Timer IO Port: 0x1808
[    0.044188] ACPI: Local APIC address 0xfee00000
[    0.044199] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.044200] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.044201] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.044202] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.044203] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.044204] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.044205] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.044206] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.044236] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.044239] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.044242] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.044244] ACPI: IRQ0 used by override.
[    0.044246] ACPI: IRQ9 used by override.
[    0.044250] Using ACPI (MADT) for SMP configuration information
[    0.044253] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.044257] TSC deadline timer available
[    0.044259] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.044291] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.044294] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.044297] PM: hibernation: Registered nosave memory: [mem 0x0008c000-0x000fffff]
[    0.044299] PM: hibernation: Registered nosave memory: [mem 0xb0dfd000-0xb0dfdfff]
[    0.044300] PM: hibernation: Registered nosave memory: [mem 0xb0dfe000-0xb0dfefff]
[    0.044303] PM: hibernation: Registered nosave memory: [mem 0xba765000-0xba816fff]
[    0.044304] PM: hibernation: Registered nosave memory: [mem 0xba817000-0xbbe49fff]
[    0.044305] PM: hibernation: Registered nosave memory: [mem 0xbbe4a000-0xbbe4afff]
[    0.044306] PM: hibernation: Registered nosave memory: [mem 0xbbe4b000-0xbbe4bfff]
[    0.044307] PM: hibernation: Registered nosave memory: [mem 0xbbe4c000-0xbbe99fff]
[    0.044308] PM: hibernation: Registered nosave memory: [mem 0xbbe9a000-0xbbefefff]
[    0.044311] PM: hibernation: Registered nosave memory: [mem 0xbbf00000-0xbf7fffff]
[    0.044312] PM: hibernation: Registered nosave memory: [mem 0xbf800000-0xf80f9fff]
[    0.044313] PM: hibernation: Registered nosave memory: [mem 0xf80fa000-0xf80fafff]
[    0.044314] PM: hibernation: Registered nosave memory: [mem 0xf80fb000-0xf80fcfff]
[    0.044315] PM: hibernation: Registered nosave memory: [mem 0xf80fd000-0xf80fdfff]
[    0.044316] PM: hibernation: Registered nosave memory: [mem 0xf80fe000-0xfdffffff]
[    0.044317] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.044318] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.044321] [mem 0xbf800000-0xf80f9fff] available for PCI devices
[    0.044323] Booting paravirtualized kernel on bare hardware
[    0.044333] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.054835] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:4 nr_node_ids:1
[    0.055095] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u524288
[    0.055105] pcpu-alloc: s192512 r8192 d28672 u524288 alloc=1*2097152
[    0.055107] pcpu-alloc: [0] 0 1 2 3 
[    0.055139] Built 1 zonelists, mobility grouping on.  Total pages: 2039848
[    0.055140] Policy zone: Normal
[    0.055142] Kernel command line: BOOT_IMAGE=/vmlinuz-linux root=UUID=bdc8b6ae-23bf-4301-aefe-bb42097a1aac rw loglevel=3 quiet audit=0 resume=UUID=a9954611-ed3c-457e-a4c6-a172842483e1
[    0.055248] audit: disabled (until reboot)
[    0.056083] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.056483] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.056568] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
[    0.090933] Memory: 7944244K/8289208K available (14339K kernel code, 1505K rwdata, 7952K rodata, 1660K init, 2944K bss, 344704K reserved, 0K cma-reserved)
[    0.090945] random: get_random_u64 called from __kmem_cache_create+0x26/0x520 with crng_init=0
[    0.091205] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.091234] Kernel/User page tables isolation: enabled
[    0.091271] ftrace: allocating 40888 entries in 160 pages
[    0.122808] ftrace: allocated 160 pages with 2 groups
[    0.122983] rcu: Preemptible hierarchical RCU implementation.
[    0.122984] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.122986] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=4.
[    0.122987] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.122989] 	Trampoline variant of Tasks RCU enabled.
[    0.122990] 	Rude variant of Tasks RCU enabled.
[    0.122991] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.122992] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.129314] NR_IRQS: 20736, nr_irqs: 1024, preallocated irqs: 16
[    0.130236] Console: colour dummy device 80x25
[    0.130242] printk: console [tty0] enabled
[    0.130274] ACPI: Core revision 20200717
[    0.130711] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.130792] APIC: Switch to symmetric I/O mode setup
[    0.130795] DMAR: Host address width 39
[    0.130797] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.130807] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.130809] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.130815] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.130817] DMAR: RMRR base: 0x000000bbde3000 end: 0x000000bbe02fff
[    0.130819] DMAR: RMRR base: 0x000000bd000000 end: 0x000000bf7fffff
[    0.130823] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.130824] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.130826] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.132562] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.132564] x2apic enabled
[    0.132579] Switched APIC routing to cluster x2apic.
[    0.136717] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.150851] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26eae8729ef, max_idle_ns: 440795235156 ns
[    0.150858] Calibrating delay loop (skipped), value calculated using timer frequency.. 5401.81 BogoMIPS (lpj=8999696)
[    0.150862] pid_max: default: 32768 minimum: 301
[    0.157235] LSM: Security Framework initializing
[    0.157242] Yama: becoming mindful.
[    0.157291] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.157312] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.157816] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.157848] process: using mwait in idle threads
[    0.157852] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.157854] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.157858] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.157860] Spectre V2 : Mitigation: Full generic retpoline
[    0.157861] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.157862] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.157864] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.157865] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.157867] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.157877] SRBDS: Mitigation: Microcode
[    0.157877] MDS: Mitigation: Clear CPU buffers
[    0.158371] Freeing SMP alternatives memory: 32K
[    0.161009] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.161196] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.161213] ... version:                4
[    0.161215] ... bit width:              48
[    0.161215] ... generic registers:      4
[    0.161217] ... value mask:             0000ffffffffffff
[    0.161218] ... max period:             00007fffffffffff
[    0.161219] ... fixed-purpose events:   3
[    0.161220] ... event mask:             000000070000000f
[    0.161313] rcu: Hierarchical SRCU implementation.
[    0.162162] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.162259] smp: Bringing up secondary CPUs ...
[    0.162470] x86: Booting SMP configuration:
[    0.162472] .... node  #0, CPUs:      #1 #2
[    0.168595] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.168595]  #3
[    0.168595] smp: Brought up 1 node, 4 CPUs
[    0.168595] smpboot: Max logical packages: 1
[    0.168595] smpboot: Total of 4 processors activated (21607.24 BogoMIPS)
[    0.171259] devtmpfs: initialized
[    0.171259] x86/mm: Memory block size: 128MB
[    0.172367] PM: Registering ACPI NVS region [mem 0xb0dfd000-0xb0dfdfff] (4096 bytes)
[    0.172367] PM: Registering ACPI NVS region [mem 0xbbe4a000-0xbbe4afff] (4096 bytes)
[    0.172367] PM: Registering ACPI NVS region [mem 0xbbe4c000-0xbbe99fff] (319488 bytes)
[    0.172367] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.172367] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.172367] pinctrl core: initialized pinctrl subsystem
[    0.172367] PM: RTC time: 15:03:09, date: 2020-12-24
[    0.172367] NET: Registered protocol family 16
[    0.174293] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.174442] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.174595] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.174862] thermal_sys: Registered thermal governor 'fair_share'
[    0.174864] thermal_sys: Registered thermal governor 'bang_bang'
[    0.174865] thermal_sys: Registered thermal governor 'step_wise'
[    0.174866] thermal_sys: Registered thermal governor 'user_space'
[    0.174868] thermal_sys: Registered thermal governor 'power_allocator'
[    0.174906] cpuidle: using governor ladder
[    0.174906] cpuidle: using governor menu
[    0.174906] Simple Boot Flag at 0x47 set to 0x1
[    0.174906] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.174906] ACPI: bus type PCI registered
[    0.174906] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.174906] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.174906] PCI: not using MMCONFIG
[    0.174906] PCI: Using configuration type 1 for base access
[    0.175034] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.178923] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.178923] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.181094] ACPI: Added _OSI(Module Device)
[    0.181096] ACPI: Added _OSI(Processor Device)
[    0.181097] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.181099] ACPI: Added _OSI(Processor Aggregator Device)
[    0.181101] ACPI: Added _OSI(Linux-Dell-Video)
[    0.181102] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.181104] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.257050] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.259603] ACPI: EC: EC started
[    0.259604] ACPI: EC: interrupt blocked
[    0.263139] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.263140] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.264293] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.291151] ACPI: Dynamic OEM Table Load:
[    0.291172] ACPI: SSDT 0xFFFF9215F5F8A000 00084F (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.294219] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.296024] ACPI: Dynamic OEM Table Load:
[    0.296036] ACPI: SSDT 0xFFFF9215F5A46800 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.299805] ACPI: Dynamic OEM Table Load:
[    0.299818] ACPI: SSDT 0xFFFF9215F545C000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.303398] ACPI: Dynamic OEM Table Load:
[    0.303408] ACPI: SSDT 0xFFFF9215F5A43400 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.308520] ACPI: Interpreter enabled
[    0.308619] ACPI: (supports S0 S3 S4 S5)
[    0.308621] ACPI: Using IOAPIC for interrupt routing
[    0.308681] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.309747] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    0.309762] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.310373] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.324188] ACPI: Power Resource [PUBS] (on)
[    0.335473] ACPI: Power Resource [PC01] (on)
[    0.337521] ACPI: Power Resource [WRST] (on)
[    0.367411] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.367629] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11)
[    0.367832] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[    0.368033] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.368233] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.368433] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.368632] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[    0.368832] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.369042] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.369051] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.369309] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug PCIeCapability LTR DPC]
[    0.369424] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.369428] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.369430] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    0.369432] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.371366] PCI host bridge to bus 0000:00
[    0.371370] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.371372] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.371374] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.371376] pci_bus 0000:00: root bus resource [mem 0xbf800000-0xfeafffff window]
[    0.371379] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.371401] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.372333] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    0.372350] pci 0000:00:02.0: reg 0x10: [mem 0xf2000000-0xf2ffffff 64bit]
[    0.372361] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.372369] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.372399] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.373453] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.373479] pci 0000:00:14.0: reg 0x10: [mem 0xf4500000-0xf450ffff 64bit]
[    0.373582] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.374950] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.374976] pci 0000:00:14.2: reg 0x10: [mem 0xf452a000-0xf452afff 64bit]
[    0.375956] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.375984] pci 0000:00:16.0: reg 0x10: [mem 0xf452b000-0xf452bfff 64bit]
[    0.376086] pci 0000:00:16.0: PME# supported from D3hot
[    0.377268] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    0.377288] pci 0000:00:17.0: reg 0x10: [mem 0xf4528000-0xf4529fff]
[    0.377300] pci 0000:00:17.0: reg 0x14: [mem 0xf452e000-0xf452e0ff]
[    0.377311] pci 0000:00:17.0: reg 0x18: [io  0xe080-0xe087]
[    0.377322] pci 0000:00:17.0: reg 0x1c: [io  0xe088-0xe08b]
[    0.377333] pci 0000:00:17.0: reg 0x20: [io  0xe060-0xe07f]
[    0.377344] pci 0000:00:17.0: reg 0x24: [mem 0xf452c000-0xf452c7ff]
[    0.377408] pci 0000:00:17.0: PME# supported from D3hot
[    0.378612] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.378727] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.380021] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.380151] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.381473] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.381589] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.382884] pci 0000:00:1d.2: [8086:9d1a] type 01 class 0x060400
[    0.382997] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.384297] pci 0000:00:1d.3: [8086:9d1b] type 01 class 0x060400
[    0.384413] pci 0000:00:1d.3: PME# supported from D0 D3hot D3cold
[    0.385720] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    0.387001] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.387020] pci 0000:00:1f.2: reg 0x10: [mem 0xf4524000-0xf4527fff]
[    0.388246] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.388278] pci 0000:00:1f.3: reg 0x10: [mem 0xf4520000-0xf4523fff 64bit]
[    0.388321] pci 0000:00:1f.3: reg 0x20: [mem 0xf4510000-0xf451ffff 64bit]
[    0.388393] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.389574] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.389626] pci 0000:00:1f.4: reg 0x10: [mem 0xf452d000-0xf452d0ff 64bit]
[    0.389678] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.390854] pci 0000:01:00.0: [10de:134d] type 00 class 0x030200
[    0.390854] pci 0000:01:00.0: reg 0x10: [mem 0xf3000000-0xf3ffffff]
[    0.390854] pci 0000:01:00.0: reg 0x14: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.390854] pci 0000:01:00.0: reg 0x1c: [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.390854] pci 0000:01:00.0: reg 0x24: [io  0xd000-0xd07f]
[    0.390854] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.390854] pci 0000:01:00.0: Enabling HDA controller
[    0.390854] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.390854] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.390854] pci 0000:00:1c.0:   bridge window [mem 0xf3000000-0xf3ffffff]
[    0.390854] pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.390854] pci 0000:02:00.0: [1217:8621] type 00 class 0x080501
[    0.390854] pci 0000:02:00.0: reg 0x10: [mem 0xf4401000-0xf4401fff]
[    0.390854] pci 0000:02:00.0: reg 0x14: [mem 0xf4400000-0xf44007ff]
[    0.390854] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.404310] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.404316] pci 0000:00:1c.4:   bridge window [mem 0xf4400000-0xf44fffff]
[    0.404654] pci 0000:03:00.0: [126f:2262] type 00 class 0x010802
[    0.404683] pci 0000:03:00.0: reg 0x10: [mem 0xf4300000-0xf4303fff 64bit]
[    0.404892] pci 0000:03:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1d.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.405060] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    0.405066] pci 0000:00:1d.0:   bridge window [mem 0xf4300000-0xf43fffff]
[    0.405216] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.405300] pci 0000:04:00.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.405411] pci 0000:04:00.0: reg 0x18: [mem 0xf4204000-0xf4204fff 64bit]
[    0.405482] pci 0000:04:00.0: reg 0x20: [mem 0xf4200000-0xf4203fff 64bit]
[    0.405845] pci 0000:04:00.0: supports D1 D2
[    0.405847] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.406214] pci 0000:00:1d.2: PCI bridge to [bus 04]
[    0.406219] pci 0000:00:1d.2:   bridge window [io  0xc000-0xcfff]
[    0.406223] pci 0000:00:1d.2:   bridge window [mem 0xf4200000-0xf42fffff]
[    0.406471] pci 0000:05:00.0: [168c:0042] type 00 class 0x028000
[    0.406519] pci 0000:05:00.0: reg 0x10: [mem 0xf4000000-0xf41fffff 64bit]
[    0.406871] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.407290] pci 0000:00:1d.3: PCI bridge to [bus 05]
[    0.407297] pci 0000:00:1d.3:   bridge window [mem 0xf4000000-0xf41fffff]
[    0.414195] ACPI: EC: interrupt unblocked
[    0.414195] ACPI: EC: event unblocked
[    0.414195] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.414195] ACPI: EC: GPE=0x20
[    0.414195] ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
[    0.414195] ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
[    0.414195] iommu: Default domain type: Translated 
[    0.414209] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.414209] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.414210] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.414212] vgaarb: loaded
[    0.414509] SCSI subsystem initialized
[    0.414534] libata version 3.00 loaded.
[    0.414534] ACPI: bus type USB registered
[    0.414534] usbcore: registered new interface driver usbfs
[    0.414534] usbcore: registered new interface driver hub
[    0.414534] usbcore: registered new device driver usb
[    0.414534] pps_core: LinuxPPS API ver. 1 registered
[    0.414534] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.414534] PTP clock support registered
[    0.414534] EDAC MC: Ver: 3.0.0
[    0.414668] Registered efivars operations
[    0.414668] NetLabel: Initializing
[    0.414668] NetLabel:  domain hash size = 128
[    0.414668] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.414668] NetLabel:  unlabeled traffic allowed by default
[    0.414668] PCI: Using ACPI for IRQ routing
[    0.419187] PCI: pci_cache_line_size set to 64 bytes
[    0.419652] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.419654] e820: reserve RAM buffer [mem 0x0008c000-0x0008ffff]
[    0.419656] e820: reserve RAM buffer [mem 0xb0dfd000-0xb3ffffff]
[    0.419658] e820: reserve RAM buffer [mem 0xba765000-0xbbffffff]
[    0.419660] e820: reserve RAM buffer [mem 0xbbf00000-0xbbffffff]
[    0.419661] e820: reserve RAM buffer [mem 0x23f800000-0x23fffffff]
[    0.422234] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.422241] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.424193] clocksource: Switched to clocksource tsc-early
[    0.445584] VFS: Disk quotas dquot_6.6.0
[    0.445605] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.445721] pnp: PnP ACPI init
[    0.446757] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.446760] system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
[    0.446762] system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
[    0.446765] system 00:00: [mem 0x000c8000-0x000cbfff] could not be reserved
[    0.446767] system 00:00: [mem 0x000cc000-0x000cffff] could not be reserved
[    0.446769] system 00:00: [mem 0x000d0000-0x000d3fff] could not be reserved
[    0.446771] system 00:00: [mem 0x000d4000-0x000d7fff] could not be reserved
[    0.446773] system 00:00: [mem 0x000d8000-0x000dbfff] could not be reserved
[    0.446775] system 00:00: [mem 0x000dc000-0x000dffff] could not be reserved
[    0.446777] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
[    0.446780] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
[    0.446782] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
[    0.446784] system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
[    0.446786] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.446788] system 00:00: [mem 0x00100000-0xbf7fffff] could not be reserved
[    0.446791] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.446794] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.446803] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.447076] system 00:01: [io  0x1800-0x189f] has been reserved
[    0.447078] system 00:01: [io  0x1600-0x167f] has been reserved
[    0.447082] system 00:01: [mem 0xf8000000-0xfbffffff] could not be reserved
[    0.447084] system 00:01: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.447086] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.447089] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.447091] system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.447093] system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.447096] system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.447098] system 00:01: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.447105] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.447251] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.447285] pnp 00:03: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.447314] pnp 00:04: Plug and Play ACPI device, IDs LEN2043 PNP0f13 (active)
[    0.447395] system 00:05: [io  0x1854-0x1857] has been reserved
[    0.447401] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.448570] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.448573] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.448575] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.448578] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.448580] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.448583] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.448585] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.448591] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.449289] system 00:07: [io  0xff00-0xfffe] has been reserved
[    0.449296] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.449452] pnp: PnP ACPI: found 8 devices
[    0.456447] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.456552] NET: Registered protocol family 2
[    0.456809] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.456882] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.457100] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.457236] TCP: Hash tables configured (established 65536 bind 65536)
[    0.457325] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.457382] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.457422] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.457558] NET: Registered protocol family 1
[    0.457565] NET: Registered protocol family 44
[    0.457575] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    0.457593] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00080000 pref]
[    0.457595] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x00080000 pref]
[    0.457605] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.457616] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.457622] pci 0000:00:1c.0:   bridge window [mem 0xf3000000-0xf3ffffff]
[    0.457626] pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.457633] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.457640] pci 0000:00:1c.4:   bridge window [mem 0xf4400000-0xf44fffff]
[    0.457650] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    0.457655] pci 0000:00:1d.0:   bridge window [mem 0xf4300000-0xf43fffff]
[    0.457664] pci 0000:00:1d.2: PCI bridge to [bus 04]
[    0.457667] pci 0000:00:1d.2:   bridge window [io  0xc000-0xcfff]
[    0.457672] pci 0000:00:1d.2:   bridge window [mem 0xf4200000-0xf42fffff]
[    0.457680] pci 0000:00:1d.3: PCI bridge to [bus 05]
[    0.457685] pci 0000:00:1d.3:   bridge window [mem 0xf4000000-0xf41fffff]
[    0.457696] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.457698] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.457700] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.457702] pci_bus 0000:00: resource 7 [mem 0xbf800000-0xfeafffff window]
[    0.457705] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.457706] pci_bus 0000:01: resource 1 [mem 0xf3000000-0xf3ffffff]
[    0.457708] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.457710] pci_bus 0000:02: resource 1 [mem 0xf4400000-0xf44fffff]
[    0.457712] pci_bus 0000:03: resource 1 [mem 0xf4300000-0xf43fffff]
[    0.457714] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
[    0.457716] pci_bus 0000:04: resource 1 [mem 0xf4200000-0xf42fffff]
[    0.457718] pci_bus 0000:05: resource 1 [mem 0xf4000000-0xf41fffff]
[    0.457934] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.458694] PCI: CLS 0 bytes, default 64
[    0.458761] Trying to unpack rootfs image as initramfs...
[    0.730686] Freeing initrd memory: 11224K
[    0.730747] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.730750] software IO TLB: mapped [mem 0xab05b000-0xaf05b000] (64MB)
[    0.731006] check: Scanning for low memory corruption every 60 seconds
[    0.731589] Initialise system trusted keyrings
[    0.731618] Key type blacklist registered
[    0.731712] workingset: timestamp_bits=41 max_order=21 bucket_order=0
[    0.734015] zbud: loaded
[    0.753357] Key type asymmetric registered
[    0.753359] Asymmetric key parser 'x509' registered
[    0.753373] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.753444] io scheduler mq-deadline registered
[    0.753446] io scheduler kyber registered
[    0.753493] io scheduler bfq registered
[    0.755533] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.755675] efifb: probing for efifb
[    0.755697] efifb: No BGRT, not showing boot graphics
[    0.755699] efifb: framebuffer at 0xd0000000, using 4160k, total 4160k
[    0.755701] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    0.755702] efifb: scrolling: redraw
[    0.755704] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.755779] fbcon: Deferring console take-over
[    0.755781] fb0: EFI VGA frame buffer device
[    0.755794] intel_idle: MWAIT substates: 0x11142120
[    0.755795] intel_idle: v0.5.1 model 0x8E
[    0.756264] intel_idle: Local APIC timer is reliable in all C-states
[    0.756358] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.764244] ACPI: Lid Switch [LID]
[    0.764324] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.767574] ACPI: Sleep Button [SLPB]
[    0.767677] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.767723] ACPI: Power Button [PWRF]
[    0.777197] thermal LNXTHERM:00: registered as thermal_zone0
[    0.777201] ACPI: Thermal Zone [THM0] (48 C)
[    0.777822] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.779278] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.779279] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    0.780832] nvme nvme0: pci function 0000:03:00.0
[    0.781142] ahci 0000:00:17.0: version 3.0
[    0.781726] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    0.781731] ahci 0000:00:17.0: flags: 64bit ncq led clo only pio slum part deso sadm sds apst 
[    0.782215] scsi host0: ahci
[    0.782346] ata1: SATA max UDMA/133 abar m2048@0xf452c000 port 0xf452c100 irq 128
[    0.782462] usbcore: registered new interface driver usbserial_generic
[    0.782469] usbserial: USB Serial support registered for generic
[    0.782500] rtc_cmos 00:02: RTC can wake from S4
[    0.783144] rtc_cmos 00:02: registered as rtc0
[    0.783253] rtc_cmos 00:02: setting system clock to 2020-12-24T15:03:09 UTC (1608822189)
[    0.783285] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.783397] intel_pstate: Intel P-state driver initializing
[    0.783849] intel_pstate: HWP enabled
[    0.783916] ledtrig-cpu: registered to indicate activity on CPUs
[    0.784069] intel_pmc_core intel_pmc_core.0:  initialized
[    0.784129] drop_monitor: Initializing network drop monitor service
[    0.784394] NET: Registered protocol family 10
[    0.787998] nvme nvme0: missing or invalid SUBNQN field.
[    0.791978] Segment Routing with IPv6
[    0.791979] RPL Segment Routing with IPv6
[    0.792012] NET: Registered protocol family 17
[    0.792534] microcode: sig=0x806e9, pf=0x80, revision=0xde
[    0.792603] nvme nvme0: 4/0/0 default/read/poll queues
[    0.792606] microcode: Microcode Update Driver: v2.2.
[    0.792610] IPI shorthand broadcast: enabled
[    0.792621] sched_clock: Marking stable (791542819, 1058135)->(806808832, -14207878)
[    0.792716] registered taskstats version 1
[    0.792727] Loading compiled-in X.509 certificates
[    0.794438]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    0.796725] Loaded X.509 cert 'Build time autogenerated kernel key: 82b5889aaa59dbf702af08992c2866a5527a56f2'
[    0.796866] zswap: loaded using pool lz4/z3fold
[    0.797005] Key type ._fscrypt registered
[    0.797006] Key type .fscrypt registered
[    0.797007] Key type fscrypt-provisioning registered
[    0.798901] PM:   Magic number: 0:944:83
[    0.799064] RAS: Correctable Errors collector initialized.
[    1.098010] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.099243] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.099249] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.099253] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.100274] ata1.00: ATA-9: WDC WD5000LPLX-08ZNTT0, 04.01A04, max UDMA/133
[    1.100279] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.101453] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.101459] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.101462] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.102561] ata1.00: configured for UDMA/133
[    1.102918] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000LPLX-0 1A04 PQ: 0 ANSI: 5
[    1.103397] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    1.103401] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.103419] sd 0:0:0:0: [sda] Write Protect is off
[    1.103423] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.103450] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.174148]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda8 sda9 sda10 sda11 sda12
[    1.176665] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.180441] Freeing unused decrypted memory: 2040K
[    1.181192] Freeing unused kernel image (initmem) memory: 1660K
[    1.208127] Write protecting the kernel read-only data: 24576k
[    1.209471] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.209789] Freeing unused kernel image (rodata/data gap) memory: 240K
[    1.288597] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.288598] x86/mm: Checking user space page tables
[    1.337638] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.337642] Run /init as init process
[    1.337643]   with arguments:
[    1.337643]     /init
[    1.337644]   with environment:
[    1.337644]     HOME=/
[    1.337645]     TERM=linux
[    1.337645]     BOOT_IMAGE=/vmlinuz-linux
[    1.431093] fbcon: Taking over console
[    1.431152] Console: switching to colour frame buffer device 170x48
[    1.486518] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.496914] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.496967] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.499681] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.499690] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.500781] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    1.501014] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.501466] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
[    1.501468] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.501470] usb usb1: Product: xHCI Host Controller
[    1.501471] usb usb1: Manufacturer: Linux 5.9.14-arch1-1 xhci-hcd
[    1.501473] usb usb1: SerialNumber: 0000:00:14.0
[    1.501589] hub 1-0:1.0: USB hub found
[    1.501605] hub 1-0:1.0: 12 ports detected
[    1.504114] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.504118] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.504123] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.504173] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
[    1.504174] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.504176] usb usb2: Product: xHCI Host Controller
[    1.504178] usb usb2: Manufacturer: Linux 5.9.14-arch1-1 xhci-hcd
[    1.504179] usb usb2: SerialNumber: 0000:00:14.0
[    1.504423] hub 2-0:1.0: USB hub found
[    1.504437] hub 2-0:1.0: 6 ports detected
[    1.505323] usb: port power management may be unreliable
[    1.510479] sdhci: Secure Digital Host Controller Interface driver
[    1.510483] sdhci: Copyright(c) Pierre Ossman
[    1.518394] random: fast init done
[    1.518690] sdhci-pci 0000:02:00.0: SDHCI controller found [1217:8621] (rev 1)
[    1.518779] sdhci-pci 0000:02:00.0: enabling device (0000 -> 0002)
[    1.524319] mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA
[    1.536678] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    1.727603] tsc: Refined TSC clocksource calibration: 2711.998 MHz
[    1.727616] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x27178451938, max_idle_ns: 440795251172 ns
[    1.727690] clocksource: Switched to clocksource tsc
[    1.830932] usb 1-6: new full-speed USB device number 2 using xhci_hcd
[    1.972830] usb 1-6: New USB device found, idVendor=0cf3, idProduct=e500, bcdDevice= 0.01
[    1.972835] usb 1-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.097571] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    2.286937] usb 1-7: New USB device found, idVendor=0bda, idProduct=58db, bcdDevice= 0.02
[    2.286944] usb 1-7: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.286948] usb 1-7: Product: Integrated Camera
[    2.286951] usb 1-7: Manufacturer: 8SSC20F27029L1GZ7690AY6
[    2.286953] usb 1-7: SerialNumber: 200901010001
[    2.579817] PM: Image not found (code -22)
[    2.664145] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Opts: (null)
[    2.799449] systemd[1]: systemd 247.2-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    2.814973] systemd[1]: Detected architecture x86-64.
[    2.849265] systemd[1]: Set hostname to <Misaka>.
[    3.045075] systemd[1]: Queued start job for default target Graphical Interface.
[    3.050307] systemd[1]: Created slice system-getty.slice.
[    3.050566] systemd[1]: Created slice system-modprobe.slice.
[    3.050772] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.051032] systemd[1]: Created slice system-wpa_supplicant.slice.
[    3.051238] systemd[1]: Created slice User and Session Slice.
[    3.051291] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.051335] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.051453] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.051486] systemd[1]: Reached target Local Encrypted Volumes.
[    3.051512] systemd[1]: Reached target Paths.
[    3.051526] systemd[1]: Reached target Remote File Systems.
[    3.051536] systemd[1]: Reached target Slices.
[    3.051604] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.051780] systemd[1]: Listening on LVM2 metadata daemon socket.
[    3.051918] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.052802] systemd[1]: Listening on Process Core Dump Socket.
[    3.055260] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
[    3.055389] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.055488] systemd[1]: Listening on Journal Socket.
[    3.055607] systemd[1]: Listening on Network Service Netlink Socket.
[    3.055696] systemd[1]: Listening on udev Control Socket.
[    3.055758] systemd[1]: Listening on udev Kernel Socket.
[    3.056419] systemd[1]: Mounting Huge Pages File System...
[    3.057073] systemd[1]: Mounting POSIX Message Queue File System...
[    3.057776] systemd[1]: Mounting Kernel Debug File System...
[    3.058481] systemd[1]: Mounting Kernel Trace File System...
[    3.059513] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.060552] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    3.061439] systemd[1]: Starting Load Kernel Module configfs...
[    3.062310] systemd[1]: Starting Load Kernel Module drm...
[    3.063369] systemd[1]: Starting Load Kernel Module fuse...
[    3.065479] systemd[1]: Starting Set Up Additional Binary Formats...
[    3.065550] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    3.067214] systemd[1]: Starting Journal Service...
[    3.069721] Linux agpgart interface v0.103
[    3.072646] systemd[1]: Starting Load Kernel Modules...
[    3.074017] random: lvm: uninitialized urandom read (4 bytes read)
[    3.076877] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.076954] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
[    3.077997] systemd[1]: Starting Coldplug All udev Devices...
[    3.078133] fuse: init (API version 7.31)
[    3.080032] systemd[1]: Mounted Huge Pages File System.
[    3.080146] systemd[1]: Mounted POSIX Message Queue File System.
[    3.080232] systemd[1]: Mounted Kernel Debug File System.
[    3.080310] systemd[1]: Mounted Kernel Trace File System.
[    3.080802] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.085672] EXT4-fs (nvme0n1p4): re-mounted. Opts: (null)
[    3.088384] acpi_call: loading out-of-tree module taints kernel.
[    3.088404] acpi_call: module verification failed: signature and/or required key missing - tainting kernel
[    3.098911] systemd[1]: modprobe@configfs.service: Succeeded.
[    3.099342] systemd[1]: Finished Load Kernel Module configfs.
[    3.099583] systemd[1]: modprobe@fuse.service: Succeeded.
[    3.099967] systemd[1]: Finished Load Kernel Module fuse.
[    3.100544] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.101637] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 214 (systemd-binfmt)
[    3.102607] systemd[1]: Mounting Arbitrary Executable File Formats File System...
[    3.104987] systemd[1]: Mounting FUSE Control File System...
[    3.111045] systemd[1]: Mounting Kernel Configuration File System...
[    3.111148] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
[    3.121105] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    3.122352] systemd[1]: Starting Load/Save Random Seed...
[    3.122437] systemd[1]: Condition check resulted in Create System Users being skipped.
[    3.123444] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.125255] systemd[1]: modprobe@drm.service: Succeeded.
[    3.125719] systemd[1]: Finished Load Kernel Module drm.
[    3.125851] systemd[1]: Mounted Arbitrary Executable File Formats File System.
[    3.126199] systemd[1]: Mounted FUSE Control File System.
[    3.126301] systemd[1]: Mounted Kernel Configuration File System.
[    3.128954] systemd[1]: Finished Set Up Additional Binary Formats.
[    3.131202] vboxdrv: Found 4 processor cores
[    3.141631] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.143184] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    3.151245] systemd[1]: Started Journal Service.
[    3.157668] vboxdrv: TSC mode is Invariant, tentative frequency 2711997757 Hz
[    3.157670] vboxdrv: Successfully loaded version 6.1.16 (interface 0x00300000)
[    3.158459] VBoxNetAdp: Successfully started.
[    3.160169] VBoxNetFlt: Successfully started.
[    3.338477] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    3.338545] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    3.351751] ACPI: AC Adapter [AC] (off-line)
[    3.384910] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.422975] random: mktemp: uninitialized urandom read (6 bytes read)
[    3.432177] random: mktemp: uninitialized urandom read (6 bytes read)
[    3.456485] random: crng init done
[    3.456487] random: 2 urandom warning(s) missed due to ratelimiting
[    3.483700] battery: ACPI: Battery Slot [BAT0] (battery present)
[    3.487553] Adding 3145724k swap on /dev/nvme0n1p6.  Priority:-2 extents:1 across:3145724k SSFS
[    3.506130] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    3.506304] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.506343] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.506759] i2c i2c-0: 2/4 memory slots populated (from DMI)
[    3.507316] i2c i2c-0: Successfully instantiated SPD at 0x50
[    3.508355] i2c i2c-0: Successfully instantiated SPD at 0x52
[    3.509640] libphy: Fixed MDIO Bus: probed
[    3.510649] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    3.512642] Non-volatile memory driver v1.3
[    3.591210] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    3.591212] thinkpad_acpi: http://ibm-acpi.sf.net/
[    3.591213] thinkpad_acpi: ThinkPad BIOS R0DET84W (1.84 ), EC R0DHT84W
[    3.591214] thinkpad_acpi: Lenovo ThinkPad E570, model 20H5A000CD
[    3.593124] thinkpad_acpi: radio switch found; radios are enabled
[    3.593372] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    3.593373] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    3.606734] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.618683] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.619082] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.619083] cfg80211: failed to load regulatory.db
[    3.678816] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[    3.697755] libphy: r8169: probed
[    3.697986] r8169 0000:04:00.0 eth0: RTL8168gu/8111gu, 54:e1:ad:72:de:0f, XID 509, IRQ 136
[    3.697988] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    3.716144] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    3.751433] thinkpad_acpi: battery 1 registered (start 75, stop 80)
[    3.751441] battery: new extension: ThinkPad Battery Extension
[    3.751497] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input7
[    3.830935] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    3.830936] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.830937] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.830938] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.830939] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.830939] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    3.837284] cryptd: max_cpu_qlen set to 1000
[    3.850849] AVX2 version of gcm_enc/dec engaged.
[    3.850850] AES CTR mode by8 optimization enabled
[    3.967299] checking generic (d0000000 410000) vs hw (f2000000 1000000)
[    3.967301] checking generic (d0000000 410000) vs hw (d0000000 10000000)
[    3.967302] fb0: switching to inteldrmfb from EFI VGA
[    3.967796] Console: switching to colour dummy device 80x25
[    3.967837] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.981622] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.982659] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    4.011743] ath10k_pci 0000:05:00.0: enabling device (0000 -> 0002)
[    4.012382] ath10k_pci 0000:05:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    4.035049] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    4.107226] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[    4.108673] ee1004 0-0052: 512 byte EE1004-compliant SPD EEPROM, read-only
[    4.110514] iTCO_vendor_support: vendor-support=0
[    4.115979] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    4.116050] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    4.116175] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    4.141224] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    4.262336] ath10k_pci 0000:05:00.0: qca9377 hw1.1 target 0x05020001 chip_id 0x003821ff sub 17aa:0901
[    4.262339] ath10k_pci 0000:05:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 0 testmode 0
[    4.262847] ath10k_pci 0000:05:00.0: firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32 42e41877
[    4.331218] ath10k_pci 0000:05:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
[    4.357763] intel_rapl_common: Found RAPL domain package
[    4.357765] intel_rapl_common: Found RAPL domain core
[    4.357766] intel_rapl_common: Found RAPL domain uncore
[    4.357767] intel_rapl_common: Found RAPL domain dram
[    4.430309] ath10k_pci 0000:05:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    4.462587] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
[    4.498964] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
[    4.498970] psmouse serio1: synaptics: Your touchpad (PNP: LEN2043 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    4.511065] EXT4-fs (nvme0n1p5): mounted filesystem with ordered data mode. Opts: (null)
[    4.513088] ath: EEPROM regdomain: 0x6c
[    4.513090] ath: EEPROM indicates we should expect a direct regpair map
[    4.513095] ath: Country alpha2 being used: 00
[    4.513096] ath: Regpair used: 0x6c
[    4.517305] ath10k_pci 0000:05:00.0 wlp5s0: renamed from wlan0
[    4.578999] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf007a3/0x943300/0x12e800/0x410000, board id: 3157, fw id: 2405942
[    4.579004] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    4.627576] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
[    4.630663] mousedev: PS/2 mouse device common for all mice
[    4.924205] mc: Linux media interface: v0.10
[    4.951946] videodev: Linux video capture interface: v2.00
[    5.007465] psmouse serio2: trackpoint: failed to get extended button data, assuming 3 buttons
[    5.018667] Bluetooth: Core ver 2.22
[    5.018689] NET: Registered protocol family 31
[    5.018690] Bluetooth: HCI device and connection manager initialized
[    5.018693] Bluetooth: HCI socket layer initialized
[    5.018695] Bluetooth: L2CAP socket layer initialized
[    5.018700] Bluetooth: SCO socket layer initialized
[    5.095937] nvidia: module license 'NVIDIA' taints kernel.
[    5.095940] Disabling lock debugging due to kernel taint
[    5.100411] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on minor 0
[    5.105391] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    5.105747] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input9
[    5.106044] ACPI: Video Device [PEGP] (multi-head: no  rom: yes  post: no)
[    5.106096] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/LNXVIDEO:01/input/input10
[    5.106388] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    5.136171] nvidia-nvlink: Nvlink Core is being initialized, major device number 236
[    5.136756] uvcvideo: Found UVC 1.00 device Integrated Camera (0bda:58db)
[    5.137951] nvidia 0000:01:00.0: enabling device (0006 -> 0007)
[    5.147919] uvcvideo: Failed to initialize entity for entity 6
[    5.147921] uvcvideo: Failed to register entities (-22).
[    5.148085] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/input/input11
[    5.148312] usbcore: registered new interface driver uvcvideo
[    5.148313] USB Video Class driver (1.1.1)
[    5.161877] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    5.171211] usbcore: registered new interface driver btusb
[    5.206943] snd_hda_codec_conexant hdaudioC0D0: CX20753/4: BIOS auto-probing.
[    5.208341] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20753/4: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    5.208344] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.208346] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x16/0x0/0x0/0x0/0x0)
[    5.208347] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    5.208349] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    5.208350] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[    5.208352] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[    5.240579] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    5.240649] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    5.240711] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    5.240764] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    5.240825] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    5.241191] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    5.241253] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    5.301093] fbcon: i915drmfb (fb0) is primary device
[    5.308314] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  455.45.01  Thu Nov  5 23:03:56 UTC 2020
[    5.312954] Console: switching to colour frame buffer device 170x48
[    5.332773] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    5.375681] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  455.45.01  Thu Nov  5 22:55:44 UTC 2020
[    5.382760] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    5.382763] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 1
[    5.401561] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input8
[    8.756710] ACPI Warning: \_SB.PCI0.RP01.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20200717/nsarguments-59)
[    9.970262] wlp5s0: authenticate with dc:a6:32:01:d9:67
[   10.006255] wlp5s0: send auth to dc:a6:32:01:d9:67 (try 1/3)
[   10.008185] wlp5s0: authenticated
[   10.008337] ath10k_pci 0000:05:00.0 wlp5s0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
[   10.013544] wlp5s0: associate with dc:a6:32:01:d9:67 (try 1/3)
[   10.024978] wlp5s0: RX AssocResp from dc:a6:32:01:d9:67 (capab=0x411 status=0 aid=3)
[   10.027154] wlp5s0: associated
[   10.057788] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s0: link becomes ready
[   10.062711] wlp5s0: Limiting TX power to 20 (20 - 0) dBm as advertised by dc:a6:32:01:d9:67
[   22.708299] wlp5s0: deauthenticating from dc:a6:32:01:d9:67 by local choice (Reason: 3=DEAUTH_LEAVING)
[   35.884320] Generic FE-GE Realtek PHY r8169-400:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)
[   36.031525] r8169 0000:04:00.0 enp4s0: Link is Down
[   39.807547] 8021q: 802.1Q VLAN Support v1.8
[   49.901535] r8169 0000:04:00.0 enp4s0: Link is Down
[   63.588255] r8169 0000:04:00.0 enp4s0: Link is Down
[  146.841607] r8169 0000:04:00.0 enp4s0: Link is Down
[  152.648821] libphy: Fixed MDIO Bus: probed
[  152.718320] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[  152.738638] libphy: r8169: probed
[  152.739506] r8169 0000:04:00.0 eth0: RTL8168gu/8111gu, 54:e1:ad:72:de:0f, XID 509, IRQ 136
[  152.739517] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[  152.749123] r8169 0000:04:00.0 enp4s0: renamed from eth0
[  175.564708] Generic FE-GE Realtek PHY r8169-400:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)
[  175.712054] r8169 0000:04:00.0 enp4s0: Link is Down
```


##### 加了`pcie_aspm=force`内核参数的 `dmesg`

```dmesg
[    0.000000] microcode: microcode updated early to revision 0xde, date = 2020-05-27
[    0.000000] Linux version 5.9.14-arch1-1 (linux@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Sat, 12 Dec 2020 14:37:12 +0000
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux root=UUID=bdc8b6ae-23bf-4301-aefe-bb42097a1aac rw loglevel=3 quiet audit=0 pcie_aspm=force resume=UUID=a9954611-ed3c-457e-a4c6-a172842483e1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b0dfcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b0dfd000-0x00000000b0dfdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b0dfe000-0x00000000b0dfefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0dff000-0x00000000ba764fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ba765000-0x00000000ba816fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ba817000-0x00000000bbe49fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bbe4a000-0x00000000bbe4afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bbe4b000-0x00000000bbe4bfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bbe4c000-0x00000000bbe99fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bbe9a000-0x00000000bbefefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bbeff000-0x00000000bbefffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bbf00000-0x00000000bf7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: SMBIOS=0xbba45000 SMBIOS 3.0=0xbba43000 ACPI=0xbbefe000 ACPI 2.0=0xbbefe014 ESRT=0xbaa78000 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20H5A000CD/20H5A000CD, BIOS R0DET84W (1.84 ) 07/21/2017
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.001609] tsc: Detected 2699.909 MHz TSC
[    0.001609] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001613] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001626] last_pfn = 0x23f800 max_arch_pfn = 0x400000000
[    0.001633] MTRR default type: write-back
[    0.001634] MTRR fixed ranges enabled:
[    0.001637]   00000-9FFFF write-back
[    0.001638]   A0000-BFFFF uncachable
[    0.001640]   C0000-FFFFF write-protect
[    0.001641] MTRR variable ranges enabled:
[    0.001644]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001646]   1 base 00BE000000 mask 7FFE000000 uncachable
[    0.001648]   2 base 00BD000000 mask 7FFF000000 uncachable
[    0.001649]   3 disabled
[    0.001650]   4 disabled
[    0.001651]   5 disabled
[    0.001652]   6 disabled
[    0.001653]   7 disabled
[    0.001654]   8 disabled
[    0.001655]   9 disabled
[    0.002531] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002953] last_pfn = 0xbbf00 max_arch_pfn = 0x400000000
[    0.021653] esrt: Reserving ESRT space from 0x00000000baa78000 to 0x00000000baa78060.
[    0.021665] check: Scanning 1 areas for low memory corruption
[    0.021674] Using GB pages for direct mapping
[    0.022677] Secure boot could not be determined
[    0.022679] RAMDISK: [mem 0x36a03000-0x374f8fff]
[    0.022699] ACPI: Early table checksum verification disabled
[    0.022704] ACPI: RSDP 0x00000000BBEFE014 000024 (v02 LENOVO)
[    0.022710] ACPI: XSDT 0x00000000BBECE188 0000D4 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022719] ACPI: FACP 0x00000000BBEF7000 0000F4 (v05 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022729] ACPI: DSDT 0x00000000BBEDF000 01316C (v02 LENOVO TP-R0D   00000840 INTL 20160422)
[    0.022734] ACPI: FACS 0x00000000BBE76000 000040
[    0.022738] ACPI: UEFI 0x00000000BBE8C000 000042 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022743] ACPI: SSDT 0x00000000BBEF9000 003245 (v02 LENOVO SaSsdt   00003000 INTL 20160422)
[    0.022749] ACPI: SSDT 0x00000000BBEF8000 00075C (v02 LENOVO PerfTune 00001000 INTL 20160422)
[    0.022753] ACPI: HPET 0x00000000BBEF6000 000038 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022758] ACPI: APIC 0x00000000BBEF5000 0000BC (v03 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022763] ACPI: MCFG 0x00000000BBEF4000 00003C (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022768] ACPI: ECDT 0x00000000BBEF3000 000052 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022772] ACPI: SSDT 0x00000000BBEDC000 002DED (v01 LENOVO SataAhci 00001000 INTL 20160422)
[    0.022777] ACPI: BOOT 0x00000000BBEDB000 000028 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022782] ACPI: BATB 0x00000000BBEDA000 00004A (v02 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022787] ACPI: SSDT 0x00000000BBED9000 000EE0 (v02 LENOVO CpuSsdt  00003000 INTL 20160422)
[    0.022791] ACPI: SSDT 0x00000000BBED8000 0004FC (v02 LENOVO CtdpB    00001000 INTL 20160422)
[    0.022796] ACPI: DBGP 0x00000000BBED7000 000034 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022801] ACPI: DBG2 0x00000000BBED6000 000054 (v00 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022806] ACPI: MSDM 0x00000000BBED5000 000055 (v03 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022810] ACPI: SSDT 0x00000000BBED4000 00006C (v01 LENOVO NvOptTbl 00001000 INTL 20160422)
[    0.022815] ACPI: SSDT 0x00000000BBED2000 001728 (v02 LENOVO SgUlt    00001000 INTL 20160422)
[    0.022820] ACPI: SSDT 0x00000000BBED1000 000024 (v02 LENOVO SgPch    00001000 INTL 20160422)
[    0.022825] ACPI: DMAR 0x00000000BBED0000 0000A8 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022829] ACPI: FPDT 0x00000000BBECF000 000044 (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022834] ACPI: UEFI 0x00000000BBE4D000 00013E (v01 LENOVO TP-R0D   00000840 PTEC 00000002)
[    0.022847] ACPI: Local APIC address 0xfee00000
[    0.022961] No NUMA configuration found
[    0.022963] Faking a node at [mem 0x0000000000000000-0x000000023f7fffff]
[    0.022969] NODE_DATA(0) allocated [mem 0x23f7fc000-0x23f7fffff]
[    0.023014] Zone ranges:
[    0.023015]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.023018]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.023019]   Normal   [mem 0x0000000100000000-0x000000023f7fffff]
[    0.023021]   Device   empty
[    0.023023] Movable zone start for each node
[    0.023024] Early memory node ranges
[    0.023026]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.023027]   node   0: [mem 0x0000000000059000-0x000000000008bfff]
[    0.023028]   node   0: [mem 0x0000000000100000-0x00000000b0dfcfff]
[    0.023030]   node   0: [mem 0x00000000b0dff000-0x00000000ba764fff]
[    0.023031]   node   0: [mem 0x00000000bbeff000-0x00000000bbefffff]
[    0.023032]   node   0: [mem 0x0000000100000000-0x000000023f7fffff]
[    0.023423] Zeroed struct page in unavailable ranges: 24850 pages
[    0.023425] Initmem setup node 0 [mem 0x0000000000001000-0x000000023f7fffff]
[    0.023428] On node 0 totalpages: 2072302
[    0.023430]   DMA zone: 64 pages used for memmap
[    0.023431]   DMA zone: 72 pages reserved
[    0.023433]   DMA zone: 3978 pages, LIFO batch:0
[    0.023472]   DMA32 zone: 11870 pages used for memmap
[    0.023474]   DMA32 zone: 759652 pages, LIFO batch:63
[    0.030929]   Normal zone: 20448 pages used for memmap
[    0.030930]   Normal zone: 1308672 pages, LIFO batch:63
[    0.043735] Reserving Intel graphics memory at [mem 0xbd800000-0xbf7fffff]
[    0.044184] ACPI: PM-Timer IO Port: 0x1808
[    0.044187] ACPI: Local APIC address 0xfee00000
[    0.044197] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.044198] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.044199] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.044200] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.044201] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.044202] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.044203] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.044204] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.044234] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.044238] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.044240] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.044242] ACPI: IRQ0 used by override.
[    0.044244] ACPI: IRQ9 used by override.
[    0.044247] Using ACPI (MADT) for SMP configuration information
[    0.044250] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.044255] TSC deadline timer available
[    0.044257] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.044288] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.044291] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.044293] PM: hibernation: Registered nosave memory: [mem 0x0008c000-0x000fffff]
[    0.044296] PM: hibernation: Registered nosave memory: [mem 0xb0dfd000-0xb0dfdfff]
[    0.044297] PM: hibernation: Registered nosave memory: [mem 0xb0dfe000-0xb0dfefff]
[    0.044299] PM: hibernation: Registered nosave memory: [mem 0xba765000-0xba816fff]
[    0.044300] PM: hibernation: Registered nosave memory: [mem 0xba817000-0xbbe49fff]
[    0.044301] PM: hibernation: Registered nosave memory: [mem 0xbbe4a000-0xbbe4afff]
[    0.044302] PM: hibernation: Registered nosave memory: [mem 0xbbe4b000-0xbbe4bfff]
[    0.044303] PM: hibernation: Registered nosave memory: [mem 0xbbe4c000-0xbbe99fff]
[    0.044304] PM: hibernation: Registered nosave memory: [mem 0xbbe9a000-0xbbefefff]
[    0.044307] PM: hibernation: Registered nosave memory: [mem 0xbbf00000-0xbf7fffff]
[    0.044308] PM: hibernation: Registered nosave memory: [mem 0xbf800000-0xf80f9fff]
[    0.044309] PM: hibernation: Registered nosave memory: [mem 0xf80fa000-0xf80fafff]
[    0.044310] PM: hibernation: Registered nosave memory: [mem 0xf80fb000-0xf80fcfff]
[    0.044311] PM: hibernation: Registered nosave memory: [mem 0xf80fd000-0xf80fdfff]
[    0.044312] PM: hibernation: Registered nosave memory: [mem 0xf80fe000-0xfdffffff]
[    0.044313] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.044314] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.044317] [mem 0xbf800000-0xf80f9fff] available for PCI devices
[    0.044320] Booting paravirtualized kernel on bare hardware
[    0.044324] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.054885] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:4 nr_node_ids:1
[    0.055144] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u524288
[    0.055155] pcpu-alloc: s192512 r8192 d28672 u524288 alloc=1*2097152
[    0.055156] pcpu-alloc: [0] 0 1 2 3 
[    0.055188] Built 1 zonelists, mobility grouping on.  Total pages: 2039848
[    0.055190] Policy zone: Normal
[    0.055192] Kernel command line: BOOT_IMAGE=/vmlinuz-linux root=UUID=bdc8b6ae-23bf-4301-aefe-bb42097a1aac rw loglevel=3 quiet audit=0 pcie_aspm=force resume=UUID=a9954611-ed3c-457e-a4c6-a172842483e1
[    0.055299] audit: disabled (until reboot)
[    0.055323] PCIe ASPM is forcibly enabled
[    0.056157] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.056555] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.056639] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
[    0.090874] Memory: 7944252K/8289208K available (14339K kernel code, 1505K rwdata, 7952K rodata, 1660K init, 2944K bss, 344696K reserved, 0K cma-reserved)
[    0.090885] random: get_random_u64 called from __kmem_cache_create+0x26/0x520 with crng_init=0
[    0.091145] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.091173] Kernel/User page tables isolation: enabled
[    0.091213] ftrace: allocating 40888 entries in 160 pages
[    0.122780] ftrace: allocated 160 pages with 2 groups
[    0.122955] rcu: Preemptible hierarchical RCU implementation.
[    0.122956] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.122958] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=4.
[    0.122959] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.122961] 	Trampoline variant of Tasks RCU enabled.
[    0.122962] 	Rude variant of Tasks RCU enabled.
[    0.122963] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.122965] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.129217] NR_IRQS: 20736, nr_irqs: 1024, preallocated irqs: 16
[    0.130082] Console: colour dummy device 80x25
[    0.130088] printk: console [tty0] enabled
[    0.130119] ACPI: Core revision 20200717
[    0.130527] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.130618] APIC: Switch to symmetric I/O mode setup
[    0.130621] DMAR: Host address width 39
[    0.130623] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.130633] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.130635] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.130641] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.130643] DMAR: RMRR base: 0x000000bbde3000 end: 0x000000bbe02fff
[    0.130646] DMAR: RMRR base: 0x000000bd000000 end: 0x000000bf7fffff
[    0.130649] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.130651] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.130652] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.132390] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.132393] x2apic enabled
[    0.132407] Switched APIC routing to cluster x2apic.
[    0.136548] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.150677] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26eae8729ef, max_idle_ns: 440795235156 ns
[    0.150684] Calibrating delay loop (skipped), value calculated using timer frequency.. 5401.81 BogoMIPS (lpj=8999696)
[    0.150688] pid_max: default: 32768 minimum: 301
[    0.157056] LSM: Security Framework initializing
[    0.157063] Yama: becoming mindful.
[    0.157112] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.157133] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.157634] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.157666] process: using mwait in idle threads
[    0.157671] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.157672] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.157676] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.157678] Spectre V2 : Mitigation: Full generic retpoline
[    0.157679] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.157680] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.157683] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.157684] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.157686] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.157695] SRBDS: Mitigation: Microcode
[    0.157696] MDS: Mitigation: Clear CPU buffers
[    0.158200] Freeing SMP alternatives memory: 32K
[    0.160821] smpboot: CPU0: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.161008] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.161026] ... version:                4
[    0.161027] ... bit width:              48
[    0.161028] ... generic registers:      4
[    0.161029] ... value mask:             0000ffffffffffff
[    0.161030] ... max period:             00007fffffffffff
[    0.161031] ... fixed-purpose events:   3
[    0.161032] ... event mask:             000000070000000f
[    0.161125] rcu: Hierarchical SRCU implementation.
[    0.161974] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.162073] smp: Bringing up secondary CPUs ...
[    0.162285] x86: Booting SMP configuration:
[    0.162287] .... node  #0, CPUs:      #1 #2
[    0.168465] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.168465]  #3
[    0.170742] smp: Brought up 1 node, 4 CPUs
[    0.170745] smpboot: Max logical packages: 1
[    0.170747] smpboot: Total of 4 processors activated (21607.24 BogoMIPS)
[    0.173383] devtmpfs: initialized
[    0.173383] x86/mm: Memory block size: 128MB
[    0.174107] PM: Registering ACPI NVS region [mem 0xb0dfd000-0xb0dfdfff] (4096 bytes)
[    0.174109] PM: Registering ACPI NVS region [mem 0xbbe4a000-0xbbe4afff] (4096 bytes)
[    0.174111] PM: Registering ACPI NVS region [mem 0xbbe4c000-0xbbe99fff] (319488 bytes)
[    0.174321] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.174321] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.174321] pinctrl core: initialized pinctrl subsystem
[    0.174382] PM: RTC time: 15:41:13, date: 2020-12-24
[    0.174623] NET: Registered protocol family 16
[    0.174827] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.174827] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.174827] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.177356] thermal_sys: Registered thermal governor 'fair_share'
[    0.177356] thermal_sys: Registered thermal governor 'bang_bang'
[    0.177356] thermal_sys: Registered thermal governor 'step_wise'
[    0.177356] thermal_sys: Registered thermal governor 'user_space'
[    0.177356] thermal_sys: Registered thermal governor 'power_allocator'
[    0.177390] cpuidle: using governor ladder
[    0.177394] cpuidle: using governor menu
[    0.177420] Simple Boot Flag at 0x47 set to 0x1
[    0.177427] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.177429] ACPI: bus type PCI registered
[    0.177431] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.177713] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.177719] PCI: not using MMCONFIG
[    0.177721] PCI: Using configuration type 1 for base access
[    0.178198] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.180749] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.180749] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.184311] ACPI: Added _OSI(Module Device)
[    0.184313] ACPI: Added _OSI(Processor Device)
[    0.184314] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.184316] ACPI: Added _OSI(Processor Aggregator Device)
[    0.184318] ACPI: Added _OSI(Linux-Dell-Video)
[    0.184320] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.184322] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.258776] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.261331] ACPI: EC: EC started
[    0.261332] ACPI: EC: interrupt blocked
[    0.264837] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.264838] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.265971] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.289741] ACPI: Dynamic OEM Table Load:
[    0.289762] ACPI: SSDT 0xFFFF9CA4F5830000 00084F (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.292816] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.294613] ACPI: Dynamic OEM Table Load:
[    0.294625] ACPI: SSDT 0xFFFF9CA4F5BA1400 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.298382] ACPI: Dynamic OEM Table Load:
[    0.298394] ACPI: SSDT 0xFFFF9CA4F5FE1000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.301991] ACPI: Dynamic OEM Table Load:
[    0.302001] ACPI: SSDT 0xFFFF9CA4F5B7E800 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.307071] ACPI: Interpreter enabled
[    0.307168] ACPI: (supports S0 S3 S4 S5)
[    0.307170] ACPI: Using IOAPIC for interrupt routing
[    0.307228] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.308328] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    0.308357] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.308971] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.320164] ACPI: Power Resource [PUBS] (on)
[    0.330018] ACPI: Power Resource [PC01] (on)
[    0.332567] ACPI: Power Resource [WRST] (on)
[    0.363393] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.363605] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11)
[    0.363808] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[    0.364009] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.364215] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.364416] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.364616] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[    0.364815] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.365024] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.365033] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.365290] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug PCIeCapability LTR DPC]
[    0.365405] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.365408] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.365411] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    0.365413] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.367333] PCI host bridge to bus 0000:00
[    0.367337] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.367340] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.367342] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.367344] pci_bus 0000:00: root bus resource [mem 0xbf800000-0xfeafffff window]
[    0.367346] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.367373] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.368287] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    0.368304] pci 0000:00:02.0: reg 0x10: [mem 0xf2000000-0xf2ffffff 64bit]
[    0.368315] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.368322] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.368352] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.369400] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.369426] pci 0000:00:14.0: reg 0x10: [mem 0xf4500000-0xf450ffff 64bit]
[    0.369526] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.370897] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.370923] pci 0000:00:14.2: reg 0x10: [mem 0xf452a000-0xf452afff 64bit]
[    0.371901] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.371930] pci 0000:00:16.0: reg 0x10: [mem 0xf452b000-0xf452bfff 64bit]
[    0.372027] pci 0000:00:16.0: PME# supported from D3hot
[    0.373207] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    0.373227] pci 0000:00:17.0: reg 0x10: [mem 0xf4528000-0xf4529fff]
[    0.373238] pci 0000:00:17.0: reg 0x14: [mem 0xf452e000-0xf452e0ff]
[    0.373250] pci 0000:00:17.0: reg 0x18: [io  0xe080-0xe087]
[    0.373261] pci 0000:00:17.0: reg 0x1c: [io  0xe088-0xe08b]
[    0.373272] pci 0000:00:17.0: reg 0x20: [io  0xe060-0xe07f]
[    0.373282] pci 0000:00:17.0: reg 0x24: [mem 0xf452c000-0xf452c7ff]
[    0.373345] pci 0000:00:17.0: PME# supported from D3hot
[    0.374525] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.374641] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.375929] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.376062] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.377368] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.377484] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.378759] pci 0000:00:1d.2: [8086:9d1a] type 01 class 0x060400
[    0.378872] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.380167] pci 0000:00:1d.3: [8086:9d1b] type 01 class 0x060400
[    0.380284] pci 0000:00:1d.3: PME# supported from D0 D3hot D3cold
[    0.381587] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    0.382867] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.382885] pci 0000:00:1f.2: reg 0x10: [mem 0xf4524000-0xf4527fff]
[    0.384097] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.384128] pci 0000:00:1f.3: reg 0x10: [mem 0xf4520000-0xf4523fff 64bit]
[    0.384172] pci 0000:00:1f.3: reg 0x20: [mem 0xf4510000-0xf451ffff 64bit]
[    0.384245] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.385422] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.385475] pci 0000:00:1f.4: reg 0x10: [mem 0xf452d000-0xf452d0ff 64bit]
[    0.385526] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.386828] pci 0000:01:00.0: [10de:134d] type 00 class 0x030200
[    0.386849] pci 0000:01:00.0: reg 0x10: [mem 0xf3000000-0xf3ffffff]
[    0.386868] pci 0000:01:00.0: reg 0x14: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.386886] pci 0000:01:00.0: reg 0x1c: [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.386898] pci 0000:01:00.0: reg 0x24: [io  0xd000-0xd07f]
[    0.386910] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.386938] pci 0000:01:00.0: Enabling HDA controller
[    0.387340] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.387345] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.387347] pci 0000:00:1c.0:   bridge window [mem 0xf3000000-0xf3ffffff]
[    0.387356] pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.387546] pci 0000:02:00.0: [1217:8621] type 00 class 0x080501
[    0.387575] pci 0000:02:00.0: reg 0x10: [mem 0xf4401000-0xf4401fff]
[    0.387589] pci 0000:02:00.0: reg 0x14: [mem 0xf4400000-0xf44007ff]
[    0.387781] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.400848] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.400855] pci 0000:00:1c.4:   bridge window [mem 0xf4400000-0xf44fffff]
[    0.401193] pci 0000:03:00.0: [126f:2262] type 00 class 0x010802
[    0.401222] pci 0000:03:00.0: reg 0x10: [mem 0xf4300000-0xf4303fff 64bit]
[    0.401433] pci 0000:03:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1d.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.401611] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    0.401617] pci 0000:00:1d.0:   bridge window [mem 0xf4300000-0xf43fffff]
[    0.401772] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.401856] pci 0000:04:00.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.401971] pci 0000:04:00.0: reg 0x18: [mem 0xf4204000-0xf4204fff 64bit]
[    0.402042] pci 0000:04:00.0: reg 0x20: [mem 0xf4200000-0xf4203fff 64bit]
[    0.402411] pci 0000:04:00.0: supports D1 D2
[    0.402413] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.402793] pci 0000:00:1d.2: PCI bridge to [bus 04]
[    0.402797] pci 0000:00:1d.2:   bridge window [io  0xc000-0xcfff]
[    0.402801] pci 0000:00:1d.2:   bridge window [mem 0xf4200000-0xf42fffff]
[    0.403042] pci 0000:05:00.0: [168c:0042] type 00 class 0x028000
[    0.403089] pci 0000:05:00.0: reg 0x10: [mem 0xf4000000-0xf41fffff 64bit]
[    0.403441] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.404148] pci 0000:00:1d.3: PCI bridge to [bus 05]
[    0.404155] pci 0000:00:1d.3:   bridge window [mem 0xf4000000-0xf41fffff]
[    0.410684] ACPI: EC: interrupt unblocked
[    0.410684] ACPI: EC: event unblocked
[    0.410684] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.410684] ACPI: EC: GPE=0x20
[    0.410684] ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
[    0.410684] ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
[    0.410684] iommu: Default domain type: Translated 
[    0.410700] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.410700] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.410702] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.410703] vgaarb: loaded
[    0.411000] SCSI subsystem initialized
[    0.411023] libata version 3.00 loaded.
[    0.411023] ACPI: bus type USB registered
[    0.411023] usbcore: registered new interface driver usbfs
[    0.411023] usbcore: registered new interface driver hub
[    0.411023] usbcore: registered new device driver usb
[    0.411023] pps_core: LinuxPPS API ver. 1 registered
[    0.411023] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.411023] PTP clock support registered
[    0.411023] EDAC MC: Ver: 3.0.0
[    0.411092] Registered efivars operations
[    0.411092] NetLabel: Initializing
[    0.411092] NetLabel:  domain hash size = 128
[    0.411092] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.411092] NetLabel:  unlabeled traffic allowed by default
[    0.411092] PCI: Using ACPI for IRQ routing
[    0.416999] PCI: pci_cache_line_size set to 64 bytes
[    0.417479] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.417481] e820: reserve RAM buffer [mem 0x0008c000-0x0008ffff]
[    0.417483] e820: reserve RAM buffer [mem 0xb0dfd000-0xb3ffffff]
[    0.417484] e820: reserve RAM buffer [mem 0xba765000-0xbbffffff]
[    0.417487] e820: reserve RAM buffer [mem 0xbbf00000-0xbbffffff]
[    0.417488] e820: reserve RAM buffer [mem 0x23f800000-0x23fffffff]
[    0.418257] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.418264] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.420690] clocksource: Switched to clocksource tsc-early
[    0.442069] VFS: Disk quotas dquot_6.6.0
[    0.442091] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.442216] pnp: PnP ACPI init
[    0.443237] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.443240] system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
[    0.443243] system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
[    0.443245] system 00:00: [mem 0x000c8000-0x000cbfff] could not be reserved
[    0.443247] system 00:00: [mem 0x000cc000-0x000cffff] could not be reserved
[    0.443249] system 00:00: [mem 0x000d0000-0x000d3fff] could not be reserved
[    0.443251] system 00:00: [mem 0x000d4000-0x000d7fff] could not be reserved
[    0.443253] system 00:00: [mem 0x000d8000-0x000dbfff] could not be reserved
[    0.443256] system 00:00: [mem 0x000dc000-0x000dffff] could not be reserved
[    0.443258] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
[    0.443260] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
[    0.443262] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
[    0.443264] system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
[    0.443266] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.443269] system 00:00: [mem 0x00100000-0xbf7fffff] could not be reserved
[    0.443271] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.443274] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.443283] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.443551] system 00:01: [io  0x1800-0x189f] has been reserved
[    0.443553] system 00:01: [io  0x1600-0x167f] has been reserved
[    0.443557] system 00:01: [mem 0xf8000000-0xfbffffff] could not be reserved
[    0.443560] system 00:01: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.443562] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.443564] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.443567] system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.443569] system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.443571] system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.443574] system 00:01: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.443580] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.443728] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.443763] pnp 00:03: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.443794] pnp 00:04: Plug and Play ACPI device, IDs LEN2043 PNP0f13 (active)
[    0.443879] system 00:05: [io  0x1854-0x1857] has been reserved
[    0.443885] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.444963] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.444966] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.444968] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.444971] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.444973] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.444975] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.444978] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.444984] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.445676] system 00:07: [io  0xff00-0xfffe] has been reserved
[    0.445683] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.445835] pnp: PnP ACPI: found 8 devices
[    0.452584] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.452691] NET: Registered protocol family 2
[    0.452959] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.453031] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.453250] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.453385] TCP: Hash tables configured (established 65536 bind 65536)
[    0.453469] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.453525] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.453565] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.453693] NET: Registered protocol family 1
[    0.453700] NET: Registered protocol family 44
[    0.453709] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    0.453727] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00080000 pref]
[    0.453729] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x00080000 pref]
[    0.453732] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.453736] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.453742] pci 0000:00:1c.0:   bridge window [mem 0xf3000000-0xf3ffffff]
[    0.453746] pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.453754] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.453761] pci 0000:00:1c.4:   bridge window [mem 0xf4400000-0xf44fffff]
[    0.453771] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    0.453776] pci 0000:00:1d.0:   bridge window [mem 0xf4300000-0xf43fffff]
[    0.453785] pci 0000:00:1d.2: PCI bridge to [bus 04]
[    0.453788] pci 0000:00:1d.2:   bridge window [io  0xc000-0xcfff]
[    0.453793] pci 0000:00:1d.2:   bridge window [mem 0xf4200000-0xf42fffff]
[    0.453802] pci 0000:00:1d.3: PCI bridge to [bus 05]
[    0.453807] pci 0000:00:1d.3:   bridge window [mem 0xf4000000-0xf41fffff]
[    0.453817] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.453819] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.453822] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.453823] pci_bus 0000:00: resource 7 [mem 0xbf800000-0xfeafffff window]
[    0.453826] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.453827] pci_bus 0000:01: resource 1 [mem 0xf3000000-0xf3ffffff]
[    0.453829] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.453831] pci_bus 0000:02: resource 1 [mem 0xf4400000-0xf44fffff]
[    0.453833] pci_bus 0000:03: resource 1 [mem 0xf4300000-0xf43fffff]
[    0.453835] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
[    0.453837] pci_bus 0000:04: resource 1 [mem 0xf4200000-0xf42fffff]
[    0.453839] pci_bus 0000:05: resource 1 [mem 0xf4000000-0xf41fffff]
[    0.454071] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.454824] PCI: CLS 0 bytes, default 64
[    0.454889] Trying to unpack rootfs image as initramfs...
[    0.706834] Freeing initrd memory: 11224K
[    0.706894] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.706897] software IO TLB: mapped [mem 0xab05b000-0xaf05b000] (64MB)
[    0.707145] check: Scanning for low memory corruption every 60 seconds
[    0.707740] Initialise system trusted keyrings
[    0.707765] Key type blacklist registered
[    0.707845] workingset: timestamp_bits=41 max_order=21 bucket_order=0
[    0.710159] zbud: loaded
[    0.730013] Key type asymmetric registered
[    0.730015] Asymmetric key parser 'x509' registered
[    0.730028] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.730099] io scheduler mq-deadline registered
[    0.730100] io scheduler kyber registered
[    0.730142] io scheduler bfq registered
[    0.732197] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.732340] efifb: probing for efifb
[    0.732360] efifb: No BGRT, not showing boot graphics
[    0.732363] efifb: framebuffer at 0xd0000000, using 4160k, total 4160k
[    0.732364] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    0.732365] efifb: scrolling: redraw
[    0.732368] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.732440] fbcon: Deferring console take-over
[    0.732442] fb0: EFI VGA frame buffer device
[    0.732455] intel_idle: MWAIT substates: 0x11142120
[    0.732456] intel_idle: v0.5.1 model 0x8E
[    0.732896] intel_idle: Local APIC timer is reliable in all C-states
[    0.733001] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.734074] ACPI: Lid Switch [LID]
[    0.734145] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.737402] ACPI: Sleep Button [SLPB]
[    0.737505] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.740730] ACPI: Power Button [PWRF]
[    0.749153] thermal LNXTHERM:00: registered as thermal_zone0
[    0.749157] ACPI: Thermal Zone [THM0] (48 C)
[    0.749751] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.751163] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.751165] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    0.752876] nvme nvme0: pci function 0000:03:00.0
[    0.752939] ahci 0000:00:17.0: version 3.0
[    0.753719] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    0.753723] ahci 0000:00:17.0: flags: 64bit ncq led clo only pio slum part deso sadm sds apst 
[    0.754160] scsi host0: ahci
[    0.754286] ata1: SATA max UDMA/133 abar m2048@0xf452c000 port 0xf452c100 irq 128
[    0.754403] usbcore: registered new interface driver usbserial_generic
[    0.754410] usbserial: USB Serial support registered for generic
[    0.754440] rtc_cmos 00:02: RTC can wake from S4
[    0.755053] rtc_cmos 00:02: registered as rtc0
[    0.755160] rtc_cmos 00:02: setting system clock to 2020-12-24T15:41:14 UTC (1608824474)
[    0.755191] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.755306] intel_pstate: Intel P-state driver initializing
[    0.755656] intel_pstate: HWP enabled
[    0.755717] ledtrig-cpu: registered to indicate activity on CPUs
[    0.755874] intel_pmc_core intel_pmc_core.0:  initialized
[    0.755936] drop_monitor: Initializing network drop monitor service
[    0.756174] NET: Registered protocol family 10
[    0.761055] nvme nvme0: missing or invalid SUBNQN field.
[    0.765210] Segment Routing with IPv6
[    0.765212] RPL Segment Routing with IPv6
[    0.765250] NET: Registered protocol family 17
[    0.765919] microcode: sig=0x806e9, pf=0x80, revision=0xde
[    0.765997] nvme nvme0: 4/0/0 default/read/poll queues
[    0.766072] microcode: Microcode Update Driver: v2.2.
[    0.766079] IPI shorthand broadcast: enabled
[    0.766097] sched_clock: Marking stable (765052100, 1008575)->(779745903, -13685228)
[    0.766362] registered taskstats version 1
[    0.766377] Loading compiled-in X.509 certificates
[    0.768089]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    0.771562] Loaded X.509 cert 'Build time autogenerated kernel key: 82b5889aaa59dbf702af08992c2866a5527a56f2'
[    0.771849] zswap: loaded using pool lz4/z3fold
[    0.772026] Key type ._fscrypt registered
[    0.772028] Key type .fscrypt registered
[    0.772029] Key type fscrypt-provisioning registered
[    0.774406] PM:   Magic number: 0:565:690
[    0.774439] mem mem: hash matches
[    0.774719] RAS: Correctable Errors collector initialized.
[    1.071164] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.072316] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.072321] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.072325] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.073278] ata1.00: ATA-9: WDC WD5000LPLX-08ZNTT0, 04.01A04, max UDMA/133
[    1.073283] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.074386] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.074392] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.074395] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.075365] ata1.00: configured for UDMA/133
[    1.075736] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000LPLX-0 1A04 PQ: 0 ANSI: 5
[    1.076133] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    1.076138] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.076158] sd 0:0:0:0: [sda] Write Protect is off
[    1.076162] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.076187] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.144285]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda8 sda9 sda10 sda11 sda12
[    1.146397] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.150004] Freeing unused decrypted memory: 2040K
[    1.150720] Freeing unused kernel image (initmem) memory: 1660K
[    1.161175] Write protecting the kernel read-only data: 24576k
[    1.162432] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.162748] Freeing unused kernel image (rodata/data gap) memory: 240K
[    1.240554] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.240555] x86/mm: Checking user space page tables
[    1.289880] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.289884] Run /init as init process
[    1.289886]   with arguments:
[    1.289886]     /init
[    1.289887]   with environment:
[    1.289887]     HOME=/
[    1.289887]     TERM=linux
[    1.289888]     BOOT_IMAGE=/vmlinuz-linux
[    1.391302] fbcon: Taking over console
[    1.391364] Console: switching to colour frame buffer device 170x48
[    1.446040] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.453537] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.453575] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.459304] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.459312] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.460412] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    1.460692] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.460918] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
[    1.460919] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.460921] usb usb1: Product: xHCI Host Controller
[    1.460923] usb usb1: Manufacturer: Linux 5.9.14-arch1-1 xhci-hcd
[    1.460924] usb usb1: SerialNumber: 0000:00:14.0
[    1.461084] hub 1-0:1.0: USB hub found
[    1.461103] hub 1-0:1.0: 12 ports detected
[    1.462848] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.462853] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.462858] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.462914] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
[    1.462919] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.462921] usb usb2: Product: xHCI Host Controller
[    1.462922] usb usb2: Manufacturer: Linux 5.9.14-arch1-1 xhci-hcd
[    1.462923] usb usb2: SerialNumber: 0000:00:14.0
[    1.463052] hub 2-0:1.0: USB hub found
[    1.463071] hub 2-0:1.0: 6 ports detected
[    1.463328] usb: port power management may be unreliable
[    1.468234] sdhci: Secure Digital Host Controller Interface driver
[    1.468236] sdhci: Copyright(c) Pierre Ossman
[    1.472201] sdhci-pci 0000:02:00.0: SDHCI controller found [1217:8621] (rev 1)
[    1.472288] sdhci-pci 0000:02:00.0: enabling device (0000 -> 0002)
[    1.472803] mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA
[    1.473909] random: fast init done
[    1.497983] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    1.730731] tsc: Refined TSC clocksource calibration: 2711.998 MHz
[    1.730744] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x27178451938, max_idle_ns: 440795251172 ns
[    1.730777] clocksource: Switched to clocksource tsc
[    1.794094] usb 1-6: new full-speed USB device number 2 using xhci_hcd
[    1.935133] usb 1-6: New USB device found, idVendor=0cf3, idProduct=e500, bcdDevice= 0.01
[    1.935138] usb 1-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.060781] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    2.246274] usb 1-7: New USB device found, idVendor=0bda, idProduct=58db, bcdDevice= 0.02
[    2.246280] usb 1-7: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.246283] usb 1-7: Product: Integrated Camera
[    2.246287] usb 1-7: Manufacturer: 8SSC20F27029L1GZ7690AY6
[    2.246289] usb 1-7: SerialNumber: 200901010001
[    2.369665] PM: Image not found (code -22)
[    2.459016] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Opts: (null)
[    2.582270] systemd[1]: systemd 247.2-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    2.598006] systemd[1]: Detected architecture x86-64.
[    2.619398] systemd[1]: Set hostname to <Misaka>.
[    2.825231] systemd[1]: Queued start job for default target Graphical Interface.
[    2.830846] systemd[1]: Created slice system-getty.slice.
[    2.831099] systemd[1]: Created slice system-modprobe.slice.
[    2.831305] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.831551] systemd[1]: Created slice system-wpa_supplicant.slice.
[    2.831747] systemd[1]: Created slice User and Session Slice.
[    2.831799] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    2.831841] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    2.831958] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    2.831995] systemd[1]: Reached target Local Encrypted Volumes.
[    2.832026] systemd[1]: Reached target Paths.
[    2.832039] systemd[1]: Reached target Remote File Systems.
[    2.832050] systemd[1]: Reached target Slices.
[    2.832116] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    2.832412] systemd[1]: Listening on LVM2 metadata daemon socket.
[    2.833022] systemd[1]: Listening on LVM2 poll daemon socket.
[    2.833931] systemd[1]: Listening on Process Core Dump Socket.
[    2.838612] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
[    2.838780] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.838917] systemd[1]: Listening on Journal Socket.
[    2.839060] systemd[1]: Listening on Network Service Netlink Socket.
[    2.839188] systemd[1]: Listening on udev Control Socket.
[    2.839264] systemd[1]: Listening on udev Kernel Socket.
[    2.839966] systemd[1]: Mounting Huge Pages File System...
[    2.840673] systemd[1]: Mounting POSIX Message Queue File System...
[    2.841647] systemd[1]: Mounting Kernel Debug File System...
[    2.842588] systemd[1]: Mounting Kernel Trace File System...
[    2.843885] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    2.844814] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    2.845816] systemd[1]: Starting Load Kernel Module configfs...
[    2.846617] systemd[1]: Starting Load Kernel Module drm...
[    2.847689] systemd[1]: Starting Load Kernel Module fuse...
[    2.849620] systemd[1]: Starting Set Up Additional Binary Formats...
[    2.849690] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    2.851293] systemd[1]: Starting Journal Service...
[    2.853819] Linux agpgart interface v0.103
[    2.860108] random: lvm: uninitialized urandom read (4 bytes read)
[    2.860407] fuse: init (API version 7.31)
[    2.862118] systemd[1]: Starting Load Kernel Modules...
[    2.862880] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.862969] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
[    2.863901] systemd[1]: Starting Coldplug All udev Devices...
[    2.865979] systemd[1]: Mounted Huge Pages File System.
[    2.866095] systemd[1]: Mounted POSIX Message Queue File System.
[    2.866175] systemd[1]: Mounted Kernel Debug File System.
[    2.866257] systemd[1]: Mounted Kernel Trace File System.
[    2.866773] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    2.869931] EXT4-fs (nvme0n1p4): re-mounted. Opts: (null)
[    2.873961] acpi_call: loading out-of-tree module taints kernel.
[    2.873977] acpi_call: module verification failed: signature and/or required key missing - tainting kernel
[    2.887987] systemd[1]: modprobe@configfs.service: Succeeded.
[    2.888422] systemd[1]: Finished Load Kernel Module configfs.
[    2.888640] systemd[1]: modprobe@fuse.service: Succeeded.
[    2.889009] systemd[1]: Finished Load Kernel Module fuse.
[    2.889493] systemd[1]: Finished Remount Root and Kernel File Systems.
[    2.890254] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 215 (systemd-binfmt)
[    2.891580] systemd[1]: Mounting Arbitrary Executable File Formats File System...
[    2.892566] systemd[1]: Mounting FUSE Control File System...
[    2.893545] systemd[1]: Mounting Kernel Configuration File System...
[    2.893645] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
[    2.894000] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    2.895175] systemd[1]: Starting Load/Save Random Seed...
[    2.895273] systemd[1]: Condition check resulted in Create System Users being skipped.
[    2.896300] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.903954] vboxdrv: Found 4 processor cores
[    2.904196] systemd[1]: Mounted Kernel Configuration File System.
[    2.904428] systemd[1]: Mounted FUSE Control File System.
[    2.906949] systemd[1]: modprobe@drm.service: Succeeded.
[    2.907397] systemd[1]: Finished Load Kernel Module drm.
[    2.912009] systemd[1]: Mounted Arbitrary Executable File Formats File System.
[    2.914044] systemd[1]: Finished Set Up Additional Binary Formats.
[    2.922040] systemd[1]: Finished Create Static Device Nodes in /dev.
[    2.923094] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    2.927549] vboxdrv: TSC mode is Invariant, tentative frequency 2711997190 Hz
[    2.927551] vboxdrv: Successfully loaded version 6.1.16 (interface 0x00300000)
[    2.928747] VBoxNetAdp: Successfully started.
[    2.931309] VBoxNetFlt: Successfully started.
[    2.933487] systemd[1]: Finished Load Kernel Modules.
[    2.934638] systemd[1]: Starting Apply Kernel Variables...
[    2.940588] systemd[1]: Finished Apply Kernel Variables.
[    2.942605] systemd[1]: Started Journal Service.
[    3.121118] ACPI: AC Adapter [AC] (off-line)
[    3.171966] battery: ACPI: Battery Slot [BAT0] (battery present)
[    3.187488] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    3.187635] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    3.200674] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.205979] Non-volatile memory driver v1.3
[    3.224494] random: mktemp: uninitialized urandom read (6 bytes read)
[    3.225495] random: mktemp: uninitialized urandom read (6 bytes read)
[    3.256162] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    3.256164] thinkpad_acpi: http://ibm-acpi.sf.net/
[    3.256165] thinkpad_acpi: ThinkPad BIOS R0DET84W (1.84 ), EC R0DHT84W
[    3.256166] thinkpad_acpi: Lenovo ThinkPad E570, model 20H5A000CD
[    3.268240] random: crng init done
[    3.268243] random: 2 urandom warning(s) missed due to ratelimiting
[    3.270134] thinkpad_acpi: radio switch found; radios are enabled
[    3.270410] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    3.270411] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    3.277374] Adding 3145724k swap on /dev/nvme0n1p6.  Priority:-2 extents:1 across:3145724k SSFS
[    3.290135] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    3.340876] thinkpad_acpi: battery 1 registered (start 75, stop 80)
[    3.340884] battery: new extension: ThinkPad Battery Extension
[    3.340941] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input5
[    3.356478] libphy: Fixed MDIO Bus: probed
[    3.361875] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    3.362049] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.362091] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.362518] i2c i2c-0: 2/4 memory slots populated (from DMI)
[    3.362815] input: PC Speaker as /devices/platform/pcspkr/input/input7
[    3.365035] i2c i2c-0: Successfully instantiated SPD at 0x50
[    3.366787] i2c i2c-0: Successfully instantiated SPD at 0x52
[    3.457774] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.465098] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.465491] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.465493] cfg80211: failed to load regulatory.db
[    3.565621] libphy: r8169: probed
[    3.565856] r8169 0000:04:00.0 eth0: RTL8168gu/8111gu, 54:e1:ad:72:de:0f, XID 509, IRQ 136
[    3.565858] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    3.614475] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    3.614477] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.614478] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.614479] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.614480] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.614481] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    3.641582] cryptd: max_cpu_qlen set to 1000
[    3.727644] AVX2 version of gcm_enc/dec engaged.
[    3.727646] AES CTR mode by8 optimization enabled
[    3.774149] checking generic (d0000000 410000) vs hw (f2000000 1000000)
[    3.774151] checking generic (d0000000 410000) vs hw (d0000000 10000000)
[    3.774152] fb0: switching to inteldrmfb from EFI VGA
[    3.774566] Console: switching to colour dummy device 80x25
[    3.775863] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.800512] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.801662] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    3.877561] ath10k_pci 0000:05:00.0: enabling device (0000 -> 0002)
[    3.878313] ath10k_pci 0000:05:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    3.920701] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    3.966236] iTCO_vendor_support: vendor-support=0
[    3.970287] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.970359] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    3.970479] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    3.970541] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[    3.971860] ee1004 0-0052: 512 byte EE1004-compliant SPD EEPROM, read-only
[    4.005043] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    4.104477] intel_rapl_common: Found RAPL domain package
[    4.104480] intel_rapl_common: Found RAPL domain core
[    4.104481] intel_rapl_common: Found RAPL domain uncore
[    4.104482] intel_rapl_common: Found RAPL domain dram
[    4.130613] ath10k_pci 0000:05:00.0: qca9377 hw1.1 target 0x05020001 chip_id 0x003821ff sub 17aa:0901
[    4.130616] ath10k_pci 0000:05:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 0 testmode 0
[    4.131147] ath10k_pci 0000:05:00.0: firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32 42e41877
[    4.198636] EXT4-fs (nvme0n1p5): mounted filesystem with ordered data mode. Opts: (null)
[    4.198727] ath10k_pci 0000:05:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
[    4.225097] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
[    4.261105] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
[    4.261112] psmouse serio1: synaptics: Your touchpad (PNP: LEN2043 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    4.295907] ath10k_pci 0000:05:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    4.332719] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf007a3/0x943300/0x12e800/0x410000, board id: 3157, fw id: 2405942
[    4.332727] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    4.369205] ath: EEPROM regdomain: 0x6c
[    4.369206] ath: EEPROM indicates we should expect a direct regpair map
[    4.369209] ath: Country alpha2 being used: 00
[    4.369209] ath: Regpair used: 0x6c
[    4.383498] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
[    4.384208] ath10k_pci 0000:05:00.0 wlp5s0: renamed from wlan0
[    4.392798] mousedev: PS/2 mouse device common for all mice
[    4.705456] Bluetooth: Core ver 2.22
[    4.705893] NET: Registered protocol family 31
[    4.705894] Bluetooth: HCI device and connection manager initialized
[    4.705898] Bluetooth: HCI socket layer initialized
[    4.705899] Bluetooth: L2CAP socket layer initialized
[    4.705903] Bluetooth: SCO socket layer initialized
[    4.731062] mc: Linux media interface: v0.10
[    4.740859] psmouse serio2: trackpoint: failed to get extended button data, assuming 3 buttons
[    4.754804] videodev: Linux video capture interface: v2.00
[    4.828342] usbcore: registered new interface driver btusb
[    4.865997] nvidia: module license 'NVIDIA' taints kernel.
[    4.865999] Disabling lock debugging due to kernel taint
[    4.899252] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    4.904959] nvidia-nvlink: Nvlink Core is being initialized, major device number 236
[    4.905526] nvidia 0000:01:00.0: enabling device (0006 -> 0007)
[    4.910051] uvcvideo: Found UVC 1.00 device Integrated Camera (0bda:58db)
[    4.916367] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on minor 0
[    4.918987] uvcvideo: Failed to initialize entity for entity 6
[    4.918988] uvcvideo: Failed to register entities (-22).
[    4.919124] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/input/input9
[    4.919245] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.919343] usbcore: registered new interface driver uvcvideo
[    4.919344] USB Video Class driver (1.1.1)
[    4.919555] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input10
[    4.919713] ACPI: Video Device [PEGP] (multi-head: no  rom: yes  post: no)
[    4.919756] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/LNXVIDEO:01/input/input11
[    4.919978] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    5.028131] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  455.45.01  Thu Nov  5 23:03:56 UTC 2020
[    5.065520] snd_hda_codec_conexant hdaudioC0D0: CX20753/4: BIOS auto-probing.
[    5.066198] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20753/4: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    5.066201] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.066204] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x16/0x0/0x0/0x0/0x0)
[    5.066205] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    5.066206] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    5.066208] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[    5.066210] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[    5.100720] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  455.45.01  Thu Nov  5 22:55:44 UTC 2020
[    5.104744] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    5.104824] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    5.104891] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    5.104967] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    5.105022] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    5.105074] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    5.105124] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    5.108667] fbcon: i915drmfb (fb0) is primary device
[    5.108836] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    5.108838] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 1
[    5.113671] Console: switching to colour frame buffer device 170x48
[    5.133670] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    5.136815] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input8
[    9.640547] ACPI Warning: \_SB.PCI0.RP01.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20200717/nsarguments-59)
[    9.736928] wlp5s0: authenticate with dc:a6:32:01:d9:67
[    9.772523] wlp5s0: send auth to dc:a6:32:01:d9:67 (try 1/3)
[    9.774360] wlp5s0: authenticated
[    9.774434] ath10k_pci 0000:05:00.0 wlp5s0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
[    9.777430] wlp5s0: associate with dc:a6:32:01:d9:67 (try 1/3)
[    9.788577] wlp5s0: RX AssocResp from dc:a6:32:01:d9:67 (capab=0x411 status=0 aid=2)
[    9.791142] wlp5s0: associated
[    9.810009] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s0: link becomes ready
[    9.867000] wlp5s0: Limiting TX power to 20 (20 - 0) dBm as advertised by dc:a6:32:01:d9:67
[   20.425980] wlp5s0: deauthenticating from dc:a6:32:01:d9:67 by local choice (Reason: 3=DEAUTH_LEAVING)
[   23.677870] Generic FE-GE Realtek PHY r8169-400:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)
[   23.857749] r8169 0000:04:00.0 enp4s0: Link is Down
[   31.786973] 8021q: 802.1Q VLAN Support v1.8
[   37.544616] Generic FE-GE Realtek PHY r8169-400:00: Downshift occurred from negotiated speed 1Gbps to actual speed 100Mbps, check cabling!
[   37.544653] r8169 0000:04:00.0 enp4s0: Link is Up - 100Mbps/Full (downshifted) - flow control rx/tx
[   37.544691] IPv6: ADDRCONF(NETDEV_CHANGE): enp4s0: link becomes ready
```
