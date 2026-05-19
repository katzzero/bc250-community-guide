# 05 - OS Installation

> Step-by-step guides for installing Linux on the BC-250.
> **BIOS must be flashed first** - see [02-BIOS](02-bios-and-firmware.md).
> **Kernel**: Community has moved to **6.19.x** which has VRR and DP audio fixes (gennro). **Mesa 26** is now current with significant RT and performance improvements.

---

## Distribution Comparison

| Distro | Best For | Difficulty | Notes |
|--------|----------|------------|-------|
| **Bazzite** | Beginners, gaming | Easy | Steam Deck-like, pre-patched kernel, works out-of-box |
| **Fedora 43+** | Most tested, general use | Easy | Mesa 25.1+ in official repos, most tested distro |
| **CachyOS** | Maximum performance | Intermediate | Arch-based, optimized packages, BORE scheduler |
| **Arch Linux** | Full control, latest packages | Advanced | Manual setup but cutting-edge |
| **Debian / PikaOS** | Stability, low power | Intermediate | Requires newer Mesa repos |
| **Nobara** | Gaming, Bazzite alternative | Intermediate | Fedora-based, not immutable, easier governor install (Discord - mothenjoyer69) |
| **Ubuntu 26.04+** | Familiar Ubuntu experience | Easy | Needs Mesa PPA |
| **Manjaro** | User-friendly Arch | Easy | GNOME recommended over KDE for stability |

---

## Universal Prerequisites

### Hardware Needed
- [ ] BC-250 board (any BIOS P2.00-P5.00)
- [ ] 300W+ 12V PSU with PCIe 8-pin (250W minimum)
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

Kernel versions **6.15.0-6.15.6** and **6.17.8-6.17.10** cause GPU initialization failures and kernel panics. Do not install these. Use **6.18.18 LTS** (recommended) or **6.17.11+** instead.

---

## Bazzite (Recommended for Beginners)

> Fedora Atomic-based, SteamOS-like distro. Works out-of-box - no nomodeset needed.

### Installation

1. Download ISO from [bazzite.gg](https://bazzite.gg)
2. Choose variant:
   - **GNOME** - Recommended for beginners
   - **KDE** - Desktop users (bugs mostly fixed as of mid-2025)
   - **Deck** - Steam Deck UI experience
3. Flash to USB with **balenaEtcher** or **Ventoy**
4. **Use the non-live installer image** (live image has login bugs) (Discord - mothenjoyer69)
5. Boot from USB - no special parameters needed
6. Complete on-screen installation (10-15 min)
7. Default password (if asked): `bazzite` (need confirmation - source: Discord)
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
- **VRR on Deck:** A custom Bazzite image with AMD VRR kernel patches exists - search community for `bazzite-vrr` images. Confirm working on OLED displays. DP audio fix not yet included.
- **40 CU Unlock on Bazzite:** erewego posted pre-built RPMs against the ba29 Deck kernel (Bazzite handheld/Deck uses ba29; desktop uses OGC kernel). Download `bazzite-bc250cu-rpms-ba29.7z` from the Discord project-forums, unpack, then:
  ```bash
  sudo rpm-ostree override replace ./*.rpm
  sudo rpm-ostree kargs --append=amdgpu.bc250_cc_write_mode=3
  sudo systemctl reboot
  ```
  Reduce GPU governor clocks to ~1850 MHz. For desktop Bazzite (OGC kernel), kernel packages are not yet available — check Discord for updates. Not recommended for normal users until CU health testing matures. See [02-BIOS & Firmware](02-bios-and-firmware.md) for full procedure details.

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

> Source: Discord (mothenjoyer69). Not in elektricM official docs.

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

## CachyOS (Best Raw Performance)

> Arch-based with optimized packages and BORE scheduler.

**Note (Nov 2025):** CachyOS now ships with compatible kernels by default. Standard ISO install works.

### Standard Method (Recommended)

1. Download [CachyOS ISO](https://cachyos.org/) (KDE or GNOME)
2. Flash to USB, boot and run installer normally
3. Select **GRUB bootloader**
4. Verify kernel is compatible:
   ```bash
   uname -r  # Should be 6.18.x LTS or 6.17.11+ (avoid 6.15.0-6.15.6, 6.17.8-6.17.10)
   ```
5. Install governor:
   ```bash
   yay -S cyan-skillfish-governor-smu
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```

### 40 CU Unlock on CachyOS

Apply the `bc250-40cu-amdgpu.patch` to the kernel PKGBUILD patch set. duggasco maintains a PR fork with the patch pre-applied.

```bash
git clone https://github.com/duggasco/bc250-40cu-unlock.git
cd bc250-40cu-unlock
sudo ./scripts/bc250-enable-40cu.sh build
sudo ./scripts/bc250-enable-40cu.sh enable   # reboots
```

Or use CachyOS Kernel Manager GUI to apply the patch. See [02-BIOS & Firmware](02-bios-and-firmware.md) for CU health testing and masking.

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

1. Install Arch normally with `linux-lts` kernel (6.18.18 LTS recommended, avoid 6.15.0-6.15.6 and 6.17.8-6.17.10)
2. Install governor from AUR:
   ```bash
   yay -S cyan-skillfish-governor-smu
   # or: paru -S cyan-skillfish-governor-smu
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```
3. Automated setup script (alternative):
   ```bash
   git clone https://github.com/eabarriosTGC/BC250--ARCH.git
   cd BC250--ARCH
   sudo chmod +x ./Arch-setup.sh
   sudo ./Arch-setup.sh
   ```
4. Alternative setup script:
    ```bash
    git clone https://github.com/pnbarbeito/bc250-arch
    cd bc250-arch
    ./install.sh
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
4. Install kernel (Xanmod LTS 6.18.18 recommended):
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
5. Kernel: 6.18.x LTS recommended (verify with `uname -r`)
6. Install governor (see `.deb` package from GitHub)

---

## Manjaro

1. Download Manjaro (KDE or GNOME edition - GNOME more stable per source)
2. Install normally (boots out-of-box, no nomodeset needed)
3. Mesa in official repos is sufficient
4. Recommended kernel: `linux618` (need confirmation from source - Discord)
   ```bash
   sudo mhwd-kernel -i linux618
   ```
5. Install governor from AUR

**Community note (source):** "Out of the box after the BIOS flash, Manjaro KDE just booted fine"

---

## Verification - After Any Installation

```bash
# Mesa version (must be 25.1+, 25.3.x recommended)
glxinfo | grep "OpenGL version"
# Should show: Mesa 25.X.X

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
# Expected: 6.18.18 LTS (recommended) or 6.17.11+
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
