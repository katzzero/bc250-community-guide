# 02 — BIOS & Firmware

> Flashing a modded BIOS is **mandatory** to unlock VRAM allocation and hidden chipset settings.

---

## Recommended Modded BIOS

| File | Version | Status |
|------|---------|--------|
| **BC250_3.00_CHIPSETMENU.ROM** | P3.00 | ✅ **Recommended** — most stable, tested widely (source: elektricM flashing.md; mod by Segfault) |
| `P4.00` (stock) | P4.00 | ❌ **Unstable** — undocumented version found on some boards; 3D apps crash (faithy2386) |
| `P5.00_clv` variants | P5.00 | ⚠️ Advanced — unlocks everything (ReBAR, PXE) but **easy to brick** | [confirmed: @etho2520, 24/02/2026] |
| **gabriwar P5.00 Toggle BIOS** | P5.00 + cores | ⚠️ Experimental — all settings unlocked **plus harvested CPU cores as a toggleable option** (enable/disable from BIOS without reflashing). Known as "megabias" / `allthecoolshit.rom`. Not yet widely released; keroppl_wizard, j0shm1lls testing Aug 2026–present. |

Stock P3.00 already includes standard fan control and IOMMU toggle — `_fanoush_` confirmed this on a pristine P3.00 board. The modded P3.00 adds the chipset menu (Unlock Cache, ReBAR) but the stock BIOS already covers cooling and IOMMU needs.

**P4.00** was discovered by faithy2386 in May 2026 — it's an undocumented stock BIOS version found on some boards. It is unstable (all 3D applications crash). Dumping and flashing to modified P5.00 fixes the issue (after CMOS clear). P4.00 is NOT recommended. P5.00 has more settings but also settings that can brick the board (rocksalt_). Some SMU commands differ on P5.00 and fewer people have looked at it (pops1cl). Patched P5 is "a bit of a mess" (kilrah).

**P5.00 chipset lanes (snodrat, May 2026):** Patched P5.00 exposes chipset PCIe lane configuration. Default mode is x2 (for M.2) + x1 + x1 (for Ethernet/USB). Alternate mode `x1x1x1x1` splits the chipset lanes 4 ways. This enables potential use of Intel H10 Optane drives (requires M.2 carrier PCB) at PCIe 2.0 x1 per lane. Without the bifurcation, H10 drives only show their QLC side (snodrat).

*Credits: P3.00 mod by **Segfault**. P5.00_clv is community-maintained. P4.00 discovery by faithy2386. elektricM credits Segfault for reverse engineering and maintaining modified firmware images.*

### Where to Download

| Source | URL |
|--------|-----|
| **Primary (GitLab)** | https://gitlab.com/TuxThePenguin0/bc250-bios/ |
| GitHub mirror | https://github.com/MrrZed0/bc-250-bios |

> ⚠️ **Always back up your existing BIOS** before flashing anything. elektricM recommends owning a CH347 programmer before starting as a safety net.

---

## BIOS Configuration (After Flashing)

Enter BIOS by spamming **Delete** on boot, then set:

```
Chipset → GFX Configuration:
  Integrated Graphics Controller = [Forces]
  UMA Mode                       = [UMA_SPECIFIED]
  UMA Frame Buffer Size          = [512M] ← See VRAM options below

Advanced → CPU Configuration:
  IOMMU = [Disabled]  ← MUST disable — broken on BC-250

Boot → Boot Mode:
  Boot Mode = [UEFI]
```

---

## VRAM Allocation Options

| Mode | GPU VRAM | System RAM | Best For |
|------|----------|------------|----------|
| **512 MB (Dynamic)** | Auto (up to ~14 GB+) | Auto | ✅ **General use — recommended** |
| 6 GB fixed (6144 MB) | 6 GB | 10 GB | AAA gaming, avoids OOM crashes |
| 8 GB fixed (8192 MB) | 8 GB | 8 GB | Balanced workload |
| 4 GB fixed (4096 MB) | 4 GB | 12 GB | Light gaming, more system RAM |

> 💡 **512 MB dynamic is best for most users.** Linux dynamically allocates more VRAM as needed. This gives ~11.5 GB GTT (total usable ~12 GB) while keeping most RAM as system RAM when not gaming (pops1cl, Discord). For gaming-only setups, 4 GB or 6 GB fixed avoids edge cases that 512 MB can trigger. 8/8 split is generally overkill (pops1cl, Discord).

### Override for Full 16 GB Access (Advanced)

```
# Kernel parameters to access full shared memory:
amdgpu.gttsize=14750 ttm.pages_limit=3959290 ttm.page_pool_size=3959290
```

*Source: elektricM vram.md — Advanced kernel parameters section.*

### Memory Timing Configuration Tool (bc250_memcfg)

**Project:** [fanoush/bc250_memcfg](https://github.com/fanoush/bc250_memcfg)
**Status:** Working — compiled binary available. Works with stock P3.00 and P5.00 BIOS.

Sets CMOS BIOS memory configuration from Linux without rebooting into BIOS. The most useful parameter is `UMA_SIZE` (VRAM allocation), but it can also adjust memory timings. Pre-built binary available in the GitHub releases page (fanoush, Jul 2026).

---

## Flashing Methods

### Method 1: USB Flashing (EFI Shell — Recommended)

**Files needed:**
- `4U12G BIOS Update.zip` — contains `AfuEfix64.efi`, `Flash.nsh`, utilities
  - Download: https://github.com/kenavru/BC-250/raw/refs/heads/main/4U12G%20BIOS%20Update.zip
- `BC250_3.00_CHIPSETMENU.ROM` — renamed to `Robin5.00`

**Steps:**
1. Format USB drive to **FAT32**
2. Extract `4U12G BIOS Update.zip` → copy `BIOS EFI` folder contents to USB root
3. USB root should contain: `AfuEfix64.efi`, `Flash.nsh`, `amdvbflash.efi`, `Robin5.00`, `EFI/`
4. Rename `BC250_3.00_CHIPSETMENU.ROM` → `Robin5.00` (capital R, no extension)
5. **Or** edit `Flash.nsh` to point to your filename
6. Unplug all drives and SSDs (forces EFI Shell boot), insert USB, power on
7. At the yellow `Shell>` prompt, type `blk0:` (with a space after the colon) then **Enter**
8. Type `Flash.nsh` then **Enter**. Note: some keyboard layouts may cause typos (e.g., French keyboards type `Flqsh.nsh`) -- najibc, help-thread. If it fails, wait a few minutes and try again.
9. **WAIT.** Do NOT interrupt. If the flash appears to hang, wait at least 15 minutes.
10. System will reboot — power off immediately, remove USB stick
11. **Clear CMOS** (see below)

> 💡 If booting to EFI shell doesn't work automatically, spam **Del** to enter BIOS and select the USB drive as boot device.

### Method 2: Hardware Programmer (For Bricked/Recovery Boards)

- **Flash chip:** `BIOS_A1` — Winbond W25Q128JVSQ (or MX25L12835F), 16 MB
- **Header:** J4004
- **Programmer:** CH347T (recommended) or CH341A with verified 3.3V logic

```bash
# Backup first!
sudo flashrom -p ch347_spi -r backup_stock.bin
sudo flashrom -p ch347_spi -v backup_stock.bin
# Flash modded BIOS
sudo flashrom -p ch347_spi -w BC250_3.00_CHIPSETMENU.ROM
```

> *Credits: Pinout documentation and recovery methods by **Segfault** (elektricM flashing.md).*

> ⚠️ Risk with CH341A: Some black-PCB CH341A programmers output 5V logic even in 3.3V mode. The BC-250 BIOS chip operates at 3.3V — 5V can destroy the chip or chipset.

### Method 3: Internal Flash from Linux [confirmed: elektricM docs]

> ⚠️ **Not documented in the elektricM guide (which covers USB and hardware programmer).** The MrrZed0 BIOS repo and community members have used `flashrom -p internal` successfully. Proceed at your own risk.

```bash
# Backup first!
sudo flashrom -p internal -r backup.bin
sudo flashrom -p internal -w BC250_3.00_CHIPSETMENU.ROM
```

### Method 4: UEFI Interactive Flashing Script

**Project:** [Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script](https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script)

Bash script providing an interactive text menu that automates firmware backup and flashing. Backs up your existing BIOS before flashing the modded P3.00 firmware. Themed menus available (CachyOS, Bazzite, PS5Linux, etc.). Screenshots confirmed working (Forbidden-Darkness, Jul 2026). Useful for users who want a guided flashing experience without manual EFI shell commands.

---

## ⛔ CMOS Clear (Critical — Do Not Skip)

After **any** BIOS flash, settings will NOT persist unless CMOS is cleared:

**Option A: Remove Battery (Recommended)**

1. Power off, unplug PSU
2. Remove **CR2032** battery for at least 60 seconds
3. While battery out, press power button **5 times** to discharge capacitors
4. Reinsert battery, power on, enter BIOS
5. Verify CMOS was cleared (system clock should be wrong)
6. Reconfigure BIOS → **F10 to save**

**Option B: CMOS Jumper**

1. Power off, unplug PSU
2. Locate CMOS clear jumper (`CLRCMOS1`)
3. Move jumper to clear position (pins 2-3) for 20 seconds
4. Return jumper to default position (pins 1-2)
5. Power on and reconfigure BIOS

> 💡 If settings still won't stick after CMOS clear, try removing the NVMe SSD during the flash process as well.

> *CMOS jumper method per elektricM flashing.md.*

---

## Flash Chip Identification

The BC-250 has **two** SPI flash chips — flash the correct one!

| Chip | Size | Label | Action |
|------|------|-------|--------|
| **BIOS_A1** | 16 MB | Winbond W25Q128JVSQ | ✅ **FLASH THIS ONE** |
| SIO1_R | 512 KB | Macronix MX25L4006E | ❌ **DO NOT FLASH** — will brick SuperIO |

**Key board components:**

| Designator | Chip | Function |
|------------|------|----------|
| M2U2 | NXP CBTL04083B | 2:1 PCIe ×4 Multiplexer |
| PUIO1 | Intersil ISL95712 | Core supply PMIC |
| PUA11 etc. | Intersil ISL99360 | Smart Power Stage |
| PUA1 | Intersil ISL69247 | Main PMIC |
| U30 | Realtek RTL8111H | Ethernet NIC |
| BIOS_A1 | Winbond W25Q128JVSQ | 16 MiB SPI flash |
| SU1 | AMD 218-0844029 | A68H Bolton-D2H FCH |
| UIO1 | Nuvoton NCT6686D | SuperIO controller |

*Source: elektricM pinouts.md — all entries verified.*

---

## USB Flashable BIOS Tool (Kenavru)

An alternative EFI flasher by [kenavru](https://github.com/kenavru/BC-250) eliminates the need for hardware flashing on many boards:

```bash
git clone https://github.com/kenavru/BC-250.git
cd BC-250
# Follow README for usage
```

> Note: Still requires the modded BIOS ROM file from TuxThePenguin0.

---

## 40 CU Unlock (Re-Enable Harvested CUs)

**Project:** [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock)
**Status:** Working (May 2026). 1.61x compute scaling verified. Two unlock methods available.

The BC-250 ships with 24 of 40 RDNA2 CUs active. 16 are harvested — disabled by firmware policy, not silicon defects. The harvested CUs have power, clocks, and matching CGTS config. Non-permanent — reboot without the modprobe config returns to stock 24 CUs. Guarded to only fire on BC-250 (PCI ID `0x13FE`).

Also confirmed working on PS5 Linux (gennro, forwarded from PS5 Linux Discord, May 2026).

### How It Works

Two registers control CU availability — both must be modified together:

| Register | What It Does | Stock (24 CU) | Unlocked (40 CU) |
|----------|-------------|---------------|-------------------|
| `CC_GC_SHADER_ARRAY_CONFIG` | Enumeration mask (tells driver how many CUs) | `0xfff80000` | `0xffe00000` |
| `SPI_PG_ENABLE_STATIC_WGP_MASK` | Dispatch gate (tells SPI where to send waves) | `0x7` (WGP 0-2) | `0x1F` (WGP 0-4) |

Neither alone is sufficient. CC alone changes driver reporting but SPI still dispatches to 24 CUs. SPI alone enables dispatch but driver only generates work for 24 CUs. The patch writes both during amdgpu driver init (duggasco, scallion_9883). On Vangogh, the equivalent is `SMU_MSG_RequestActiveWgp`. On Cyan Skillfish, that SMU message isn't exposed but the SPI register is directly writable (Claude/Codex analysis).

### Performance

| Config | pp512 tok/s | Power | Temp | SCLK |
|--------|-------------|-------|------|------|
| Stock 24 CU (governor) | 230 | 95W | 79C | 1500 MHz |
| 40 CU unlocked (governor) | 372 | 125W | 83C | 1500 MHz |
| 40 CU @ 2 GHz governor | 466 | 181W | 96C | 2000 MHz |

**Recommended sweet spot:** 1500 MHz / 900 mV via cyan-skillfish-governor.

### Method 1: No Kernel Patch (Recommended — big_trov, May 2026)

The latest discovery: the module can be patched on stock kernel without rebuilding the entire kernel. big_trov's `runtime_40cu_unlock.sh` and gennro's toolkit both use this approach. corbanitevevo confirmed identical results to patched kernel at 2200 MHz/1030 mV.

**gennro/bc250-toolkit (CachyOS — Automated):**

```bash
curl -sSLO https://raw.githubusercontent.com/gennro/bc250-toolkit/main/bc250-toolkit.sh
sudo bash bc250-toolkit.sh
```

Automates: kernel source download, amdgpu module patching, modprobe config, and hook for kernel updates. Supports stock, deckify, and bore CachyOS kernels. Works with limine and systemd-boot (gennro, hojnikb).

**big_trov runtime script (Any Distro):** See the [bc250-collective Discord](https://discord.gg/8eZfFWhczz) project-forums for the latest `runtime_40cu_unlock.sh` — the script URL changes with updates.

### Method 2: Kernel Patch (All Distros — Fallback)

For distros without kernel-manager-based workflows, the original kernel-patch method still works:

```bash
cd /path/to/linux-source/drivers/gpu/drm/amd/amdgpu/
curl -O https://raw.githubusercontent.com/duggasco/bc250-40cu-unlock/main/patch/bc250-40cu-amdgpu.patch
patch -p5 < bc250-40cu-amdgpu.patch

make -C /lib/modules/$(uname -r)/build M=$(pwd) -j$(nproc) modules
sudo cp amdgpu.ko.zst /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/amd/amdgpu/
sudo depmod -a
echo 'options amdgpu bc250_cc_write_mode=3' | sudo tee /etc/modprobe.d/bc250-40cu.conf
sudo reboot
```

**Distro-specific instructions** (CachyOS PKGBUILD patch, Bazzite COPR kernel, Arch AUR): see [05-OS Installation](05-os-installation.md).

**Bazzite:** erewego posted pre-built RPMs against ba29 Deck kernel. Bazzite Desktop uses OGC kernel — kernel packages not yet available as of June 2026. Check the `bc250-resources` Discord channel for updated RPMs.

### Verification

```bash
dmesg | grep active_cu_number     # Expected: active_cu_number 40
dmesg | grep bc250-40cu           # Shows register writes
RADV_DEBUG=info vulkaninfo --summary 2>&1 | grep num_cu   # Expected: num_cu = 40
```

### bc250-cu-live-manager (No Kernel Patch Required — May 2026)

**Project:** [WinnieLV/bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager)
**Status:** Working (May 2026). Interactive TUI for toggling CUs live — no kernel patch, no reboot needed.

Key features:
- Toggle individual CUs on/off **while the system is running** (UMR-based)
- Vim-style keyboard navigation in terminal UI
- Auto-detects dri path (fixes Bazzite where dri index is 1, not 0)
- Persistence via systemd service (`bc250-unlock.service`)
- Shows `D+` (driver-enabled, 24 default) and `S+` (SPI-only, newly unlocked)
- Safety checks prevent invalid configurations
- Can read harvest map, toggle specific WGPs, and apply boot persistence

```bash
git clone https://github.com/WinnieLV/bc250-cu-live-manager.git
cd bc250-cu-live-manager
# Follow README instructions for your distro
```

This replaces the kernel patch method for most users. Use your distro's stock kernel + the live manager. After unlocking, verify with: `sudo cat /sys/kernel/debug/dri/0/amdgpu_gca_config | grep active_cu_number` (note: will still show 24 because the driver initialized with 24; UMR sets registers after init — big_trov).

**June 2026 update:** The live-manager now supports **disabling stock WGPs** (Work Group Processors), not just unlocking harvested CUs. This enables binary search for defective CUs — disable half, test, halve again until the bad CU is isolated (technique by pops1cl). See [10 — Troubleshooting](10-troubleshooting.md) for the full artifact hunting workflow.

### CU Health Testing

Not all CUs are healthy. Bad CUs cause immediate artifacts (green dots, visual corruption) and shutdown when enabled (koloses, meee). Some users can only identify bad CUs via in-game artifacts, not synthetic benchmarks — a board that passes Furmark may still crash in games (pm_me_kitsunemimi). The live manager makes testing much faster — toggle CUs without rebooting and spot visual artifacts immediately.

Boards with scattered harvest patterns (`■■□□■■□□■■`) likely have defective silicon.

**Live-manager method (TUI):** Enable WGPs one by one in the interactive UI and check for artifacts immediately — no reboot needed.

```bash
cd bc250-cu-live-manager
sudo ./bc250-cu-live-manager.sh
# Press 'e' to edit WGP table, toggle unlocked WGPs, test stability
# Press 'f' for full 40 CU dispatch
```

**Batch method (duggasco scripts):** Per-WGP isolation test that reboots for each WGP. More thorough but much slower.

```bash
git clone https://github.com/duggasco/bc250-40cu-unlock.git
cd bc250-40cu-unlock
sudo ./scripts/bc250-cu-health-test.sh start   # 20 reboots, tests each WGP
./scripts/bc250-compute-verify.sh               # quick check, no reboot
```

### CU Fault Detection

Doom: The Dark Ages and CS2 are more sensitive than synthetic benchmarks for detecting borderline CU faults. A board that passes Furmark may still crash in these games with unlocked CUs (community reports, May 2026).

### CU Harvest Map

Check which CUs are active/harvested on your board using the [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock) scripts (sinh_28065, lux.the.cook):

```bash
git clone https://github.com/duggasco/bc250-40cu-unlock.git
cd bc250-40cu-unlock
./scripts/cu_map.sh                              # Show current CU map
./scripts/cu_map.sh --health results.tsv         # Show map with health overlay
./scripts/bc250-cu-mask.sh --results results.tsv # Generate selective mask config
```

Most boards show the standard 24/40 map (first 6 CUs of each block active). Some users confirmed full 40/40 (dizzey0709, lux.the.cook). ungamead confirmed 38/40 (2 harvested in SE1 SH1).

**YMMV on stability:** nonu0038 tested 3 boards, only 1 ran stable with all 40 CUs. The other 2 had artifacts/crashes. If your board has an irregular harvest map (e.g., `■■□□■■□□■■` pattern), the non-stock CUs are more likely to be defective. Selective masking lets you find a stable subset.

### Selective CU Masking

**Important:** `amdgpu.disable_cu=X.Y.Z` indexes WGP **pairs**, not individual CUs (ungamead, greatapo, itsanarse). `X.Y.Z` = SE.SH.WGP-pair. Example: `1.1.1` disables WGP pair 1 on SE1 SH1 (CUs 3-4 there, NOT CUs 1-2).

CUs are disabled at WGP granularity (pairs). Disabling CU 6 also disables CU 7 in the same WGP. Format: `amdgpu.disable_cu=SE.SH.WGP-pair` (comma-separated).

```
WGP 0 = CU 0,1   (stock active)    — disable_cu=X.Y.0
WGP 1 = CU 2,3   (stock active)    — disable_cu=X.Y.1
WGP 2 = CU 4,5   (stock active)    — disable_cu=X.Y.2
WGP 3 = CU 6,7   (unlocked — test) — disable_cu=X.Y.3
WGP 4 = CU 8,9   (unlocked — test) — disable_cu=X.Y.4
```

Format: `amdgpu.disable_cu=SE.SH.WGP-pair` (comma-separated, added to `/etc/modprobe.d/bc250-40cu.conf`).

```bash
# Mask WGP pair 3 on SE0 SH0 -> 38 CUs
options amdgpu bc250_cc_write_mode=3 disable_cu=0.0.3

# Mask WGP pair 4 across all shader arrays -> 32 CUs
options amdgpu bc250_cc_write_mode=3 disable_cu=0.0.4,0.1.4,1.0.4,1.1.4
```

**Bazzite:** `rpm-ostree kargs --append="amdgpu.disable_cu=X.Y.Z"`
**CachyOS/Arch:** Add to `/etc/modprobe.d/bc250-40cu.conf` and run `sudo mkinitcpio -P` (big_trov).

### Disabling

**If using the duggasco kernel patch:**
```bash
cd bc250-40cu-unlock
sudo ./scripts/bc250-enable-40cu.sh disable   # removes config, reboots to 24 CU
sudo ./scripts/bc250-enable-40cu.sh restore   # restores original amdgpu module
```

**If using the live-manager:** Open the TUI and press `t` (Restore factory WGPs), or:
```bash
cd bc250-cu-live-manager
sudo ./bc250-cu-live-manager.sh stock-dispatch  # restores factory 24 CU layout
```

### 40 CU Crash Behavior (big_trov, codyrainy, cralant, May 2026)

Three distinct crash modes exist when pushing 40 CU limits:

| Symptom | Voltage/Freq | Cause | Fix |
|---------|-------------|-------|-----|
| **OCP hard lock**: monitor standby, reset/power buttons unresponsive, requires power cable pull | 2400 MHz at any voltage | Over Current Protection triggering | Stay at or below 2300 MHz |
| **Hard lock**: monitor standby, reset button fails, power drops to ~20W | >1000 mV at 2300+ MHz | Suspected OCP/VRM limit | Reduce voltage below 1000 mV or lower clocks |
| **Soft freeze**: monitor stays on, reset works, power 130→75W | <1000 mV | Voltage unstable for clocks | Increase voltage by 10-15 mV |

2400 MHz at 40 CU consistently causes OCP hard lockup across multiple boards regardless of cooling (big_trov, codyrainy, cralant). One user with AIO cooling reported 2400 MHz at 1120 mV stable (needs >1100 mV or loses FPS; crashes at 1050 mV). Higher CPU overclock lowers the GPU voltage threshold for hard lock -- this is a system-wide power limit, not GPU-specific (big_trov, hojnikb). Defective CUs can individually clock to 2600 MHz -- the defect is NOT clock capability, likely a global OCP/VRM limit. VRM temps are the hidden bottleneck; thermal adhesive tape is insufficient for VRM cooling (capt.cat_13).

**Additional OCP findings (late May 2026):** Above ~1850-2200 MHz (varies by board), a secondary power limit is tripped causing hard lock where even reset and power buttons fail (big_trov). This is distinct from the voltage ceiling — it's a system-level power limit. A shunt mod may be needed to bypass it (big_trov, May 2026). At 2300 MHz, only ~1025 mV is passable for Superposition on some boards; any higher voltage causes hard lock, any lower causes freeze but remains resettable (big_trov, May 2026).

### PS5 40 CU Patch Confirmed

The BC-250 40 CU unlock patch (`bc250-40cu-amdgpu.patch`) also works on **PS5 Linux** (gennro, via PS5 Linux Discord, May 2026). The jump from 36 CU to 40 CU on PS5 gives approximately 4% more benchmark score. Note: the PS5 hypervisor still runs during Linux, which may limit performance compared to BC-250 results.

### CPU Core Unlock (Jul-Aug 2026 — FUNCTIONAL)

The BC-250 has 6 active Zen 2 CPU cores; the disabled cores are believed to be software/firmware-blocked, not physically fused off. As of late July 2026, functional unlocks now exist via multiple approaches:

**How the unlock works (porocyon, Jul 30 2026):** The Python script sends a mailbox message to the SMN/PSP (Platform Security Processor) through PCIe, which makes the PSP unlock all cores on the next boot. This is **entirely OS-independent** — the same mechanism works on any OS. The exploit bypasses the security check and writes an arbitrary bitmask to the core presence register.

**Alternate bitmasks (0xcats, Jul 30 2026):** The write primitive is not limited to 0xFF. 0xcats tested writing other bitmasks: 0x7F (enables core 3, disables core 7), 0xF7 (enables core 7, disables core 3). This means **7 out of 8 core unlocks are possible** on boards where one specific core is defective — the interconnect to cache may be wrong on that core. Not all boards have the same bad core.

**Non-0x77 core masks (fforduck, Jul 30 2026):** fforduck tested a board with core mask 0x7B (instead of the standard 0x77). The Python script was edited to target this mask and all 8 cores work correctly. If your board has a non-standard disabled-core layout, the script can be modified to match.

**Option 1: Patched BIOS (Permanent)** — [RescueMei/BC250-DXE-SMU-Core-Unlock](https://github.com/RescueMei/BC250-DXE-SMU-Core-Unlock)
- DXE/SMU patched BIOS that enables all 8 cores permanently
- **Now includes unlock option in the CPU configuration section** and official SteamOS boot logo at boot (yrouel86, Aug 1 2026)
- ⚠️ **Verify your cores work first with the Python script** — if cores don't work and you flash the modded BIOS, you're stuck and need an external programmer to recover (yrouel86, Jul 2026)
- RescueMei bought a second BC-250 specifically as an open benchtest for BIOS development (Jul 31 2026)

**Option 2: EFI Shim (Semi-Permanent, No BIOS Modification)** — [Hexxeh/bc250-efi-core-unlock](https://github.com/Hexxeh/bc250-efi-core-unlock)
- EFI boot shim that unlocks cores at every boot without touching the BIOS
- Add to the EFI boot partition and add to boot targets (NVMe steps in progress by Hexxeh, Jul 2026)

**Option 3: Python Script (rw-r-r-0644)** — [rw-r-r-0644/bc250-core-unlock](https://github.com/rw-r-r-0644/bc250-core-unlock)
- The original unlock script. Sends the SMU mailbox message directly from Linux userspace
- ⚠️ Does not survive hard shutdown — if the board crashes, it reverts to 6 cores (dizzey0709, Jul 30 2026)
- Best for verifying your cores work before committing to the permanent BIOS mod

**Option 4: SMU Mailbox 0x98 Tool (gabriwar, Aug 2026)** — [GabriWar/bc250-core-cu-unlock](https://github.com/GabriWar/bc250-core-cu-unlock)
- Full Linux tool for unlocking **8 CPU cores AND 40 CU** without a BIOS flash: `status`/`apply`/`install` subcommands, plus a systemd unit that re-applies the mask after cold boot
- Mechanism: writes the core-enable bitmask register **`SMN 0x0115A870`** (factory `0x77` = 6 cores, `0xFF` = 8 cores) through an **SMU mailbox message `0x98`**, reached via the PCI config index/data pair `0xB8`/`0xBC` on device `00:00.0`. Same register/primitive family as the Python script, packaged with validation
- **Warm vs cold reset:** a warm reboot (`reboot`) preserves the unlock; a cold boot (`poweroff`, PSU switch) reverts to `0x77` — a guaranteed escape hatch. The systemd unit handles the cold-boot case (never auto-reboots; an early version that did bootlooped a board)
- **`test-cores.sh`** runs per-core `stress-ng --verify` (20s/core, ~3 min) — on the author's board the two unlocked cores (3 and 7) were 100% healthy, spread ±0.3% (7-zip +26.9%: 53,610 → 68,039 MIPS)
- ⚠️ **Re-tune overclocks after unlocking** — two extra cores change load-line droop, thermals (82.4°C Tctl at stock under 16-thread load), and the CPU/GPU shared power budget. An old curve is no longer valid; a voltage stable at 6 cores can be marginal at 8
- ⚠️ **GPU clock monitoring breaks after 8-core unlock** — see the metrics fix notes below. The repo bundles higorprado's SMU telemetry patch under `kernel/`
- Also ships a **ready-to-flash 8-core BIOS** (`bios/`, P5.00_clv base with the unlock driver and a custom boot logo) and an ACPI fix installer — see the ACPI section below

**8-core GPU metrics fix options (Aug 2026):**
- **keroppl_wizard patch (Jul 30 2026):** [bc250-cyan-skillfish-8core-metrics.patch](https://github.com/keyboardspecialist/bc250-steamos/blob/master/bc250-audio-fix/bc250-cyan-skillfish-8core-metrics.patch) — kernel-level fix, compatible with 6 and 8 core configs
- **`fix-freq` governor option (filippor, commit `be9537f`, Aug 2026):** the `cyan-skillfish-governor` gained a userspace `fix-freq = true` option that fixes the 8-core GPU clock reporting via bind mounts — no kernel patch needed (thanks to punsh). See [06-gpu-governor.md](06-gpu-governor.md)
- **higorprado telemetry mapping:** [higorprado/bc250-8core-telemetry-report](https://github.com/higorprado/bc250-8core-telemetry-report) — reverse-engineered the 8-core SMU metrics layout (the 8-core per-core arrays displace `GfxclkFrequency` in the fixed 116-byte metrics table, so the driver reads a residency counter instead of a clock)

**8-core ACPI fix required after unlock (Aug 2026):** The community ACPI fix (`bc250-acpi-fix`) declares one processor object per *thread*, and the 6-core tables stop at `C00B` (12 threads). Once all 8 cores are active you have 16 threads, so **CPUs 12–15 get no cpuidle states at all** — they cannot enter any C-state and burn power at idle. [mendesrr/bc250-acpi-fix-updated-8c](https://github.com/mendesrr/bc250-acpi-fix-updated-8c) rebuilt the tables to extend the declarations to `C00F` (16 threads). The gabriwar tool wraps this in `bc250-acpi-fix.sh` (`status`/`install`/`revert`), which fetches the 8-core SSDTs, backs up your tables and rebuilds the initramfs (Arch/CachyOS/mkinitcpio). For Bazzite/SteamOS, follow the README in the source repo. Verify with `cpupower idle-info` or check for missing C-states.

**Field reports (Aug 2026):**
- **glide_2026 (03/08):** temporary unlock, Elden Ring gained ~10 fps ("definitely added 10ish frames", still fluctuates around 60). Ratchet & Clank Rift Apart "incredible with 8 cores and 40 CUs" with the gfx1013-fix
- **crazy_t0176 (03/08):** flashed the 8-core BIOS (Forbidden-Darkness UEFI script) — great FPS, but GPU clocks read only 20–100 MHz. bigmedi's reply: "Not yet" (the metrics fix landed days later — see the metrics options above)
- **seb061492 (04/08):** OC that was stable at 6 cores (4000 MHz) crashes in Unigine with 8 cores unlocked, even at 3500 MHz, unless the SMU service/governor is disabled entirely — likely a marginal unlocked core (baalah: "bad cpu core"). His 40 CU @ 2200 MHz kept working
- **dmoraza (03–04/08):** 0x7B mask works for some boards, but 8-core + governor on kernel 7.1 gives a black screen; OK on 6.18 (see [10-troubleshooting.md](10-troubleshooting.md) for the governor kernel note)
- **fforduck (03/08):** CPU 4 and 5 pass stress tests yet misbehave in some games — he sets Steam to use all cores *except* 4 and 5 rather than fully disabling them. Partial core masks are supported (see alternate bitmasks above)
- **Silicon lottery update (xseol, 06/08):** ~80% chance for 40 CU, 8 cores still new — estimate 50–60% for 8-core + 40-CU together ("you need to win two silicon lotteries")

**Auto-activation script (qwert9811, Jul 2026):** A community script checks for 8 active cores on cold boot, runs the unlock Python script if needed, and reboots (with a reboot counter to prevent infinite loops). Works on CachyOS desktop.

**Game mode shortcut (dbkretro, Aug 1 2026):** The unlock script can be added as a non-Steam game in game mode — tap the icon, it runs the unlock steps and reboots. Requires sudoers entry to avoid password prompts.

**Silicon lottery (0xcats, Jul 30 2026):** Of 5 boards tested, 1 could not reliably boot with all 8 cores (crashes or hangs during POST). That board had core mask 0x7E — core 0 defective. Roughly **80% success rate** in this small sample. Boards that fail POST with the unlock typically need an external programmer to recover.

**Background:** duggasco and mrfrakes previously decompiled and extracted bootrom and understood how the PSP (Platform Security Processor) checks and initializes cores from fuses. The working theory was that cores are controlled by a ROM array written during manufacturing rather than physically fused off — now validated by the working unlocks. Early speculation: unlocking BC-250 cores could theoretically apply to other low-end Ryzen CPUs with disabled cores, but that's uncharted territory.

**jwagnervaz BIOS Rev Eng (Jul 09-11, 2026):** Another independent modder is reverse engineering a custom BIOS for the BC-250:
- "Working in rev eng to make a better bios to bc 250" — posted progress photos from Jun 20, 2026 (Jul 2026)
- Already fixed ACPI tables and made optimizations; prior experience modding X99 Chinese boards
- Tested ALL available 4700S BIOS images found: **none boot** on BC-250 — different memory lithography and different ABL SMU between the two chips (Jul 11, 2026)
- Boot stops at UART-debuggable point "in another place" after partial adjustment — working toward next breakthrough with UART debug tools
- Goal: "port bootsec/tpm and find some solution to windows drivers. one step at a time."
- Note: mrfrakes claims to have booted 4700S C08 BIOS on BC-250 with external GPU — may require specific BIOS version and external GPU like the original 4700S setup (Jul 11, 2026)

**VCN unlock discussion (Jul 30 2026):** thelamer proposed using the same register exploit for VCN (video codec) hardware decode — `VCN feature version: 0, firmware version: 0x00000000` suggests the hardware is present but disabled. yrouel86 notes this would still need the firmware blob, and it would most likely need to be signed. VCN unlock remains an open research question.

*Credits: RescueMei (@The Mei™, patched BIOS), Hexxeh (EFI shim), qwert9811 (auto-activation script), rw-r-r-0644 (Python unlock script), 0xcats (alternate bitmask testing), fforduck (0x7B mask testing), keroppl_wizard (8-core metrics patch), dbkretro (game mode shortcut), jwagnervaz (independent BIOS rev eng, 4700S testing), yrouel86 (verification guidance), zedan015 (non-standard core layout testing), porocyon (SMN/PSP mechanism explanation), dizzey0709 (hard shutdown behavior), gabriwar (SMU mailbox 0x98 unlock tool), filippor (fix-freq governor option), punsh (fix-freq discovery), higorprado (8-core SMU metrics layout), mendesrr (8-core ACPI tables).*

### SMU Firmware Reverse Engineering (Jul 2026)

The [bc250-collective/amd_smu_reverse_engineering](https://github.com/bc250-collective/amd_smu_reverse_engineering) project is reverse engineering the SMU (System Management Unit) firmware — the tiny microcontroller on the APU die that handles power, voltage, frequency, and thermal management. The SMU is a PS5-customized variant (not the standard AMD SMU), which is why standard tools like ZenStates-Core don't work.

Key findings so far:
- The BC-250 has **one SMU** for both CPU and GPU (unlike standard Ryzen which has separate ones)
- SMU firmware is Xtensa-based and can be extracted from BIOS using PSPTool
- Ghidra scripts map SMU message handlers — message IDs match the amdgpu driver's `smu_v11_8_ppsmc.h`
- The SMU has a cooperative scheduler with task states (READY, WAIT_LOCK, SLEEP, WAIT_EVENT, SUSPENDED)
- Sony customized the SMU for PS5 sleep mode — the sleep commands are unmapped/unknown on BC-250

**Why this matters:** Unlocking SMU commands could enable CPU overclocking (currently limited to ~4 GHz via `bc250_smu_oc`), proper sleep/suspend mode, and finer power management. ded811 is actively working on sleep mode through SMU analysis. keroppl_wizard is using AI-assisted BIOS ROM analysis.

*Credits: ded811 (SMU research, sleep mode), big_trov (repo discovery), keroppl_wizard (BIOS ROM analysis), keyboardspecialist (SMU-FINDINGS.md).*

### 40 CU Kernel Build Warnings

- Default governor clocks/voltages are designed for 24 CU. Reduce clocks to ~1850 MHz for 40 CU to avoid board damage (erewego).
- `nct6687` module often missing from custom kernels → fan RPM not reported. Reinstall governor after kernel change (erewego, fallenmask).
- `xone-dongle` module may be missing → wireless Xbox controller broken (kurozip).
- MangoHud may show 0% GPU usage after kernel update (fallenmask).
- `cu_health_check.sh` causes boot loops on some boards. Use `cu_check.sh` from nonu0038 instead (realdern, lil_gabo, essdee4336).

### Credits

duggasco (research, repo), filippor (independent testing, ignore_cu_harvest), scallion_9883 (benchmarks), vinnijs.dev (bc250-cu-live-manager), faithy2386 (P4.00 BIOS discovery, flashrom testing), meee (CU artifact detection), pm_me_kitsunemimi (game-based CU testing), Claude/Codex (SPI register discovery), kilrah (disable_cu masking), hojnikb (harvest maps), koloses (bad CU testing), essdee4336 (thermal), big_trov (stable verify), codyrainy (build test).