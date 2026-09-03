# 02 — BIOS & Firmware

> Flashing a modded BIOS is **mandatory** to unlock VRAM allocation and hidden chipset settings.

---

## Recommended Modded BIOS

| File | Version | Status |
|------|---------|--------|
| **BC250_3.00_CHIPSETMENU.ROM** | P3.00 | ✅ **Recommended** — most stable, tested widely (source: elektricM flashing.md; mod by Segfault) |
| `P4.00` (stock) | P4.00 | ❌ **Unstable** — undocumented version found on some boards; 3D apps crash (faithy2386) |
| `P5.00_clv` variants | P5.00 | ⚠️ Advanced — unlocks everything (ReBAR, PXE) but **easy to brick** | [confirmed: @etho2520, 24/02/2026] |
| **gabriwar P5.00 Toggle BIOS** | P5.00 + cores | ⚠️ Experimental — all settings unlocked **plus harvested CPU cores as a toggleable option** (enable/disable from BIOS without reflashing). Known as "megabias" / `allthecoolshit.rom`. Not yet widely released; keroppl_wizard, j0shm1lls testing Aug 2026–present. keroppl_wizard: "I'll flash when the final megabios is released" (Aug 5 2026). |
| **ForbiddenDarkness 8-core BIOS** (via UEFI v2.2 menu script) | P3.00 + cores | ⚠️ Widely used Aug 2026 — modded P3.00 with 8-core unlock option + selectable themed boot images (CachyOS, Bazzite, SteamOS logo). Flashed via [AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script](https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script). Recommended over plain RescueMei images by some users ("they do nicer releases" — rescuemei, Aug 7 2026). One report of boot failure after flashing (dmoraza, Aug 8 2026) — test and keep a backup. |

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

### Method 5: Forbidden-Darkness V3 DXE BIOS (Aug 2026)

**Project:** [RescueMei/BC250-DXEv3-BIOSMOD](https://github.com/RescueMei/BC250-DXEv3-BIOSMOD)

Full V3 BIOS mod with DXE drivers for ACPI patching, SMU Unlock, Core Unlock, and manual core selection. Companion repo [RescueMei/BC250-DXEv3-SMU-Patch](https://github.com/RescueMei/BC250-DXEv3-SMU-Patch) provides a DXE driver that fixes 8-core reporting by changing the `[6]` fields to `[8]` in `smu11_driver_if_cyan_skillfish.h` (requires SMU unlock to apply). Pushed 23/08/2026 (Forbidden-Darkness). Experimental — test on a backup board first.

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

**Which method should you use? (decision table)**

| Method | Type | Persistence | Risk | Best for | Details |
|--------|------|-------------|------|----------|---------|
| **4. SMU mailbox tool (gabriwar)** | Userspace + systemd | Re-applied after cold boot by systemd unit | Low — no BIOS flash, warm reboot reverts | **Recommended all-rounder**: 8 cores + 40 CU, ships `test-cores.sh` + ACPI fix installer | Option 4 below |
| 3. Python script (rw-r-r-0644) | Userspace SMU write | Lost on hard shutdown/cold boot | Low | Verifying your cores work before committing to anything permanent | Option 3 below |
| 2. EFI shim (Hexxeh) | Boot shim | Re-applied at every boot | Low — BIOS untouched | Semi-permanent unlock without flashing | Option 2 below |
| 1. Patched BIOS (RescueMei / Forbidden-Darkness) | BIOS flash | Permanent (survives everything; only a reflash clears it) | **Highest** — defective cores require an external programmer to recover | Set-and-forget, AFTER cores are verified | Option 1 below |
| 5. Control center (movacx) | GUI app | — | — | One-click unlock + monitoring in one install | Option 5 below |
| 6. SteamOS toolkit (rpf16rj) | Toolkit | Survives cold boot + SteamOS updates | — | SteamOS users | Option 6 below |

⚠️ **Regardless of method: test the unlocked cores FIRST** (Option 3 script or Option 4 `test-cores.sh`). If the extra cores are defective and you already flashed a permanent BIOS, you need an external programmer to recover (yrouel86, Jul 2026).

**How the unlock works (porocyon, Jul 30 2026):** The Python script sends a mailbox message to the SMN/PSP (Platform Security Processor) through PCIe, which makes the PSP unlock all cores on the next boot. This is **entirely OS-independent** — the same mechanism works on any OS. The exploit bypasses the security check and writes an arbitrary bitmask to the core presence register.

**Alternate bitmasks (0xcats, Jul 30 2026):** The write primitive is not limited to 0xFF. 0xcats tested writing other bitmasks: 0x7F (enables core 3, disables core 7), 0xF7 (enables core 7, disables core 3). This means **7 out of 8 core unlocks are possible** on boards where one specific core is defective — the interconnect to cache may be wrong on that core. Not all boards have the same bad core.

**Non-0x77 core masks (fforduck, Jul 30 2026):** fforduck tested a board with core mask 0x7B (instead of the standard 0x77). The Python script was edited to target this mask and all 8 cores work correctly. If your board has a non-standard disabled-core layout, the script can be modified to match.

**Non-0x77 masks usually mean defective cores (nobulletsfound case, Aug 17 2026):** a board reporting core presence mask **0xB7** triggered the unlock script's warning ("high probability of defective cores - STOPPING!"). Overriding with `-f` booted but produced graphical glitches and crashes — the enabled cores were indeed defective (@caredil_bg, @dizzey0709: the non-standard factory mask likely maps out defective cores). Custom per-core masks (e.g. running only 7 healthy cores) are an in-progress community effort — not available yet (dizzey0709, 17/08/2026).

**Bad-core workaround without reflashing (h00man._., 16/08/2026):** on a board where core 3 fails under load, boot with kernel param `isolcpus=6,7` plus a small systemd script that offlines those two threads (core 3) at boot — keeps the 8-core BIOS usable while avoiding the bad core.

**Option 1: Patched BIOS (Permanent)** — [RescueMei/BC250-DXE-SMU-Core-Unlock](https://github.com/RescueMei/BC250-DXE-SMU-Core-Unlock)
- DXE/SMU patched BIOS that enables all 8 cores permanently
- **Now includes unlock option in the CPU configuration section** and official SteamOS boot logo at boot (yrouel86, Aug 1 2026)
- ⚠️ **Verify your cores work first with the Python script** — if cores don't work and you flash the modded BIOS, you're stuck and need an external programmer to recover (yrouel86, Jul 2026)
- RescueMei bought a second BC-250 specifically as an open benchtest for BIOS development (Jul 31 2026)
- **MeiMeiDXE V2.1 (Aug 7 2026):** the [RescueMei/BC250-DXEv2-BIOSMOD](https://github.com/RescueMei/BC250-DXEv2-BIOSMOD) successor adds **auto cold boot** — on compatible boards with constant/standby power (native ATX mod), it powers off the board via RTC-wake scheduling into S5 when a config change (e.g. disabling the 8-core option) requires a cold boot to take effect. Builds custom ROMs with themed boot images; rescuemei now builds and flashes BIOS roms directly on a BC-250 (Jul-Aug 2026)
- **Recommended BIOS (Aug 7 2026):** ForbiddenDarkness' variants of the same firmware are widely recommended — "I would go with @NY's ForbiddenDarkness's version... they do nicer releases" (rescuemei), and they're used by the [AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script](https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script) installer with selectable boot images

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

**Quick start (unlock + verify):**

```bash
git clone https://github.com/GabriWar/bc250-core-cu-unlock
cd bc250-core-cu-unlock

sudo ./bc250-8core-unlock.sh status     # show current core mask (factory 0x77 = 6 cores)
sudo ./bc250-8core-unlock.sh apply      # unlock now (then: sudo reboot — warm reset preserves it)
./test-cores.sh          # per-core health sweep, 20s/core (~3 min)
./test-cores.sh 60       # longer, more thorough sweep
sudo ./bc250-8core-unlock.sh install    # persist across cold boots via systemd unit
```

Requires `stress-ng` and 8 cores already visible (run the unlock first). Interpretation: `failed > 0` on any core → that core produces WRONG results, do not use; one core far below the median → marginal silicon, re-test at stock clocks; spread within ~1% → normal binning.
- ⚠️ **Re-tune overclocks after unlocking** — two extra cores change load-line droop, thermals (82.4°C Tctl at stock under 16-thread load), and the CPU/GPU shared power budget. An old curve is no longer valid; a voltage stable at 6 cores can be marginal at 8
- ⚠️ **GPU clock monitoring breaks after 8-core unlock** — see the metrics fix notes below. The repo bundles higorprado's SMU telemetry patch under `kernel/`
- Also ships a **ready-to-flash 8-core BIOS** (`bios/`, P5.00_clv base with the unlock driver and a custom boot logo) and an ACPI fix installer — see the ACPI section below
- The SMU mailbox mechanism bypasses the signing requirement — "you can make arbitrary modifications without signing" (thelamer, Aug 6 2026)

**Option 5: movacx/bc250-control-center (Aug 2026)** — [movacx/bc250-control-center](https://github.com/movacx/bc250-control-center)
- Linux control center bundling monitoring, GPU SMU control, CPU OC, fan PWM control and 40 CU tools — includes a one-click 8-core unlock (skcanss used it for the core unlock, Aug 2 2026). Single install for most unlock needs

**Option 6: SteamOS Real Toolkit (Aug 2026)** — [rpf16rj/bc250-steamos-real-toolkit](https://github.com/rpf16rj/bc250-steamos-real-toolkit)
- Bundles the SteamOS 40 CU unlock together with the 8-core unlock; the 8-core state **survives a cold boot without a BIOS flash** and survives SteamOS updates (luciud, Aug 7 2026: "It nice especially since the SteamOS 40CU unlock comes with the 8core and survives a cold boot without needing a bios flash... It even survives steamos updates too")

**8-core GPU metrics fix options (Aug 2026):**
- **keroppl_wizard patch (Jul 30 2026):** [bc250-cyan-skillfish-8core-metrics.patch](https://github.com/keyboardspecialist/bc250-steamos/blob/master/bc250-audio-fix/bc250-cyan-skillfish-8core-metrics.patch) — kernel-level fix, compatible with 6 and 8 core configs
- **`fix-freq` governor option (filippor, commit `be9537f`, Aug 2026):** the `cyan-skillfish-governor` gained a userspace `fix-freq = true` option that fixes the 8-core GPU clock reporting via bind mounts — no kernel patch needed (thanks to punsh). See [06-gpu-governor.md](06-gpu-governor.md)
- **higorprado telemetry mapping:** [higorprado/bc250-8core-telemetry-report](https://github.com/higorprado/bc250-8core-telemetry-report) — reverse-engineered the 8-core SMU metrics layout (the 8-core per-core arrays displace `GfxclkFrequency` in the fixed 116-byte metrics table, so the driver reads a residency counter instead of a clock)

**8-core ACPI fix required after unlock (Aug 2026):** The community ACPI fix (`bc250-acpi-fix`) declares one processor object per *thread*, and the 6-core tables stop at `C00B` (12 threads). Once all 8 cores are active you have 16 threads, so **CPUs 12–15 get no cpuidle states at all** — they cannot enter any C-state and burn power at idle. [mendesrr/bc250-acpi-fix-updated-8c](https://github.com/mendesrr/bc250-acpi-fix-updated-8c) rebuilt the tables to extend the declarations to `C00F` (16 threads). The gabriwar tool wraps this in `bc250-acpi-fix.sh` (`status`/`install`/`revert`), which fetches the 8-core SSDTs, backs up your tables and rebuilds the initramfs (Arch/CachyOS/mkinitcpio). For Bazzite/SteamOS, follow the README in the source repo. Verify with `cpupower idle-info` or check for missing C-states.

**Unified ACPI fix repo (e_tho, 15/08/2026):** [e-tho/bc250-acpi-fix](https://github.com/e-tho/bc250-acpi-fix) consolidates the unmaintained original plus the forks, and adds fixes none of them had: enables **C1/C2 idle states**, **8 frequency-scaling steps from 800 MHz to 3.2 GHz**, stubs the undefined control methods that throw errors at boot, and replaces the broken idle state table (rw_r_r-0644's approach) instead of adding a second one alongside it. Works on 6-core *and* 8-core boards on every BIOS release; tested idle at 800 MHz → boost ~3.5 GHz. Note: if running a BIOS with built-in ACPI tables (The Mei™'s), disable ACPI injection in firmware setup first. C1 does real work (core halting); no measurable power saving from C2 (e_tho, 16/08/2026).

### 8 Cores ≠ 6 Cores: The Full Process (Aug 2026)

Unlocking to 8 cores is not a drop-in change — the board, ACPI, governor and OC all need rework. The community consensus process that emerged this week:

**1. Test your cores first, then flash.** The BIOS mod is now the dominant method (rescuemei: "I just use a bios mod for unlocking them on my bc250s since I know their cores are good", Aug 13 2026), but it is mandatory to verify the unlocked cores *before* committing to a flash: "TEST YOUR CORES WITH @rw-r-r-0644'S SCRIPT BEFORE FLASHING THE BIOS TO ENABLE THEM" (rescuemei, Aug 13 2026). The BIOS mod "does the same exact unlock and warm reset, just faster and at boot" (rescuemei, Aug 13 2026), and "only enable the 8 core unlock if your system is stable at 8 through the script" (rescuemei, Aug 13 2026). If the extra cores are defective and you flashed the BIOS anyway, you must recover via external programmer.

**2. Apply the ACPI fix — and accept a small FPS cost.** The 6-core ACPI tables stop at 12 threads (`C00B`); 8 cores = 16 threads, so CPUs 12–15 get no cpuidle states (see the ACPI section above). Several users report the ACPI fix has a measurable framerate hit: dbkretro (Aug 10 2026): "I get a perf drop from solid 60fps to 52-55fps on RE4 with ACPI on in the BIOS, same as when I tried it in software" and "Your mileage may vary with ACPI, at least a few of us have found it can hit the frame rate" (Aug 13 2026). dizzey0709 (Aug 10 2026) noted reduced FPS in GPU-intensive tasks after enabling 8 cores + ACPI together, and wondered if ACPI's clock management conflicts with the governor — no consensus yet. The BIOS-built-in ACPI fix uses the same tables as the software one (rescuemei: "Yeh, it's inserting the same acpi tables", Aug 10 2026), so the FPS behavior is equivalent.

**3. Re-tune the CPU OC.** The unlocked 8-core config changes load-line droop, thermals and the shared CPU/GPU power budget. seb061492 (Aug 4 2026) found an OC stable at 6 cores (4 GHz) crashes in Unigine at 8 cores — even at 3.5 GHz — unless the governor/SMU service is disabled entirely (likely a marginal unlocked core, baalah: "bad cpu core"). Typical working 8-core configs this week: 3.5–3.85 GHz CPU (sho.ta: 8 cores @ 3.85 GHz 1150 mV for RDR2) vs 4.0–4.1 GHz common on 6 cores. mitchthepreacher (Aug 13 2026): OCCT's Combined setting (CPU+GPU together) throws errors at CPU 4 GHz — "I should probably back off... Don't seem to have any issues in games." Stress test the combined load, not just single-core.

**4. Expect +10-12°C and higher power draw.** felingreenleaf (Aug 12 2026) measured MK1 at 54–58 FPS on 6 cores vs 59–60 FPS on 8 cores — "about a 10-12C difference" in temps. buzzynoob (Aug 6 2026): "Since the new core unlocks the power draw has increased". Factor both into your cooling and PSU margin.

**5. Re-enable GPU metrics** via the `fix-freq` governor option or the kernel patch (see the metrics fix options above and [06-gpu-governor.md](06-gpu-governor.md)) — the 8-core per-core SMU arrays displace `GfxclkFrequency`, so `pp_dpm_sclk` shows nonsense until fixed.

**6. Defective-cores contingency.** Not every board unlocks cleanly: fforduck (Aug 3 2026) has cores 4 and 5 that pass stress tests yet misbehave in some games — he pins Steam to use all cores *except* 4 and 5 (partial masks are supported, see alternate bitmasks above). If a single core is bad, the 7-of-8 mask (`0x7F`/`0xF7`) is a valid target.

**Why this is not a "just unlock" switch:** the 6-core vs 8-core difference is not only the two extra cores — ACPI cpuidle coverage, GPU telemetry layout, load-line response and thermal envelope all change. Users who enable 8 cores without the ACPI fix burn power at idle on CPUs 12–15; users who skip the metrics fix get wrong GPU clock readings; users who skip re-tuning risk instability at old OC voltages.

**Auto-activation script (qwert9811, Jul 2026):** A community script checks for 8 active cores on cold boot, runs the unlock Python script if needed, and reboots (with a reboot counter to prevent infinite loops). Works on CachyOS desktop.

**Game mode shortcut (dbkretro, Aug 1 2026):** The unlock script can be added as a non-Steam game in game mode — tap the icon, it runs the unlock steps and reboots. Requires sudoers entry to avoid password prompts.

**Silicon lottery (0xcats, Jul 30 2026):** Of 5 boards tested, 1 could not reliably boot with all 8 cores (crashes or hangs during POST). That board had core mask 0x7E — core 0 defective. Roughly **80% success rate** in this small sample. Boards that fail POST with the unlock typically need an external programmer to recover.

*Credits: RescueMei (@The Mei™, patched BIOS, test-before-flash guidance), Hexxeh (EFI shim), qwert9811 (auto-activation script), rw-r-r-0644 (Python unlock script), 0xcats (alternate bitmask testing), fforduck (0x7B mask testing, partial-mask gaming workaround), keroppl_wizard (8-core metrics patch), dbkretro (game mode shortcut, ACPI FPS cost report), jwagnervaz (independent BIOS rev eng, 4700S testing), yrouel86 (verification guidance), zedan015 (non-standard core layout testing), porocyon (SMN/PSP mechanism explanation), dizzey0709 (hard shutdown behavior), gabriwar (SMU mailbox 0x98 unlock tool), filippor (fix-freq governor option), punsh (fix-freq discovery), higorprado (8-core SMU metrics layout), mendesrr (8-core ACPI tables), movacx (control center), rpf16rj (SteamOS toolkit), luciud (SteamOS persistence report), skcanss (unlock persistence testing), buzzynoob (power draw), alexxxor_ (BIOS hash mismatch), midlifediy (EFI-vs-BIOS observation), j0shm1lls (bad-core report), vadym557 (boot failure with bad cores), felingreenleaf (8-core temp delta), seb061492 (8-core OC regression report), mitchthepreacher (combined stress report), sho.ta (8-core RDR2 config).*

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

---

## Research & Active Projects

### VCN Hardware Video Decode

**Status:** Active research — major progress Aug-Sep 2026. VCN 2.0.3 is confirmed **present and NOT harvested** (IP discovery, instance 0, harvest=0), but the Linux driver deliberately skips its registration. The problem is diagnosed as a **power-path issue, not a codec or firmware issue**.

**Root cause (thelamer, Aug 14 2026):** On Cyan Skillfish (GC 10.1.3) `adev->pg_flags = 0`, the board has **no `dpm_set_vcn_enable` callback**, and generic SMU code returns success when that callback is absent. `vcn_v2_0_start()` then proceeds into VCN PGFSM/MMIO accesses assuming power-up succeeded — but **VCN is still physically powered down**, so touching the block hard-locks the machine. "This is increasingly looking less like 'VCN fused off' and more like unused IP that AMD simply didn't wire up in the BC250 software stack" (thelamer, 14/08/2026).

**Working theory (Jobs, per thelamer):**
- **Job 1:** recover the missing BC250/Cyan Skillfish VCN power-on mechanism — an omitted SMU message mapping or a direct power/isolation register sequence. Success criterion: keep the machine alive and get VCLK to move from 0.
- **Job 2:** once provably powered, re-enable the VCN 2.0.3 driver/firmware path and bring up rings/decoding.

**Progress (Aug 13-15 2026):**
- paul_lionking got amdgpu to recognize VCN 2.0.3 and load Navi VCN 2.0 firmware (`navi10_vcn.bin` aliased as `vcn_2_0_3.bin`; Navi10/12/14 blobs are byte-for-byte identical); the machine stays stable when init stops before `amdgpu_vcn_resume()`. On a normal boot SMU reports: VCN Powered down, VCLK = 0, DCLK = 1111.
- paul_lionking extracted the resident BC250 SMU/MP1 PMFW from the BIOS (Xtensa, v88.6.0) and reverse-engineered the message dispatcher: raw SMU command `0x2A` is NULL in the BC250 table; undocumented public commands are `0x1F`, `0x20`, `0x26` (none looks like a VCN power switch). `smu_v11_5_ppsmc.h` defines `PPSMC_MSG_PowerDownVcn 0x8` / `PowerUpVcn 0x9` — bjaan: "most probably 0x8 and 0x9 are the messages to disable & enable power to the VCN block... they're just not implemented for the BC-250 version 11.8".
- rw_r_r_0644 (Aug 15 2026): "We have fully arb code execution on the SMU at runtime via a bug in one of the message handlers" — appears exclusive to Cyan Skillfish (PS5/coreboot have an extra bound check). Can set arbitrary clocks/voltages (incl. ~2 GHz GDDR6) and write core masks. Possible path to power-up the VCN from the SMU; exploit cleanup pending.
- Historical context: holde and Angablade got the SMU to wake the VCN block ~a year ago (one malformed frame via ffmpeg) but did not publish the SMU command. holde (Aug 14 2026): firmware is signed **by AMD, not Sony** — corrects earlier doc statements blaming Sony.

**Progress (Aug 17-24 2026):**
- bjaan (14/08/2026) mapped the CH3 SMU message-handler table and found an unused message `0xA4` slot plus a dormant PMFW handler at offset `0x1c1a0` that feeds `0x309b4` — a substantial platform/power transition routine. Registering the handler alone (without sending A4) hung the machine during boot — rules out that activation route but confirms a genuine dormant control path exists.
- bjaan (15/08/2026): direct VCN firmware loads (`navi10_vcn.bin`, bypassing PSP) all end in system hang. His traced builds show the direct-load patch bypasses PSP authentication, places firmware in the VCN buffer, and initialization progresses all the way into `vcn hw_init` — it still hangs when the decoder ring is first exercised.
- dantistnfs (18/08/2026), power-on validation criteria: status register reports powered on + VCN operating frequency enabled + firmware loading no longer crashes (firmware gets rejected by PSP with error `0xffff0008` for others). rw_r_r_0644 built an RPC-style patch that can call any SMU function from Python (published in [bc250-smu-unlock](https://github.com/rw-r-r-0644/bc250-smu-unlock)).
- thelamer (19/08/2026): shipped unlock + the new power-on method as helpers in [bc250-lab-image v0.3.0](https://github.com/thelamer/bc250-lab-image/releases/tag/v0.3.0) as a dedicated POC platform ("if this works it will be a combination of smu commands, custom kernel, and possibly customization to libva").
- **Status summary (yrouel86, 24/08/2026):** "Firmware loading has been solved AFAIK, the issue that remain is to properly turn on and initialize the VCN, powering it seems to have been solved but there's another gate to solve" — the full chain is not complete yet.

**Progress (Aug 24 - Sep 1 2026):**
- rukkusireland / daveconde (24/08/2026): created [bc250-vcn-enable](https://github.com/daveconde/bc250-vcn-enable) with a full [VCN2 register map](https://github.com/daveconde/bc250-vcn-enable/blob/main/vcn2_register_map.md). Decoded the PSP t28 firmware blob: fw_type 13 = VCN0, fw_type 58 = VCN1. On a working card, loading VCN firmware makes the PSP write 1 to SMN `0x0900c004` (cold reset register for UVD) via `svc #0x7c` — on the BC250 the fw_type-13 load is rejected (`ITEM_NOT_FOUND`), so this write never happens and the island stays clamped. This is "the best candidate yet for the root clamp release" (rukkusireland, 24/08/2026).
- rukkusireland (29-30/08/2026): VCN1 is a dead end — no 2nd IP discovery entry for HWID 12. Type 58 in the t28 blob may be leftover code from another chipset. PS5 has multiple VCN instances, so the missing discovery data hypothesis remains open.
- mergeconflicted (01/09/2026): investigating CVE-2023-31316 against the BC-250 PSP type-13 save/restore path. Experimentally confirmed: during restore, attacker-controlled data is copied into the PSP-protected GPU firmware region before HMAC validation — a verified protected-memory write primitive. However, the PSP's `saved_len` variable is never properly initialized (contains garbage instead of `0x62940`), so restore faults before reaching firmware-release/activation. Updated to P5 BIOS and PSP reload files were accepted, but the clamp still did not release.
- mergeconflicted (02/09/2026): the random values in the CVE were related to a fix in P5 — using P5 BIOS allowed PSP reload files to be accepted, but the clamp persists. Current investigation: how to correct or bypass `saved_len` so the restore can complete after planting the Navi VCN firmware.

### GPU Unlock Research (40 CU)

The 40 CU unlock went through multiple research phases before reaching the current stable state:

- **Phase 1 — BIOS-level (Jul 2026):** RescueMei patched the P3.00 BIOS to expose hidden SMU commands (`PPSMC_MSG_SetConfig` 0x29) that enable harvested CUs. Requires hardware programmer or EFI shell flashing. First community confirmation of 40 working CUs.
- **Phase 2 — Kernel patch (Jul-Aug 2026):** duggasco created a kernel patch (`bc250-40cu-unlock`) that disables the CU harvest check at driver load time. Works on any distro but requires rebuilding the kernel after updates.
- **Phase 3 — Live manager (May 2026):** vinnijs.dev / `bc250-cu-live-manager` uses UMR to write the WGP disable register at runtime — no kernel patch, no reboot. Currently recommended method. Supports selective CU masking for cards with defective CUs.
- **Open question:** GPU unlock stability depends on CU health. `cu_health_check.sh` (duggasco) and `cu_check.sh` (nonu0038) test each CU individually. Some boards have 1-2 defective CUs that must be masked (typically CU 3 or CU 7 on bad boards).

### CPU Core Unlock Research (8 Cores)

- **Phase 1 — BIOS modding (Jul 2026):** RescueMei / Forbidden-Darkness added core-unlock DXE drivers to the P3.00 BIOS. First boards booted with 8 cores confirmed via `nproc` and `lscpu`.
- **Phase 2 — SMU mailbox (Jul 2026):** GabriWar created `bc250-core-cu-unlock` — a Python script that writes the core enable mask directly to the SMU via the mailbox interface (`0x98`). Works from userspace, persists across warm reboots but not cold boots (SMU resets on power-off). systemd service re-applies on boot.
- **Phase 3 — ACPI + metrics fix (Aug 2026):** 8-core boards need ACPI tables for CPUs 12-15 (mendesrr / gabriwar `bc250-acpi-fix.sh`) and GPU metrics fix (`fix-freq` in governor or kernel patch from _mastag) to correct the 8-core frequency reporting.
- **Known issue:** Core 3 is defective on some boards (h00man._., Aug 2026). Workaround: `isolcpus=6,7` + boot script to disable the bad cores. Not all boards affected — lottery dependent.

See [10-troubleshooting](10-troubleshooting.md) for known issues and [11-community-and-resources](11-community-and-resources.md) for related repositories.

### Core Unlock — Field Reports & History (Jul-Aug 2026)

Community field reports and research history, moved here from the unlock procedure section (DOC_STANDARDS.md §3). Actionable conclusions from these reports are already reflected in the procedure above.

**Field reports (Aug 2026):**
- **glide_2026 (03/08):** temporary unlock, Elden Ring gained ~10 fps ("definitely added 10ish frames", still fluctuates around 60). Ratchet & Clank Rift Apart "incredible with 8 cores and 40 CUs" with the gfx1013-fix
- **crazy_t0176 (03/08):** flashed the 8-core BIOS (Forbidden-Darkness UEFI script) — great FPS, but GPU clocks read only 20–100 MHz. bigmedi's reply: "Not yet" (the metrics fix landed days later — see the metrics options above)
- **seb061492 (04/08):** OC that was stable at 6 cores (4000 MHz) crashes in Unigine with 8 cores unlocked, even at 3500 MHz, unless the SMU service/governor is disabled entirely — likely a marginal unlocked core (baalah: "bad cpu core"). His 40 CU @ 2200 MHz kept working
- **dmoraza (03–04/08):** 0x7B mask works for some boards, but 8-core + governor on kernel 7.1 gives a black screen; OK on 6.18 (see [10-troubleshooting.md](10-troubleshooting.md) for the governor kernel note)
- **fforduck (03/08):** CPU 4 and 5 pass stress tests yet misbehave in some games — he sets Steam to use all cores *except* 4 and 5 rather than fully disabling them. Partial core masks are supported (see alternate bitmasks above)
- **Silicon lottery update (xseol, 06/08):** ~80% chance for 40 CU, 8 cores still new — estimate 50–60% for 8-core + 40-CU together ("you need to win two silicon lotteries")
- **EFI vs BIOS — no consensus yet (Aug 5 2026):** midlifediy: "doesn't seem to be a consensus on EFI vs BIOS core unlock quite yet? (ive stayed put while this plays out)". keroppl_wizard: "I'm running EFI. I'll flash when the final megabios is released" (referring to gabriwar's `allthecoolshit.rom`)
- **Bad cores do happen (Aug 2026):** j0shm1lls flashed the 8-core BIOS on his 2nd board *before* testing the unlock: "WHOOPS. (spoiler alert: cores dont b workin gud)". vadym557 tried 3 times with the cores-unlock option — stuck at Steam logo with a spinner; booted only when cores were disabled ("Guess my extra cores are cooked)" (Aug 8 2026). ⚠️ Always `test-cores.sh` / the Python script first — if the unlocked cores are defective, you must recover via external programmer
- **Unlock survives OS reinstall — only a BIOS reflash clears it (skcanss, Aug 2 2026):** selecting the revert option and restarting still showed 8c/16t; even `blkdiscard` + fresh CachyOS install kept the cores unlocked; BIOS reset didn't clear it either — only reflashing the BIOS did. The mask lives in the SMU/BIOS, not the OS
- **Power draw rises with core unlock (buzzynoob, Aug 6 2026):** "Since the new core unlocks the power draw has increased" — factor in extra margin on the original power delivery method (see [03-Power Supply Guide](03-power-supply-guide.md))
- **Stock P3.00 BIOS hash mismatch (alexxxor_, Aug 4 2026):** a board with a P3.00 sticker produced a backup ROM whose `sha256sum` (`56c548afb8ac3147793f1254ee71f414f4a0002d39196edc98e3a28cd05862c3`) differs from the listed stock hash — boards ship with slightly different images, always back up before flashing

**Background:** duggasco and mrfrakes previously decompiled and extracted bootrom and understood how the PSP (Platform Security Processor) checks and initializes cores from fuses. The working theory was that cores are controlled by a ROM array written during manufacturing rather than physically fused off — now validated by the working unlocks. Early speculation: unlocking BC-250 cores could theoretically apply to other low-end Ryzen CPUs with disabled cores, but that's uncharted territory.

**jwagnervaz BIOS Rev Eng (Jul 09-11, 2026):** Another independent modder is reverse engineering a custom BIOS for the BC-250:
- "Working in rev eng to make a better bios to bc 250" — posted progress photos from Jun 20, 2026 (Jul 2026)
- Already fixed ACPI tables and made optimizations; prior experience modding X99 Chinese boards
- Tested ALL available 4700S BIOS images found: **none boot** on BC-250 — different memory lithography and different ABL SMU between the two chips (Jul 11, 2026)
- Boot stops at UART-debuggable point "in another place" after partial adjustment — working toward next breakthrough with UART debug tools
- Goal: "port bootsec/tpm and find some solution to windows drivers. one step at a time."
- Note: mrfrakes claims to have booted 4700S C08 BIOS on BC-250 with external GPU — may require specific BIOS version and external GPU like the original 4700S setup (Jul 11, 2026)

**VCN unlock discussion (Jul 30 2026):** thelamer proposed using the same register exploit for VCN (video codec) hardware decode — `VCN feature version: 0, firmware version: 0x00000000` suggests the hardware is present but disabled. yrouel86 notes this would still need the firmware blob, and it would most likely need to be signed. VCN unlock remains an open research question.
**Last verified: 2026-09-03**
