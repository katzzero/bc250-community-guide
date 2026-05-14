# 06 — GPU Governor

> **The GPU governor is essential.** Without it, the GPU is locked at 1500 MHz and idle power is 85–105W.
> With it, the GPU dynamically scales from ~1000 MHz (idle) to 2000–2300 MHz (gaming), and idle power drops to 65–85W.

---

## Which Governor Should You Use?

| Governor | Type | Kernel Patch? | Recommended? | Notes |
|----------|------|---------------|--------------|-------|
| **cyan-skillfish-governor-smu** | SMU-based | ❌ No (works on any distro) | ✅ **YES — Best choice** | Most efficient, best scaling, no kernel mods needed |
| **cyan-skillfish-governor-tt** | Multi-step | ✅ Yes (pre-included in Bazzite) | Good alternative | Thermal throttling aware |
| **oberon-governor** | Two-state | ✅ Yes | Legacy / No longer recommended | Simple but limited to 1000/2000 MHz |

---

## Installation: cyan-skillfish-governor-smu (Recommended)

### Fedora / Bazzite

```bash
sudo dnf copr enable filippor/bazzite
sudo dnf install cyan-skillfish-governor-smu      # Fedora
rpm-ostree install cyan-skillfish-governor-smu     # Bazzite
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Arch / CachyOS / Manjaro

```bash
yay -S cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Debian / Ubuntu

```bash
# Download .deb from GitHub releases page:
# https://github.com/Magnap/cyan-skillfish-governor/releases
wget https://github.com/Magnap/cyan-skillfish-governor/releases/latest/download/cyan-skillfish-governor-smu_amd64.deb
sudo dpkg -i cyan-skillfish-governor-smu_amd64.deb
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Generic Linux (Build from Source)

```bash
git clone https://github.com/filippor/cyan-skillfish-governor.git
cd cyan-skillfish-governor
# See repo README for build instructions
```

---

## Configuration

Config file: `/etc/cyan-skillfish-governor-smu/config.toml`

### Recommended Config (Good for Most Users)

```toml
safe-points = [
    [1000, 700],   # 1000 MHz @ 700 mV (idle)
    [1500, 900],   # 1500 MHz @ 900 mV
    [2000, 1000],  # 2000 MHz @ 1000 mV (gaming)
    [2175, 1025],  # 2175 MHz @ 1025 mV (boost)
    [2230, 1060],  # 2230 MHz @ 1060 mV (OC — needs good cooling)
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

> 💡 **Minimum voltage is 700 mV.** Going below this locks the GPU to 1500 MHz and defeats the purpose.

### After Changing Config

```bash
sudo systemctl restart cyan-skillfish-governor-smu
```

---

## Manual Testing

To test a specific frequency/voltage combination before adding it to the config:

```bash
# Stop the governor
sudo systemctl stop cyan-skillfish-governor-smu

# Manually set frequency (in MHz) and voltage (in mV)
echo vc 0 2100 1050 > /sys/devices/pci0000:00/0000:00:08.1/0000:01:00.0/pp_od_voltage

# Run a game or benchmark (30+ minutes for stability test)

# If stable, add to your config
# If it crashes, increase voltage or lower frequency

# Restart governor when done
sudo systemctl start cyan-skillfish-governor-smu
```

---

## Known Stable Frequency / Voltage Points

| Frequency | Voltage | Cooling Needed | Stability |
|-----------|---------|----------------|-----------|
| 2000 MHz | 1000 mV | Stock air cooling | ✅ Safe for all boards |
| 2100 MHz | 1025–1050 mV | Good air cooling | ✅ Most boards |
| 2230 MHz | 1060 mV | Good air cooling required | ✅ Tested by community |
| 2300 MHz | 1075 mV | High-end air / AIO | ⚠️ Depends on silicon lottery |
| 2400 MHz | 1125 mV | Liquid cooling only | ⚠️ NexGen3D testing only |

---

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

| CPU Freq | Voltage | 7zip Score | Temp | vs Stock |
|----------|---------|-----------|------|----------|
| 3500 MHz (stock) | Auto | 26,062 | 60°C | Baseline |
| 3600 MHz | 1150 mV | 26,518 | 65°C | +1.7% |
| 3700 MHz | 1199 mV | 27,212 | 68°C | +4.4% |
| 3800 MHz | 1250 mV | 27,919 | 72°C | +7.1% |
| 3900 MHz | 1275 mV | 28,410 | 75°C | +9.0% |
| 4000 MHz | — | Throttles | 77°C | ❌ Not stable |

---

## PS5GPU-BC250 (GUI Controller)

A visual GPU controller like MSI Afterburner for Windows:

- **Repository:** https://github.com/ZEROAESQUERDA/PS5GPU-BC250
- Features: Automatic + manual modes, temperature limits, 4 boost stages
- **Must disable any other governor** before using

---

## ACPI Fix (CPU Power States)

The [bc250-acpi-fix](https://github.com/bc250-collective/bc250-acpi-fix) enables proper CPU idle and frequency scaling:

- **SSDT-CST:** Enables C1/C2/C3 CPU sleep states (lower idle power)
- **SSDT-PST:** Enables CPU frequency scaling (800 MHz – 3200 MHz)

Recommended for all users. See the full installation in the [governor documentation](https://github.com/filippor/cyan-skillfish-governor).

---

## Performance Comparison

| Governor | Idle Freq | Max Freq | CPU Usage | Response Time | Kernel Patch? |
|----------|-----------|----------|-----------|---------------|---------------|
| **None** | 1500 MHz (locked) | 1500 MHz | 0% | N/A | No |
| **SMU ⭐** | Variable (~1000 MHz) | 2300+ MHz | 0.9–1.3% | 24 ms | No |
| **TT** | Variable | 2175+ MHz | 0.9–1.3% | 24 ms | Yes |
| **Oberon (legacy)** | 1000 MHz | 2000 MHz | 0.4% | 100 ms | Yes |

---

## Troubleshooting

### Governor Won't Start
```bash
# Check if service exists
sudo systemctl status cyan-skillfish-governor-smu

# Reinstall
sudo dnf reinstall cyan-skillfish-governor-smu
```

### GPU Stuck at 1500 MHz
```bash
# Check governor is running
systemctl status cyan-skillfish-governor-smu

# Check minimum voltage isn't below 700 mV
cat /etc/cyan-skillfish-governor-smu/config.toml

# Check if kernel is limiting frequency
cat /sys/devices/pci0000:00/0000:00:08.1/0000:01:00.0/pp_od_clk_voltage
```

### Black Screen During GPU Reset
If the governor causes crashes during GPU-intensive games, temporarily disable it:
```bash
sudo systemctl stop cyan-skillfish-governor-smu
# Play the game, then re-enable
sudo systemctl start cyan-skillfish-governor-smu
```
Consider lowering max frequency or increasing voltage in your config.