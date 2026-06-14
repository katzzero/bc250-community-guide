# BC-250 Unofficial Community Guide

> Unofficial community guide for the AMD BC-250 mining board repurposed as a budget gaming/desktop PC. Not an official community project — made by katzzero.

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
| 13 | [Case Mods & Custom Enclosures](13-case-mods.md) | Community case designs, commercial sources, 3D-printable files |

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
| **OS Support** | Linux only -- no official Windows GPU drivers. Unofficial WIP: [ZEROAESQUERDA/BC250-windowsDriverTest](https://github.com/ZEROAESQUERDA/BC250-windowsDriverTest) (untested) |

---

## Benchmark Leaders

| Category | Rank 1 | Score | Config | User |
|----------|--------|-------|--------|------|
| Superposition Extreme 1080p (24 CU) | 1 | 4713 pts | 2530 MHz GPU, 4175 MHz CPU, 1165 mV, liquid cooling | nexgen3d |
| Superposition Extreme 1080p (40 CU) | 1 | ~5900 pts | 40 CU | gennro |
| Furmark VK 1080p (40 CU) | 1 | 153 FPS | 2150 MHz, 990 mV, 79C, ~200W | essdee4336 |
| CPU Clock (24 CU) | 1 | 4175 MHz | — | nexgen3d |
| GPU Clock (24 CU) | 1 | 2530 MHz | 1165 mV | nexgen3d |

---

## Important Warnings

1. **No official Windows GPU drivers** -- Linux is required. Unofficial WIP: [ZEROAESQUERDA/BC250-windowsDriverTest](https://github.com/ZEROAESQUERDA/BC250-windowsDriverTest) (untested)
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
| Thermal Pad (APU) | PTM7950 Phase Change Pad | Amazon B0DHRR78H7 | [confirmed: @selectivelygood_16010, 11/12/2025]
| Thermal Pads | 1.5 mm front, 2.0 mm back | Amazon multi-pack |
| Display Cable | Passive DP-to-HDMI | Amazon / AliExpress ~$2 |
| WiFi | TP-Link Archer TX10UB Nano (WiFi 6 + BT 5.3) | Amazon B0DZCC95G6 | [confirmed: @walkjivefly, 29/01/2026]
| GPU Governor | cyan-skillfish-governor-smu | COPR / AUR |

---

*Last updated: Based on community data through May 2026. Unofficial — not endorsed by AMD or any community. Prices and availability change frequently -- verify before purchasing.*

---

## How This Guide Is Maintained

This guide is maintained by katzzero. It is updated continuously from community Discord activity using a semi-automated pipeline:

1. **Export** — New Discord messages are exported via DiscordChatExporter
2. **Index** — A local RAG vector database (ChromaDB + sentence-transformers) indexes all exports and reference docs
3. **Audit** — New exports are searched for benchmarks, corrections, tools, crash data, and other updates
4. **Cross-reference** — Every claim is verified against elektricM source-of-truth docs and existing documentation
5. **Update** — Files are edited with attributions, uncertainty marked `(need confirmation)`, and a changelog entry is logged
6. **Commit** — Changes are committed to `github.com/katzzero/bc250-unofficial-community-guide`

---

## Latest Additions (May 2026)

- **CU Live Manager (vinnijs.dev)** — [bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager). Toggle CUs on the fly, no kernel patch. TUI with vim keys, systemd persistence. Works on stock kernel.
- **40 CU: No kernel patch needed.** Use stock kernel + live manager. Start at 2000 MHz @ 980 mV. Stay below 1130 mV / 85°C.
- **Cyberpunk 2077 Record (dznuts)** — 38 CU, 2270 MHz GPU, 4050 MHz CPU: min FPS >60 at 1080p Ultra (no FSR). Matched RTX 3060. Memory OC gave +18.4% FPS boost.
- **Voltage Wall & OCP Analysis (big_trov)** — Two limit curves intersect at ~2200 MHz at 40 CU. OCP hard lock at 2400 MHz requires power cable pull.
- **BIOS P4.00 Discovered (faithy2386)** — Undocumented stock version, unstable. Dumped and preserved. Flash to P5.00 fixed.
- **AIOS Confirmed** — Thermalright Aqua Elite 240 V2/V4/V6 all working with 3D-printed AM4 mount. Multi-fan control via J4003 header (CoolerControl).
- **Micro-Fit Power Mod** — Onboard power ports as PCIe cable supplement (Old Lamer). Tested by community.
- **Dell DA2 PSU (hoodyracoon)** — Running 40 CU at 1700 MHz/3600 MHz undervolted on 220W 12V-only external PSU.
- **Mesa 26** — GTA V Enhanced fixed; shipped in CachyOS with RT/perf improvements.
- **VRR** — CachyOS native, Bazzite custom image confirmed. Cheap Aliexpress DP>HDMI adapters recommended.
- **AWG Cable Safety Table** — 16 AWG minimum verified; 18 AWG risky at 220W+ sustained; 22 AWG melts under load. Added to power guide with current/wattage per gauge.
- **WiFi Adapter Guide** — M.2 Key E slot compatibility (Intel AX210, AX200, AC-9260, Realtek, MediaTek), USB adapter options, driver requirements, antenna connector types.
- **Nylon Washer Warning (mzk10, .captainwasabi)** — Heatsink disassembly: 4 clear/black nylon washers under screw heads frequently lost. Reassembling without them causes gap → 90-100°C idle. Added to cooling guide.
- **ACPI Fix Controversy** — `bc250-acpi-fix` table debated: some report cosmetic cpufreq only (frequency doesn't actually change), others report instability. Verify with `grep MHz /proc/cpuinfo`.
- **DP Audio Fix (kernel 6.19.10+)** — New amdgpu DP audio implementation resolves audio-on-active-adapter issue. Older kernels: audio over active DP-HDMI adapters broken.
- **Spider-Man 2 OOM Crash** — Game crashes with out-of-memory on BC-250. No known fix — game allocator issue, not fixable via kernel parameters.
- **ttm.pages_limit Formula** — Documented calculation: `pages_limit = (GTT_size_bytes) / PAGE_SIZE`. Example: 14750 MB → 3776000 pages. Added to performance guide.
- **Fin Straightening Tools** — Catalogued: 3D printed fin straightener (Printables), HVAC nylon fin straightener (Amazon), Scooper tool (~$2), manual pliers method. Temperature impact: 5-10°C.
- **Mean Well LOP Series Expanded** — Added LOP-400-12 (400W), LOP-500-12 (500W), LOP-600-12 (600W) alongside existing 300W. Open frame, fanless on 300W/400W.
- **FSP500 vs Metalfish Fan Comparison** — FSP500: stock 40mm×20mm sleeve bearing ~8000 RPM, noticeable whine. Metalfish: quieter 40mm×10mm hydraulic bearing, modular braided cables.
- **Server PSU Noise Table** — HP DPS-800GB (~65 dBA), Delta DPS-750RB (~70 dBA), Bitmain APW3++ (~60 dBA, 220W idle), Dell 1U 750W (~55 dBA). Noise reduction options included.
- **PTM7950 Detail** — Phase-change pad requires thermal cycling to cure. Best performance option. Dedicated thread for size/thickness guidance.