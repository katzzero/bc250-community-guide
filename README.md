# BC-250 Unofficial Community Guide

> Turn a $50-150 ex-mining board into a capable Linux gaming PC. The BC-250 is a recycled AMD board with a cut-down PS5 "Oberon" APU — 6 Zen 2 cores + 24 RDNA 2 CUs + 16 GB GDDR6. Performance lands between an RX 6600 and RX 6600 XT. Total build cost: **~$150-250** including board, PSU, fan, SSD, and adapters.
>
> **Linux only** — no Windows GPU drivers. Unofficial guide by katzzero, not endorsed by AMD. [Discord](https://discord.gg/8eZfFWhczz) · [Changelog](changelog.md) · [Contribute](CONTRIBUTING.md)

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
| 05 | [OS Installation](05-os-installation.md) | Bazzite, CachyOS, Fedora, Arch, Debian, Ubuntu |
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
| **CPU** | 6× Zen 2 @ ~3.5 GHz (up to 4 GHz via SMU OC) |
| **GPU** | 24 RDNA 2 CUs (up to 40 unlockable), 1500–2300 MHz |
| **Performance** | Stock: RX 6600–6600 XT level. 40 CU: RX 6700 / GTX 1080 Ti level |
| **Memory** | 16 GB GDDR6 shared — 14 Gbps, 256-bit, ~448 GB/s |
| **Storage** | 1× M.2 2280 (PCIe 2.0 x2 — ~1 GB/s max, don't overspend) |
| **Display** | 1× DisplayPort 1.4 (no HDMI — passive adapter ~$5) |
| **Network** | 1× Gigabit Ethernet (no WiFi — USB adapter needed) |
| **USB** | 2× USB 3.0 + 2× USB 2.0 |
| **TDP** | 220W typical, 235W peak gaming, 250–320W Furmark |
| **OS** | Linux only — Bazzite, CachyOS, Fedora 43+, Arch, Debian |

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
10. **No hardware video encode/decode** — VCN blocked by Sony (NOT fused off — research active)

---

## Performance

### Superposition Extreme 1080p (Leaderboard)

| Rank | CU | Score | Config | User |
|------|-----|-------|--------|------|
| #1 | 40 | 5900 | — | gennro |
| #1 | 24 | 4713 | 2530 MHz GPU, 4175 MHz CPU, liquid | nexgen3d |

### Furmark VK 1080p (40 CU Top)

| FPS | Config | User |
|-----|--------|------|
| 153 | 2150 MHz, 990 mV, 79°C | essdee4336 |
| 150 | 2300 MHz, 85°C, 288W | big_trov |

See [07 — Game Benchmarks](07-game-benchmarks.md) for 60+ community-tested games.

---

## Join the Community

- **[BC250 Community Discord](https://discord.gg/8eZfFWhczz)** — 3,500+ members, active daily
- **[elektricM Docs](https://elektricm.github.io/amd-bc250-docs/)** — source-of-truth documentation (33+ pages)
- **[bc250-collective](https://github.com/bc250-collective)** — ACPI fix, SMU OC, governor

---

## What's New

**June 2026:** Black Myth: Wukong benchmark (edges RX 6700) · Binary search artifact hunting · Live-manager stock WGP disabling · OCP power limit documented · VCN confirmed NOT fused off (partial decode) · Kernel 6.19.x recommended · Mesa 26.x standard

**May 2026:** CU Live Manager (toggle 40 CUs without kernel patch) · Cyberpunk 2077 38 CU record (matches RTX 3060) · BIOS P4.00 discovered · AIOs confirmed (Thermalright Aqua Elite 240) · Micro-Fit power mod · Dell DA2 220W undervolted success · Mesa 26 + VRR on CachyOS/Bazzite

---

## How This Guide Is Maintained

Updated continuously from BC-250 Discord community data using a semi-automated pipeline: export → RAG indexing → audit → cross-reference → edit → commit. Every claim verified against [elektricM docs](https://elektricm.github.io/amd-bc250-docs/) and Discord exports.

---

*Unofficial — not endorsed by AMD or any community. Prices change often, verify before buying. [Changelog](changelog.md) · [Contribute](CONTRIBUTING.md) · [Discord](https://discord.gg/8eZfFWhczz)*
