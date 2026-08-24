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
| [bc250-collective/amd_smu_reverse_engineering](https://github.com/bc250-collective/amd_smu_reverse_engineering) | SMU firmware reverse engineering — Ghidra scripts, message tables, BIOS extraction tools | [ded811, big_trov, keroppl_wizard, Jul 2026]
| [bc250-collective/bc250_smu_oc](https://github.com/bc250-collective/bc250_smu_oc) | CPU SMU overclocking tool (4 GHz+) |
| [filippor/cyan-skillfish-governor](https://github.com/filippor/cyan-skillfish-governor) | GPU governor (original repo, SMU + TT branches; `fix-freq = true` option for 8-core GPU clock reporting, commit `be9537f` Aug 2026) |
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
| [mosfetparty/bc250-psu-adapter](https://github.com/mosfetparty/bc250-psu-adapter) | ATX PSU control adapter (pilimmm) — plug-and-play PS_ON board for FSP500 + 24-pin ATX, [mosfet.party](https://mosfet.party) |
| [PetteriLah/BC-250-PC-Remote-Control](https://github.com/PetteriLah/BC-250-PC-Remote-Control) | ESP32 remote PSU controller — PS5 DualSense BLE wake, web interface (wisserbasser) |
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
| [bc250-collective/SomnacinDumper-CPUCoreMod](https://github.com/bc250-collective/SomnacinDumper-CPUCoreMod) | CPU core unlock mod tool (WIP, unconfirmed — requires Pi Pico 2 hardware) |
| [bc250-collective/amd_smu_reverse_engineering](https://github.com/bc250-collective/amd_smu_reverse_engineering) | SMU reverse engineering for BC-250 / PS5 (research) |
| [leafyjerk/BC-250-CPU-Core-Map](https://github.com/leafyjerk/BC-250-CPU-Core-Map) | Read-only CPU core layout diagnostic (does not unlock anything) |
| [NeOdYmS/bazzite-bc250-toolkit](https://github.com/NeOdYmS/bazzite-bc250-toolkit) | Bazzite-specific setup toolkit |
| [fanoush/bc250_memcfg](https://github.com/fanoush/bc250_memcfg) | Memory configuration tool — set VRAM size and timings from Linux (works with stock P3.00/P5.00) |
| [katzzero/250mon](https://github.com/katzzero/250mon) | Lightweight hardware monitor for BC-250 — temperature, frequency, power stats |
| [suapapa/rusty-bc250-atx](https://github.com/suapapa/rusty-bc250-atx) | ATX PSU power control (Rust) |
| [Koloses/Solarflare](https://github.com/Koloses/Solarflare) | Moonlight/Sunshine fork with Pyrowave for BC-250 |
| [Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script](https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script) | Interactive UEFI flashing script — automated BIOS backup + modded P3.00 (incl. 8-core unlock BIOS) flash with themed menus. **Release v0.5.0** (Aug 2026) — prerequisite: "Deploy only on AMD BC-250 platforms verified 100% stable with all 8 CPU silicon cores active under legacy validation methods" |
| [tmghd272/bc250-toolkit-lite](https://github.com/tmghd272/bc250-toolkit-lite) | Lighter toolkit variant |
| [tmghd272/bc250-custom-bios-logo](https://github.com/tmghd272/bc250-custom-bios-logo) | BC250 BIOS boot logo theme — AMI OEM "ChangeLogo.exe" for DIY mods |
| [tmghd272/bc250-custom-overlays](https://github.com/tmghd272/bc250-custom-overlays) | Custom overlays/logos (Turzx, MangoHud presets, BIOS) |
| [thelamer/bc250-ollama-openwebui](https://github.com/thelamer/bc250-ollama-openwebui) | Ollama + OpenWebUI setup guide |
| [keyboardspecialist/bc250-steamos](https://github.com/keyboardspecialist/bc250-steamos) | SteamOS setup for BC-250 |
| [tmghd272/bc250-batocera-tools](https://github.com/tmghd272/bc250-batocera-tools) | Batocera Linux tools for BC-250 |
| [rpf16rj/bc250-steamos-real-toolkit](https://github.com/rpf16rj/bc250-steamos-real-toolkit) | Real SteamOS toolkit — 40 CU + 8-core unlock surviving cold boot and SteamOS updates without a BIOS flash. **v1.3.0** adds Dolby Digital 5.1 via HDMI/eARC (option 13, Aug 2026) |
| [akandr/bc250](https://github.com/akandr/bc250) | Ollama + Vulkan inference guide for BC-250 |
| [mix3d/bc250-perf-profile-switcher](https://github.com/mix3d/bc250-perf-profile-switcher) | Decky Loader plugin — GPU clock slider + telemetry overlay in Quick Access Menu |
| [cachenetics/bc250-nixos](https://github.com/cachenetics/bc250-nixos) | NixOS configuration for BC-250 |
| [cachenetics/project-ariel](https://github.com/cachenetics/project-ariel) | Project Ariel |
| [ded811/BC250-Power-Adapter](https://github.com/ded811/BC250-Power-Adapter) | BC-250 J2000/J2001 Micro-Fit power adapter PCB (UNTESTED — waiting for fab boards, build at own risk) |
| [RescueMei/BC250-DXE-SMU-Core-Unlock](https://github.com/RescueMei/BC250-DXE-SMU-Core-Unlock) | Patched BIOS (DXE/SMU) that unlocks all 8 CPU cores — permanent, needs external programmer for recovery (Jul 2026) |
| [RescueMei/BC250-DXEv2-BIOSMOD](https://github.com/RescueMei/BC250-DXEv2-BIOSMOD) | MeiMeiDXE V2.1 BIOS mod — 8-core unlock toggle + ACPI options in BIOS menu, themed boot images, auto cold boot via RTC (compatible boards with standby power) (Aug 2026) |
| [Hexxeh/bc250-efi-core-unlock](https://github.com/Hexxeh/bc250-efi-core-unlock) | EFI boot shim that unlocks extra CPU cores without BIOS modification (semi-permanent, Jul 2026) |
| [rw-r-r-0644/bc250-core-unlock](https://github.com/rw-r-r-0644/bc250-core-unlock) | Original CPU core unlock Python script — SMU mailbox, userspace, no BIOS flash (Jul 2026) |
| [movacx/bc250-control-center](https://github.com/movacx/bc250-control-center) | Linux control center for BC-250 — monitoring, GPU SMU control, CPU OC, fan PWM, 40 CU tools + one-click 8-core unlock (Aug 2026) |
| [F5GO/bc250-cu-live-manager-SteamOS](https://github.com/F5GO/bc250-cu-live-manager-SteamOS) | CU live manager variant for real SteamOS |
| [SamSkjord/ubazzite600](https://github.com/SamSkjord/ubazzite600) | TP-Link UB600 (RTL8761BU) Bluetooth fix for Bazzite / atomic Fedora via out-of-tree btusb rebuild |
| [Thunkar/bc250-esp32-switch](https://github.com/Thunkar/bc250-esp32-switch) | ESP32-C3 power switch — BLE controller wake, WiFi config portal, boot watchdog (ATX PSU) |
| [1mathp/ESP32C3-ATX-Blynk](https://github.com/1mathp/ESP32C3-ATX-Blynk) | ESP32-C3 remote power-on via Blynk app — works outside local network (Aug 2026) |
| [ProjectSomnacin/somnacin-hardware](https://github.com/ProjectSomnacin/somnacin-hardware) | Somnacin project hardware |
| [awalol/DS5Dongle](https://github.com/awalol/DS5Dongle) | Pico2W DualSense bridge — HD haptics, headset audio, wireless BT bridging |
| [djanice1980/DS5_Bridge](https://github.com/djanice1980/DS5_Bridge) | DS5 Bridge Linux/CachyOS port — PipeWire audio, audio-driven haptics, uinput chord injection |
| [bangstk/amd-bc250-docs](https://github.com/bangstk/amd-bc250-docs) | Community-driven documentation for AMD BC-250 (Cyan Skillfish) |
| [JustVugg/colibri](https://github.com/JustVugg/colibri) | Run GLM-5.2 (744B MoE) on 25GB-RAM machine — pure C, zero deps, experts streamed from disk |
| [Umio-Yasuno/amdgpu_top](https://github.com/Umio-Yasuno/amdgpu_top) | AMD GPU top — live GPU monitoring tool |
| [dexikdex/ESP32-BC250-LOP_PSU-PowerON-Xbox](https://github.com/dexikdex/ESP32-BC250-LOP_PSU-PowerON-Xbox) | ESP32_Relay X2 — Xbox BLE wake, sniper pairing, zombie-wake protection (LOP PSU) |
| [huzhekun/bt-dongle-with-pc-wake](https://github.com/huzhekun/bt-dongle-with-pc-wake) | Pi Pico 2W as BT dongle with controller wake (Linux, early stage) |
| [tmghd272/bc250-batocera-tools](https://github.com/tmghd272/bc250-batocera-tools) | Batocera Linux tools for BC-250 |
| [peterdk31/bc250_ws2812b_controller](https://github.com/peterdk31/bc250_ws2812b_controller) | WS2812B LED controller for BC-250 | — upstream for Debian builds |
| [GabriWar/bc250-core-cu-unlock](https://github.com/GabriWar/bc250-core-cu-unlock) | Linux SMU mailbox 0x98 unlock — 8 CPU cores + 40 CU, systemd unit, core test script, bundled 8-core BIOS + ACPI fix (Aug 2026) |
| [GabriWar/bc250-rocm-working](https://github.com/GabriWar/bc250-rocm-working) | Stable Diffusion on BC-250 via ROCm/HIP — kernel patches, rocBLAS gfx1013 kernels, runlist TLB flush fix, full investigation (Aug 2026) |
| [higorprado/bc250-8core-telemetry-report](https://github.com/higorprado/bc250-8core-telemetry-report) | 8-core SMU metrics layout — maps the per-core arrays that displace GPU clock reporting (Aug 2026) |
| [mendesrr/bc250-acpi-fix-updated-8c](https://github.com/mendesrr/bc250-acpi-fix-updated-8c) | 8-core ACPI tables (SSDT C-states extended to 16 threads) — required after CPU core unlock (Aug 2026) |
| [onlinermm/BC250-Telemetry](https://github.com/onlinermm/BC250-Telemetry) | VRM telemetry daemon + web dashboard — PMBus over I2C (per-rail voltage/current/power/temp), 2-wire hardware mod (Aug 2026) |
| [DryhoppedIPA/bc250-gfx1013-fix](https://github.com/DryhoppedIPA/bc250-gfx1013-fix) | Async compute queue (ACE) fix for GFX1013 — kernel + Mesa/RADV patches, +25% FPS (Aug 2026) |
| [dmorazasanchez/bc250-fsr4](https://github.com/dmorazasanchez/bc250-fsr4) | Experimental FSR 4 optimization for GFX1013 — Mesa/RADV INT8 dot-product fallback via i24 instead of broken native DP4A; FSR 4.1.1 shader dropped 64k→37k instructions, ~306k→104k throughput; "huge performance improvement" in Cyberpunk 2077 (Aug 2026) |
| [MastaG/linux-cachyos-bc250](https://github.com/MastaG/linux-cachyos-bc250) | CachyOS BC-250 kernel + Mesa repo — kernel-7.1 patches (audio, compute queue fix), updated Mesa, telemetry fixed at source in-kernel (`gpu_metrics`, `gpu_busy_percent`, real `freq1_input`). On this kernel, governor `fix-freq`/`fix-metrics` are redundant bind mounts (Aug 2026). |
| [e-tho/bc250-acpi-fix](https://github.com/e-tho/bc250-acpi-fix) | Unified ACPI fix — C1/C2 idle states, 8 P-state steps 800 MHz–3.2 GHz, stubs undefined methods, replaces broken idle table; works 6c and 8c on every BIOS (Aug 2026) |
| [lonewolf0622/BC250-Native-Mesh-Shaders-](https://github.com/lonewolf0622/BC250-Native-Mesh-Shaders-) | Native Mesh Shader support — V1 works for mesh-only games; V2 complete but unshipped pending Task Shader implementation ("on the verge of being complete", Aug 2026) |
| [rw-r-r-0644/bc250-smu-unlock](https://github.com/rw-r-r-0644/bc250-smu-unlock) | Fully arbitrary read/write and code execution on the BC-250 SMU — RPC-style patches from Python (Aug 2026); foundation of current VCN power-on research |
| [thelamer/bc250-lab-image](https://github.com/thelamer/bc250-lab-image) | Dedicated experiment image — v0.3.0 ships the SMU unlock plus rw_r_r_0644's power-on method as helpers for VCN research (Aug 2026) |
| [rpf16rj/steamos-led-wled](https://github.com/rpf16rj/steamos-led-wled) | DIY LED bar replica for BC-250 controlled from SteamOS Game Mode via WLED (Aug 2026) |

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
| Jul-Aug 2026 | 8-core CPU unlock (SMU mailbox exploit), 40 CU unlock, BIOS mods, gfx1013-fix — major performance unlocks |
| Aug 2026 | BIOS mod becomes the dominant 8-core method; ACPI fix extended to 16 threads; `fix-freq` governor option for 8-core GPU clock reporting |
| Aug 2026 | VCN 2.0.3 confirmed present and NOT fused off; power-path root cause identified (no `dpm_set_vcn_enable`); "VCN: The final boss" research thread opened (thelamer, Aug 14 2026) |
| Aug 2026 | rw_r_r_0644 achieves arbitrary code execution on the SMU at runtime (Cyan Skillfish only) — possible VCN power-up path (Aug 15 2026) |
| Aug 2026 | dmorazasanchez/bc250-fsr4 published — FSR 4 running on GFX1013 with i24 fallback (Aug 14 2026) |

---

## Price History (BC-250 Board)

| Period | Price Range | Trend |
|--------|-------------|-------|
| Late 2024 | $50-80 | Low (mining surplus) | [confirmed: @david_manigo, 16/11/2025]
| Mid 2025 | $80-100 | Rising | [confirmed: @Discord]
| Oct 2025 | $100-130 | YouTube coverage increased demand | [confirmed: @dapping, 20/03/2026]
| Early 2026 | $150-200+ | Current -- still climbing | [confirmed: @dartzon, 10/06/2026]
| May 2026 | ~$130-140 | Some deals at $130-140, trending up | [confirmed: @Discord]
| Aug 2026 | $150-200 (AliExpress) | Active listings: $166.54 US / AUD$211 AU (~$150); users report seeing $188–196 with occasional $166 flash listings [confirmed: @chu, @j0shm1lls, @alexxxor_, @dderps, 14-17/08/2026]

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