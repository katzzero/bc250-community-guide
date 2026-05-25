# BC-250 Community Guide

> Comprehensive, community-driven guide for the AMD BC-250 mining board repurposed as a budget gaming/desktop PC.

---

## Table of Contents

| # | File | Topic |
|---|------|-------|
| 01 | [Hardware Specifications](01-hardware-specs.md) | Board specs, components, physical dimensions |
| 02 | [BIOS & Firmware](02-bios-and-firmware.md) | BIOS flashing, VRAM config, modded BIOS files |
| 03 | [Power Supply Guide](03-power-supply-guide.md) | PSU options with verified specs & purchase links |
| 04 | [Cooling Guide](04-cooling-guide.md) | Heatsink mods, fan selection, thermal interface, temps |
| 05 | [OS Installation](05-os-installation.md) | Distro-by-distro setup guides (Bazzite, Fedora, etc.) |
| 06 | [GPU Governor](06-gpu-governor.md) | Governor options, installation, tuning & OC |
| 07 | [Game Benchmarks](07-game-benchmarks.md) | Community-tested performance database |
| 08 | [Display & Audio](08-display-and-audio.md) | DP/HDMI, audio solutions, cable recommendations |
| 09 | [WiFi & Peripherals](09-wifi-and-peripherals.md) | WiFi/BT adapters, USB accessories, storage |
| 10 | [Troubleshooting](10-troubleshooting.md) | Error messages, fixes, debugging commands |
| 11 | [Community & Resources](11-community-and-resources.md) | Links, Discord, timeline, credits |
| 12 | [AI Inference & LLMs](12-ai-inference.md) | llama.cpp, Ollama, Stable Diffusion, ROCm status |

---

## Key Facts at a Glance

| Spec | Value |
|------|-------|
| **APU** | AMD BC-250 "Cyan Skillfish" (cut-down PS5 Oberon) |
| **CPU** | 6x Zen 2 cores @ ~3.5 GHz |
| **GPU** | 24 RDNA 2 CUs (up to 40 via kernel patch), base 1500 MHz, up to 2230 MHz (OC) |
| **Memory** | 16 GB GDDR6 shared (CPU + GPU) |
| **Storage** | 1x M.2 2280 (PCIe 2.0 x2 NVMe or SATA3) |
| **TDP** | 220W (up to 235W under full load) |
| **Display** | 1x DisplayPort 1.4 (no HDMI -- adapter required) |
| **Network** | 1x Gigabit Ethernet (no built-in WiFi) |
| **USB** | 2x USB 3.0 + 2x USB 2.0 |
| **OS Support** | Linux only -- no Windows GPU drivers exist |

---

## Important Warnings

1. **No Windows GPU drivers** -- Linux is required
2. **Always clear CMOS** after USB BIOS flash (settings won't stick otherwise)
3. **Disable IOMMU** in BIOS -- it is broken and causes display failures
4. **Avoid older broken kernels** -- 6.15.0-6.15.6 and 6.17.8-6.17.10 were known-bad; these ranges are now outdated for current distros (use 6.18.18 LTS, 6.19.x, or 6.17.11+)
5. **Governor minimum voltage: 700 mV** -- below that GPU locks to 1500 MHz
6. **Do NOT use Smokeless_UMAF** -- can cause permanent damage
7. **No hardware video encode/decode** -- VCN firmware blocked by Sony, software decoding only
8. **Never use 6-pin to 8-pin PCIe adapters** for power delivery -- fire hazard (Discord confirmed)
8. **ACPI fix recommended** -- SSDT tables enable CPU C-States (idle power) and P-States (frequency scaling 800-3200 MHz). Confirmed working on kernel 6.19.8. Note: repo README says P-States may not work on all boards. ([bc250-acpi-fix](https://github.com/bc250-collective/bc250-acpi-fix))
9. **VRAM chips have no temperature sensor** -- ensure backplate airflow

---

## Quick Shopping

| Item | Recommended | Where |
|------|-------------|-------|
| BC-250 Board | Any BIOS P2.00-P5.00 | AliExpress, eBay |
| PSU (Best Value) | FSP500-30AS Flex ATX 500W, 80+ Platinum (need confirmation) | eBay -- search `389522369783` (need confirmation) |
| Fan | Arctic P12 Max / P12 Pro 120mm (3-pack or 5-pack) | Amazon |
| Thermal Pad (APU) | PTM7950 Phase Change Pad | Amazon B0DHRR78H7 (need confirmation) |
| Thermal Pads | 1.5 mm front, 2.0 mm back | Amazon multi-pack |
| Display Cable | Passive DP-to-HDMI | Amazon / AliExpress ~$2 |
| WiFi | TP-Link Archer TX10UB Nano (WiFi 6 + BT 5.3) | Amazon B0DZCC95G6 (need confirmation) |
| GPU Governor | cyan-skillfish-governor-smu | COPR / AUR |

---

*Last updated: Based on community data through May 2026. Prices and availability change frequently -- verify before purchasing.*

---

## Latest Additions (May 2026)

- **Runtime 40 CU Unlock (No Kernel Patch)** — big_trov's `runtime_40cu_unlock.sh` enables 40 CU on stock kernel without rebuilding. gennro/bc250-toolkit automates module compilation for CachyOS. Results identical to patched kernel (corbanitevevo, May 2026).
- **Voltage Wall Analysis (big_trov)** — Two limit curves (voltage ceiling + power limit) intersect at ~2200 MHz at 40 CU, creating a hard stability ceiling. ~250W gaming, ~350W Furmark wall power (bytepond).
- **Sleep/Wake Bug** — Monitor fails to wake after resume; audio shifts to USB DAC. CachyOS workaround via kscreenlocker re-enable.
- **Stock Heatsink Fixes** — 1mm thermal pad spacer improves APU die contact (gennro). Heat pipe failure diagnosis: bytepond traced 85C to a failed heat pipe, replacement dropped to 72C.
- **Vulkan_NullVRS (bangstk)** — Vulkan layer that nullifies VRS commands, fixing 640x480 rendering in Doom TDA and other affected games.
- **CU Fault Detection** — Doom TDA and CS2 more sensitive than synthetic benchmarks for detecting borderline CU faults.
- **40 CU Unlock** — [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock). 1.61x compute scaling, 57→153 FPS gaming. Kernel patch + CU health testing (duggasco, filippor, big_trov, essdee4336, scallion_9883).
- **AI Inference Guide** — `12-ai-inference.md`. llama.cpp Vulkan quick start, benchmarks, ROCm status, model compatibility, multi-board RPC (hammercoral, __nightfox, xseol).
- **13 Resolved FAQs** — Sourced from help-thread; added to troubleshooting with user credits.
- **Bazzite 40 CU RPMs** — erewego posted pre-built ba29 kernel RPMs for Deck.
- **Community Projects** — ATX PSU Control Adapter (pilimmm), Remote ESP32 Controller (wisserbasser), AMD clip cooler adapter (bioizhere), CachyOS Toolkit (redbeard1083).
- **CU Masking Fix + Crash Behavior** — Corrected WGP-pair syntax (ungamead, greatapo), 40CU hard-lock vs soft-freeze modes (big_trov), VRM bottleneck warning (capt.cat_13), OCP hard lockup at 2400 MHz requiring power pull (big_trov, codyrainy, cralant).
- **New Game Benchmarks** — Forza Horizon 6, Crimson Desert, MGS3 Delta 40CU +66%, Hitman 2 40CU 1.33x, Fatal Frame 2, Marvel Rivals, Returnal.
- **Troubleshooting** — Low DP volume fix (dizzey0709), WiFi DKMS after 40CU kernel (devilplayer25), fan RPM/MangoHud 0% fix (fallenmask/erewego). ATX wire gauge specs (iamdarkyoshi).
- **Superposition Leaderboard** — 24 CU (nexgen3d 4713 Extreme record) and 40 CU (gennro ~5900, big_trov 5759).
- **CU Health Scripts** — `cu_map.sh` for harvest map, `bc250-cu-mask.sh` for selective masking, `--health` overlay (sinh_28065, lux.the.cook).
- **VRR on Bazzite Deck** — Custom image with AMD VRR patches confirmed working; cheap Aliexpress DP>HDMI adapters support VRR without audio desync.
- **Mesa 26** — GTA V Enhanced fixed (was 3-5fps crash, now smooth); CachyOS ships Mesa 26 with RT and performance improvements.
- **CPU Core Unlock Research** — duggasco and mrfrakes researching unlocking extra CPU cores; decompiled bootrom, understanding PSP fuse checks.
- **Governor Plus Variant** — `cyan-skillfish-governor-smu-plus` with `fix-metrics` config option, `set-method`, `frequency-range`. Issues on CachyOS.
- **2400 MHz 40CU confirmed with AIO** — Requires >1100 mV; crashes at 1050 mV. Still OCP hard lockup for most boards.
- **RE4 Remake crashes** — Specific game instability even with stable stress tests; games need more voltage than benchmarks.
- **Memory OC limited gains** — `RobinMemTiming` utility confirmed; only +80 Superposition, +1 FPS Cyberpunk.
- **Forza H6 Ultra 60 FPS** — 40 CU runs Ultra preset at 60 FPS; RT causes crashes.
- **Debian unsupported** — Patched 40 CU kernel does not work on Debian.
- **Stock P3.00 BIOS fan curve** — Original P3.00 already has custom fan curve and IOMMU toggle (fanous_). Modded P3.00 still recommended for chipset menu.
- **38/40 CU benchmarks** — pijuli. tested a partially harvested board: 38 CU @ 1900 MHz = 130 FPS Furmark (84C, 336W), 35% faster than 24 CU at same temp.
- **40 CU stability variance** — nonu0038 tested 3 boards, only 1 stable at 40 CU. YMMV strongly depends on individual board quality.
- **duggasco build script Debian-specific** — Arch/CachyOS users reported failures with the automated script (zloymalefic_76235). Manual patch required on non-Debian distros.
- **New community repos** — mosfetparty/bc250-psu-adapter (wiring diagrams + 3D models), safwyls/BC-250_ATXCase, dyllan500/bazzite-amd-hdmi-kde (VRR fixes), GreatApo/bc250-40cu-unlock (corrected CU masking), bc250-collective/bc250_smu_oc (CPU OC tool).
- **elektricM source sync** — elektricM docs now recommend SMU governor over TT; MST hub compatibility table added; micro-stutter fix (disable hhd) confirmed from source.
- **Governor v0.4.0** — CPU-based memory clock control released to bc250-collective org. Lowers memory controller and IF clocks at idle.
- **Idle power tested** — big_trov: 40 CU = 70W idle (same as 24 CU). pops1cl: 64W at 50 MHz / 650 mV.
- **dznuts 5300 Superposition** — 38 CU at 2200 MHz, new 40 CU leaderboard entry. Memory OC only +80 points.
- **Death Stranding 2** — 36 CU, ultrawide 1440p@60fps high. PICO (PS5 FSR port) upscaler superior to FSR3.
- **S.T.A.L.K.E.R. 2** — 55 FPS stock, 60 FPS at 36 CU, 110-120 with frame gen.
- **Subnautica 2** — Playable with Proton Experimental, 40 CU.
- **PS5 40 CU patch confirmed** — BC-250 unlock patch works on PS5 Linux; 36→40 CU = 4% gain.
- **Thermalright Peerless Assassin 120** — Best non-liquid cooler, works with 3D-printed bracket and GPU backplate cooler (dartzon).
- **OCP power limit at 1850-2200 MHz** — Secondary power limit causes hard lock. May need shunt mod.
