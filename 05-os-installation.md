# 05 - OS Installation

> Step-by-step guides for installing Linux on the BC-250.
> **BIOS must be flashed first** - see [02-BIOS](02-bios-and-firmware.md).
> **Kernel**: Community has moved to **6.19.x** which has VRR and DP audio fixes (gennro). **6.18.18 LTS** is the stable fallback. 40 CU unlock no longer requires a kernel patch — use `bc250-cu-live-manager` on stock kernel. **Mesa 26** is now current with significant RT and performance improvements.

---

## Distribution Comparison

| Distro | Best For | Difficulty | Notes |
|--------|----------|------------|-------|
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
| **Stability** | ⚠ Unstable with 40 CU — green screen on idle/download, random freezes. "A bunch of people moved from Bazzite to CachyOS" (community, Jul 2026). | Rock solid — "5 days no crashes after switching from Bazzite" (evo9899). Several users report identical experience. |
| **Ease of setup** | Easiest — pre-patched kernel, Game Mode included. But outdated kernel causes governor install issues. | Moderate — Arch-based, manual setup. More flexible, fewer surprises. |
| **Kernel** | ⚠ Stable: **6.17.7** (OLD!). Testing: kernel 7.0 + Mesa 26 — not yet released. | Latest 6.19+ out of box. No waiting for updates. |
| **40 CU unlock** | CU live manager works. Legacy kernel patch available (ba29 Deck kernel only). OGC desktop kernel packages not yet available. | CU live manager works on stock kernel. Full toolkit support (redbeard1083, gennro). |
| **Governor install** | `dnf copr` + `rpm-ostree install`. Can be tricky on old kernel. Rebase to `bazzite:testing` or `bazzite:stable` helps (zerosumpr). | `yay -S` or AUR helper. Straightforward. |
| **Updates** | Immutable — safer rollbacks, but updates are slow. BC-250 needs bleeding-edge kernel which conflicts with Bazzite's philosophy. | Rolling — bleeding edge. May break occasionally but quick fixes. |
| **Game Mode** | Built-in Gamescope session. Some users report instability (Split Fiction crashes, black screen loops). | Handheld Edition includes Gamescope + FSR (stevounit). Desktop needs manual setup. |
| **VRR / Audio** | Audio issues persist for some users (Jul 2026). VRR works with custom image. | Native 6.19+ kernel support for VRR + DP audio. Working out of box. |
| **Best for** | Console experience with fully working Game Mode — IF on testing branch. Good for users willing to rebase. | Raw performance, stability, tuners, desktop use, AI/LLM. Community default. |

**Community consensus (July 2026):**
- Bazzite stable is **not recommended** for 40 CU builds due to outdated kernel (6.17.7). BC-250 needs 6.19+.
- If you want Bazzite, rebase to the **testing branch** which has kernel 7.0 + Mesa 26 (not yet in stable).
- CachyOS has become the de-facto recommendation for stability + performance: "definitely better in terms of stability and features" (community, Jul 2026).
- The performance gap is real — Bazzite stable's old kernel causes tangible issues with 40 CU, governor, and audio.
- For non-technical users who want a console experience: Bazzite desktop testing branch or CachyOS Handheld Edition.
- Several users explicitly recommended CachyOS over Bazzite after experiencing instability: "5 days no crashes" (evo9899), "rock solid reliable" (multiple users).

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
- **⚠ Important:** Stable branch is on kernel 6.17.7 — too old. Rebase to `bazzite-deck:testing` for kernel 7.0 + Mesa 26 before setting up governor and 40 CU.
- Install EmuDeck for emulation: use the Bazzite portal
- Update with `ujust update` (or `rpm-ostree upgrade` + `flatpak update`)
- Rollback broken updates with `rpm-ostree rollback`
- **VRR:** Testing branch includes VRR support natively. Stable branch does not.
- **Audio:** DP audio fix in kernel 6.19.10+. Bazzite stable (6.17.7) does NOT include it. Testing branch does.
- **Instability workaround:** If experiencing green screens, freezes, or crashes on Bazzite, rebase to testing branch first. If issues persist, multiple users report switching to CachyOS resolves them (evo9899, community, Jul 2026).
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
4. Recommended kernel: `linux618` or `linux619` (kernel 6.19.x preferred for VRR/DP audio; source: Discord)
   ```bash
   sudo mhwd-kernel -i linux618
   ```
5. Install governor from AUR

**Community note (source):** "Out of the box after the BIOS flash, Manjaro KDE just booted fine"

---

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
