# 05 - OS Installation

> Step-by-step guides for installing Linux on the BC-250.
> **BIOS must be flashed first** - see [02-BIOS](02-bios-and-firmware.md).
> 40 CU unlock no longer requires a kernel patch — use `bc250-cu-live-manager` on stock kernel. **Mesa 26** is current with significant RT and performance improvements.

## Kernel Support Matrix (canonical — as of 2026-09-03)

This table is the **single source of truth** for kernel recommendations. Other files link here instead of restating it.

| Kernel line | Status | Notes |
|-------------|--------|-------|
| **CachyOS standard (7.1.x)** | ✅ Current default | e.g. 7.1.8-1. DP audio spread-spectrum disable landed in the 7.1 stable line (big_trov, 20/08/2026). |
| **7.2 (CachyOS)** | Upcoming | Expected to carry the latest DP audio patch, which also fixes some display issues (essdee4338, 16/08/2026). |
| **7.3 rc1** | Upcoming | Expected ~30 Aug 2026; _mastag preparing a CachyOS-flavored 7.3 rc with async compute shaders + extended GPU frequency patches (~1–2 weeks after rc1) (_mastag, 25–26/08/2026). |
| **6.19.x** | ✅ Recommended stable | VRR + DP audio fixes (TheFloW patch, 6.19.10+). |
| **6.18 LTS** (6.18.42-1-cachyos-lts) | ✅ Stable fallback | |
| **6.15.0–6.15.6 and 6.17.8–6.17.10** | ❌ Broken — avoid | GPU initialization failures / kernel panics. |

After kernel updates, if you get a blank screen, boot the previous kernel from the boot menu and remove the broken one (rocksalt_, 16/08/2026).

---

## Distribution Comparison

| Distro | Best For | Difficulty | Notes |
|--------|----------|------------|-------|
| **SteamOS** | Console experience, seamless gaming | Easy | Valve's official OS. Immutable Arch-based. Boots into Gamescope. Requires toolkit for full BC-250 support. Gaining popularity. |
| **CachyOS** | Maximum performance, stability | Intermediate | Arch-based, optimized packages, latest kernel + Mesa 26. Most stable for 40 CU and governor. Community default (Jul 2026). |
| **Bazzite** | Console-like experience | Easy | Steam Deck UI out of box. **⚠ Stable kernel is 6.17.7 — too old for BC-250 (needs 6.19+).** Use testing branch or expect instability with 40 CU (see below). |
| **Fedora 43+** | Most tested, general use | Easy | Mesa 25.1+ in official repos, most tested distro |
| **Arch Linux** | Full control, latest packages | Advanced | Manual setup but cutting-edge |
| **Nobara** | Gaming, Bazzite alternative | Intermediate | Fedora-based, not immutable, easier governor install (mothenjoyer69) |
| **Debian / PikaOS** | Stability, low power | Intermediate | Requires newer Mesa repos |
| **Ubuntu 26.04+** | Familiar Ubuntu experience | Easy | Needs Mesa PPA |
| **Manjaro** | User-friendly Arch | Easy | GNOME recommended over KDE for stability |

### Bazzite vs CachyOS — Direct Comparison

CachyOS has become the community default as of July 2026 due to Bazzite's stable branch lagging on an outdated kernel.

| Factor | Bazzite | CachyOS |
|--------|---------|---------|
| **Performance** | Behind — stable branch on kernel 6.17.7, old Mesa (fforduck, Jul 2026) | Best — kernel 6.19+, Mesa 26, optimized packages, BORE scheduler (dznuts, gennro) |
| **Stability** | ⚠ Unstable with 40 CU — green screen on idle/download, random freezes. "A bunch of people here moved from Bazzite to CachyOS because Bazzite Handheld is pretty far out of date" (pops1cl, 10/06/2026). | Rock solid — "5 days no crashes" after switching (evo9899, 04/07/2026). Several users report identical experience. |
| **Ease of setup** | Easiest — pre-patched kernel, Game Mode included. But outdated kernel causes governor install issues. | Moderate — Arch-based, manual setup. More flexible, fewer surprises. |
| **Kernel** | ⚠ Stable: **6.17.7** (OLD!). Testing: kernel 7.0+ Mesa 26 — not yet released. **⚠ Kernel 7.1+ causes black screen with governor — dmoraza (Aug 3 2026).** Stay on 6.19.x or 6.18 LTS for governor use. Bazzite deck 44 update reported working fine by early adopters (ntimd8r, dbkretro, 22/08/2026). | Standard kernel now **7.1.x-based**; 7.2 imminent with DP audio + display fixes (essdee4338, 16/08/2026). Some users saw blank screens on 7.x and 6.18 after updates — roll back via boot menu if hit (@bencraft3204, @rocksalt_, 16/08/2026). |
| **40 CU unlock** | CU live manager works. Legacy kernel patch available (ba29 Deck kernel only). OGC desktop kernel packages not yet available. | CU live manager works on stock kernel. Full toolkit support (redbeard1083, gennro). |
| **Governor install** | `dnf copr` + `rpm-ostree install`. Can be tricky on old kernel. Rebase to `bazzite:testing` or `bazzite:stable` helps (zerosumpr). | `yay -S` or AUR helper. Straightforward. |
| **Updates** | Immutable — safer rollbacks, but updates are slow. BC-250 needs bleeding-edge kernel which conflicts with Bazzite's philosophy. | Rolling — bleeding edge. May break occasionally but quick fixes. |
| **Game Mode** | Built-in Gamescope session. Some users report instability (Split Fiction crashes, black screen loops). | Handheld Edition includes Gamescope + FSR (stevounit). Desktop needs manual setup. |
| **VRR / Audio** | Audio issues persist for some users (Jul 2026). VRR works with custom image. | Native 6.19+ kernel support for VRR + DP audio. Working out of box. |
| **Best for** | Console experience with fully working Game Mode — IF on testing branch. Good for users willing to rebase. | Raw performance, stability, tuners, desktop use, AI/LLM. Community default. |

**Community consensus (July 2026):** CachyOS is the de-facto recommendation — "definitly CashyOs is better in terms of stability and features" (rpf16rj, 04/07/2026); "5 days. No crashes... Cachyos has been great" after switching from Bazzite (evo9899, 04/07/2026); "a bunch of people here moved from Bazzite to CachyOS" (pops1cl, 10/06/2026). Bazzite stable (kernel 6.17.7) is **not recommended** for 40 CU builds — rebase to the testing branch first if you want Bazzite. For non-technical users who want a console experience: Bazzite desktop testing branch or CachyOS Handheld Edition. The performance gap is real: Bazzite stable's old kernel causes tangible issues with 40 CU, governor, and audio.

---

## SteamOS (Console Experience — Official Valve OS)

> Valve's immutable Arch-based gaming OS. Boots directly into Gamescope (Steam Gaming Mode). Two community toolkits provide BC-250 support. Gaining traction over Bazzite — "SteamOS is my long game plan" (dbkretro, 02/09/2026).

### SteamOS Versions on BC-250

| Version | Kernel | Mesa | Status | Notes |
|---------|--------|------|--------|-------|
| **3.8.x** | 6.18 (valve) | 26.1.x | Stable | Base version. Audio fix + EDID patch required. |
| **3.9 Preview** | 7.2 (valve) | 26.1.99 | Preview channel | Major update — kernel 7.2 fixes display/audio sync. EDID patch no longer needed. |
| **3.10 Main** | 7.2 (valve) | 26.1.99 | Main channel | Same kernel as 3.9 preview. Toolkit v1.8.0+ required. |

**How to update to 3.9/3.10:** Enable Developer Mode > Advanced Update Channels > switch to Main or Preview channel. After update, run "Install All" in the toolkit ([rpf16rj, 29/08/2026, help-thread]).

### Installation

1. Download SteamOS recovery image from [Valve's official site](https://store.steampowered.com/steamos/download) or use the recovery USB creator
2. Flash to USB with **balenaEtcher** or **Rufus** (UEFI/FAT32)
3. Boot from USB — standard installer
4. **Known gotcha:** Some users report issues with partitioning during SteamOS setup — may need to modify a line in the installation script (essdee4338, 25/08/2026; hit in practice by _wesk, 17/07/2026). SATA M.2 drives can confuse the installer — "I think having a SATA m.2 confuses it" (andrewloomis, 24/08/2026).
5. Complete installation, reboot

### Post-Install: BC-250 Toolkits

SteamOS on the BC-250 requires a toolkit for governor, CU unlock, audio fix, and WiFi drivers. Two toolkits exist:

#### rpf16rj/bc250-steamos-real-toolkit (Recommended)

Primary toolkit — TUI menu interface, most actively maintained. ([rpf16rj, GitHub](https://github.com/rpf16rj/bc250-steamos-real-toolkit))

```bash
git clone https://github.com/rpf16rj/bc250-steamos-real-toolkit.git
cd bc250-steamos-real-toolkit
chmod +x install.sh
./install.sh
```

**Features (v1.8.2, Aug 2026):**
- CPU governor + GPU governor (SMU) with undervolt/overclock
- 8-core CPU unlock (EFI + SMU mailbox)
- 40 CU GPU unlock (UMR-based, runtime)
- Audio fix (DP audio clock patch — wrong DP refclk for DCN 2.0.1)
- AIC8800 USB WiFi/BT driver
- EDID patch for 4K@120Hz (not needed on kernel 7.2+)
- DP-HDMI YCbCr 4:4:4 deep color + HDMI 2.1 FRL (v1.8.1+)
- HDMI-CEC support
- SteamOS boot logo (Steam Graphic Wordmark)
- Telemetry fix for 8-core metrics reporting
- All features install to update-proof paths (`/etc`, `/var`, `$HOME`) and self-heal across SteamOS updates

**Important:** On kernel 7.2 (SteamOS 3.9/3.10), some audio/display patches are already upstream. The toolkit auto-detects kernel version and skips redundant patches ([keroppl_wizard, 29/08/2026, Yet Another SteamOS Toolkit]).

#### keyboardspecialist/bc250-steamos

Developer-focused toolkit with more granular control. ([keroppl_wizard, GitHub](https://github.com/keyboardspecialist/bc250-steamos))

**Features (v0.20.14, Aug 2026):**
- Same core features as rpf16rj toolkit (governor, CU unlock, audio fix, WiFi)
- Decky plugin for Steam Game Mode integration
- TUI tray control + desktop control
- "Trainer" app (retro-style OC interface with music)
- CEC with independent receiver commands + device mapping
- GPU load target and ramp-up controls
- More modular — individual scripts per feature

**Known issue:** "keyboardspecialist's ui and usability is a bit of a mess though, I'm new to Linux and I struggled with it for a while" ([help-thread user, Jul 2026]).

### 40 CU Unlock on SteamOS

```bash
# Via rpf16rj toolkit: Install All > option includes 40 CU
# Or manual: run the CU unlock step separately, test boot before adding more features
```

**Warning:** Some boards with defective CUs will black-screen after 40 CU unlock. If this happens, mash ESC during boot to enter SteamOS safe mode (reverts to previous version), then try unlocking CUs one by one to find the defective one ([ininew, 23/08/2026, help-thread]). Test CU unlock alone first without 8-core unlock or telemetry ([rpf16rj, 23/08/2026, help-thread]).

### Performance: SteamOS vs CachyOS

Community reports are mixed but lean toward comparable performance:
- "SteamOS runs fairly well on this board since 3.8 and 3.9 will be even better" (yrouel86, 24/08/2026)
- "some benchmarks on Rx 6600. pretty identical while steamos has better lows sometimes" (dejan_994, 27/08/2026)
- "why does Elden ring seem to run so much better on steamos compared to cachy?" (dejan_994, 30/07/2026; reddit report of 60 fps 1080p relayed by matearz, 19/07/2026) — could not replicate, game-specific?
- "there really isn't anything special steamos is doing for our board, that would have any meaningful edges over cachyos" (hojnikb, 29/08/2026) — both Arch-based, SteamOS is more closed and immutable
- SteamOS + toolkit: "Ran the SteamOS Real Toolkit and unlocked to 8c 40cu at 3.85 and 2000 respectively. Runs cyberpunk at around 102 average fps high preset" (concerned_c1t1zen, 31/08/2026)

### Known Issues

- **GPU governor not starting on boot:** systemd kills the service on some installs. Restart manually with `sudo systemctl start cyan-skillfish-governor-smu` — it persists until next reboot ([land_and_air, 24/08/2026, help-thread]).
- **DP→HDMI signal loss on mode switch:** Active DP adapters (e.g. UGREEN) may lose signal when switching between Game Mode and Desktop Mode. Workaround: force-DisplayPort systemd service ([yrouel86, 25/08/2026, Yet Another SteamOS Toolkit]). On kernel 7.2 this is partially fixed.
- **4K@120Hz instability:** Shimmering and intermittent no-signal with some DP→HDMI adapters. EDID patch helps on kernel 6.18; on 7.2 the adapter firmware update (CH7218) is recommended — requires Windows to flash ([dejan_994, rpf16rj, 26-27/08/2026, help-thread]).
- **Bad overclock at boot:** Easy to get stuck with a bad OC/undervolt. Recovery requires mounting A/B partitions and disabling the service manually — "the filesystem structure you see on a booted system is pretty much an illusion" on SteamOS ([keroppl_wizard, yrouel86, 31/08/2026, Yet Another SteamOS Toolkit]).
- **Temperature reporting:** GPU temp may not report after upgrade to 3.9 — install telemetry patch from toolkit with correct 8-core flag ([j0shm1lls, rpf16rj, 30/08/2026, help-thread]).

### SteamOS Tips

- **Update channel:** Stable (3.8) is safest. Preview (3.9) and Main (3.10) have kernel 7.2 with most display fixes upstreamed.
- **Decky plugins:** Work on SteamOS — Decky Loader install guide at [GamingOnLinux](https://www.gamingonlinux.com/guides/view/how-to-set-up-decky-loader-on-steam-deck-steamos-for-easy-plugins/). rpf16rj toolkit includes a Decky plugin for GPU/CPU control.
- **Dolby Digital 5.1:** Works via HDMI/eARC with rpf16rj toolkit v1.3.0+ option 13 — udev + WirePlumber AC-3 activation ([rpf16rj, 17/08/2026, bc250-resources]).
- **Switching to Desktop:** `sudo steamos-session-select plasma-wayland-persistent` (back to Game Mode: `sudo steamos-session-select gamescope-persistent`) (yrouel86, 25/07/2026; renamed from `plasma-persistent` — daddy8437, 17/12/2025).
- **BC250 Control Center GUI:** ZEROAESQUERDA's PS5GPU-BC250 Qt app supports SteamOS — GPU frequency/voltage control from a desktop GUI, similar to MSI Afterburner ([ZEROAESQUERDA, bc250-resources]).

---

## Universal Prerequisites

### Hardware Needed
- [ ] BC-250 board (any BIOS P2.00-P3.00 or P5.00; avoid P4.00 — unstable)
- [ ] 300W+ 12V PSU with PCIe 8-pin
- [ ] High static pressure 120mm fan (Arctic P12 recommended)
- [ ] DisplayPort cable **or** passive DP-to-HDMI adapter
- [ ] USB drive (8GB+) for installation media
- [ ] M.2 NVMe SSD or SATA drive (optional but recommended)
- [ ] USB WiFi adapter (no built-in wireless)
- [ ] Another PC to prepare USB drives

### BIOS Settings (Verify After Flashing)
```
Integrated Graphics Controller = [Forced]
UMA Mode = [UMA_SPECIFIED]
UMA Frame Buffer Size = [512M]
IOMMU = [Disabled]
Boot Mode = [UEFI]
```

### Broken Kernel Versions (Avoid)

Kernel versions **6.15.0-6.15.6** and **6.17.8-6.17.10** cause GPU initialization failures and kernel panics. Do not install these. Use **6.19.x** (recommended — VRR and DP audio fixes) or **6.18.18 LTS** (stable fallback) instead.

---

## Bazzite (Console-Like Experience — Use Testing Branch)

> ⚠ **Bazzite stable ships kernel 6.17.7 which is too old for BC-250 (needs 6.19+).** This causes instability with 40 CU, governor install failures, audio issues, and random crashes. See comparison table above.

> Fedora Atomic-based, SteamOS-like distro. For a stable experience, **rebase to the testing branch** before installing the governor and 40 CU unlock.

### Installation

1. Download ISO from [bazzite.gg](https://bazzite.gg)
2. Choose variant:
   - **Deck** - Steam Deck UI experience (most popular for BC-250)
   - **KDE** - Desktop users
   - **GNOME** - Minimal desktop
3. Flash to USB with **balenaEtcher** or **Ventoy**
4. **Use the non-live installer image** (live image has login bugs) (mothenjoyer69)
5. Boot from USB - no special parameters needed
6. Complete on-screen installation (10-15 min)

### Critical: Switch to Testing Branch

After installation, immediately rebase to the testing branch for kernel 7.0 + Mesa 26:

```bash
# Rebase to testing branch (get kernel 7.0 + Mesa 26)
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck:testing

# Or stay on stable with a slightly newer build (still 6.19, better than 6.17.7)
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck:stable-43.20260210
```

**Why:** Bazzite's default stable branch is on kernel 6.17.7 which is known-bad for BC-250. The testing branch includes kernel 7.0 + Mesa 26 — necessary for 40 CU stability, audio fix, and VRR (fforduck, community Jul 2026). Multiple users report instability resolved immediately after switching.
7. Default password (if asked): `bazzite`
8. Reboot

### Post-Install Setup

```bash
# Update system
sudo rpm-ostree update
sudo systemctl reboot

# Install GPU governor (SMU - recommended, no kernel patch needed)
sudo dnf copr enable filippor/bazzite
rpm-ostree install cyan-skillfish-governor-smu
sudo systemctl reboot
sudo systemctl enable --now cyan-skillfish-governor-smu.service

# Verify
systemctl status cyan-skillfish-governor-smu
```

### Patched Performance Images (Optional)

Custom images with pre-configured kernel + governor exist but **may kill USB WiFi** after rebase (Issue #10):

```bash
# GNOME (recommended)
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vietsman/bazzite-gnome-patched:latest

# KDE
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vietsman/bazzite-kde-patched:latest

# Deck
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vietsman/bazzite-deck-patched:latest
```

**Warning:** Rebasing to patched images may remove USB WiFi/Bluetooth drivers. If WiFi stops working: use Ethernet, check available kernel modules (`lsmod | grep <driver>`), install missing drivers, or rollback with `rpm-ostree rollback`.

### Bazzite Tips
- Install EmuDeck for emulation: use the Bazzite portal
- Update with `ujust update` (or `rpm-ostree upgrade` + `flatpak update`)
- Rollback broken updates with `rpm-ostree rollback`
- **VRR:** Testing branch includes VRR support natively. Stable branch does not.
- **Audio:** DP audio fix in kernel 6.19.10+. Bazzite stable (6.17.7) does NOT include it. Testing branch does.
- **Instability workaround:** If experiencing green screens, freezes, or crashes on Bazzite, rebase to testing branch first. If issues persist, users report switching to CachyOS resolves them (evo9899, 04/07/2026).
- **40 CU Unlock on Bazzite:** The [bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) (UMR-based, no kernel patch) is the preferred method — works on stock Bazzite kernel (auto-detects dri path, vinnijs.dev). For legacy kernel patch: erewego posted pre-built RPMs against the ba29 Deck kernel. Download `bazzite-bc250cu-rpms-ba29.7z` from the Discord project-forums.
  ```bash
  sudo rpm-ostree override replace ./*.rpm
  sudo rpm-ostree kargs --append=amdgpu.bc250_cc_write_mode=3
  sudo systemctl reboot
  ```
  Reduce GPU governor clocks to ~1850 MHz. For governor/SMU issues on Bazzite, using the testing branch (kernel 7.0) resolves most problems. For desktop Bazzite (OGC kernel), kernel packages are not yet available — check Discord for updates. See [02-BIOS & Firmware](02-bios-and-firmware.md) for full procedure details.

---

## Fedora 43+ (Most Tested)

> Mesa 25.1+ included in official repos. Most community documentation targets Fedora.

**Note:** Fedora 42 is End of Life. If still running Fedora 42, upgrade to Fedora 43.

### Installation

1. Download [Fedora 43 Workstation](https://getfedora.org/) (or newer)
2. Flash to USB with **Fedora Media Writer**, **balenaEtcher**, or **Ventoy**
3. Boot installer - select **"Basic Graphics Mode"** from GRUB (auto-enables nomodeset)
4. Complete installation normally, reboot

### Post-Install Setup

```bash
# Update system
sudo dnf upgrade --refresh

# Install GPU governor (SMU variant - no kernel patch needed)
sudo dnf copr enable filippor/bazzite
sudo dnf install cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service

# Remove nomodeset (no longer needed after governor + drivers installed)
sudo nano /etc/default/grub
# Change: GRUB_CMDLINE_LINUX_DEFAULT="quiet nomodeset"
# To:     GRUB_CMDLINE_LINUX_DEFAULT="quiet"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo reboot

# Install gaming tools
sudo dnf install steam mangohud goverlay
```

### Verify Mesa (Fedora 43 ships Mesa 25.x)

```bash
dnf list mesa-\*
glxinfo | grep "OpenGL version"
# Should show Mesa 25.x+
```

---

## Nobara (Gaming-Focused Fedora Alternative)

> Source: Discord community discussion. Not in elektricM official docs.

Fedora-based, not immutable - easier governor installation.

**Installation:**
1. Download [Nobara](https://nobaraproject.org/) (GNOME or KDE)
2. Flash to USB, boot normally (add `nomodeset` if black screen)
3. Complete installation

**Post-install:**
```bash
sudo dnf update
sudo dnf install steam mangohud goverlay
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

---

## CachyOS (Community Recommended — Best Stability + Performance)

> Arch-based with optimized packages, BORE scheduler, and latest kernel (6.19+) + Mesa 26 out of the box. **Community default as of July 2026.**

**Note (Jul 2026):** CachyOS ships with kernel 6.19+ and Mesa 26 — everything needed for 40 CU, VRR, and DP audio works out of the box. No kernel patching or rebase needed.

**Upcoming:** CachyOS RC kernels 7.1 and 7.2 (`linux-cachyos-rc`) include significant amdgpu driver optimizations and bug fixes. Worth testing when available for improved stability (gennro, Jul 2026).

### Standard Method (Recommended)

1. Download [CachyOS ISO](https://cachyos.org/) (KDE or GNOME)
2. Flash to USB, boot and run installer normally
3. Select **GRUB bootloader**
4. Verify kernel is compatible:
   ```bash
    uname -r  # Should be 6.19.x (recommended) or 6.18.x LTS (avoid 6.15.0-6.15.6, 6.17.8-6.17.10)
   ```
5. Install governor:
   ```bash
   paru -S cyan-skillfish-governor-smu
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```

### 40 CU Unlock on CachyOS

The [bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) works on stock CachyOS kernel — no kernel patch needed. This is the preferred method (vinnijs.dev, May 2026).

For kernel patch method (legacy), apply the `bc250-40cu-amdgpu.patch` to the kernel PKGBUILD patch set. duggasco maintains a PR fork with the patch pre-applied.

```bash
# Live manager (recommended):
git clone https://github.com/WinnieLV/bc250-cu-live-manager.git
cd bc250-cu-live-manager
# Follow README for your distro

# Kernel patch (legacy):
git clone https://github.com/duggasco/bc250-40cu-unlock.git
cd bc250-40cu-unlock
sudo ./scripts/bc250-enable-40cu.sh build
sudo ./scripts/bc250-enable-40cu.sh enable   # reboots
```

Also available: redbeard1083/bc250-toolkit and gennro/bc250-toolkit for automated CachyOS setup.

### CachyOS Architecture Fix

CachyOS pacman uses `x86_64_v3` architecture by default, which can cause failed installs for `x86_64`-only packages. Fix (graytl):

```bash
sudo nano /etc/pacman.conf
# Change: Architecture = auto
# To:     Architecture = x86_64 x86_64_v3
```

### Legacy Method (if standard ISO won't boot)

1. Install Arch Linux with `linux-lts` kernel
2. Reboot into Arch
3. Migrate to CachyOS repos:
   ```bash
   wget https://mirror.cachyos.org/cachyos-repo.tar.xz
   tar xvf cachyos-repo.tar.xz
   cd cachyos-repo
   sudo ./cachyos-repo.sh
   # Select x86-64-v3 optimization
   ```
4. Install CachyOS kernel:
   ```bash
   sudo pacman -S linux-cachyos-lts linux-cachyos-lts-headers
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   sudo reboot
   ```

---

## Arch Linux (Maximum Control)

1. Install Arch normally with `linux-lts` kernel (6.19.x recommended, 6.18.18 LTS stable fallback; avoid 6.15.0-6.15.6 and 6.17.8-6.17.10)
2. Install governor from AUR:
   ```bash
   paru -S cyan-skillfish-governor-smu
   # or: yay -S cyan-skillfish-governor-smu
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```
3. Automated setup script (alternative):
   ```bash
   git clone https://github.com/eabarriosTGC/BC250--ARCH.git
   cd BC250--ARCH
    chmod +x ./install.sh
    ./install.sh
   ```
4. Alternative setup script:
    ```bash
    git clone https://github.com/pnbarbeito/bc250-arch
    cd bc250-arch
    ./oberon_install.sh
    ```

5. 40 CU unlock: apply `bc250-40cu-amdgpu.patch` to kernel PKGBUILD (duggasco). See [02-BIOS & Firmware](02-bios-and-firmware.md).

---

## Debian / PikaOS

> Requires Testing/Sid - Stable is too old for Mesa 25.1+.

### Installation

1. Download [Debian Testing ISO](https://www.debian.org/CD/netinst/)
2. Boot with `nomodeset` if needed
3. Add experimental repo:
   ```bash
   echo "deb http://deb.debian.org/debian experimental main" | sudo tee /etc/apt/sources.list.d/experimental.list
   sudo apt update
   sudo apt install -t experimental mesa-vulkan-drivers libgl1-mesa-dri mesa-utils
   ```
4. Install kernel (Xanmod LTS 6.18.18 or 6.19.x from backports):
   ```bash
   wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/xanmod-archive-keyring.gpg
   echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
   sudo apt update
   sudo apt install linux-xanmod-lts-x64v3
   sudo update-grub
   sudo reboot
   ```
   Alternative: `sudo apt install linux-image-6.12` (Debian 6.12 LTS). Confirmed working: 6.18.3+ tested Jan 2026.

5. Install governor (.deb from GitHub releases):
   ```bash
   wget https://github.com/Magnap/cyan-skillfish-governor/releases/latest/download/cyan-skillfish-governor-smu_amd64.deb
   sudo dpkg -i cyan-skillfish-governor-smu_amd64.deb
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```

**Info:** A pre-built Debian image exists with kernel 6.18.3, Mesa 26, and GPU patches pre-applied. Check community resources.

**PikaOS** (Debian-based gaming distro) includes Mesa 25.1+ out of the box and GPU frequency patch pre-applied - easiest Debian option.

---

## Ubuntu 26.04+

> Ubuntu 26.04 daily server ISO includes Mesa 25+ and kernel 6.17/6.18 with out-of-box BC-250 support.

1. Download Ubuntu 26.04 daily server ISO or newer
2. Flash to USB, boot with `nomodeset` if needed
3. Install normally
4. Add Mesa PPA if needed:
   ```bash
   sudo add-apt-repository ppa:kisak/kisak-mesa
   sudo apt update && sudo apt upgrade
   ```
5. Kernel: 6.19.x recommended, 6.18.x LTS stable fallback (verify with `uname -r`)
6. Install governor (see `.deb` package from GitHub)

---

## Manjaro

1. Download Manjaro (KDE or GNOME edition - GNOME more stable per source)
2. Install normally (boots out-of-box, no nomodeset needed)
3. Mesa in official repos is sufficient
4. Install governor from AUR

**Community note:** "Out of the box after the BIOS flash, Manjaro KDE just booted fine" (samuelwf4949, 28/06/2025)

---

## Memory Configuration (zswap vs zram)

The BC-250 has **16 GB system RAM**. Distros differ in how they handle memory pressure: **Bazzite enables zram by default (4 GB)**, using RAM to compress RAM. On a memory-constrained 16 GB board, the community found **zswap + swapfile** generally preferable — it dumps cold pages to disk and keeps available RAM for the game.

**Which to use:**

| Scenario | Recommendation |
|----------|---------------|
| Most games / under 16 GB usage | **zswap + swapfile** — leaves more RAM free; zswap "is almost always better than zram, assuming your storage device can handle it" (pops1cl, 23/06/2026) |
| VRAM-heavy / very RAM-hungry titles | Either; zram helps when you cross the 16 GB line. essdee4336: the board "performs better overall without Zram enabled. It just takes precious CPU cycles away" (23/06/2026) |
| Slow / heavily-worn storage | **zram** instead — zswap swapfile "might put some strain on your SSD" (nydendard, 12/12/2025) |

**Compression algorithm:** nydendard benchmarked on the BC-250 — **lz4** is the clear winner (fastest decompression at 3692 MB/s vs 3210 MB/s for lz4hc), which matters most for responsiveness (13/12/2025).

**On Bazzite (disable zram → zswap + 32 GB swapfile):**
```bash
# Disable zram
echo "" | sudo tee /etc/systemd/zram-generator.conf

# Create swapfile (32 GB) on btrfs
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

# Enable zswap with lz4
rpm-ostree initramfs --enable \
  --arg=--add-drivers \
  --arg=lz4 \
  --arg=--add-drivers \
  --arg=lz4_compress

rpm-ostree kargs --append-if-missing="zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4"
sudo reboot
```

**Verify:**
```bash
grep -r . /sys/module/zswap/parameters/
```
Should show `enabled:Y`, `compressor:lz4`, `max_pool_percent:25`.

Original guide: nydendard (12/12/2025, bc250-resources "zswap instead of zram"); adopted into the NexGen3D SteamMachine script (nexgen3d, 13/12/2025). Set swappiness to 180 when using zswap.

## Verification - After Any Installation

```bash
# Mesa version (must be 25.1+, 26.x recommended)
glxinfo | grep "OpenGL version"
# Should show: Mesa 26.X.X

# Vulkan driver (must show RADV)
vulkaninfo | grep deviceName
# Should show: AMD Radeon Graphics (RADV GFX1013)

# Governor running
systemctl status cyan-skillfish-governor-smu
# Should show: active (running)

# GPU frequency check (should show multiple frequencies)
cat /sys/class/drm/card1/device/pp_dpm_sclk

# GPU renderer (NOT llvmpipe)
glxinfo | grep "OpenGL renderer"
# Should show: radv gfx1013
```

### Kernel Verification

```bash
uname -r
# Expected: 6.19.x (recommended) or 6.18.18 LTS (stable fallback)
# Avoid: 6.15.0-6.15.6, 6.17.8-6.17.10
```

---

## Bootable USB Creation Tools

| Tool | Platform | Notes |
|------|----------|-------|
| **Ventoy** | All | Best option - boot multiple ISOs from one drive |
| **balenaEtcher** | All | Simple GUI flasher |
| **Fedora Media Writer** | All | Fedora's recommended tool |
| **Rufus** | Windows | Use UEFI / FAT32 mode |
| **dd** | Linux CLI | `sudo dd if=image.iso of=/dev/sdX status=progress && sync` |
**Last verified: 2026-09-03**
