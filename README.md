# BC-250 Unofficial Community Guide

> **Turn a $50-150 mining board into a Linux gaming PC.** The BC-250 carries a cut-down PS5 "Oberon" APU — 6 Zen 2 cores (up to 8 unlockable), 24 RDNA 2 CUs (up to 40 unlockable), 16 GB GDDR6. Performance: RX 6600–RX 6700 level with unlocks. Total build: **~$150-250**.
>
> **Linux only** — no Windows GPU drivers *officially* but multiple parallel projects exist. Maintained by katzzero from community Discord data. [Discord](https://discord.gg/8eZfFWhczz) · [Wiki](https://github.com/katzzero/bc250-unofficial-community-guide/wiki) · [Changelog](changelog.md) · [Contribute](CONTRIBUTING.md)

---

## Start Here

If you just bought a BC-250, follow this step-by-step guide:

### [00 -- From Zero to Gaming](00-from-zero-to-gaming.md)

Linear walkthrough: purchase → assembly → BIOS flash → OS install → first game running. Takes about 2 hours.

---

## What's in This Guide

| # | File | Topic |
|---|------|-------|
| **00** | **[From Zero to Gaming](00-from-zero-to-gaming.md)** | **Start here — complete setup walkthrough** |
| 01 | [Hardware Specifications](01-hardware-specs.md) | Board specs, APU details, connectors, pinouts |
| 02 | [BIOS & Firmware](02-bios-and-firmware.md) | BIOS flashing, VRAM config, 40 CU unlock |
| 03 | [Power Supply Guide](03-power-supply-guide.md) | PSU options with verified specs & purchase links |
| 04 | [Cooling Guide](04-cooling-guide.md) | Heatsink mods, fans, thermal pads, temps |
| 05 | [OS Installation](05-os-installation.md) | CachyOS (recommended), Bazzite, Fedora, Arch, Debian, Ubuntu |
| 06 | [GPU Governor](06-gpu-governor.md) | Governor install, tuning, overclocking |
| 07 | [Game Benchmarks](07-game-benchmarks.md) | 60+ community-tested games with FPS data |
| 08 | [Display & Audio](08-display-and-audio.md) | DP/HDMI, audio, VRR, multi-monitor |
| 09 | [WiFi & Peripherals](09-wifi-and-peripherals.md) | WiFi/BT adapters, SSDs, USB accessories |
| 10 | [Troubleshooting](10-troubleshooting.md) | Error reference, fixes, debugging commands |
| 11 | [Community & Resources](11-community-and-resources.md) | Discord, repos, timeline, YouTube coverage |
| 12 | [AI Inference & LLMs](12-ai-inference.md) | llama.cpp, Ollama, Stable Diffusion, ROCm |
| 13 | [Case Mods & Custom Enclosures](13-case-mods.md) | 3D-printable cases, commercial sources |

---

## Quick Specs

| Spec | Value |
|------|-------|
| **APU** | AMD BC-250 "Cyan Skillfish" — cut-down PS5 Oberon |
| **CPU** | 6× Zen 2 (@ ~3.5 GHz, up to 8 unlockable via SMU BIOS shim) |
| **GPU** | 24 RDNA 2 CUs (up to 40 unlockable), 1500–2300 MHz |
| **Memory** | 16 GB GDDR6 shared — 14 Gbps, 256-bit, ~448 GB/s |
| **Storage** | 1× M.2 2280 (PCIe 2.0 x2 — ~1 GB/s max, don't overspend) |
| **Display** | 1× DisplayPort 1.4 (no HDMI — passive adapter ~$5) |
| **Network** | 1× Gigabit Ethernet (no WiFi — USB adapter needed) |
| **USB** | 2× USB 3.0 + 2× USB 2.0 |
| **TDP** | 220W typical, 235W peak gaming, 250–320W Furmark |
| **OS** | Linux only — CachyOS (recommended), Bazzite, Fedora 43+, Arch, Debian |

---

## Quick Shopping

| Item | Recommendation | Price |
|------|---------------|-------|
| **Board** | BC-250, BIOS P2.00–P3.00 or P5.00 (avoid P4.00) | ~$80–150 |
| **PSU** | FSP500-30AS Flex ATX (eBay `389522369783`) or Mean Well LOP-400 | ~$15–65 |
| **Fan** | Arctic P12 Pro / P12 Max 120mm | ~$8–12 |
| **Thermal pad** | PTM7950 phase-change pad (Amazon `B0F9Y5SCK2`) | ~$10 |
| **Thermal pads** | 1.5mm front + 2.0mm back for VRAM | ~$8 |
| **Display cable** | Passive DP-to-HDMI adapter | ~$5 |
| **WiFi adapter** | TP-Link Archer TX10UB Nano (WiFi 6 + BT 5.3) | ~$20 |
| **SSD** | Any M.2 NVMe (PCIe 2.0 x2 — cheap drives saturate the bus) | ~$25 |
| | **Total (approx)** | **~$150–250** |

---

## ⚠️ Important Warnings

1. **Linux only** — no Windows GPU drivers exist
2. **Always clear CMOS** after BIOS flash — settings won't stick otherwise
3. **Disable IOMMU** in BIOS — broken, causes display failures
4. **Use kernel 6.19.x** (recommended) or 6.18.18 LTS — avoid 6.15.0–6.15.6 and 6.17.8–6.17.10
5. **Governor voltage: minimum 700 mV** — below that GPU locks to 1500 MHz
6. **Never use 6-pin to 8-pin PCIe adapters** — fire hazard
7. **Never use Smokeless_UMAF** — can permanently damage the board
8. **Don't lose the 4 nylon washers** under heatsink screws — missing = 90–100°C idle
9. **VRAM has no temperature sensor** — must cool backplate actively
10. **No hardware video encode/decode** — VCN 2.0.3 present but power-gated; active research (not fused off)

---

## Performance Unlocks

The BC-250 ships lock-down — the PS5 "Oberon" APU was cut down to 6 CPU cores and 24 Compute Units. Both are unlockable with community tools:

### 40 CU GPU Unlock (RDNA 2)

Stock board has 24 of 40 CUs active. All 16 harvested can be re-enabled:

- **Live Manager** (recommended): [WinnieLV/bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) — TUI on the fly, no reboot. Works on stock kernel.
- **Kernel patch**: [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock) — legacy method, rebuilds amdgpu module.
- **Runtime script** (Jul 2026): [big_trov's runtime_40cu Unlock.sh](https://discord.gg/8eZfFWhczz) — patches module in-memory without kernel recompile.

Full guide: [02-BIOS & Firmware](02-bios-and-firmware.md#40-cu-unlock). Benchmarks: [07-Game Benchmarks](07-game-benchmarks.md).

### 8 CPU Core Unlock (Zen 2 — New!)

Board ships with 6 of 8 Zen 2 cores active. As of **Aug 2026**, three working methods exist:

| Method | Type | Risk |
|--------|------|------|
| **RescueMei/BC250-DXE-SMU-Core-Unlock** | Patched BIOS (DXE/SMU) — permanent unlock | ⚠️ If cores don't work, need external flash programmer to recover |
| **Hexxeh/bc250-efi-core-unlock** | EFI shim at boot — semi-permanent, no BIOS modification | ✅ Safer option |
| **GabriWar/bc250-core-cu-unlock** | Linux SMU mailbox 0x98 tool — 8 cores + 40 CU, no BIOS flash, systemd unit re-applies after cold boot | ✅ Reverts on cold boot (guaranteed escape hatch) |

8-core benchmark in Cyberpunk 2077: **+5-14% FPS** (6 cores → 8 cores: 72→93 fps Low FSR2). Total build cost adds $0 for the unlock itself. After unlocking, apply the **8-core ACPI fix** (CPUs 12-15 need C-states) and the **8-core metrics fix** (`fix-freq = true` governor option, no kernel patch needed) — see [02-bios-and-firmware.md](02-bios-and-firmware.md) and [06-gpu-governor.md](06-gpu-governor.md).

### Stock Performance Baseline

| Config | Game Level | Notes |
|--------|-----------|-------|
| **6 CU, 24 CU stock** | RX 6600–6600 XT level | Solid 1080p gaming baseline |
| **40 CU unlocked** | RX 6700 / GTX 1080 Ti | See [game benchmarks](07-game-benchmarks.md) for details |
| **40 CU + 8 cores** | ~60 FPS Cyberpunk 2077 (dbkretro) | ~10 FPS gain in CPU-heavy areas (Dogtown, qwert9811) |

Full benchmark suite: [07 — Game Benchmarks](07-game-benchmarks.md) (60+ community-tested games).

---

## Join the Community

- **[BC250 Community Discord](https://discord.gg/8eZfFWhczz)** — 3,500+ members, active daily
- **[elektricM Docs](https://elektricm.github.io/amd-bc250-docs/)** — source-of-truth documentation (33+ pages)
- **[bc250-collective](https://github.com/bc250-collective)** — ACPI fix, SMU OC, governor

---

## What's New

**August 2026:** CPU core unlock matures — Linux SMU mailbox 0x98 tool (GabriWar) with systemd re-apply, warm/cold boot behavior, core test script (+26.9% 7-zip) · `fix-freq` governor option fixes 8-core GPU clock reporting (no kernel patch) · 8-core ACPI fix (mendesrr) · Async compute queue fix (DryhoppedIPA, +25% FPS Cyberpunk, in Toolkit v1.1.0) · VRM telemetry via I2C/PMBus + web dashboard (punsh1734, 2-wire mod) · Patched BIOS unlock option + SteamOS boot logo · VCN unlock research active

**July 2026:** CPU core unlock functional (RescueMei patched BIOS + Hexxeh EFI shim + rw-r-r-0644 Python script) · Alternate bitmask testing (7-of-8 cores possible) · OS-independent SMN/PSP mechanism proven · 8-core benchmark: +5-14% FPS in Cyberpunk · jwagnervaz independent BIOS rev eng (4700S BIOS testing)

**June 2026:** Black Myth: Wukong benchmark (edges RX 6700) · Binary search artifact hunting · Live-manager stock WGP disabling · OCP power limit documented · VCN confirmed NOT fused off (partial decode) · Kernel 6.19.x recommended · Mesa 26.x standard

**May 2026:** CU Live Manager (toggle 40 CUs without kernel patch) · Cyberpunk 2077 38 CU record (matches RTX 3060) · BIOS P4.00 discovered · AIOs confirmed (Thermalright Aqua Elite 240) · Micro-Fit power mod · Dell DA2 220W undervolted success · Mesa 26 + VRR on CachyOS/Bazzite

---

## How This Guide Is Maintained

Updated continuously from BC-250 Discord community data using a semi-automated pipeline: export → RAG indexing → audit → cross-reference → edit → commit. Every claim verified against [elektricM docs](https://elektricm.github.io/amd-bc250-docs/) and Discord exports.

---

*Unofficial — not endorsed by AMD or any community. Prices change often, verify before buying. [Changelog](changelog.md) · [Contribute](CONTRIBUTING.md) · [Discord](https://discord.gg/8eZfFWhczz)*
