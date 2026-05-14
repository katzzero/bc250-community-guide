# 05 — OS Installation

> Step-by-step guides for installing Linux on the BC-250.
> **BIOS must be flashed first** — see [02-BIOS](02-bios-and-firmware.md).

---

## Distribution Comparison

| Distro | Best For | Difficulty | Notes |
|--------|----------|------------|-------|
| **Bazzite** | Beginners, gaming | Easy | Steam Deck-like, pre-patched kernel, works out-of-box |
| **Fedora 43+** | Most tested, general use | Easy | Mesa 25.1+ in official repos, best documentation |
| **CachyOS** | Maximum performance | Medium | Arch-based, optimized packages, BORE scheduler |
| **Arch Linux** | Full control, latest packages | Advanced | Manual setup but cutting-edge |
| **Debian / PikaOS** | Stability, low power | Medium | Requires newer Mesa repos |
| **Nobara** | Gaming, Bazzite alternative | Medium | Fedora-based with Cachy kernel optimizations, easier governor installation |
| **Ubuntu 26.04+** | Familiar Ubuntu experience | Easy | Needs Mesa PPA |
| **Manjaro** | User-friendly Arch | Easy | KDE Plasma recommended |

---

## Universal Prerequisites

### Hardware Needed
- [ ] BC-250 board (any BIOS P2.00–P5.00)
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

---

## Bazzite (Recommended for Beginners)

> Fedora Atomic-based, SteamOS-like distro. Works out-of-box — no nomodeset needed.

### Installation

1. Download ISO from [bazzite.gg](https://bazzite.gg)
2. Choose variant:
   - **GNOME** — Recommended for beginners
   - **KDE** — Desktop users (bugs mostly fixed as of mid-2025)
   - **Deck** — Steam Deck UI experience
3. Flash to USB with **balenaEtcher** or **Ventoy**
4. **Use the non-live installer image** (live image has login bugs!)
5. Boot from USB — no special parameters needed
6. Complete on-screen installation (10–15 min)
7. Default password (if asked): `bazzite`
8. Reboot

### Post-Install Setup

```bash
# Update system
sudo rpm-ostree update
sudo systemctl reboot

# Install GPU governor (SMU — recommended, no kernel patch needed)
sudo dnf copr enable filippor/bazzite
rpm-ostree install cyan-skillfish-governor-smu
sudo systemctl reboot
sudo systemctl enable --now cyan-skillfish-governor-smu.service

# Verify
systemctl status cyan-skillfish-governor-smu
```

### ⚠️ Patched Performance Images (Optional)

Custom images with pre-configured kernel + governor exist but **may kill USB WiFi** after rebase:

```bash
# GNOME (recommended)
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vietsman/bazzite-gnome-patched:latest

# KDE
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vietsman/bazzite-kde-patched:latest

# Deck
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vietsman/bazzite-deck-patched:latest
```

> ⚠️ **Warning:** Rebasing to patched images may remove USB WiFi/Bluetooth drivers. If WiFi stops working: use Ethernet, check available kernel modules (`lsmod | grep <driver>`), install missing drivers, or rollback with `rpm-ostree rollback`.

### Bazzite Tips
- Install EmuDeck for emulation: use the Bazzite portal
- Update with `ujust update` (or `rpm-ostree upgrade` + `flatpak update`)
- Rollback broken updates with `rpm-ostree rollback`

---

## Fedora 43+ (Most Tested)

> Mesa 25.1+ included in official repos. Most community documentation targets Fedora.

### Installation

1. Download [Fedora 43 Workstation](https://getfedora.org/) (or newer)
2. Flash to USB with **Fedora Media Writer**, **balenaEtcher**, or **Ventoy**
3. Boot installer → select **"Basic Graphics Mode"** from GRUB (auto-enables nomodeset)
4. Complete installation normally, reboot

### Post-Install Setup

```bash
# Update system
sudo dnf update

# Install GPU governor (SMU variant — no kernel patch needed)
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

---

## Nobara (Gaming-Focused Fedora Alternative)

> Fedora-based with Cachy kernel optimizations, not immutable — easier governor installation.

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

### Standard Method (Recommended)

1. Download [CachyOS ISO](https://cachyos.org/) (KDE or GNOME)
2. Flash to USB, boot and run installer normally
3. Select **GRUB bootloader**
4. Verify kernel is compatible:
   ```bash
   uname -r  # Should be 6.18.x LTS or 6.17.11+
   ```
5. Install governor:
   ```bash
   yay -S cyan-skillfish-governor-smu
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
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

1. Install Arch normally with `linux-lts` kernel
2. Install governor from AUR:
   ```bash
   yay -S cyan-skillfish-governor-smu
   # or: paru -S cyan-skillfish-governor-smu
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```
3. Automated setup script (alternative):
   ```bash
   wget https://github.com/dannybastos/bc-250-archlinux/raw/main/bc-250-archlinux-setup.sh
   chmod +x bc-250-archlinux-setup.sh
   ./bc-250-archlinux-setup.sh
   ```

---

## Debian / PikaOS

> Requires Testing/Sid — Stable is too old for Mesa 25.1+.

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
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   sudo reboot
   ```
5. Install governor (.deb from GitHub releases):
   ```bash
   wget https://github.com/Magnap/cyan-skillfish-governor/releases/latest/download/cyan-skillfish-governor-smu_amd64.deb
   sudo dpkg -i cyan-skillfish-governor-smu_amd64.deb
   sudo systemctl enable --now cyan-skillfish-governor-smu.service
   ```

> 💡 **PikaOS** (Debian-based gaming distro) includes Mesa 25.1+ out of the box — easiest Debian option.

---

## Ubuntu 26.04+

1. Download Ubuntu 26.04 daily server ISO or newer
2. Flash to USB, boot with `nomodeset` if needed
3. Install normally
4. Add Mesa PPA if needed:
   ```bash
   sudo add-apt-repository ppa:kisak/kisak-mesa
   sudo apt update && sudo apt upgrade
   ```
5. Install governor (see `.deb` package from GitHub)

---

## Manjaro

1. Download Manjaro (KDE Plasma recommended)
2. Install normally
3. Mesa in official repos is sufficient
4. Recommended kernel: `linux618`
   ```bash
   sudo mhwd-kernel -i linux618
   ```
5. Install governor from AUR

---

## Verification — After Any Installation

```bash
# Mesa version (must be 25.1+)
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

# GPU renderer (NOT llvmpipe!)
glxinfo | grep "OpenGL renderer"
# Should show: radv gfx1013
```

---

## Bootable USB Creation Tools

| Tool | Platform | Notes |
|------|----------|-------|
| **Ventoy** | All | Best option — boot multiple ISOs from one drive |
| **balenaEtcher** | All | Simple GUI flasher |
| **Fedora Media Writer** | All | Fedora's recommended tool |
| **Rufus** | Windows | Use UEFI / FAT32 mode |
| **dd** | Linux CLI | `sudo dd if=image.iso of=/dev/sdX status=progress && sync` |