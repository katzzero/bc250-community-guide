# 10 -- Troubleshooting

> Common problems and their solutions. If you don't see your issue here, check the [community resources](11-community-and-resources.md).

---

## Frequently Asked Questions

| Question | Brief Answer | See Also |
|----------|-------------|----------|
| **Which PSU should I buy?** | FSP500-30AS (US, ~$10-22 eBay) or Mean Well LOP-400/500/600 for best value. Metalfish Flex 500W for non-US. 400W+ minimum for OC. | [03-Power Supply Guide](03-power-supply-guide.md) |
| **Which WiFi adapter works?** | TP-Link Archer TX10UB Nano or UGreen AX900 (both MT7921AU chipset, OOTB on Bazzite). Avoid combo WiFi/BT dongles on USB 3.0 ports -- use separate dongles or a USB 2.0 hub. | [09-WiFi & Peripherals](09-wifi-and-peripherals.md) |
| **How do I fix VRAM out-of-memory crashes?** | Use 512MB dynamic allocation in BIOS, add kernel params `ttm.pages_limit=3959290 ttm.page_pool_size=3959290`, set up zswap + 16-32GB swapfile. Static splits (6GB/10GB) are more reliable for AAA games. | VRAM section below, [02-BIOS](02-bios-and-firmware.md) |
| **How do I fix ACPI idle power draw?** | Install `bc250-acpi-fix` -- enables CPU C-States and P-States for lower idle power. GitHub: bc250-collective/bc250-acpi-fix. Requires dracut rebuild on Bazzite. | help-thread exports |
| **How do I fix green screen / visual artifacts?** | Check CPU stability (increase voltage), GPU governor voltage too low (raise 25-50mV), VRAM overheating (add heatsinks). If persistent at stock settings, board may have faulty silicon. | Artifacts section below |
| **Why is my CPU fan not spinning?** | J4003 header may need fan with detection pin grounded. Try different fan model. Check with multimeter for oxidized pins. Some fans require the 4th PWM pin to be connected. | help-thread: `None of The CPU fans I try work` |
| **Which OS should I use?** | CachyOS = community default, best stability + performance for 40 CU. Bazzite = console-like BUT needs testing branch (stable kernel 6.17.7 is too old). | [05-OS Installation](05-os-installation.md) |
| **How do I recover from a bricked BIOS?** | Use CH341A or Raspberry Pi Pico on J4004 header with SOP8 clip. Flash chip: BIOS_A1 (Winbond W25Q128JVSQ, 16MB). Always backup first. | Flash Failed section below |
| **No audio over DisplayPort?** | Use a passive (not active) DP-to-HDMI adapter. Update to kernel 6.19.10+ for DP audio fix. USB audio adapter ($10) as fallback. | [08-Display & Audio](08-display-and-audio.md) |
| **How do I reduce idle power draw?** | ACPI fix (see above) + cyan-skillfish-governor (dynamically scales GPU, reducing idle freq) + disable unnecessary USB devices in BIOS. Typical idle: 60-70W with governor + ACPI fix; SMU profile 0 saves ~15W vs profile 3. | ACPI fix repo, governor docs |

---

## Board Won't Boot (No POST)

**Symptoms:** Fans spin, LEDs light, but no display and keyboard doesn't light up.

**Checklist:**
1. **Clear CMOS** - remove CR2032 battery for 60 seconds, press power button 5x
2. **Try a different PSU** - bad PSU is the #1 cause
3. **Check Q11 transistor** near the Nuvoton chip (can get knocked off). Replacement parts (SOT-23 NPN): **MMBT4401LT1** (original, marking "S1A"), **BS170FTA**, or **MMBT3904-R1 40V** (hazy6401, redpacman724, Jun 2026).
4. **Reseat RAM** (it's soldered, but check connections)
5. **Hardware flash BIOS** with CH341A or Raspberry Pi Pico
6. **Check for short circuits** - plastic washers on wrong side of mounting screws
7. **Board may be DOA** - contact seller

**Green LED always on when board is off:** If the green LED stays lit when power is disconnected and turns red only when pressing the power button, this may indicate a corrupted BIOS or a PSU mod issue (matearz, help-thread, June 2026). Check if you modified the 5V standby rail (PLD5 conductor removal per iamdarkyoshi's PSU power-on mod) — this can prevent POST on some boards.

---

## Power On For 1 Second Then Off (No POST)

**Symptoms:** Board powers on for about 1 second, red and blue LEDs blink, then immediately shuts off with a distinctive click from the PSU. No display, no USB power.

**Cause:** PSU detecting a short circuit and triggering over-current protection. Most commonly a faulty PSU. In one documented case the PSU was confirmed as the root cause: with a Metalfish 500W Flex the board shut off after ~1 second every boot, and swapping to a different known-working PSU fixed it (gredzikk, help-thread "No POST, auto power off after 1 second"). Note the sequence in that thread: the Corsair SF750 also failed to boot it -- the fix was a third, known-good PSU. **Metalfish 600W (BD650M) caveat:** multiple users report the 600W model will not boot the BC-250 when only the PCIe 8-pin is connected -- the protection circuit cuts power (dmsgod., pay2win5858, nexgen3d, Nov-Dec 2025). **Alternative cause:** plastic washers on the wrong side of the mounting screws causing thermal shutdown -- ntimd8r: "Mine did that after a repaste...I put the plastic washers on the wrong side. It was thermally shutting down" (17/04/2026).

**Fix:** Try a different known-working PSU before assuming the board is dead. Also check:
1. No 12V wires mixed up with GND
2. Remove any metal debris from cutting heatsink fins (shavings can short pins)
3. Check plastic washers are on the correct side of the mounting screws (thermally shutting down)
4. Try a different PCIe port on the PSU
5. BIOS reflash via CH341 programmer did not help in the documented case above -- the PSU was the root cause (gredzikk, 23/04/2026).

---

## SteamOS 3.9 Bootloop After Upgrade from 3.8

**Symptoms:** System loops at SteamOS intro video immediately after upgrading from 3.8. Occurs when selecting "main channel" in updates and rebooting. Tested with UGreen 8K DP adapter and direct DP to board — no output. Reproduced on a fresh SteamOS install (generic 3.8 image, then set update channel to MAIN to get wifi adapter working) (uba2615, Aug 3-4 2026).

**Status:** No confirmed workaround as of Aug 8 2026. Suggested alternatives include using a fresh Bazzite install or reverting to SteamOS 3.8.x (j0shm1lls: "don't get 3.9 yet, not ready for mainstream, 3.8.24 works great though").

---

## 8-Core Unlock Boot Failure (Stuck at Boot Logo / No POST)

**Symptoms (vadym557, Aug 2 & 8 2026):** After flashing an 8-core BIOS and enabling the unlock, the board gets stuck at the boot logo with a small spinner (SteamOS), or Bazzite won't start and sometimes crashes with a "kernel panic". Disabling the cores in the BIOS boots fine. Multiple attempts with the unlock enabled all fail.

**Cause:** The unlocked cores are defective ("bad cores" — vadym557: "Guess my extra cores are cooked"). The core-unlock BIOS and the EFI/Python methods expose the same silicon; if the two extra cores can't POST, no boot method will fix it.

**Fix:**
1. Disable the 8-core unlock in BIOS (the toggle BIOSes make this a menu option; otherwise clear CMOS — yrouel86) and verify the board boots at 6 cores
2. Before flashing any permanent BIOS, **always test the cores first** with the software unlock (`test-cores.sh` or the Python script) — if they fail, do NOT flash the permanent BIOS, or you'll need an external programmer to recover (yrouel86). Run the sweep with the 8 cores visible:

```bash
git clone https://github.com/GabriWar/bc250-core-cu-unlock
cd bc250-core-cu-unlock
sudo ./bc250-8core-unlock.sh apply && sudo reboot   # or use the Python script/EFI shim
./test-cores.sh      # stress-ng --verify, 20s per physical core
```

Pass: `failed` = 0 on every core and spread within ~1% of the median. **Fail:** any `failed` > 0 means that core returns wrong results (bad silicon — vadym557: "Guess my extra cores are cooked"); do not flash the permanent BIOS, and re-test at stock clocks if one core sits far below the median.
3. On Bazzite with an 8-core BIOS, test with the unlock disabled before blaming the OS — a Bazzite-specific panic may actually be a bad-core POST failure

**Related GPU errors (h00man._., Aug 1 2026):** Applying the CPU unlock commands produced AMD GPU errors — the board booted but Wayland glitched or didn't turn on at all (yet htop confirmed all 8c/16t present at 100% in one boot). Suggested isolation (filippor): disable the governor, CPU overclock/undervolt, and the 40 CU enable to test the unlock on its own.

**Related service hang (krystlih, Aug 6 2026):** The `bc250-cpu-service` install can hang while testing overclocks on an unlocked board. If the 8-core unlock is already working (via EFI) and Furmark/gaming are stable, the hang is in the service's OC validation — skip the service or run it with the OC test disabled.

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
| Wrong kernel version | Check the canonical [Kernel Support Matrix (05)](05-os-installation.md#kernel-support-matrix-canonical--as-of-2026-09-03): avoid 6.15.0–6.15.6 and 6.17.8–6.17.10; CachyOS 7.1.x is current, 6.19.x recommended stable, 6.18 LTS fallback |
| Bad GPU frequency | Boot with `nomodeset`, install governor, remove nomodeset (source: boot.md) |
| IOMMU enabled | Disable IOMMU in BIOS (source: boot.md, display.md, stability.md) |
| Green screen (CPU instability) | Try better PSU, different SSD, proper DP cable -- (community report — cause not confirmed; green screen only documented in the ACPI context in stability.md) |
| Blue artifacts (GPU silicon) | Reduce frequency, may need board replacement -- (community report — artifacts documented, but the "blue = silicon" link is not confirmed in source docs) |

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

## Bazzite Installer Freezes at Second Phase

**Fix:** Install CachyOS Deck version instead. User .moosi confirmed: "Fixed after I installed CachyOS deck version" -- the Bazzite installer consistently froze at the second phase, and switching to CachyOS resolved it completely.

---

## Green Screen During Bazzite Install (Or Repeatedly)

**Warning:** If you get a green screen (or black screen with proper DP cable) during Bazzite installation or repeatedly during use, this may indicate **hardware failure** -- broken solder balls under the GDDR6 memory ICs.

**Fix:** Requires reballing all GDDR6 ICs and replacing any shorted ICs. jayawesome completed this repair successfully: after reballing and replacing one shorted IC, the board ran stable 24/7. This is advanced hardware repair, not a software fix.

**Software alternative:** Green screen crashes on Bazzite during idle/Steam downloads (but NOT during gaming) may be an OS issue rather than hardware failure. Multiple users (evo9899, Jun 2026) reported that switching to CachyOS resolved persistent green screen crashes, suggesting a corrupted Bazzite install or configuration conflict. Before concluding hardware failure, test with a different OS or try reinstalling Bazzite from scratch.

### ATX Auto-Power-On Mod — Wrong Pin Connection

**Symptom:** After performing the ATX PSU auto-power-on mod, the board shows a solid red light, fans ramp to maximum, and no display appears — all triggered when the PSU switch is flipped (without pressing the power button).

**Cause:** The PS_ON pin was bridged to COM (ground) instead of **+5VSB (standby power)**. Bridging to ground immediately forces the PSU on, triggering the board's protection.

**Fix (endangered.species):** Connect PS_ON (green wire on 24-pin ATX) to +5VSB (purple wire), NOT to COM/GND. The +5VSB standby rail provides the correct signal to control PSU power state. Double-check your wiring before powering on.

### Elden Ring / CPU-Bound Games — Core 0 Affinity Workaround

**Symptom:** Elden Ring cannot reach 60 FPS even at 480p. The game has a known bug that overloads CPU Core 0, making it a single-core bottleneck. Other CPU-bound games may have similar behavior (matearz, fabiiii_, Jun 2026).

**Fix A — htop (temporary):**
```bash
sudo htop
# Find the game process, press 'a', deselect CPU 0 with Space, press Enter
```

**Fix B — Steam launch option (permanent):**
```
WINE_CPU_TOPOLOGY=11:1,2,3,4,5,6,7,8,9,10,11 %command%
```

This prevents the game from using Core 0, distributing work across the remaining 5 cores. (kaferlord, pops1cl)

### GPU-Bound Games — Split Lock Mitigation Disable

**Symptom:** CPU-intensive games underperform on BC-250. The unified GDDR6 memory has higher latency than DDR4/DDR5, which amplifies the penalty of split-lock mitigations enforced by the Linux kernel.

**Fix (dejan_994, pops1cl, Jun 2026):**
```bash
sudo sysctl kernel.split_lock_mitigate=0
```

By default on x86, Linux restricts applications to holding one split lock at a time (DoS prevention). Disabling this removes that bottleneck. Particularly effective on BC-250 due to GDDR6 latency characteristics.

### MangoHud Frame Pacing Issues

**Symptom:** Sawtooth pattern in frame time graph. Games feel like "slow-motion" despite displaying 60 FPS. Present on both GameScope and Desktop mode, on CachyOS and Bazzite (loris_kujo, Jun 2026).

**Fix (brillaglacielle, Jun 2026):** Turn off MangoHud completely. With MangoHud disabled, the sawtooth frame pattern disappears and the game returns to normal speed.

### GPU Governor — Config Parse Error on Start

**Symptom:** Governor installed but refuses to start. Log shows config file parse errors. Common on Bazzite with kernel 6.17.7 (god_of_onions, Jun 2026).

**Fix (big_trov, Jun 2026):** The `[frequency-range]` lines must NOT contain the `MHz` suffix:
```toml
# WRONG — "MHz" suffix breaks parser
[frequency-range]
max = 1850MHz

# CORRECT
[frequency-range]
max = 1850
```
Also try restoring the default config file: reinstall the governor package or copy from `/etc/cyan-skillfish-governor-smu/`.

### GPU Stuck at Wrong Frequency

**Symptom:** Governor running but GPU never reaches the top safe-point frequency. Config says 2000 MHz but GPU stays at 1850 MHz even under full load. Temps are fine (boilerkim, Jun 2026).

**Fixes (lonewolf05849, hashtagoctothorp, boilerkim, Jun 2026):**
1. Check `[frequency-range] max` in config.toml — may be set lower than expected
2. **Restart governor** after config change: `sudo systemctl restart cyan-skillfish-governor-smu`
3. If still stuck: voltage at target frequency may be too low on default. Increase by 30-40mV. Example: `[2000, 1000]` instead of `[2000, 980]`
4. Verify with: `sudo systemctl status cyan-skillfish-governor-smu`

---

## "Press ESC to Skip Startup.nsh"

**Cause:** Normal UEFI shell prompt during BIOS flash.

**Fix:** Type `Flash.nsh` and press Enter. Note: some keyboard layouts may cause typos (e.g., French keyboards may type `Flqsh.nsh`). -- (community report — najibc, help-thread; also documented in [02-BIOS](02-bios-and-firmware.md))

---

## "amdgpu: Unsupported clock type"

**Status:** Harmless message. -- (community report — harmless)

**Impact:** Almost none. Ignore unless accompanied by GPU timeouts or crashes.

**Fix if issues occur:** Install the [cyan-skillfish-governor](https://github.com/filippor/cyan-skillfish-governor).

---

## "dal_irq_service_dummy_ack"

**Status:** Benign. Does NOT indicate hardware damage. -- (community report — benign)

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
   -- (Note: the previous value `ttm.pages_limit=2490368` for ~10 GB was not in source docs; corrected to match source.)
2. **Lower texture detail** in games
3. **Disable ZRAM or use fixed VRAM allocation** (source: stability.md)
4. **For OpenGL:** `MESA_LOADER_DRIVER_OVERRIDE=zink` (source: Discord bc250-chat)

---

## GPU Hang After 1-2h of Gaming (VRAM Overheating)

**Symptoms:** After 1-2 hours of AAA gaming (Resident Evil, Arc Raiders, etc.), the GPU hangs or freezes. System may recover or require reboot.

**Cause:** VRAM chips on the backplate overheat during extended gaming. They have no temperature sensor, so the overheating goes undetected until the GPU hangs (gdong0921_04971, baramin, help-thread).

**Fix:** Add heatsinks to the GDDR6 modules behind the backplate. gdong0921_04971 confirmed: "put a heatsink and that fix it" -- GPU hang stopped after adding VRAM heatsinks.

---

## GPU Freeze with KIQ Fence Timeout and KFD Failure

**Symptoms:** Black screen, system completely unresponsive (can't even ping). Screen goes black under GPU-intensive load. Errors in kernel log:
```
timeout waiting for kiq fence
ring gfx_0.0.0 timeout
ring gfx_0.0.0 reset failed
GPU reset begin
Failed to quiesce KFD
```

**Cause:** GPU voltage too low for the configured frequency — the GPU core can't complete operations at the selected voltage/frequency point, causing a hard lockup. Common when running 40 CU on default governor safe-points (nunofgs., May 2026).

**Fixes:**
1. **Increase voltage** on affected safe-points in governor config (hojnikb). If using 40 CU, start at a lower frequency (e.g., 1850 MHz) and increase voltage by 10-15 mV per step.
2. **Reduce max frequency** in governor config until stable.
3. If you're on Bazzite with stock governor settings, try adding the governor if not installed, then tune voltages.
4. Use `journalctl -k -b -1 | grep -i "gpu\|amdgpu\|timeout\|kfd"` to check last boot errors.

---

## High RAM Usage / OOM Crashes (Alternative to zram)

If zram is not enough for RAM-hungry games, use **zswap + swapfile** -- it dumps cold memory pages to disk, freeing RAM for games (source: performance.md).

**On Bazzite:**
```bash
# Disable zram
echo "" | sudo tee /etc/systemd/zram-generator.conf

# Create swapfile (32 GB)
sudo btrfs subvolume create /var/swap  # (community-contributed steps — not in source performance.md)
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

**Cause:** Broken RDSEED instruction on BC-250 hardware (fixed in kernel 6.16+). -- (community report; fixed in kernel 6.16+)

**Fixes:**
- Update to **kernel 6.16+** (recommended: 6.19.x for VRR/DP audio)
- Update to **Qt 6.8+**
- Workaround: Use GNOME instead of KDE

---

## Consistent Micro-Stuttering (Every Few Seconds)

**Cause:** Bazzite's Handheld Daemon (HHD) fails to load required functionality and restarts constantly (elektricM bazzite.md, PlugWorld).

**Fix:**
```bash
sudo systemctl disable --now hhd
sudo systemctl mask hhd   # Prevents re-enabling on updates
```

---

## Gamescope Artifacts / Visual Glitches

**Symptoms:** Artifacts on GameScope windows and games; not visible in desktop mode. -- (i.am.brantastic, 13/05/2026; also safwyl, same thread)

**Fixes:**
1. Enable **Force Composition** in Steam GameScope settings (disables direct scan-out)
2. Bump lowest governor safe point -- e.g. `350 MHz @ 720 mV`
3. Change monitor refresh rate

---

## Artifact Hunting — Finding a Bad CU (Binary Search)

**Symptoms:** Artifacts appear 5+ minutes into gameplay. VRAM gets hot. Memtest86 passes fine. The issue may be a single defective Compute Unit (CU) rather than a systemic problem.

**Technique (pops1cl, vinnijs.dev, June 2026):**
Use `bc250-cu-live-manager` to disable CUs in groups using binary search:

1. Disable half the CUs — test for artifacts in a game
2. If artifacts persist, the bad CU is in the remaining active half
3. If artifacts disappear, the bad CU is in the disabled half
4. Repeat (halving each time) until the single bad CU is isolated
5. Keep that CU permanently disabled in the live-manager config

**Important:** Some artifacts don't disappear until you restart the game/application. A game (not synthetic benchmark) is the best stress test for artifact hunting.

The newest version of `bc250-cu-live-manager` (June 2026) supports disabling stock WGPs directly. See [06 — GPU Governor](06-gpu-governor.md) for installation.

---

## Blue Artifacts in Many Games (Poor GPU Bin)

**Symptoms:** Diagonal blue artifacts in multiple games (Sekiro, Cyberpunk, Satisfactory) at default governor settings. No crashes or overheating.

**Cause:** Poorly binned GPU chip that cannot sustain high clocks without artifacts. sajonsmk tested extensively: at 1000MHz/700mV no artifacts, at 1500MHz/1065mV FurMark ran 1.5h without artifacts at 74C, but higher clocks consistently produced blue diagonal artifacts (sajonsmk, help-thread) (community report — single user).

**Fix:** This is a hardware limitation -- the chip cannot reliably run above ~1500MHz. Lock the governor to a lower max frequency or accept the artifacts.

---

## High Temperatures (85C+)

**Causes and fixes:**

| Issue | Solution |
|-------|----------|
| Stock thermal paste dried out | Replace with PTM7950 pad or quality paste (source: performance.md, stability.md) |
| Heatsink fins closed | Open center fins (scooper tool or bending) (source: sensors.md "cut fins") |
| Fan too slow / not spinning | Check PWM settings, use higher speed curve (source: sensors.md) |
| Poor case airflow | Open case panels, add exhaust fan |
| VRAM overheating | Add thermal pads + rear fan — see [04 — Cooling Guide](04-cooling-guide.md#vram-cooling---dont-forget-the-back) |
| Overclocking too aggressive | Lower frequency or increase voltage (source: stability.md) |
| Heat pipe failure | Replace entire heatsink (bytepond, May 2026) |
| Heatsink contact pressure | Add 1mm thermal pad spacer (gennro, May 2026) |

---

## Governor Not Starting

```bash
# Check status
systemctl status cyan-skillfish-governor-smu

# Reinstall (source: governor.md)
sudo dnf reinstall cyan-skillfish-governor-smu     # Fedora
paru -S cyan-skillfish-governor-smu                  # Arch/CachyOS

# Check config exists (source: governor.md)
ls -l /etc/cyan-skillfish-governor-smu/config.toml

# Check logs (source: governor.md)
sudo journalctl -u cyan-skillfish-governor-smu --no-pager -n 20
```

---

## smu_oc Can't Install or Uninstall ("service not found" / "no module named bc250_detect")

**Symptoms:** redbeard's script says "already installed", applying a config gives "CPU service failed to start, and bc250-smu-oc.service not found"; BC250 Control Center reports `No module named bc250_detect` even though the file exists in `.local/bin`. Uninstall reports success but changes nothing (jmexp, 16/08/2026, CachyOS with 8-core unlock).

**Fix:** wipe the pipx environment and reinstall from the script — completely deleting `~/.local/share/pipx` allowed reinstalling smu_oc again (aethelbarry, 17/08/2026). ⚠️ This removes other pipx-installed tools too; reinstall anything else you had.

---

## Cyberpunk 2077 Instant Crash — gfxhub Page Fault (TCP client) on Mesa 26.x

**Symptoms:** game flatlines seconds after launch (before fully loading): screen freezes, audio trails off, process dies. dmesg shows repeating `[gfxhub]` page fault from `vkd3d_queue`, always **TCP client (0x8), write fault (RW=1), 0x8003xxxxxxxx range**, ending in `gfx_0.0.0 ring timeout/reset` (alessio_m, 17/08/2026).

**Context:** Nobara, Mesa 26.1.1–26.2.0 (25.3.6 no longer packaged), kernel 7.1.8, no unlocks applied, default governor config. Ruled out one-by-one: IOMMU disable, zswap→zram switch, GE-Proton11-5, static 6GB/6GB VRAM split, GTT/TTM params, `radv_enable_unified_heap_on_apu` (game wouldn't launch at all with it). Other DX12/vkd3d titles stable.

**Suspected cause / first thing to try:** stock governor config may be too **undervolted** for your particular card — hashtagoctothorp hit the same on his board ("the default gpu governor config is too undervolted for your card. (It was for mine)", 17/08/2026). Test with less aggressive UV or stock voltages before deeper debugging. Resolution still open as of Aug 2026.

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

## GPU Stuck at 1850 MHz (Not Reaching Max Frequency)

**Symptoms:** Governor config specifies 2000 MHz max, but the GPU stays at 1850 MHz under load. Temps are fine.

**Cause:** The `frequency-range` max value in config.toml is set to 1850 MHz instead of 2000 MHz (boilerkim, help-thread, June 2026).

**Fix:**
1. Check `/etc/cyan-skillfish-governor-smu/config.toml` and ensure the max safe-point frequency matches your target (e.g., 2000 MHz)
2. After changing config, restart the governor:
   ```bash
   sudo systemctl restart cyan-skillfish-governor-smu
   ```

**Note:** If stability issues occur at 2000 MHz (e.g., Death Stranding 2 artifacts at 2000 MHz but fine at 1850 MHz), the chip may need higher voltage or lower frequency — silicon lottery applies (boilerkim, help-thread, June 2026).

---

## Mangohud Shows 655% GPU Usage

**Cause:** The SMU outputs a raw `FFFF` error code at offset `0x1C` inside the `gpu_metrics` binary kernel table — MangoHud interprets this as 655% GPU usage.

**Fix:** A script by hassanthejust (Discord project-forums) runs a lightweight Python daemon that intercepts the live binary data stream and overwrites only those two bytes with the correctly calculated GPU utilization. It reads raw DRM hardware job execution times (fdinfo) — same method nvtop uses.

Download `Gpu_usage_fix.zip` from the BC-250 Discord project-forums channel, then:
```bash
chmod +x ./install_gpu_usage_fix.sh
sudo ./install_gpu_usage_fix.sh
```

Does not break VRAM or temperature readings. No MangoHud config changes needed.

---

## Low Volume on DP Audio

**Symptoms:** DP audio volume is very low, requires massive amplifier gain. Affects both Bazzite and Arch (dizzey0709).

**Fixes:**
1. Try a passive DP-to-HDMI adapter instead (pops1cl).
2. Test with CachyOS USB boot (known-good kernel for DP audio).
3. Use a USB audio adapter as fallback. See [08-Display & Audio](08-display-and-audio.md).

---

## WiFi Driver DKMS Failure After 40 CU Kernel

**Symptoms:** After applying a custom 40 CU kernel, WiFi stops working. DKMS cannot build the wifi module because kernel headers don't match.

**Cause:** Custom kernel lacks matching headers. DKMS requires headers matching `uname -r` exactly (devilplayer25, stingerguy). Most common on Bazzite.

**Fix:** Ensure the custom kernel package includes matching headers, or use a distro with pre-built kernel packages that include headers (CachyOS/Arch).

---

## Fan RPM Missing / MangoHud 0% After 40 CU Kernel

**Symptoms:** After installing a custom 40 CU kernel, fan RPM is not reported and MangoHud shows 0% GPU usage.

**Cause:** `nct6687` module missing from the custom kernel build (fallenmask). erewego uploaded a fix for Bazzite.

**Fix:** Reinstall the governor (`cyan-skillfish-governor-smu`) after kernel changes. Verify `nct6687` module is loaded: `lsmod | grep nct6687`.

---

## Sleep/Wake Bug (Monitor Fails to Wake)

**Symptoms:** After system resume from sleep, monitor fails to wake or audio shifts from DP to USB DAC.

**Status (May 2026):** Sleep does not work on BC-250 (pops1cl). Hibernate was working on Bazzite in December 2025 but is broken on CachyOS as of May 2026 — kernel bug suspected (essdee4336, pops1cl). Even swap file/partition approaches fail; system doesn't shut down properly for hibernate.

**Root cause (Jul 2026):** The SMU (System Management Unit) on the BC-250 is a PS5-customized variant, not the standard AMD SMU. Sleep/suspend is handled entirely by the SMU, and Sony customized the sleep commands for PS5 — the BC-250 doesn't have the hardware or firmware to respond to standard AMD sleep commands (ded811, Jul 2026). See [02-BIOS & Firmware](02-bios-and-firmware.md) for SMU reverse engineering progress.

**Workaround:**
- Use shutdown/reboot instead of suspend/hibernate
- ded811 is working on a sleep-like mode using black screen savor + clock minimization
- Re-enable kscreenlocker/lockscreen after resume (CachyOS)
- Use USB DAC for audio as fallback (see [08-Display & Audio])

---

## BIOS Settings Don't Stick

**Fix (source: display.md, boot.md):** Clear CMOS properly:
1. Power off, unplug PSU
2. Remove CR2032 battery for 60 seconds
3. Press power button 5 times
4. Reinsert battery, enter BIOS
5. Save again with F10

---

## 40 CU Hard Lock / OCP at High Clocks

**Symptoms:** System locks up with monitor in standby mode. Reset button and power button do nothing. Must unplug power cable to recover. Typically occurs at 2200-2400 MHz with 40 CU unlocked.

**Cause:** Two separate limits being hit (big_trov, May 2026):
1. **Voltage ceiling** — Too much voltage (>1000 mV) at high clocks triggers a hard lock
2. **Power limit (OCP)** — A secondary system-level power limit at ~1850-2200 MHz (varies per board) causes hard lock regardless of voltage

**Fixes:**
- Stay at or below 2200 MHz for 40 CU
- Keep voltage under 1000 mV at high clocks
- If hard lock occurs at moderate settings, reduce max frequency or voltage further
- Higher CPU overclock lowers GPU hard lock threshold — undervolt CPU when pushing GPU (big_trov, hojnikb)
- No workaround for the secondary power limit yet; shunt mod may be required (big_trov)

---

## Flash Failed -- Board Won't POST

**Recovery (source: boot.md):**
1. **Hardware programmer required:** CH341A or Raspberry Pi Pico with SOP8 clip
   -- (Note: our file said CH347T. Corrected to match source boot.md line 845. CH347T may also work.)
2. Flash chip: `BIOS_A1` (Winbond W25Q128JVSQ 16MB per flashing.md, or W25Q64 8MB per boot.md -- check your board revision)
3. Command:
   ```bash
   sudo flashrom -p ch341a_spi -w BC250_3.00_CHIPSETMENU.ROM
   ```
   -- (Note: programmer name corrected from `ch347_spi` to `ch341a_spi` to match source hardware)

---

## 640x480 Resolution in Games

**Symptoms:** Games render at 640x480 regardless of in-game settings. Affects multiple titles.

**Cause:** Faulty EDID detection from DP-to-HDMI adapters or display handshake issues.

**Fixes:**
1. Use a native DisplayPort cable instead of adapters
2. Try a different DP-to-HDMI adapter
3. Check monitor EDID emulation settings if available

## VRS Crashes in Doom: The Dark Ages

**Symptoms:** Game crashes immediately with VRS-related errors. Some users also required +10 mV over previously-stable settings at 40 CU (hojnikb, May 2026).

**Cause:** Variable Rate Shading (VRS) commands are not supported on Cyan Skillfish GPU, causing the Vulkan driver to crash. Specific shaders/instructions in some games can trigger bad CUs that pass synthetic benchmarks — e.g., Dinkum crashes above 1700 MHz at 40 CU (mikecmp, May 2026).

**Fix:** Use the Vulkan_NullVRS layer by bangstk (see [08-Display & Audio](08-display-and-audio.md) for install).

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

- Never use 6-pin to 8-pin PCIe adapters for power delivery -- they will melt (source: Discord bc250-chat) [confirmed: @essdee4336]
- Never flash the `SIO1_R` chip (Macronix MX25L4006E) -- you will brick the SuperIO (source: elektricM flashing.md)
- Never set GPU voltage below 700 mV -- GPU will lock to 1500 MHz (source: governor.md, stability.md)
- Never use Smokeless_UMAF -- can cause permanent damage (source: quick-reference.md)
- Always clear CMOS after BIOS flash (source: boot.md, display.md, quick-reference.md)
- Always disable IOMMU in BIOS (source: boot.md, display.md, stability.md, quick-reference.md)
- Always use passive DP-to-HDMI for audio (source: display.md)
- Follow the canonical [Kernel Support Matrix (05)](05-os-installation.md#kernel-support-matrix-canonical--as-of-2026-09-03): CachyOS 7.1.x current, 6.19.x recommended stable, 6.18 LTS fallback — avoid 6.15.0–6.15.6 and 6.17.8–6.17.10 (source: boot.md, display.md, performance.md, quick-reference.md)
**Last verified: 2026-09-03**
