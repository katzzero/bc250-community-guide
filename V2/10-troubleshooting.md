# 10 -- Troubleshooting

> Common problems and their solutions. If you don't see your issue here, check the [community resources](11-community-and-resources.md).

---

## Board Won't Boot (No POST)

**Symptoms:** Fans spin, LEDs light, but no display and keyboard doesn't light up.

**Checklist:**
1. **Clear CMOS** -- remove CR2032 battery for 60 seconds, press power button 5x (source: boot.md)
2. **Try a different PSU** -- bad PSU is the #1 cause; minimum 300W, 400W+ recommended (source: boot.md)
3. **Check for short circuits** -- plastic washers on wrong side of mounting screws, metal debris on board (source: boot.md)
4. **NVMe SSD with Windows partitions** -- wipe all partitions on another machine; Windows partitions can completely prevent boot (source: boot.md)
5. **Hardware flash BIOS** with CH341A programmer or Raspberry Pi Pico (source: boot.md; our file said CH347T -- corrected to match source)
6. **Board may be DOA** -- contact seller
7. **Check Q11 transistor** near the Nuvoton chip (can get knocked off) -- (need confirmation; not found in source docs)
8. **Reseat RAM** (it's soldered, but check connections) -- (need confirmation; RAM is soldered on BC-250)

---

## Black Screen After BIOS Flash

**Cause:** CMOS settings didn't persist (source: display.md, boot.md).

**Fix:**
1. Power off, unplug PSU
2. Remove CR2032 battery for 60 seconds
3. Press power button 5 times to discharge
4. Reinsert battery, enter BIOS
5. Reconfigure settings, save with F10
6. **Also try:** Remove NVMe SSD during flash, then reinsert

---

## Black Screen on Boot (Before OS)

**Possible causes and fixes:**

| Cause | Fix |
|-------|------|
| Wrong kernel version | Avoid 6.15.0-6.15.6 and 6.17.8-6.17.10. Use **6.18.18 LTS** (recommended), 6.17.11+, or 6.12.x-6.14.x LTS (source: boot.md, display.md, performance.md) |
| Bad GPU frequency | Boot with `nomodeset`, install governor, remove nomodeset (source: boot.md) |
| IOMMU enabled | Disable IOMMU in BIOS (source: boot.md, display.md, stability.md) |
| Green screen (CPU instability) | Try better PSU, different SSD, proper DP cable -- (need confirmation; green screen only mentioned in ACPI context in stability.md line 271) |
| Blue artifacts (GPU silicon) | Reduce frequency, may need board replacement -- (need confirmation; artifacts mentioned but not specifically "blue = silicon" in source docs) |

---

## No Display in BIOS (But OS Boots)

**Fix:** Use a native DisplayPort cable or passive DP-to-HDMI adapter. Active adapters may not initialize fast enough for BIOS (source: display.md "Display Works But No BIOS Menu" section).

---

## Black Screen During OS Installation

**Bazzite specific:**
- Use the **non-live installer** image
- If using live image: boot in "Basic Graphics Mode" (troubleshooting menu)
- Try only one monitor connected during install
- Verify ISO hash (corrupt downloads cause this)

**Fedora specific:**
- Select "Basic Graphics Mode" from GRUB before booting installer (source: boot.md, display.md)

---

## "Press ESC to Skip Startup.nsh"

**Cause:** Normal UEFI shell prompt during BIOS flash.

**Fix:** Type `Flash.nsh` and press Enter. Note: some keyboard layouts may cause typos (e.g., French keyboards may type `Flqsh.nsh`). -- (need confirmation; not found in any source doc; appears to be from Discord)

---

## "amdgpu: Unsupported clock type"

**Status:** Harmless message. -- (need confirmation; not found in source docs; reportedly from Discord)

**Impact:** Almost none. Ignore unless accompanied by GPU timeouts or crashes.

**Fix if issues occur:** Install the [cyan-skillfish-governor](https://github.com/filippor/cyan-skillfish-governor).

---

## "dal_irq_service_dummy_ack"

**Status:** Benign. Does NOT indicate hardware damage. -- (need confirmation; not found in source docs; reportedly from Discord)

**Fix:** None needed. GPU works normally despite this message.

---

## GPU Hang / Reset (Screen Freezes, Sound Continues)

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
1. **Increase VRAM limit** -- for LLM/AI workloads, add to kernel parameters (source: performance.md):
   ```
   amdgpu.gttsize=14750 ttm.pages_limit=3959290 ttm.page_pool_size=3959290
   ```
   This allows up to ~14.75 GB for VRAM. Limit usage to 14.25-14.5 GB in applications.
   -- (Note: our file had `ttm.pages_limit=2490368` for ~10 GB. That value is not in source docs; corrected to match source. The 2490368 values may be from Discord -- (need confirmation))
2. **Lower texture detail** in games
3. **Disable ZRAM or use fixed VRAM allocation** (source: stability.md)
4. **For OpenGL:** `MESA_LOADER_DRIVER_OVERRIDE=zink` -- (need confirmation; not found in source docs)

---

## High RAM Usage / OOM Crashes (Alternative to zram)

If zram is not enough for RAM-hungry games, use **zswap + swapfile** -- it dumps cold memory pages to disk, freeing RAM for games (source: performance.md).

**On Bazzite:**
```bash
# Disable zram
echo "" | sudo tee /etc/systemd/zram-generator.conf

# Create swapfile (32 GB)
sudo btrfs subvolume create /var/swap  # (need confirmation: btrfs + SELinux steps not in source performance.md)
sudo semanage fcontext -a -t var_t /var/swap
sudo restorecon /var/swap
SIZE=32G
sudo btrfs filesystem mkswapfile --size $SIZE /var/swap/swapfile
sudo semanage fcontext -a -t swapfile_t /var/swap/swapfile
sudo restorecon /var/swap/swapfile
sudo swapon /var/swap/swapfile

# Add to fstab
echo "/var/swap/swapfile none swap defaults,nofail 0 0" | sudo tee -a /etc/fstab

# Enable zswap with lz4 (source: performance.md)
rpm-ostree initramfs --enable \
  --arg=--add-drivers \
  --arg=lz4 \
  --arg=--add-drivers \
  --arg=lz4_compress

rpm-ostree kargs --append-if-missing="zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4"
sudo reboot
```

Verify with (source: performance.md):
```bash
grep -r . /sys/module/zswap/parameters/
```
Should show `enabled:Y`, `compressor:lz4`, `max_pool_percent:25`.

---

## KDE Plasma / Qt Crashes

**Cause:** Broken RDSEED instruction on BC-250 hardware (fixed in kernel 6.16+). -- (need confirmation; not found in any source doc; appears to be from Discord)

**Fixes:**
- Update to **kernel 6.16+** (recommended: 6.18.18 LTS)
- Update to **Qt 6.8+**
- Workaround: Use GNOME instead of KDE

---

## Consistent Micro-Stuttering (Every Few Seconds)

**Cause:** Bazzite's Handheld Daemon (HHD) fails to load required functionality and restarts constantly. -- (need confirmation; not found in source docs; appears to be from Discord)

**Fix:**
```bash
sudo systemctl disable --now hhd
sudo systemctl mask hhd   # Prevents re-enabling on updates
```

---

## Gamescope Artifacts / Visual Glitches

**Symptoms:** Artifacts on GameScope windows and games; not visible in desktop mode. -- (need confirmation; not found in source docs; appears to be from Discord)

**Fixes:**
1. Enable **Force Composition** in Steam GameScope settings (disables direct scan-out)
2. Bump lowest governor safe point -- e.g. `350 MHz @ 720 mV`
3. Change monitor refresh rate

---

## High Temperatures (85C+)

**Causes and fixes:**

| Issue | Solution |
|-------|----------|
| Stock thermal paste dried out | Replace with PTM7950 pad or quality paste (source: performance.md, stability.md) |
| Heatsink fins closed | Open center fins (scooter tool or bending) (source: sensors.md "cut fins") |
| Fan too slow / not spinning | Check PWM settings, use higher speed curve (source: sensors.md) |
| Poor case airflow | Open case panels, add exhaust fan |
| VRAM overheating | Add thermal pads + rear fan -- (need confirmation: BC-250 is an APU; "VRAM backplate" wording may be inaccurate) |
| Overclocking too aggressive | Lower frequency or increase voltage (source: stability.md) |

---

## Governor Not Starting

```bash
# Check status
systemctl status cyan-skillfish-governor-smu

# Reinstall (source: governor.md)
sudo dnf reinstall cyan-skillfish-governor-smu     # Fedora
yay -S cyan-skillfish-governor-smu                  # Arch

# Check config exists (source: governor.md)
ls -l /etc/cyan-skillfish-governor-smu/config.toml

# Check logs (source: governor.md)
sudo journalctl -u cyan-skillfish-governor-smu --no-pager -n 20
```

---

## GPU Locked at 1500 MHz

**Causes (source: governor.md):**
1. Governor not running (see above)
2. Minimum voltage below 700 mV (source: governor.md -- "Never set minimum GPU voltage below 700mV. This locks the GPU to 1500MHz")
3. Kernel limitation (no frequency range patch)

**Fix (source: governor.md):**
```bash
# Check current frequency
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Check governor config voltage
cat /etc/cyan-skillfish-governor-smu/config.toml
# Ensure minimum voltage >= 700 mV

# Verify governor is targeting the right GPU
vulkaninfo | grep deviceName
# Should show: AMD Radeon Graphics (RADV GFX1013), NOT llvmpipe (source: quick-reference.md)
```

---

## BIOS Settings Don't Stick

**Fix (source: display.md, boot.md):** Clear CMOS properly:
1. Power off, unplug PSU
2. Remove CR2032 battery for 60 seconds
3. Press power button 5 times
4. Reinsert battery, enter BIOS
5. Save again with F10

---

## Flash Failed -- Board Won't POST

**Recovery (source: boot.md):**
1. **Hardware programmer required:** CH341A or Raspberry Pi Pico with SOP8 clip
   -- (Note: our file said CH347T. Corrected to match source boot.md line 845. CH347T may also work -- (need confirmation))
2. Flash chip: `BIOS_A1` (Winbond W25Q64 -- source: boot.md line 846)
   -- (Note: our file said W25Q128JVSQ. Corrected to match source. Different board revisions may have different chips -- (need confirmation))
3. Command:
   ```bash
   sudo flashrom -p ch341a_spi -w BC250_3.00_CHIPSETMENU.ROM
   ```
   -- (Note: programmer name corrected from `ch347_spi` to `ch341a_spi` to match source hardware)

---

## Debugging Commands (Quick Reference)

```bash
# Check kernel version
uname -r

# Check Mesa version (source: quick-reference.md, display.md)
glxinfo | grep "OpenGL version"

# Check Vulkan device (source: quick-reference.md, display.md)
vulkaninfo | grep deviceName
# Should show: AMD Radeon Graphics (RADV GFX1013)

# Check GPU frequency (source: governor.md)
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Check governor status (source: governor.md)
systemctl status cyan-skillfish-governor-smu

# Check boot errors
dmesg | grep -i "error\|fail\|amdgpu\|acpi"

# Check GPU load (source: performance.md)
cat /sys/class/drm/card1/device/gpu_busy_percent

# Check temperatures (source: sensors.md)
sensors

# Check SuperIO sensors (source: sensors.md)
find /sys -name "temp*_input" 2>/dev/null | while read f; do
  echo "$f: $(cat $f)"; done

# Check GPU renderer (should NOT be llvmpipe) (source: performance.md)
glxinfo | grep "OpenGL renderer"
```

---

## Important Reminders

- Never use 6-pin to 8-pin PCIe adapters for power delivery -- they will melt -- (need confirmation; not found in source docs; reportedly from Discord)
- Never flash the `SIO1_R` chip (Macronix MX25L4006E) -- you will brick the SuperIO -- (need confirmation; not found in source docs; reportedly from Discord)
- Never set GPU voltage below 700 mV -- GPU will lock to 1500 MHz (source: governor.md, stability.md)
- Never use Smokeless_UMAF -- can cause permanent damage (source: quick-reference.md)
- Always clear CMOS after BIOS flash (source: boot.md, display.md, quick-reference.md)
- Always disable IOMMU in BIOS (source: boot.md, display.md, stability.md, quick-reference.md)
- Always use passive DP-to-HDMI for audio (source: display.md)
- Use kernel 6.18.18 LTS (recommended), 6.17.11+, or 6.12.x-6.14.x LTS (avoid 6.15.0-6.15.6 and 6.17.8-6.17.10) (source: boot.md, display.md, performance.md, quick-reference.md)
