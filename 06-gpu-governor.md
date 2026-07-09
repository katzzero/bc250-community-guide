# 06 — GPU Governor

> **The GPU governor is essential.** Without it, the GPU is locked at 1500 MHz and idle power is 85–105W.
> With it, the GPU dynamically scales from ~1000 MHz (idle) to 2000–2230 MHz (gaming), and idle power drops to 60–70W.

---

## Which Governor Should You Use?

| Governor | Type | Kernel Patch? | Recommended? | Notes |
|----------|------|---------------|--------------|-------|
| **cyan-skillfish-governor-smu** | SMU-based | No (works on any distro) | YES — Best choice | Most efficient, best scaling, no kernel mods needed |
| **cyan-skillfish-governor-smu-plus** | SMU-based + extras | No | Emerging alternative | Adds `fix-metrics`, `set-method`, `frequency-range`, pprofile autoswitching, memory controller/IF clock idle lowering -- some CachyOS issues reported |
| **cyan-skillfish-governor-tt** | Multi-step | Yes (pre-included in Bazzite) | Good alternative | Thermal throttling aware |
| **oberon-governor** | Two-state | Yes | Legacy / No longer recommended | Simple but limited to 1000/2000 MHz |

---

## Installation: cyan-skillfish-governor-smu (Recommended)

### Fedora

```bash
sudo dnf copr enable filippor/bazzite
sudo dnf install cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Bazzite (rpm-ostree)

```bash
sudo dnf copr enable filippor/bazzite
rpm-ostree install cyan-skillfish-governor-smu
systemctl reboot
# After reboot:
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### CachyOS (paru pre-installed)

```bash
paru -S cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Arch / Manjaro (install an AUR helper first)

```bash
# Install paru (if not present)
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si && cd ..

# Then:
paru -S cyan-skillfish-governor-smu
# Or with yay: yay -S cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Debian / Ubuntu

```bash
wget https://github.com/Magnap/cyan-skillfish-governor/releases/latest/download/cyan-skillfish-governor-smu_amd64.deb
sudo dpkg -i cyan-skillfish-governor-smu_amd64.deb
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Generic Linux (Build from Source)

```bash
git clone https://github.com/filippor/cyan-skillfish-governor.git
cd cyan-skillfish-governor
# See repo README for build instructions (SMU variant is on smu branch)
```

---

---

## How the Governor Works (Technical Overview)

Understanding the governor's internal behavior helps tune it for your specific board and cooling setup (explained by filippor, May 2026).

### Timing and Sampling

Every `adjust` microseconds (default: 200,000 µs = 200ms) the governor runs a sampling cycle:

1. Samples the GPU's **busy-flag** 64 times, once every `sample` µs (default: 500 µs)
2. Calculates the percentage of time the GPU was busy vs idle
3. Compares to the `load_target` range (upper/lower thresholds)
4. If GPU utilization is above `upper` target → increase frequency to next safe-point
5. If GPU utilization is below `lower` target → decrease frequency to previous safe-point
6. Every `flush-every` cycles (default: 10) → updates the displayed frequency (visible in MangoHud)

```
Timeline:
  |-- adjust (200ms) --|-- adjust (200ms) --|
  | 64x sample (500µs) | 64x sample (500µs) |
  | busy-flag check    | busy-flag check    |
                   ↕ (every 10 cycles = flush-every)
                   MangoHud frequency updates
```

### Safe-Point Interpolation

Between two safe-points, the governor uses the voltage of the **next higher** safe-point (filippor). Examples:

| GPU Frequency | Voltage Used | Source Safe-Point |
|--------------|-------------|-------------------|
| 350 MHz | 800 mV | Uses 1000 MHz safe-point (next up) |
| 501 MHz | 900 mV | Uses 1500 MHz safe-point |
| 1200 MHz | 900 mV | Uses 1500 MHz safe-point |
| 1500 MHz | 900 mV | Exact match at safe-point |

This means the lowest safe-point `[1000, 800]` controls voltage for ALL frequencies between 0-1000 MHz. A conservative GPU that never exceeds 1800 MHz during gaming only needs safe-points from 1000-2000 MHz range.

### Load Target Tuning

The `load_target` controls how aggressively the governor scales frequency (filippor, May 2026):

| Setting | Behavior | Best For |
|---------|----------|----------|
| Upper 0.80 / Lower 0.65 | Less aggressive, stays at lower frequencies longer | Cooler, quieter, lower power |
| Upper 0.65 / Lower 0.50 | More aggressive, faster to ramp up | Performance, higher FPS |

**Why a lower upper target means MORE aggressive:** The governor tries to keep GPU utilization below the upper target. With upper=0.65, it will ramp frequency up sooner (at 65% utilization). With upper=0.80, it waits until 80% before ramping. This is counterintuitive — the *lower* the upper target, the *more* the GPU boosts.

### Metrics Bug Workaround

On some kernels, GPU metrics reporting is broken. Try setting `fix-metrics = false` in config.toml if you see incorrect GPU utilization in MangoHud (community report, May 2026).

---

## Configuration

Config file: `/etc/cyan-skillfish-governor-smu/config.toml`

### Recommended Config (Good for Most Users)

```toml
safe-points = [
    [1000, 700],   # 1000 MHz @ 700 mV (idle)
    [1500, 900],   # 1500 MHz @ 900 mV
    [2000, 1000],  # 2000 MHz @ 1000 mV (gaming)
    [2100, 1025],  # 2100 MHz @ 1025 mV
    [2175, 1050],  # 2175 MHz @ 1050 mV (overclock)
    [2300, 1075],  # 2300 MHz @ 1075 mV (OC, good air cooling)
]

[load_target]
min = 0.70    # 70% GPU utilization target minimum
max = 0.95    # 95% GPU utilization target maximum

[timing]
interval_ms = 50       # How often to check GPU load
burst_samples = 20     # Samples before jumping to max frequency
```

### Conservative Config (Lower Temps / Less OC)

```toml
safe-points = [
    [1000, 700],
    [1500, 900],
    [2000, 1000],
]
[load_target]
min = 0.70
max = 0.95
[timing]
interval_ms = 50
burst_samples = 20
```

> Minimum voltage is 700 mV. Going below this locks the GPU to 1500 MHz and defeats the purpose. (source: governor.md:36). Some users run 650 mV at very low frequencies (350-500 MHz) for deep idle, but stability varies.

### Idle Power Testing (May 2026)

Community testing shows CU count has minimal impact on idle power:

| Config | Idle Power (from wall) | User |
|--------|----------------------|------|
| 4 CU @ 350 MHz / 700 mV | 68W | big_trov |
| 24 CU @ 350 MHz / 700 mV | 69W | big_trov |
| 40 CU @ 350 MHz / 700 mV | 70W | big_trov |
| 24 CU @ 50 MHz / 650 mV | 64W (FSP500-30AS) | pops1cl |

Downclocking the GPU to 10 MHz works, but 1 MHz crashes the kernel driver (pops1cl, May 2026). The default minimum frequency in the governor config has been bumped from 400 MHz to 500 MHz.

### After Changing Config

```bash
sudo systemctl restart cyan-skillfish-governor-smu
```

### SMU-Plus Config Options (Emerging)

The `cyan-skillfish-governor-smu-plus` variant adds these config options:

```toml
# /etc/cyan-skillfish-governor-smu-plus/config.toml
fix-metrics = true            # Enables GPU usage metrics fix
set-method = "smu"            # "smu" or "kernel"
[frequency-range]
min = 400                     # Minimum allowed frequency (MHz)
max = 2200                    # Maximum allowed frequency (MHz)
[dbus]
enabled = false               # D-Bus service
```

Note: SMU-plus has known issues on CachyOS — the regular SMU governor is more stable.

### Governor v0.4.0 (May 2026)

Released to the bc250-collective organization. Key new feature: **CPU-based control of memory clocks** — lowers memory controller and Infinity Fabric clocks at idle for additional power savings (codyrainy, May 2026). See [bc250-collective/cyan-skillfish-governor](https://github.com/bc250-collective/cyan-skillfish-governor).

---

## Manual Testing

To test a specific frequency/voltage combination before adding it to the config:

```bash
# Stop the governor
sudo systemctl stop cyan-skillfish-governor-smu

# Manually set frequency (in MHz) and voltage (in mV)
echo "vc 0 2100 1050" | sudo tee /sys/devices/pci0000:00/0000:00:08.1/0000:01:00.0/pp_od_clk_voltage

# Commit changes
echo "c" | sudo tee /sys/devices/pci0000:00/0000:00:08.1/0000:01:00.0/pp_od_clk_voltage

# Run a game or benchmark (30+ minutes for stability test)

# If stable, add to your config
# If it crashes, increase voltage or lower frequency

# Restart governor when done
sudo systemctl start cyan-skillfish-governor-smu
```

---

## SMU Performance Profile Tuning (Power Savings)

Changing the SMU performance profile index can reduce idle power:

```bash
# Profile 3 (default): ~75W idle
# Profile 2: ~65W idle
# Profile 1: ~60W idle (disputed — most users report 60-70W floor)
# Profile 0: ~60W idle (gennro reports ~60W from 75W, saving ~15W)
```

Note: perfprofileindex works on BIOS v3 but NOT on BIOS v5. This is an advanced tuning step — test stability carefully.

## Known Stable Frequency / Voltage Points

| Frequency | Voltage | Cooling Needed | Stability |
|-----------|---------|----------------|-----------|
| 2000 MHz | 980-1000 mV | Stock air cooling | Safe for all boards — recommended daily driver (vinnijs.dev, paul_lionking) |
| 2100 MHz | 1025-1050 mV | Good air cooling | Most boards |
| 2200 MHz | 1030-1050 mV | Good air cooling required | Upper limit for most boards at 40 CU before OCP |
| 2230 MHz | 1060 mV | Good air cooling required | Tested by community |
| 2300 MHz | 1075 mV | High-end air / AIO | Depends on silicon lottery; risks hard lock at 40 CU |
| 2400 MHz | 1125 mV | Liquid cooling only | OCP hard lock at 40 CU — 2400 MHz causes hard lock regardless of cooling at 40 CU; may work at 24 CU with adequate voltage (big_trov, codyrainy, cralant) |

**40 CU voltage guidance (May 2026):**
- Start at 2000 MHz @ 980 mV and tune from there (vinnijs.dev).
- Stay below ~1130 mV and 85°C for longevity (hojnikb).
- Even 1800 MHz at 40 CU is faster than 24 CU at 2400 MHz, with much better thermals (essdee4336).
- Silicon lottery varies: one user needed 2000@960, another needed 2000@1060 (paul_lionking).
- At ~2200 MHz at 40 CU, a secondary power limit is tripped by high voltage — raising voltage above a certain point causes hard lock (big_trov).

(source: governor.md:577-583)

---

## 40 CU Unlock Without Kernel Patch

As of May 2026, 40 CU unlock no longer requires a kernel patch. Use [bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) by vinnijs.dev — an interactive TUI that toggles CUs on the fly via UMR. No kernel modifications needed. Works on stock kernel across all distributions including Bazzite (auto-detects dri path).

```bash
git clone https://github.com/WinnieLV/bc250-cu-live-manager.git
cd bc250-cu-live-manager
# Follow README for your distro
```

The tool persists across reboots via systemd (`bc250-unlock.service`). As of June 2026, the live-manager also supports **disabling stock WGPs** (Work Group Processors) — useful for isolating defective CUs during artifact troubleshooting. See [10 — Troubleshooting](10-troubleshooting.md) for binary search approach to finding bad CUs.

For kernel parameter-based masking: `amdgpu.disable_cu=X.Y.Z` uses WGP-pair indexing. See [02 — BIOS & Firmware](02-bios-and-firmware.md) for full 40 CU documentation.

## CPU Overclocking (Advanced)

Uses the [bc250_smu_oc](https://github.com/bc250-collective/bc250_smu_oc) tool to raise CPU boost ceiling:

```bash
git clone https://github.com/bc250-collective/bc250_smu_oc.git
cd bc250_smu_oc
pip install --user .

# Test frequency (auto-tunes voltage)
sudo bc250-detect -f 3900 -v 1280 -k

# Make permanent
sudo bc250-detect -f 3900 -v 1280 -k -c /etc/bc250-overclock.conf
sudo bc250-apply -a -i /etc/bc250-overclock.conf
sudo systemctl enable bc250-smu-oc
```

### Verified Results (Fedora 43, Kernel 6.19.8)

(source: governor.md:610-619)

| CPU Freq | Voltage | 7zip Score | Temp | vs Stock |
|----------|---------|-----------|------|----------|
| 3500 MHz (stock) | Auto | 26,062 | 60C | Baseline |
| 3600 MHz | 1150 mV | 26,518 | 65C | +1.7% |
| 3700 MHz | 1199 mV | 27,212 | 68C | +4.4% |
| 3800 MHz | 1250 mV | 27,919 | 72C | +7.1% |
| 3900 MHz | 1275 mV | 28,410 | 75C | +9.0% |
| 4000 MHz | -- | Throttles | 77C | Not stable |

---

## PS5GPU-BC250 (GUI Controller)

A visual Qt-based GPU controller like MSI Afterburner for Windows:

- **Repository:** https://github.com/ZEROAESQUERDA/PS5GPU-BC250
- Features: Automatic + manual modes, temperature limits, 4 boost stages
- Works on KDE and GNOME
- Must disable any other governor before using (source: governor.md:117-119)

---

## ACPI Fix (CPU Power States)

The [bc250-acpi-fix](https://github.com/bc250-collective/bc250-acpi-fix) enables proper CPU idle and frequency scaling:

- **SSDT-CST:** Enables C1/C2/C3 CPU sleep states (lower idle power)
- **SSDT-PST:** Enables CPU frequency scaling (800 MHz - 3200 MHz) via standard Linux cpufreq governors (schedutil, powersave, etc.). Note: the repo README says "P-states doesn't work" but this is outdated per community testing (dantistnfs, Jan 2026) -- confirmed working as of kernel 6.19.8.

Confirmed working on kernel 6.19.8. Both tables loaded via initrd override. See the bc250-acpi-fix repo for full installation instructions. (source: governor.md:640-706)

---

## Verification

### Check Governor is Running

```bash
systemctl status cyan-skillfish-governor-smu
# Should show: active (running)
```

### Check Frequency Scaling

```bash
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Example output:
# 0: 1000Mhz
# 1: 1500Mhz
# 2: 2000Mhz *
#
# The * indicates active frequency
```

Test dynamic scaling: check frequency at idle (~1000 MHz), start a game, check frequency under load (2000+ MHz).

### Monitoring Tools

**CoolerControl (GUI):**
```bash
# Fedora
sudo dnf copr enable terra/terra
sudo dnf install coolercontrol

# Bazzite
ujust install-coolercontrol
```

**MangoHud (In-Game Overlay):**
```bash
sudo dnf install mangohud  # Fedora
sudo pacman -S mangohud    # Arch

# Steam launch option: mangohud %command%
```

(source: governor.md:294-322)

---

## Performance Comparison

| Governor | Idle Freq | Max Freq | CPU Usage | Response Time | Kernel Patch? |
|----------|-----------|----------|-----------|---------------|---------------|
| **None** | 1500 MHz (locked) | 1500 MHz | 0% | N/A | No |
| **SMU** | Variable (~1000 MHz) | 2300+ MHz | 0.9-1.3% | 24 ms | No |
| **TT** | Variable | 2175+ MHz | 0.9-1.3% | 24 ms | Yes |
| **Oberon (legacy)** | 1000 MHz | 2000 MHz | 0.4% | 100 ms | Yes |

(source: governor.md:504-511)

---

## Troubleshooting

### Governor Won't Start

```bash
# Check service status
sudo systemctl status cyan-skillfish-governor-smu

# Check logs
sudo journalctl -u cyan-skillfish-governor-smu

# Enable and restart
sudo systemctl enable cyan-skillfish-governor-smu
sudo systemctl restart cyan-skillfish-governor-smu
```

### GPU Stuck at 1500 MHz

Check: governor is running, minimum voltage is not below 700 mV, config file exists.

```bash
# Check governor status
systemctl status cyan-skillfish-governor-smu

# Check minimum voltage
cat /etc/cyan-skillfish-governor-smu/config.toml

# Check kernel frequency range
cat /sys/devices/pci0000:00/0000:00:08.1/0000:01:00.0/pp_od_clk_voltage
```

### Black Screen During GPU Reset

If the governor causes crashes during GPU-intensive games, temporarily disable it:

```bash
sudo systemctl stop cyan-skillfish-governor-smu
# Play the game, then re-enable
sudo systemctl start cyan-skillfish-governor-smu
```

Long-term fix: use stable voltage/frequency settings that don't cause GPU crashes. Increase voltage or reduce max frequency for problematic games.

### Governor High CPU Usage

Normal CPU usage: 0.9-1.3%. If usage exceeds 2%, increase polling interval:

```toml
# /etc/cyan-skillfish-governor-smu/config.toml
[timing]
interval_ms = 100  # Increase from 50
```

(source: governor.md:482-502)

---

## Community Resources

- [NexGen3D SteamMachine Scripts](https://github.com/NexGen-3D-Printing/SteamMachine) — automated Bazzite setup (governor + swap/zram + CPU mitigations)
- [redbeard1083 BC250 Toolkit](https://github.com/redbeard1083/bc250-toolkit) — setup script for CachyOS
- [DeathStalker Grimoire](https://github.com/DeathStalker471/bc250theGrimoire) — community step-by-step guide
- [PS5GPU-BC250](https://github.com/ZEROAESQUERDA/PS5GPU-BC250) — GUI GPU controller
- [cyan-skillfish-governor-smu](https://github.com/bc250-collective/cyan-skillfish-governor) — SMU governor (moved to bc250-collective org, v0.4.0 adds CPU-based memory clock control)
- [filippor/cyan-skillfish-governor](https://github.com/filippor/cyan-skillfish-governor) — Original repo (smu branch still maintained)

(source: governor.md:711-716)

---

**Source of truth:** elektricM docs/system/governor.md, docs/system/power.md, docs/bios/overclocking.md
**Last updated:** 2026-06-14
