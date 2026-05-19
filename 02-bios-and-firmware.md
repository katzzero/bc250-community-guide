# 02 — BIOS & Firmware

> Flashing a modded BIOS is **mandatory** to unlock VRAM allocation and hidden chipset settings.

---

## Recommended Modded BIOS

| File | Version | Status |
|------|---------|--------|
| **BC250_3.00_CHIPSETMENU.ROM** | P3.00 | ✅ **Recommended** — most stable, tested widely (source: elektricM flashing.md; mod by Segfault) |
| `P5.00_clv` variants | P5.00 | ⚠️ Advanced — unlocks everything (ReBAR, PXE (need confirmation)) but **easy to brick** |

*Credits: P3.00 mod by **Segfault**. P5.00_clv is community-maintained. elektricM credits Segfault for reverse engineering and maintaining modified firmware images.*

### Where to Download

| Source | URL |
|--------|-----|
| **Primary (GitLab)** | https://gitlab.com/TuxThePenguin0/bc250-bios/ |
| GitHub mirror | https://github.com/MrrZed0/bc-250-bios (need confirmation) |

> ⚠️ **Always back up your existing BIOS** before flashing anything. elektricM recommends owning a CH347 programmer before starting as a safety net.

---

## BIOS Configuration (After Flashing)

Enter BIOS by spamming **Delete** on boot, then set:

```
Chipset → GFX Configuration:
  Integrated Graphics Controller = [Forced]  (corrected from "Forces" typo in elektricM)
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

### Method 3: Internal Flash from Linux (need confirmation)

> ⚠️ **Not documented in elektricM source-of-truth.** The elektricM FAQ explicitly states only USB and hardware programmer methods are supported. Proceed at your own risk.

```bash
# Backup first!
sudo flashrom -p internal -r backup.bin
sudo flashrom -p internal -w BC250_3.00_CHIPSETMENU.ROM
```

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
**Status:** Working (May 2026). 1.61x compute scaling verified. 19 stars, 1 fork.

The BC-250 ships with 24 of 40 RDNA2 CUs active. 16 are harvested — disabled by firmware policy, not silicon defects. The harvested CUs have power, clocks, and matching CGTS config. Non-permanent — reboot without the modprobe config returns to stock 24 CUs. Guarded to only fire on BC-250 (PCI ID `0x13FE`).

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

### Installation (Script — Any Distro)

```bash
git clone https://github.com/duggasco/bc250-40cu-unlock.git
cd bc250-40cu-unlock
sudo ./scripts/bc250-enable-40cu.sh build
sudo ./scripts/bc250-enable-40cu.sh enable   # reboots
```

### Manual Kernel Patch (Any Distro)

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

For distro-specific instructions (CachyOS PKGBUILD patch, Bazzite COPR kernel, Arch AUR), see [05-OS Installation](05-os-installation.md).

### Verification

```bash
dmesg | grep active_cu_number     # Expected: active_cu_number 40
dmesg | grep bc250-40cu           # Shows register writes
RADV_DEBUG=info vulkaninfo --summary 2>&1 | grep num_cu   # Expected: num_cu = 40
```

### CU Health Testing

Not all CUs are healthy. Bad CUs cause immediate artifacts and shutdown when enabled (koloses). Boards with scattered harvest patterns (`■■□□■■□□■■`) likely have defective silicon. The project includes a per-WGP isolation test:

```bash
sudo ./scripts/bc250-cu-health-test.sh start   # 20 reboots, tests each WGP
./scripts/bc250-compute-verify.sh               # quick check, no reboot
```

### Selective CU Masking

CUs are disabled at WGP granularity (pairs). Disabling CU 6 also disables CU 7 (same WGP). Format: `amdgpu.disable_cu=SE.SH.CU` (comma-separated, added to `/etc/modprobe.d/bc250-40cu.conf`).

```
WGP 0 = CU 0,1   (stock active)
WGP 1 = CU 2,3   (stock active)
WGP 2 = CU 4,5   (stock active)
WGP 3 = CU 6,7   (unlocked — test these)
WGP 4 = CU 8,9   (unlocked — test these)
```

```bash
# Mask WGP 3 in SE1/SH0 -> 38 CUs
options amdgpu bc250_cc_write_mode=3 disable_cu=1.0.6,1.0.7

# Mask WGP 4 across all arrays -> 32 CUs
options amdgpu bc250_cc_write_mode=3 disable_cu=0.0.8,0.0.9,0.1.8,0.1.9,1.0.8,1.0.9,1.1.8,1.1.9
```

### Disabling

```bash
sudo ./scripts/bc250-enable-40cu.sh disable   # removes config, reboots to 24 CU
sudo ./scripts/bc250-enable-40cu.sh restore   # restores original amdgpu module
```

### Credits

duggasco (research, repo), filippor (independent testing, ignore_cu_harvest), scallion_9883 (benchmarks), Claude/Codex (SPI register discovery), kilrah (disable_cu masking), hojnikb (harvest maps), koloses (bad CU testing), essdee4336 (thermal), big_trov (stable verify), codyrainy (build test).
