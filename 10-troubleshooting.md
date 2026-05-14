# 10 — Troubleshooting

> Common problems and their solutions. If you don't see your issue here, check the [community resources](11-community-and-resources.md).

---

## 🔴 Board Won't Boot (No POST)

**Symptoms:** Fans spin, LEDs light, but no display and keyboard doesn't light up.

**Checklist:**
1. **Clear CMOS** — remove CR2032 battery for 60 seconds, press power button 5×
2. **Try a different PSU** — bad PSU is the #1 cause
3. **Check Q11 transistor** near the Nuvoton chip (can get knocked off)
4. **Reseat RAM** (it's soldered, but check connections)
5. **Hardware flash BIOS** with CH347T or Raspberry Pi Pico
6. **Check for short circuits** — plastic washers on wrong side of mounting screws
7. **Board may be DOA** — contact seller

---

## 🔴 Black Screen After BIOS Flash

**Cause:** CMOS settings didn't persist.

**Fix:**
1. Power off, unplug PSU
2. Remove CR2032 battery for 60 seconds
3. Press power button 5 times to discharge
4. Reinsert battery, enter BIOS
5. Reconfigure settings, save with F10
6. **Also try:** Remove NVMe SSD during flash, then reinsert

---

## 🔴 Black Screen on Boot (Before OS)

**Possible causes and fixes:**

| Cause | Fix |
|-------|-----|
| Wrong kernel version | Avoid 6.15.0–6.15.6 and 6.17.8–6.17.10. Use **6.18.18 LTS** |
| Bad GPU frequency | Boot with `nomodeset`, install governor, remove nomodeset |
| IOMMU enabled | Disable IOMMU in BIOS |
| Green screen (CPU instability) | Try better PSU, different SSD, proper DP cable |
| Blue artifacts (GPU silicon) | Reduce frequency, may need board replacement |

---

## 🟡 No Display in BIOS (But OS Boots)

**Fix:** Use a native DisplayPort cable or passive DP-to-HDMI adapter. Active adapters may not work in BIOS. See [Display Guide](08-display-and-audio.md).

---

## 🟡 Black Screen During OS Installation

**Bazzite specific:**
- Use the **non-live installer** image
- If using live image: boot in "Basic Graphics Mode" (troubleshooting menu)
- Try only one monitor connected during install
- Verify ISO hash (corrupt downloads cause this)

**Fedora specific:**
- Select "Basic Graphics Mode" from GRUB before booting installer

---

## 🟡 "Press ESC to Skip Startup.nsh"

**Cause:** Normal UEFI shell prompt during BIOS flash.

**Fix:** Type `Flash.nsh` and press Enter. Note: some keyboard layouts may cause typos (e.g., French keyboards may type `Flqsh.nsh`).

---

## 🟡 "amdgpu: Unsupported clock type"

**Status:** Harmless message, present since Mesa 25.1.

**Impact:** Almost none. Ignore unless accompanied by GPU timeouts or crashes.

**Fix if issues occur:** Install the [cyan-skillfish-governor](https://github.com/filippor/cyan-skillfish-governor).

---

## 🟡 "dal_irq_service_dummy_ack"

**Status:** Benign. Does NOT indicate hardware damage.

**Fix:** None needed. GPU works normally despite this message.

---

## 🟡 GPU Hang / Reset (Screen Freezes, Sound Continues)

**Error messages you'll see:**
```
amdgpu: Dumping IP State
amdgpu: ring gfx_0.0.0 timeout
amdgpu: Starting gfx_0.0.0 ring reset
amdgpu: device wedged, but recovered through reset
```

**Causes:**
- VRAM exhaustion (game using >8 GB shared memory)
- OpenGL workloads
- Kernel bug

**Fixes:**
1. **Increase VRAM limit** — add to kernel parameters:
   ```
   ttm.pages_limit=2490368 ttm.pages_pool_size=2490368
   ```
   This allows up to ~10 GB for VRAM with 512 MB BIOS setting.
2. **Lower texture detail** in games
3. **Enable zram:** `zram-size = ram × 0.75`
4. **For OpenGL:** `MESA_LOADER_DRIVER_OVERRIDE=zink`

---

## 🟡 High RAM Usage / OOM Crashes (Alternative to zram)

If zram isn't enough for RAM-hungry games, use **zswap + swapfile** — it dumps cold memory pages to disk, freeing RAM for games.

**On Bazzite:**
```bash
# Disable zram
echo "" | sudo tee /etc/systemd/zram-generator.conf

# Create swapfile (32 GB)
sudo btrfs subvolume create /var/swap
sudo semanage fcontext -a -t var_t /var/swap
sudo restorecon /var/swap
SIZE=32G
sudo btrfs filesystem mkswapfile --size $SIZE /var/swap/swapfile
sudo semanage fcontext -a -t swapfile_t /var/swap/swapfile
sudo restorecon /var/swap/swapfile
sudo swapon /var/swap/swapfile

# Add to fstab
echo "/var/swap/swapfile none swap defaults,nofail 0 0" | sudo tee -a /etc/fstab

# Enable zswap with lz4 (best compressor for BC-250 per community benchmarks)
rpm-ostree initramfs --enable \
  --arg=--add-drivers \
  --arg=lz4 \
  --arg=--add-drivers \
  --arg=lz4_compress

rpm-ostree kargs --append-if-missing="zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4"
sudo reboot
```

Verify with:
```bash
grep -r . /sys/module/zswap/parameters/
```
Should show `enabled:Y`, `compressor:lz4`, `max_pool_percent:25`.

---

## 🟡 KDE Plasma / Qt Crashes

**Cause:** Broken RDSEED instruction on BC-250 hardware (fixed in kernel 6.16+).

**Fixes:**
- Update to **kernel 6.16+** (recommended: 6.18.18 LTS)
- Update to **Qt 6.8+** (properly fixes RDSEED)
- Workaround: Use GNOME instead of KDE

---

## 🟡 Consistent Micro-Stuttering (Every Few Seconds)

**Cause:** Bazzite's Handheld Daemon (HHD) fails to load required functionality and restarts constantly.

**Fix:**
```bash
sudo systemctl disable --now hhd
sudo systemctl mask hhd   # Prevents re-enabling on updates
```

---

## 🟡 Gamescope Artifacts / Visual Glitches

**Symptoms:** Artifacts on GameScope windows and games; not visible in desktop mode.

**Fixes:**
1. Enable **Force Composition** in Steam GameScope settings (disables direct scan-out)
2. Bump lowest governor safe point — e.g. `350 MHz @ 720 mV`
3. Change monitor refresh rate

---

## 🟡 High Temperatures (85°C+)

**Causes and fixes:**

| Issue | Solution |
|-------|----------|
| Stock thermal paste dried out | Replace with PTM7950 pad or quality paste |
| Heatsink fins closed | Open center fins (scooter tool or bending) |
| Fan too slow / not spinning | Check PWM settings, use higher speed curve |
| Poor case airflow | Open case panels, add exhaust fan |
| VRAM overheating (backplate) | Add thermal pads + rear fan |
| Overclocking too aggressive | Lower frequency or increase voltage |

---

## 🟡 Governor Not Starting

```bash
# Check status
systemctl status cyan-skillfish-governor-smu

# Reinstall
sudo dnf reinstall cyan-skillfish-governor-smu     # Fedora
yay -S cyan-skillfish-governor-smu                  # Arch

# Check config exists
ls -l /etc/cyan-skillfish-governor-smu/config.toml

# Check logs
sudo journalctl -u cyan-skillfish-governor-smu --no-pager -n 20
```

---

## 🟡 GPU Locked at 1500 MHz

**Causes:**
1. Governor not running (see above)
2. Minimum voltage below 700 mV
3. Kernel limitation

**Fix:**
```bash
# Check current frequency
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Check governor config voltage
cat /etc/cyan-skillfish-governor-smu/config.toml
# Ensure minimum voltage ≥ 700 mV

# Verify governor is targeting the right GPU
vulkaninfo | grep deviceName
# Should show: AMD Radeon Graphics (RADV GFX1013), NOT llvmpipe
```

---

## 🟡 BIOS Settings Don't Stick

**Fix:** Clear CMOS properly:
1. Power off, unplug PSU
2. Remove CR2032 battery for 60 seconds
3. Press power button 5 times
4. Reinsert battery, enter BIOS
5. Save again with F10

---

## 🔴 Flash Failed — Board Won't POST

**Recovery:**
1. **Hardware programmer required:** CH347T or Raspberry Pi Pico with SOP8 clip
2. Flash chip: `BIOS_A1` (Winbond W25Q128JVSQ)
3. Command:
   ```bash
   sudo flashrom -p ch347_spi -w BC250_3.00_CHIPSETMENU.ROM
   ```

---

## 📋 Debugging Commands (Quick Reference)

```bash
# Check kernel version
uname -r

# Check Mesa version
glxinfo | grep "OpenGL version"

# Check Vulkan driver
vulkaninfo | grep driverName

# Check GPU driver (should show: radv)
vulkaninfo | grep driverName

# Check GPU frequency
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Check governor status
systemctl status cyan-skillfish-governor-smu

# Check boot errors
dmesg | grep -i "error\|fail\|amdgpu\|acpi"

# Check GPU load
cat /sys/class/drm/card1/device/gpu_busy_percent

# Check temperatures
sensors

# Check nct6683 sensors
find /sys -name "temp*_input" 2>/dev/null | while read f; do
  echo "$f: $(cat $f)"; done

# Check GPU renderer (should NOT be llvmpipe)
glxinfo | grep "OpenGL renderer"
```

---

## 🛡️ Important Reminders

- ❌ Never use 6-pin to 8-pin PCIe adapters for power delivery — they will melt
- ❌ Never flash the `SIO1_R` chip (Macronix MX25L4006E) — you'll brick the SuperIO
- ❌ Never set GPU voltage below 700 mV — GPU will lock to 1500 MHz
- ❌ Never use Smokeless_UMAF — can cause permanent damage
- ✅ Always clear CMOS after BIOS flash
- ✅ Always disable IOMMU in BIOS
- ✅ Always use passive DP-to-HDMI for audio
- ✅ Keep kernel between 6.17.11+ and 6.18.18+ (avoid known-broken versions)