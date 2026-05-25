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
9. **ACPI fix recommended** -- SSDT tables enable CPU C-States (idle power) and P-States (frequency scaling 800-3200 MHz). Confirmed working on kernel 6.19.8. Note: repo README says P-States may not work on all boards. ([bc250-acpi-fix](https://github.com/bc250-collective/bc250-acpi-fix))
10. **VRAM chips have no temperature sensor** -- ensure backplate airflow

---

## Quick Shopping

| Item | Recommended | Where |
|------|-------------|-------|
| BC-250 Board | Any BIOS P2.00-P5.00 | AliExpress, eBay |
| PSU (Best Value) | FSP500-30AS Flex ATX 500W, 80+ Platinum | eBay -- search `389522369783` (essdee4336) |
| Fan | Arctic P12 Max / P12 Pro 120mm (3-pack or 5-pack) | Amazon |
| Thermal Pad (APU) | PTM7950 Phase Change Pad | Amazon B0DHRR78H7 (need confirmation) |
| Thermal Pads | 1.5 mm front, 2.0 mm back | Amazon multi-pack |
| Display Cable | Passive DP-to-HDMI | Amazon / AliExpress ~$2 |
| WiFi | TP-Link Archer TX10UB Nano (WiFi 6 + BT 5.3) | Amazon B0DZCC95G6 (need confirmation) |
| GPU Governor | cyan-skillfish-governor-smu | COPR / AUR |

---

*Last updated: Based on community data through May 2026. Prices and availability change frequently -- verify before purchasing.*

---

## How This Guide Is Maintained

This documentation is updated continuously from community Discord activity using a semi-automated pipeline:

1. **Export** — New Discord messages are exported via DiscordChatExporter
2. **Index** — A local RAG vector database (ChromaDB + sentence-transformers) indexes all exports and reference docs
3. **Audit** — New exports are searched for benchmarks, corrections, tools, crash data, and other updates
4. **Cross-reference** — Every claim is verified against elektricM source-of-truth docs and existing documentation
5. **Update** — Files are edited with attributions, uncertainty marked `(need confirmation)`, and a changelog entry is logged
6. **Commit** — Changes are committed to `github.com/katzzero/bc250-community-guide`

---

## Latest Additions (May 2026)

- **40 CU Unlock** — [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock). Runtime unlock (no kernel patch), 1.61x compute scaling, CU health testing (duggasco, big_trov, filippor, essdee4336).
- **Voltage Wall & OCP Analysis (big_trov)** — Two limit curves intersect at ~2200 MHz at 40 CU. OCP hard lock at 2400 MHz requires power cable pull. Secondary power limit at 1850-2200 MHz.
- **Governor v0.4.0** — CPU-based memory clock control, idle power tests (big_trov: 40 CU = 70W idle; pops1cl: 64W downclocked).
- **Game Benchmarks** — dznuts 5300 Superposition (38 CU), Death Stranding 2 (36 CU@1440p+FG=60), S.T.A.L.K.E.R. 2 (110-120 with FG), PICO upscaler.
- **Mesa 26** — GTA V Enhanced fixed; shipped in CachyOS with RT/perf improvements.
- **VRR** — CachyOS native, Bazzite custom image confirmed. Cheap Aliexpress DP>HDMI adapters recommended.
- **Superposition Leaderboard** — 24 CU (nexgen3d 4713) and 40 CU (gennro ~5900, big_trov 5759).
- **Cooling** — Thermalright Peerless Assassin 120 with 3D-printed bracket, GPU backplate cooler (dartzon).
- **PS5 40 CU Patch Confirmed** — BC-250 unlock patch works on PS5 Linux (gennro).
- **CPU Core Unlock Research** — duggasco/mrfrakes researching extra CPU cores via PSP/decompiled bootrom.
