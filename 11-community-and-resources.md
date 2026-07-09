# 11 -- Community & Resources

> The BC-250 community is active and growing. Here is where to find help, share builds, and stay updated.

---

## Primary Documentation

| Resource | URL | Notes |
|----------|-----|-------|
| **elektricM Docs** (most comprehensive) | https://elektricM.github.io/amd-bc250-docs/ | 33+ pages, searchable, community-maintained | [confirmed: @bishopahre, 04/06/2026]
| **mothenjoyer69 Docs** (original) | https://github.com/mothenjoyer69/bc250-documentation | Hardware pinouts, specifications |
| **vietsman Docs** (setup scripts) | https://github.com/vietsman/bc250-documentation | Automated setup scripts | [confirmed: @vietsman, 14/05/2025]
| **BC-250.info** | https://www.bc250.info/ | Quick reference site | [confirmed: @arthurdept44s4_13234, 18/04/2026]
| **This guide** (Revised) | `/Revised/` | Restructured from community data |

---

## GitHub Repositories

| Repository | Description |
|------------|-------------|
| [elektricM/amd-bc250-docs](https://github.com/elektricM/amd-bc250-docs) | Main documentation (98 commits, 85 stars -- need confirmation) |
| [bc250-collective](https://github.com/bc250-collective) | ACPI fix, SMU OC tool, and more |
| [bc250-collective/bc250-acpi-fix](https://github.com/bc250-collective/bc250-acpi-fix) | SSDT tables for CPU C-States (P-States experimental per repo README) |
| [bc250-collective/bc250_smu_oc](https://github.com/bc250-collective/bc250_smu_oc) | CPU SMU overclocking tool (4 GHz+) |
| [filippor/cyan-skillfish-governor](https://github.com/filippor/cyan-skillfish-governor) | GPU governor (original repo, SMU + TT branches) |
| [bc250-collective/cyan-skillfish-governor](https://github.com/bc250-collective/cyan-skillfish-governor) | GPU governor (community fork, v0.4.0+ adds CPU-based memory clock control) |
| [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock) | 40 CU unlock kernel patch (legacy) |
| [WinnieLV/bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) | 40 CU live manager — no kernel patch needed. Interactive TUI (UMR-based) |
| [ZEROAESQUERDA/BC250-windowsDriverTest](https://github.com/ZEROAESQUERDA/BC250-windowsDriverTest) | Windows display driver experiment for BC-250 (WIP, untested) |
| [GreatApo/bc250-40cu-unlock](https://github.com/GreatApo/bc250-40cu-unlock) | 40 CU unlock fork with corrected CU masking docs |
| [TuxThePenguin0/bc250-bios](https://gitlab.com/TuxThePenguin0/bc250-bios) | Modded BIOS files | [confirmed: @dznuts, 13/01/2026]
| [NexGen-3D-Printing/SteamMachine](https://github.com/NexGen-3D-Printing/SteamMachine) | Steam Machine cases + setup scripts | [confirmed: @nexgen3d, 11/12/2025]
| [kenavru/BC-250](https://github.com/kenavru/BC-250) | EFI flash tool (no hardware programmer needed) | [confirmed: @kitsunechan7118, 21/07/2025]
| [Fred78290/nct6687d](https://github.com/Fred78290/nct6687d) | lm-sensors monitoring driver + PWM fan control | [confirmed: elektricM docs]
| [ZEROAESQUERDA/PS5GPU-BC250](https://github.com/ZEROAESQUERDA/PS5GPU-BC250) | GUI GPU controller | [confirmed: @tom97br, 07/03/2026]
| [vietsman/bc250-documentation](https://github.com/vietsman/bc250-documentation) | Setup scripts (Bazzite/Fedora/Ubuntu) | [confirmed: @vietsman, 22/05/2025]
| [mosfetparty/bc250-psu-adapter](https://github.com/mosfetparty/bc250-psu-adapter) | ATX PSU control adapter — wiring diagrams + 3D models |
| [PetteriLah/BC-250-PC-Remote-Control](https://github.com/PetteriLah/BC-250-PC-Remote-Control) | ESP32 remote PSU controller |
| [redbeard1083/bc250-toolkit](https://github.com/redbeard1083/bc250-toolkit) | CachyOS setup toolkit |
| [safwyls/BC-250_ATXCase](https://github.com/safwyls/BC-250_ATXCase) | ATX case design for BC-250 |
| [dyllan500/bazzite-amd-hdmi-kde](https://github.com/dyllan500/bazzite-amd-hdmi-kde) | VRR fixes for Bazzite KDE |
| [tdakhran/wl-ambilight](https://github.com/tdakhran/wl-ambilight) | Wayland Ambilight project |
| [jurkovic-nikola/OpenLinkHub](https://github.com/jurkovic-nikola/OpenLinkHub) | Open source fan/RGB controller hub |
| [gennro/bc250-toolkit](https://github.com/gennro/bc250-toolkit) | CachyOS 40CU unlock + governor automation toolkit |
| [bangstk/Vulkan_NullVRS](https://github.com/bangstk/Vulkan_NullVRS) | Vulkan layer that nullifies VRS commands -- fixes 640x480 rendering |
| [onemorecap/bc-250-sleeve-adapter](https://github.com/onemorecap/bc-250-sleeve-adapter) | 120mm fan adapter for stock heatsink |
| [isaacalvex/BC-250-Custom-Case](https://github.com/isaacalvex/BC-250-Custom-Case) | Alternative 3D-printable enclosure |
| [eabarriosTGC/BC250--ARCH](https://github.com/eabarriosTGC/BC250--ARCH) | Arch Linux automated setup script |
| [pnbarbeito/bc250-arch](https://github.com/pnbarbeito/bc250-arch) | Arch Linux setup with governor + 40 CU unlock |
| [Magnap/cyan-skillfish-governor](https://github.com/Magnap/cyan-skillfish-governor) | SMU governor Debian/Ubuntu package -- upstream for Debian builds |
| [Keshas-dev/AMD-BC-250-Windows-Driver](https://github.com/Keshas-dev/AMD-BC-250-Windows-Driver) | Windows display driver for BC-250 (WIP, untested) |
| [gottmoz/BC-250-Windows-graphics-driver](https://github.com/gottmoz/BC-250-Windows-graphics-driver) | Windows graphics driver experiment (WIP, untested) |
| [bc250-collective/SomnacinDumper-CPUCoreMod](https://github.com/bc250-collective/SomnacinDumper-CPUCoreMod) | CPU core unlock mod tool |
| [bc250-collective/amd_smu_reverse_engineering](https://github.com/bc250-collective/amd_smu_reverse_engineering) | SMU reverse engineering for BC-250 / PS5 |
| [NeOdYmS/bazzite-bc250-toolkit](https://github.com/NeOdYmS/bazzite-bc250-toolkit) | Bazzite-specific setup toolkit |
| [fanoush/bc250_memcfg](https://github.com/fanoush/bc250_memcfg) | Memory timing configuration tool |
| [katzzero/250mon](https://github.com/katzzero/250mon) | Lightweight hardware monitor |
| [suapapa/rusty-bc250-atx](https://github.com/suapapa/rusty-bc250-atx) | ATX PSU power control (Rust) |
| [Koloses/Solarflare](https://github.com/Koloses/Solarflare) | Moonlight/Sunshine fork with Pyrowave for BC-250 |
| [Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script](https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script) | UEFI firmware menu script |
| [tmghd272/bc250-toolkit-lite](https://github.com/tmghd272/bc250-toolkit-lite) | Lighter toolkit variant |
| [thelamer/bc250-ollama-openwebui](https://github.com/thelamer/bc250-ollama-openwebui) | Ollama + OpenWebUI setup guide |
| [keyboardspecialist/bc250-steamos](https://github.com/keyboardspecialist/bc250-steamos) | SteamOS setup for BC-250 |
| [rpf16rj/bc250-steamos-real-toolkit](https://github.com/rpf16rj/bc250-steamos-real-toolkit) | Real SteamOS toolkit |
| [akandr/bc250](https://github.com/akandr/bc250) | Ollama + Vulkan inference guide for BC-250 |
| [mix3d/bc250-perf-profile-switcher](https://github.com/mix3d/bc250-perf-profile-switcher) | Performance profile switcher |
| [cachenetics/bc250-nixos](https://github.com/cachenetics/bc250-nixos) | NixOS configuration for BC-250 |
| [cachenetics/project-ariel](https://github.com/cachenetics/project-ariel) | Project Ariel |
| [ded811/BC250-Power-Adapter](https://github.com/ded811/BC250-Power-Adapter) | BC-250 power adapter design |
| [dexikdex/ESP32-BC250-LOP_PSU-PowerON-Xbox](https://github.com/dexikdex/ESP32-BC250-LOP_PSU-PowerON-Xbox) | ESP32 LOP PSU power-on controller |
| [tmghd272/bc250-batocera-tools](https://github.com/tmghd272/bc250-batocera-tools) | Batocera Linux tools for BC-250 |
| [peterdk31/bc250_ws2812b_controller](https://github.com/peterdk31/bc250_ws2812b_controller) | WS2812B LED controller for BC-250 | — upstream for Debian builds |

---

## Discord Community

- **Server:** [BC250 Community Discord](https://discord.gg/8eZfFWhczz)
- **Channels:**
- `#bc250-chat` -- general discussion [confirmed: @Discord]
  - `#benchmarks` -- game performance sharing | [confirmed: @odinforrest, 10/04/2026]
  - `#help-thread` -- troubleshooting | [confirmed: @mothenjoyer69, 27/01/2025]
- `#bc250-flex-chat` -- build showcases [confirmed: @codyrainy, 30/05/2026]
- `#bc250-resources` -- shared resources [confirmed: @deathstalkerjr, 19/11/2025]
- **Members:** 3,500+ | **Messages:** 9,716 technical messages (elektricM docs)

Note: mkdocs.yml contains a different invite code (`discord.com/invite/uDvkhNpxRQ`) -- the README link is used here as the primary source.

---

## Useful Hashtags for Searching

When searching for help, try these identifiers:
- `#bc250` or `#amd-bc250`
- `#cyan-skillfish`
- `#bazzite`
- `#BC250Community`

---

## Timeline -- Key Milestones

| Date | Event |
|------|-------|
| Oct 2024 | First BC-250 boards appear on eBay/AliExpress (~$50-80) | [confirmed: @david_manigo, 16/11/2025]
| Dec 2024 | BC-250 Community Discord launches | [confirmed: @Discord]
| Feb 2025 | KDE RDSEED fix lands in kernel -- KDE becomes usable | [confirmed: @astrocast, 08/01/2026]
| May 2025 | **Mesa 25.1 released** -- official Cyan Skillfish GPU support (HUGE milestone) |
| May 2025 | vietsman's one-click Bazzite installer published | [confirmed: @hahahahahhaha3733, 12/04/2026]
| Jul 2025 | Patched Bazzite fork with GPU OC (2230 MHz) by filippor | [confirmed: @filippor, 29/07/2025]
| Aug 2025 | COPR repository launches -- one-command governor install | [confirmed: @mothenjoyer69, 13/11/2025]
| Sep 2025 | GPU frequency patch lands in official Bazzite | [confirmed: @filippor, 28/08/2025]
| Nov 2025 | elektricM documentation site launches (33+ pages) | [confirmed: @dantistnfs, 12/05/2026]
| Dec 2025 | CPU SMU overclocking tool released (4 GHz achieved!) | [confirmed: @big_trov, 29/01/2026]
| Jan 2026 | cyan-skillfish-governor-smu v0.4.0 released (SMU-based, no kernel patch) | [confirmed: @Discord]
| Mar 2026 | All docs updated to latest state |
| May 2026 | VRR working on Bazzite Deck via custom kernel patch image (fforduck) | [confirmed: @fforduck, 14/04/2026]
| May 2026 | VCN partial decode achieved via SMU poking (holde, Angablade) - active research |

---

## Price History (BC-250 Board)

| Period | Price Range | Trend |
|--------|-------------|-------|
| Late 2024 | $50-80 | Low (mining surplus) | [confirmed: @david_manigo, 16/11/2025]
| Mid 2025 | $80-100 | Rising | [confirmed: @Discord]
| Oct 2025 | $100-130 | YouTube coverage increased demand | [confirmed: @dapping, 20/03/2026]
| Early 2026 | $150-200+ | Current -- still climbing | [confirmed: @dartzon, 10/06/2026]
| May 2026 | ~$130-140 | Some deals at $130-140, trending up | [confirmed: @Discord]

> Prices continue to rise as supply dwindles and demand grows from the gaming community. Expect $150-200+ in active listings. [confirmed: @iambryan_x1, 24/01/2026]

---

## YouTube Coverage

| Creator | Period | Notes |
|---------|--------|-------|
| Budget Builds Official | Oct 2025 | First major coverage -- prices started climbing | [confirmed: @cliff_86, 29/11/2025]
| oldlamer | Late 2025 | Most technically accurate guides | [confirmed: @Discord]
| CraftComputing | Late 2025 | Early coverage, some buggy results | [confirmed: @Discord]
| ToastyBros | Dec 2025 | Criticized for not using governor/OC [confirmed: @selectivelygood_16010, 03/01/2026]
| TechDweeb | Jan 2026 | ChimeraOS coverage | [confirmed: @Discord]
| NexGen3D | Feb 2026 | Case design channel | [confirmed: @nexgen3d, 11/12/2025]

---

## Contributing

Found a solution to a problem? Help others by adding it to the documentation.

**Easy way:** Click "Edit on GitHub" on any page of the [elektricM docs](https://github.com/elektricM/amd-bc250-docs) and submit a pull request.

**What is needed:**
- Tested hardware configurations
- Game compatibility reports
- Troubleshooting solutions
- Distribution-specific setup steps
- Fixes for outdated information

---

## Complete Index of Revised Files

| # | File | Description |
|---|------|-------------|
| 01 | [Hardware Specifications](01-hardware-specs.md) | Board specs, APU details, connectors |
| 02 | [BIOS & Firmware](02-bios-and-firmware.md) | Flashing guides, VRAM config, component map |
| 03 | [Power Supply Guide](03-power-supply-guide.md) | All PSU options with verified specs & prices |
| 04 | [Cooling Guide](04-cooling-guide.md) | Heatsink mods, fans, thermal interface, temps |
| 05 | [OS Installation](05-os-installation.md) | Step-by-step for every supported distro |
| 06 | [GPU Governor](06-gpu-governor.md) | Governor options, OC, tuning, benchmarks |
| 07 | [Game Benchmarks](07-game-benchmarks.md) | Community-tested FPS data for 60+ games |
| 08 | [Display & Audio](08-display-and-audio.md) | DP/HDMI, audio solutions, cable guide |
| 09 | [WiFi & Peripherals](09-wifi-and-peripherals.md) | Adapters, storage, accessories |
| 10 | [Troubleshooting](10-troubleshooting.md) | Error fixes, debugging commands |
| 11 | [Community & Resources](11-community-and-resources.md) | Links, Discord, timeline, credits |
| 12 | [AI Inference & LLMs](12-ai-inference.md) | llama.cpp, Ollama, Stable Diffusion, ROCm status |
| 13 | [Case Mods & Custom Enclosures](13-case-mods.md) | Community case designs, commercial sources, 3D-printable files |

---

*This revised documentation was compiled from the original resume files, 9,716 Discord messages (elektricM docs), the elektricM/amd-bc250-docs repository (98 commits, 85 stars -- need confirmation), and verified against current internet sources (March 2026). All errors from the original documents have been corrected.*