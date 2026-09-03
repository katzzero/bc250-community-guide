# 00 — From Zero to Gaming: Complete BC-250 Setup Guide

> A linear step-by-step guide from purchase to first game running.
> Each section links to the detailed document — use this as your main roadmap.

---

## Table of Contents

1. [Before Buying](#1-before-buying)
2. [Receiving the Board](#2-receiving-the-board)
3. [Assembly: Power Supply](#3-assembly-power-supply)
4. [Assembly: Cooler](#4-assembly-cooler)
5. [Assembly: Storage and Case](#5-assembly-storage-and-case)
6. [BIOS: Flash](#6-bios-flash)
7. [BIOS: Configuration](#7-bios-configuration)
8. [First Boot + OS Selection](#8-first-boot--os-selection)
9. [OS Installation](#9-os-installation)
10. [Post-Install: Governor and Drivers](#10-post-install-governor-and-drivers)
11. [Display and Audio](#11-display-and-audio)
12. [WiFi and Peripherals](#12-wifi-and-peripherals)
13. [Steam and Games](#13-steam-and-games)
14. [Performance Unlocks (Optional)](#14-performance-unlocks-optional)
15. [Benchmarks](#15-benchmarks)
16. [Quick Troubleshooting](#16-quick-troubleshooting)
17. [Next Steps](#17-next-steps)

---

## 1. Before Buying

### What you need to order

| Item | Essential? | Notes |
|------|-----------|-------|
| **BC-250 board** | Essential | AliExpress or eBay, BIOS P2.00-P3.00 or P5.00 (avoid P4.00 — unstable) |
| **12V PSU with PCIe 8-pin** | Essential | FSP500-30AS (~$15 eBay, search `389522369783`) is the gold standard |
| **120mm high-pressure fan** | Essential | Arctic P12 Pro (~$25/5-pack) |
| **DisplayPort cable** | Essential | Native DisplayPort is the best output |
| **USB WiFi (if needed)** | Recommended | No onboard WiFi — TP-Link TX10UB Nano |
| **M.2 NVMe SSD** | Recommended | Any drive, slot is PCIe 2.0 x2 (~1 GB/s max) |
| **Thermal paste or PTM7950** | Recommended | Stock paste is dried out — MX-4, Kryonaut, or PTM7950 |
| **Thermal pads for VRAM** | Recommended | 1.5mm front, 2.0mm back (8x GDDR6 chips with no temp sensor) |
| **Case/mount** | Recommended | 3D printed case, GPU enclosure, or DIY mount |

**Recommended purchase order:** Board first (AliExpress takes longer), then everything else.

> See [Prerequisites (elektricM)](https://elektricm.github.io/amd-bc250-docs/getting-started/prerequisites/) for a complete checklist.

### Quick specs

- **APU:** 6x Zen 2 + 24 CU RDNA 2 (gfx1013), 16 GB GDDR6 shared
- **TDP:** ~220W (235W peak)
- **Video output:** 1x DisplayPort 1.4 (no native HDMI)
- **Storage:** 1x M.2 2280 PCIe 2.0 x2
- **Network:** 1x Gigabit Ethernet (no WiFi)
- **IOMMU:** Broken — always disable in BIOS

> See [01 — Hardware Specs](01-hardware-specs.md) for full details.

---

## 2. Receiving the Board

### Inspection checklist

- [ ] Heatsink with no visible physical damage
- [ ] Fans (if included) with no broken blades
- [ ] PCIe 8-pin connector pins straight
- [ ] BIOS_A1 chip with no signs of damage (near the M.2 slot)
- [ ] Q11 transistor near the Nuvoton chip (top-right area) — can get knocked off during shipping

### CRITICAL: 4x Nylon Washers

The heatsink is held by **4 spring-tensioned screws** through the back of the board. Under each screw head there is a **clear or black nylon washer**. These prevent short circuits and ensure proper contact pressure.

**Do NOT lose them.** If reassembled without them, the heatsink won't make full contact with the APU die, causing **90-100°C at idle**. Keep track of them during disassembly — they're small and easily lost.

### Heatsink — preparation

1. Remove the 4 screws and take off the heatsink
2. **Open the center fins** — they are crushed from the factory (5-10°C difference)
3. Use fine-nose pliers or the "BC-250 Scooper" tool (Printables)
4. Clean old thermal paste with isopropyl alcohol

> See [04 — Cooling Guide](04-cooling-guide.md) for heatsink preparation techniques.

---

## 3. Assembly: Power Supply

### The essential requirement

The BC-250 requires **12V only** with a **PCIe 8-pin (6+2) connector**.

| Option | Verdict | Price |
|--------|---------|-------|
| **FSP500-30AS** (Flex ATX) | Gold standard | ~$15 eBay |
| **MeanWell LOP-300-12** | Great for ultra-compact builds | ~$40 DigiKey |
| **Any ATX 400W+** | Works if you already have one | ~$0 (reused) |
| **Server PSU + breakout board** | Works but VERY loud | ~$20-30 |

### Connection

1. ATX PSU: connect the PCIe 8-pin cable directly to the board
2. **FSP500-30AS (10-pin):** bridge PS_ON (green wire, pin 3) to GND (black wire, any adjacent pin) — use a paperclip or jumper wire. This tells the PSU to turn on.
3. Board powers on automatically when 12V is applied (jumper AUTO_PWRON1: pins 1-2, located near the PCIe power connector)

### Safety

- **NEVER** use SATA-to-PCIe adapters — fire hazard (SATA = 54W, board = 235W)
- **NEVER** use cheap 6-pin to 8-pin PCIe adapters — they will melt
- Use **16 AWG wire minimum** (silicone, not PVC/nylon) — 18 AWG has melted under load testing
- 20-22 AWG is **dangerous** — BC-250 current exceeds these cables' rating
- FSP500-30AS is the standard because of its high-quality cables

> See [03 — Power Supply Guide](03-power-supply-guide.md) for pinouts, wiring, and more PSU options.

---

## 4. Assembly: Cooler

### Thermal paste application

| Product | Conductivity | Verdict |
|---------|-------------|---------|
| **PTM7950** (phase change pad) | Excellent (4-15°C improvement) | Best, but requires thermal cycles to "cure" |
| **Thermal Grizzly Kryonaut** | 12.5 W/mK | Excellent traditional paste |
| **Arctic MX-6** | 10.0 W/mK | Great value |
| **Arctic MX-4** | 8.5 W/mK | Good and affordable |

**Application (PTM7950):**
1. Clean the die and heatsink copper with isopropyl alcohol
2. Remove plastic from one side, apply to the die
3. Remove the second plastic
4. Tighten screws in a cross pattern
5. **First boot will show 80-90°C** — normal, the pad needs to "cook in"

### Fan mounting

1. Position a **120mm high static pressure fan** (Arctic P12 Pro) over the center of the heatsink
2. Secure with **zip ties** — simplest and safest method
3. Connect to header **J1** (4-pin PWM, located near the PCIe power connector — small white connector)
4. **Recommended configuration:** push (blowing into the heatsink)

### Thermal pads (VRAM)

- **Front:** 1.5mm thickness
- **Rear (GDDR6):** 2.0mm thickness — CRITICAL, no temperature sensor
- **Alternative:** Thermal putty (Fehonda LTP81) — self-adjusting

> See [04 — Cooling Guide](04-cooling-guide.md) for fan selection, push-pull, 3D printed shrouds, and water cooling.

---

## 5. Assembly: Storage and Case

### M.2 SSD

- Any NVMe works (PCIe 2.0 x2 = ~1 GB/s max, not worth spending much)
- Minimum 256GB, recommended 1TB
- SATA SSDs also work in the slot

### Case / Enclosure

| Option | Description |
|--------|-------------|
| **3D printed** | 145+ designs on Printables — see [elektricM Case Gallery](https://elektricm.github.io/amd-bc250-docs/community/cases/) |
| **GPU enclosure** | Some enclosures fit the BC-250 |
| **DIY** | Standoffs + acrylic/wood |
| **4U server case** | Original ASRock, noisy fans — replace them |

### Final assembly

1. Install the SSD in the M.2 slot
2. Mount the board in the case/enclosure
3. Connect the PCIe 8-pin cable from the PSU
4. Connect the fan to header J1
5. Connect the DisplayPort cable to the monitor
6. Connect USB keyboard/mouse
7. (Optional) Connect Ethernet cable for installation

> See [13 — Case Mods & Custom Enclosures](13-case-mods.md) for community case designs. See [09 — WiFi & Peripherals](09-wifi-and-peripherals.md) for storage and accessories.

---

## 6. BIOS: Flash

> **Flashing the modified BIOS is MANDATORY.** Without it, you cannot configure dynamic VRAM, fan control, and other essential options.

### What to download

1. Modified BIOS: [bc250-bios (GitLab)](https://gitlab.com/TuxThePenguin0/bc250-bios/)
2. USB flash tool: [4U12G BIOS Update (GitHub)](https://github.com/kenavru/BC-250/raw/refs/heads/main/4U12G%20BIOS%20Update.zip)
3. Recommended BIOS file: `BC250_3.00_CHIPSETMENU.ROM`

### USB Method (Recommended)

1. Format a USB drive as **FAT32**
2. Extract the ZIP and copy the contents to the root of the USB drive
3. Rename the downloaded BIOS to `Robin5.00` (capital R, no extension)
4. USB drive should contain: `AfuEfix64.efi`, `Flash.nsh`, `Robin5.00`
5. **Remove the SSD** from the board — this forces the board to boot from USB into EFI Shell instead of the OS. Reinstall the SSD after flashing.
6. Connect the USB drive, power on the board
7. At the `Shell>` prompt, type `blk0:` (type `b`, `l`, `k`, `0`, `:`, then **spacebar**, then Enter) — this selects the USB drive
8. Type `Flash.nsh` and press Enter. **Note:** some keyboard layouts may cause typos (e.g., French keyboards type `Flqsh.nsh`) — check the screen before pressing Enter.
9. **WAIT.** The screen may freeze or go blank. Do NOT interrupt for at least 15 minutes — interrupting during flash will brick the board.
10. System reboots — **shut down immediately** (hold the power button), remove the USB drive, reinstall the SSD

### CMOS Clear (CRITICAL — Do Not Skip)

After ANY BIOS flash, settings won't persist without this:

1. Shut down, unplug the PSU from the wall
2. Remove the **CR2032** battery for **60 seconds**
3. With the battery out, press the power button **5 times**
4. Reinsert the battery, power on, enter BIOS (Del)
5. Verify CMOS was cleared (clock will be wrong)
6. Reconfigure BIOS settings and save with F10

> See [02 — BIOS & Firmware](02-bios-and-firmware.md) for alternative methods (CH341A, internal flash), pinouts, and troubleshooting.

---

## 7. BIOS: Configuration

Enter the BIOS by pressing **Delete** during boot and configure:

```
Chipset → GFX Configuration:
  Integrated Graphics Controller = [Forces]
  UMA Mode                       = [UMA_SPECIFIED]
  UMA Frame Buffer Size          = [512M]   ← Dynamic VRAM (recommended)

Advanced → CPU Configuration:
  IOMMU = [Disabled]   ← REQUIRED — IOMMU is broken on BC-250

Boot → Boot Mode:
  Boot Mode = [UEFI]
```

### VRAM: Which mode to choose?

| Mode | VRAM | RAM | Best for |
|------|------|-----|----------|
| **512MB (Dynamic)** | Auto (~11.5 GB) | Auto | General use |
| 6 GB fixed | 6 GB | 10 GB | AAA gaming without OOM risk |
| 8 GB fixed | 8 GB | 8 GB | Balanced workload |
| 4 GB fixed | 4 GB | 12 GB | Light gaming, more system RAM |

512MB dynamic is best for most users. Linux allocates more VRAM automatically when needed.

---

## 8. First Boot + OS Selection

### Boot test

1. Connect everything, power on the PSU
2. Board should power on automatically (AUTO_PWRON1)
3. Press Del to enter BIOS
4. **Can't see BIOS?** Switch to a native DisplayPort cable (adapters may not initialize fast enough)

### Which OS to choose?

| Distro | Difficulty | Verdict |
|--------|-----------|---------|
| **CachyOS** | Intermediate | Community default — best stability + performance, current kernel out of box (7.1.x as of Sep 2026 — see the [kernel matrix](05-os-installation.md#kernel-support-matrix-canonical--as-of-2026-09-03)) |
| **Bazzite** | Easy | Needs testing branch (stable is kernel 6.17.7 — too old for 40 CU). See rebase instructions below. |
| **Fedora 43+** | Easy | Most documented, Mesa 25.1+ native |
| **Nobara** | Intermediate | Fedora-based, non-immutable, easy governor setup |
| **Arch Linux** | Advanced | Full control, requires manual configuration |
| **Ubuntu 26.04+** | Easy | Works with Mesa PPA |
| **Manjaro** | Easy | Boots out-of-box |

**Community recommendation (July 2026): CachyOS.** Bazzite stable ships kernel 6.17.7 which causes 40 CU instability — only use Bazzite if you rebase to the testing branch immediately after install.

### Broken kernels (AVOID)

**6.15.0-6.15.6** and **6.17.8-6.17.10** cause GPU failure. Check the canonical [Kernel Support Matrix (05)](05-os-installation.md#kernel-support-matrix-canonical--as-of-2026-09-03) before installing: as of Sep 2026, CachyOS ships 7.1.x; 6.19.x remains the recommended stable line, 6.18 LTS the fallback.

**Bazzite stable ships 6.17.7** — too old for 40 CU stability. Rebase to the testing branch immediately after install (instructions in section 9 below).

> See [05 — OS Installation](05-os-installation.md) for complete installation guides for each distro.

---

## 9. OS Installation

### Preparation

1. On another PC, download the ISO for your chosen distro
2. Write it to a USB drive with **Ventoy** (recommended), **balenaEtcher**, or **Rufus**
3. Connect the USB drive to the BC-250, power on

### Bazzite (requires testing branch)

**Important:** Bazzite stable ships kernel 6.17.7 which is too old. After install, immediately rebase to testing branch:

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck:testing
```

1. Use the **non-live installer** image (live image has login bugs)
2. Boot from USB — no special parameters needed
3. Normal installation (~10-15 min)
4. Default password (if asked): `bazzite`
5. Reboot
6. After reboot, run the rebase command above to get kernel 7.0 + Mesa 26

### CachyOS (recommended — latest kernel out of box)

1. Download [CachyOS ISO](https://cachyos.org/)
2. Flash to USB and boot — standard install works, no special parameters
3. Complete installation (~10-15 min)
4. Handheld Edition recommended for Game Mode + Gamescope + FSR

### Fedora 43

1. Boot from USB
2. In GRUB, select **"Basic Graphics Mode"** (enables nomodeset automatically)
3. Normal installation
4. Reboot — screen may go black (nomodeset still active, normal)

> See [05 — OS Installation](05-os-installation.md) for installation on CachyOS, Arch, Debian, Ubuntu, Manjaro, and Nobara.

---

## 10. Post-Install: Governor and Drivers

### Step 1: Install the GPU Governor

**The governor is ESSENTIAL.** Without it the GPU is stuck at 1500 MHz and idle power is 85-105W.

**SMU governor (recommended — no kernel patch needed):**

**CachyOS / Arch (community default):**
```bash
paru -S cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

**Fedora / Nobara:**
```bash
sudo dnf copr enable filippor/bazzite
sudo dnf install cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

**Bazzite (rpm-ostree — requires testing branch):**
```bash
sudo dnf copr enable filippor/bazzite
rpm-ostree install cyan-skillfish-governor-smu
systemctl reboot
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

**Debian / Ubuntu:**
```bash
wget https://github.com/Magnap/cyan-skillfish-governor/releases/latest/download/cyan-skillfish-governor-smu_amd64.deb
sudo dpkg -i cyan-skillfish-governor-smu_amd64.deb
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Step 2: Remove nomodeset

**Fedora / GRUB:**
```bash
sudo nano /etc/default/grub
# Change: GRUB_CMDLINE_LINUX_DEFAULT="quiet nomodeset"
# To:     GRUB_CMDLINE_LINUX_DEFAULT="quiet"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo reboot
```

**Bazzite (rpm-ostree):**
```bash
rpm-ostree kargs --delete-if-present="nomodeset"
systemctl reboot
```

### Step 3: ACPI Fix (CPU Power States — Recommended)

Enables C-States (idle) and P-States (CPU frequency scaling 800-3200 MHz):

```bash
git clone https://github.com/bc250-collective/bc250-acpi-fix.git
cd bc250-acpi-fix
# Follow the README for your distro
```

This reduces idle power consumption and allows the CPU to scale frequency.

### Step 4: Configure governor (optional)

File: `/etc/cyan-skillfish-governor-smu/config.toml`

**Recommended config (general use):**
```toml
safe-points = [
    [1000, 700],   # idle
    [1500, 900],   # medium load
    [2000, 1000],  # gaming
    [2100, 1025],  # light overclock
    [2175, 1050],  # moderate overclock
    [2300, 1075],  # max overclock (requires good air cooling)
]
```

After changing: `sudo systemctl restart cyan-skillfish-governor-smu`

### Step 5: Verify installation

```bash
# Mesa version (26.x recommended, 25.1+ minimum)
glxinfo | grep "OpenGL version"

# GPU driver (should show RADV GFX1013, NOT llvmpipe)
vulkaninfo | grep deviceName

# Governor running
systemctl status cyan-skillfish-governor-smu

# GPU frequency (should show multiple frequencies)
cat /sys/class/drm/card1/device/pp_dpm_sclk
```

> See [06 — GPU Governor](06-gpu-governor.md) for detailed config, overclocking, SMU profiles, and troubleshooting.

---

## 11. Display and Audio

### Display

- **Best option:** Native DisplayPort cable (up to 4K@120Hz, HDR10, audio works)
- **Second option:** Passive DP-to-HDMI adapter (~$5-10, 1080p60/1440p60 with audio)
- **Avoid:** Active DP-to-HDMI adapter (audio broken on BC-250)

### Audio

| Solution | Quality | Works? |
|----------|---------|--------|
| Audio over native DP | Great | Yes (kernel 6.19.10+ fixed bugs) |
| DP-to-HDMI passive | Good | Yes |
| **USB Sound Card** | Great | **Most reliable** — Sabrent AU-EMCB or generic USB dongle (~$10) |
| DP-to-HDMI active | Poor | Audio dropouts |

**Kernel 6.19.10+** includes the DP audio fix by TheFloW (PS5 Linux developer).

### VRR (Variable Refresh Rate)

Works natively on **CachyOS kernel 6.19+** and via custom image on Bazzite.

> See [08 — Display & Audio](08-display-and-audio.md) for more details on VRR, multi-monitor, adapters, and NullVRS.

---

## 12. WiFi and Peripherals

### WiFi (no onboard)

| Adapter | Chipset | WiFi | BT | Price |
|---------|---------|------|-----|-------|
| **TP-Link Archer TX10UB Nano** | MT7921AU | AX900 (WiFi 6) | BT 5.3 | ~$20 |
| **Fenvi FU-AX1800** | MediaTek | AX1800 | BT 5.0 | ~$20 |
| **EDUP AX3000M** | MT7921AU | AX3000 (WiFi 6E) | BT 5.0 | ~$25 |
| **TP-Link Archer T2UB Nano** | — | WiFi 5 | BT 4.2 | ~$15 |

Adapters with **RTL8822BU** chipset have better in-kernel support (Linux 6.12+). Custom kernels (e.g., Bazzite performance mode) may not include your adapter's driver — have Ethernet as a fallback.

### Bluetooth only

- **TP-Link UB500 Plus** (BT 5.3, ~$10-15)
- **EDUP B3536** (BT 5.0, ~$5 AliExpress)

### Ethernet

The BC-250 has **Realtek RTL8111H Gigabit Ethernet** — plug and play on all distros.

### Keyboard and Power Button

- **Power button:** The board has no standard power button header — it powers on automatically when 12V is applied (AUTO_PWRON1 defaults to pins 1-2). To add a physical button: solder two wires to the onboard push button (small black button on the back edge), then move AUTO_PWRON1 jumper to pins 2-3.
- **Standard USB keyboard** works for BIOS

> See [09 — WiFi & Peripherals](09-wifi-and-peripherals.md) for storage, USB accessories, cases, and mounting.

---

## 13. Steam and Games

### Install Steam + Gaming Tools

**Fedora / Nobara:**
```bash
sudo dnf install steam mangohud goverlay
```

**Bazzite:** Steam comes pre-installed.

**CachyOS / Arch:**
```bash
sudo pacman -S steam mangohud goverlay
```

### Proton (Running Windows Games)

1. Open Steam → Settings → Compatibility
2. Enable **"Enable Steam Play for all other titles"**
3. Select **Proton Experimental** (or the latest version)

### Recommended Launch Options

**For games with graphical artifacts:**
```bash
RADV_DEBUG=nohiz %command%
```

**For games with 640x480 resolution (broken VRS):**
```bash
ENABLE_VK_NULLVRS_1=1 %command%
```

**MangoHud overlay:**
```bash
mangohud %command%
```

### Micro-Stuttering on Bazzite?

```bash
sudo systemctl disable --now hhd
sudo systemctl mask hhd
```

The Handheld Daemon (HHD) on Bazzite restarts constantly if it doesn't find expected functionalities.

---

## 14. Performance Unlocks (Optional)

The board ships with the PS5 "Oberon" APU cut down to 6 CPU cores and 24 Compute Units. Both are unlockable with community tools. Both unlocks are optional — the board is fully usable stock.

### 40 CU GPU Unlock

> Unlocks 16 harvested CUs — 24 CU → 40 CU. ~60% more compute performance.

**Recommended Method: bc250-cu-live-manager**

**No kernel patch, no reboot.** Works on any distro:

```bash
git clone https://github.com/WinnieLV/bc250-cu-live-manager.git
cd bc250-cu-live-manager
# Follow the README — interactive TUI to toggle CUs individually
```

### 8 CPU Core Unlock

The board ships with 6 of 8 Zen 2 cores active. As of Aug 2026, working unlocks exist via multiple methods — see [02 — BIOS & Firmware](02-bios-and-firmware.md) for the full comparison (patched BIOS, EFI shim, Python script, SMU mailbox tool).

**Recommended Method: gabriwar/bc250-core-cu-unlock** — unlocks 8 cores AND 40 CU from Linux, no BIOS flash:

```bash
git clone https://github.com/GabriWar/bc250-core-cu-unlock
cd bc250-core-cu-unlock
sudo ./bc250-8core-unlock.sh status     # show current core mask (factory 0x77 = 6 cores)
sudo ./bc250-8core-unlock.sh apply      # unlock now (then: sudo reboot — warm reset preserves it)
./test-cores.sh          # per-core health sweep, 20s/core (~3 min)
sudo ./bc250-8core-unlock.sh install    # persist across cold boots via systemd unit
```

### Verification

```bash
dmesg | grep active_cu_number        # Expected: 40
RADV_DEBUG=info vulkaninfo --summary 2>&1 | grep num_cu  # Expected: 40
# 8 cores visible
nproc   # Expected: 8
lscpu | grep "CPU(s)"   # Expected: 16 threads (8c/16t)
```

### Required Adjustments

- **Run the 8-core ACPI fix** — the stock 6-core tables leave CPUs 12-15 without C-states (burn power at idle). The gabriwar tool wraps this (`bc250-acpi-fix.sh install`)
- **Fix 8-core GPU clock reporting** — set `fix-freq = true` in the governor config (no kernel patch) — see [06 — GPU Governor](06-gpu-governor.md)
- **Reduce the governor max clock** to ~1850 MHz (40 CU generates more heat)
- **Re-tune overclocks** — a curve stable at 6 cores can be marginal at 8 (extra cores change load-line droop and thermals)
- **Test stability** — some boards have defective CUs or unlocked cores; always run `test-cores.sh` first, enable CUs individually
- **Test cores before flashing a patched BIOS** — if unlocked cores are defective, you need an external programmer to recover (yrouel86, Jul 2026)

> See [02 — BIOS & Firmware](02-bios-and-firmware.md) for health testing, selective masking, crash behavior, and unlock troubleshooting.

---

## 15. Benchmarks

After everything is configured, test your board:

```bash
# Temperatures
sensors

# GPU load
cat /sys/class/drm/card1/device/gpu_busy_percent

# Current GPU frequency
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Vulkan info
vulkaninfo --summary
```

### Benchmark Tools

| Tool | Installation | What it tests |
|------|-------------|---------------|
| **Unigine Superposition** | Steam (free) | General GPU |
| **3DMark** | Steam (paid) | GPU + CPU |
| **Geekbench 6** | Official site | CPU + GPU |
| **FurMark** | Official site | GPU stress + thermals |
| **7zip benchmark** | `7z b` | CPU compression |
| **pp512 (LLM)** | Python script | AI inference |

> See [07 — Game Benchmarks](07-game-benchmarks.md) for FPS of 60+ community-tested games.

---

## 16. Quick Troubleshooting

### Board won't boot (no POST)
1. Clear CMOS (battery 60s)
2. Try a different PSU (bad PSU is cause #1)
3. Check Q11 transistor (may have been knocked off during shipping)
4. Flash BIOS via CH341A

### Black screen on boot (OS doesn't appear)
1. Use native DisplayPort cable (not adapter)
2. Disable IOMMU in BIOS
3. Check kernel (avoid 6.15.0-6.15.6 and 6.17.8-6.17.10)
4. Boot with `nomodeset`, install governor, remove nomodeset

### GPU not detected (llvmpipe)
1. Check Mesa 25.1+: `glxinfo | grep "OpenGL version"`
2. Check kernel: `uname -r`
3. Check if nomodeset was removed
4. Confirm IOMMU is disabled

### GPU stuck at 1500 MHz
1. Governor running? `systemctl status cyan-skillfish-governor-smu`
2. Minimum voltage >= 700 mV? (below this locks to 1500 MHz)
3. Reinstall the governor

### High temperatures (85°C+)
1. Thermal paste replaced? (stock is dried out)
2. Heatsink fins opened? (opening center = 5-10°C improvement)
3. High static pressure fan? (P12 Pro > common case fan)
4. Rear VRAM cooled? (no sensor, silent overheating)

### Visual artifacts in games
1. `RADV_DEBUG=nohiz %command%` in Steam launch options
2. If persistent: reduce governor overclock
3. If only in specific games: install Vulkan_NullVRS

> See [10 — Troubleshooting](10-troubleshooting.md) for a complete guide with all known errors.

---

## 17. Next Steps

Your BC-250 is running. Now you can:

- [ ] **Optimize cooling** — water cooling, 3D printed fan shrouds, push-pull
- [ ] **Tune the governor** — GPU overclock, perf profiles, undervolt
- [ ] **Run CU + core health tests** — if unlocking 40 CU or 8 cores
- [ ] **Run benchmarks** — compare with the [community leaderboard](07-game-benchmarks.md)
- [ ] **Set up AI inference** — Ollama, pp512, ROCm
- [ ] **Print a custom case** — 145+ designs on Printables
- [ ] **Join the community** — Discord for support, tips, and new projects

> See [11 — Community & Resources](11-community-and-resources.md) for Discord, GitHub, and community project links.
>
> See [12 — AI Inference](12-ai-inference.md) for a guide on setting up LLMs and local inference.

---

*Guide generated from Revised/01-13 documents, export/elektricM-docs, and BC-250 Discord community data.*
*Last updated: August 2026. Last verified: 2026-09-03.*
