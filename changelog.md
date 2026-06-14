# Changelog — V2 Corrections from Community Discord Data

This file documents every correction or update discovered by cross-referencing V2 documentation against live community Discord exports (bc250-chat, bc250-resources, bc250-flex-chat, benchmarks, and new May 2026 exports). Each item cites the community member who contributed the information.

---

## June 14, 2026 — Wiki Sync, AI Protocol Update, Missing Repos Added

### 1. Wiki Synced with Revised
- Copied updated CONTRIBUTING.md to wiki/ (removed obsolete Windows driver rule)
- Added 13-case-mods to Home.md Table of Contents
- Committed to wiki repo

### 2. AI_PROTOCOL.md Public Version Updated
- Added missing sections: README Sync Rule, Pre-Commit Review Rule, Post-Edit Quality Checklist, Track Record Rule
- Renumbered existing sections (6-7 → 10-11)
- Updated last modified date

### 3. Missing Repos Added to Community Page
- Added 5 undocumented repos to 11-community-and-resources.md: bc-250-sleeve-adapter, BC-250-Custom-Case, BC250--ARCH, bc250-arch, Magnap/cyan-skillfish-governor

---

## May 26, 2026 — Live CU Manager, Benchmarks, Tools

### 1. bc250-cu-live-manager — 40 CU Without Kernel Patch

**New finding:** vinnijs.dev released [bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) — interactive TUI to toggle CUs on the fly via UMR. No kernel patch needed. Works on stock kernel across all distributions. Auto-detects dri path (fixes Bazzite where index=1). Systemd persistence.

**Updated:** 02-bios-and-firmware.md, 05-os-installation.md, 06-gpu-governor.md, 11-community-and-resources.md, README.md.

### 2. Cyberpunk 2077 38 CU Record

**New finding:** dznuts achieved min FPS >60 at 1080p Ultra (no FSR) with 38 CU @ 2270 MHz GPU, 4050 MHz CPU, 1975 MT memory. Matched RTX 3060 level. Memory OC gave +18.4% min FPS boost.

**Updated:** 07-game-benchmarks.md, README.md.

### 3. BIOS P4.00 Discovered

**New finding:** faithy2386 found undocumented stock BIOS P4.00 on their board. Unstable — all 3D apps crash. Dumped via flashrom (confirmed no R/W protection). Flashing to modded P5.00 resolved. P5.00 caveats noted (rocksalt_, kilrah, pops1cl).

**Updated:** 02-bios-and-firmware.md.

### 4. CU Health & Artifact Detection

**New finding:** Live CU manager enables rapid artifact detection. Some bad CUs only manifest in games, not synthetic benchmarks (pm_me_kitsunemimi, meee). Dinkum crashes above 1700 MHz @ 40 CU (mikecmp). Doom: The Dark Ages needed +10 mV over stable settings (hojnikb).

**Updated:** 02-bios-and-firmware.md, 10-troubleshooting.md.

### 5. Cooling: AIOs Confirmed, Fan Control

**New finding:** Thermalright Aqua Elite 240 V2, V4, V6 all confirmed working (gennro, sousapro, telefragger). MSI AIO also used. Bykski custom waterblocks mentioned. Multi-fan control via J4003 header + CoolerControl documented (essdee4336).

**Updated:** 04-cooling-guide.md.

### 6. PSU: Micro-Fit Mod, Cable Safety

**New finding:** Old Lamer (YouTube) demonstrated onboard Micro-Fit 3.0 power ports as PCIe supplement. Tested by essdee4336. Melted cable photo evidence (capt.cat_13). Apevia PSU warning (steel wires). Dell DA2 220W running 40 CU undervolted (hoodyracoon).

**Updated:** 03-power-supply-guide.md.

### 7. 40 CU Voltage Guidance

**New finding:** Community consensus: start at 2000 MHz @ 980 mV (vinnijs.dev). Stay below ~1130 mV / 85°C (hojnikb). Silicon lottery varies widely (960-1060 mV for 2000 MHz). Even 1800 MHz @ 40 CU is faster than 24 CU @ 2400 MHz (essdee4336).

**Updated:** 06-gpu-governor.md.

### 8. OS Fixes

**New finding:** CachyOS pacman uses x86_64_v3 by default — fix via Architecture line in pacman.conf (graytl). Bazzite governor issues resolved by rebasing to bazzite:stable (zerosumpr). Hibernate broken on CachyOS (kernel bug — essdee4336, pops1cl).

**Updated:** 05-os-installation.md, 10-troubleshooting.md.

### 9. Rebrand: Unofficial Guide

Repository renamed to `katzzero/bc250-unofficial-community-guide`. All docs updated to reflect: unofficial, made by katzzero, not endorsed by any community.

**Updated:** README.md, CONTRIBUTING.md, all AI protocol files.

---

## HIGH Severity

### 1. VCN Status — V2 is Outdated

**V2 claim:** "No progress, the last person working on it disappeared."

**Community data shows:** Active work IS happening. Users Angablade and holde have poked the SMU to engage the VCN block and are getting partial results. The VCN block is confirmed NOT fused off.

| Evidence | Source | User |
|----------|--------|------|
| "Nothing actually stopping me from poking the SMU commands directly. Because I did it. And that made the registers for the VCN stop being dead registers" | bc250-chat part 331:155 | holde |
| "The driver did see the VCN present after I did that, but ffmpeg didn't return an expected result. I got ONE frame out of it and then ffmpeg crashed" | bc250-chat part 331:266 | holde |
| "Anga sent me over a test script that'll poke the SMU" | bc250-chat part 331:282 | holde |
| "SetSoftMaxVcn 0x4C, SetSoftMinVcn 0x4D" (SMU commands being tested) | bc250-chat part 323:252-253 | Unnamed |
| "neat, my results, active VCN, partially working decode with wrong output, frame encoding probably same" | bc250-chat part 344 | holde |
| "cyan-skillfish-governor-smu would be a good place to inject the correct commands to enable VCN" | bc250-chat part 323:440 | Unnamed |

**Action:** VCN section needs complete rewrite. Status: active research, partial decode achieved, not yet functional.

---

## MEDIUM Severity

### 2. Kernel Recommendations — 6.19.x is the Current Target

**V2 claim:** Recommends 6.18.18 LTS as the primary kernel.

**Community data shows:** No mention of 6.18.18 was found across all 839 export files. The community has moved to kernel 6.19.x, which contains important VRR and DP audio fixes.

| Evidence | Source | User |
|----------|--------|------|
| "All the good stuff that helps this device is already in mesa 26 and kernel 6.19" | bc250-chat part 336:277 | Unnamed |
| "kernel 6.19 has VRR fixes" | bc250-chat part 9:317 | Unnamed |
| "The latest testing release comes with the OGC 6.19.11 kernel. DisplayPort audio works" | bc250-chat part 329:868 | gennro |
| "Testing 6.19 with gpu patch and mesa-git" | bc250-chat part 201:260 | Unnamed |
| Broken kernel ranges confirmed: 6.15.0-6.15.6 and 6.17.8-6.17.10 | Multiple sources | Multiple |

**Action:** Update recommended kernel to 6.19.x. Keep 6.18 stable as fallback but note 6.19 has VRR and DP audio.

---

### 3. Mesa Version — 26 is Now Current

**V2 claim:** "Mesa 25.1+ minimum, 25.3.x recommended."

**Community data shows:** Mesa 26 is actively in use with significant performance improvements.

| Evidence | Source | User |
|----------|--------|------|
| "My Bazzite-deck image from last week is running mesa 26" | bc250-chat part 351:88 | Unnamed |
| "cachy is using the latest mesa 26 which has a lot of fixes and performance improvements in it" | bc250-chat part 350:899 | Unnamed |
| "gains with mesa 26 were no joke. In GTAV enhanced..." (from 3-5fps with RT to smooth) | bc250-chat part 262:860 | Unnamed |
| "We get a little more in Mesa 26 and a little from 6.19" | bc250-chat part 207:488 | Unnamed |
| Mesa-git packages at version "26.0.0_devel.215111" available | channel-export part 6915:15-16 | Chaotic AUR |

**Action:** Update recommendation from "25.3.x" to "26.x recommended, 25.1+ minimum."

---

### 4. VRR — Multiple Paths Now Available

**V2 claim:** Mentions only a custom Bazzite image for VRR.

**Community data shows:** At least four working approaches now exist.

| Evidence | Source | User |
|----------|--------|------|
| "yeah on cachyos VRR is working for me" | bc250-chat part 330:103 | Unnamed |
| "Tested CachyOS and can confirm VRR is working with the Ugreen 8k60hz DP to HDMI 2.1 adaptor" | bc250-chat part 330:301 | Unnamed |
| "VRR is working on the testing build for Bazzite. I use the deck build" | bc250-chat part 331:740 | Unnamed |
| "kernel 6.19 has VRR fixes" | bc250-chat part 349:257 | Unnamed |
| "there is a custom image of bazzite that pulls through the latest stable build but adds the AMD VRR patches" | new-export part 16:308-320 | fforduck |

**Action:** Expand VRR section to document all four approaches: (1) CachyOS native, (2) Bazzite testing branch, (3) custom Bazzite image, (4) kernel 6.19+.

---

## LOW-MEDIUM Severity

### 5. Idle Power Consumption — Range Slightly High

**V2 claim:** "Idle with governor: 65-85W." Also previously claimed 60-70W (Discord-sourced) and referenced perfprofile down to 48W.

**Community data shows:** Actual consensus is 60-70W with SMU governor. The 48W claim from resources is disputed as unverified.

| Evidence | Source | User |
|----------|--------|------|
| "my current idle is about 60W" (after changing SMU profile from 3 to 0) | bc250-chat part 337:418 | gennro |
| "stock ungoverned idle is about 80W, with the GPU governor it's about 40W" (contested claim) | channel-export part 478:19 | neggles |
| "without the patch board with proper fan will hover around 100W on idle, if you use patch, it will idle at 65W" | channel-export part 3822:26 | dantistnfs |
| "measured at the wall with a wattmeter the lowest I've ever gotten the board to idle is like 68 watts" | channel-export part 3767:15 | Unnamed |
| "claims of 45w are BS" | bc250-chat part 48:644 | NexGen-3D |
| "power draw lower than 65 watts has yet to be replicated by anyone in here" | bc250-chat part 12:291 | Unnamed |

**Action:** Refine idle power to "60-70W with SMU governor" (gennro, dantistnfs). Mark sub-60W claims as disputed (NexGen-3D). Add note about SMU profile tuning (profile 0 saves ~15W over profile 3, per gennro).

---

### 6. FSP500-30AS — Missing Caveats

**V2 claim:** 500W, 80+ Platinum. eBay search ID provided.

**Community data shows:** Missing important caveats.

| Evidence | Source | User |
|----------|--------|------|
| "the FSP500 only does 396w on the 12v rail" (not full 500W) | bc250-chat part 342:627 | gennro |
| "FSP500-30AS also commonly emits coil whine when theres no load" | bc250-chat part 105:195 | Unnamed |
| "yeah it took my FSP500 out" (killed by sustained high draw) | bc250-chat part 329:111 | gennro |
| "I was pushing upwards up 350w through that single pcie 8 pin and never melted a wire, but killed the PSU" | bc250-chat part 342:685 | gennro |

**Action:** Add note: 12V rail is 396W (not 500W), known coil whine at no-load, can fail under sustained high draw (gennro).

---

## LOW Severity

### 7. DP Audio Fix — TheFloW Attribution Missing

**V2 claim:** Fixed in Linux 6.19.10+. Bazzite needs custom kernel.

**Community data shows:** Fix was contributed by TheFloW (PS5 Linux developer). Not 100% perfect for all configs.

| Evidence | Source | User |
|----------|--------|------|
| "the guy that added PS5 support to mesa... he says he also fixed displayport audio" | bc250-chat part 304:645 | fanoush_ |
| "We got working dp (and active dp hdmi adapters) audio before GTA 6 thanks to TheFloW" | bc250-chat part 292:807 | Unnamed |
| "it's mostly fixed in newer kernels although audio desynchronization can occur" | bc250-chat part 335:656 | Unnamed |
| "And I still have a hiccup in audio on my 4k TV approximately every 38 seconds (with the active adapter, passive works without issue)" | bc250-chat part 329:906 | gennro |

**Action:** Add attribution to TheFloW. Note that active DP-HDMI adapters may still have intermittent audio issues (gennro).

---

### 8. Sound Blaster Play! 4 — Not Community-Adopted

**V2 claim:** Recommends Creative Sound Blaster Play! 4, ASIN B08T9LM3LM.

**Community data shows:** Zero mentions of Play! 4 or that ASIN across all exports. Community standardizes on generic USB audio dongles.

| Evidence | Source | User |
|----------|--------|------|
| Sabrent USB audio adapter commonly used | bc250-chat part 286:803 | Unnamed |
| UGREEN USB Audio Adapter used | bc250-chat part 59:136 | Unnamed |
| Apple 3.5mm dongle used | bc250-resources 1471566474446372977:334 | Unnamed |
| "just using a usb audio dac and its fine" | bc250-chat part 53:849 | Unnamed |

**Action:** Keep Play! 4 as one option but note it's not community-verified. List commonly-used community options: Sabrent, UGREEN, Apple dongle.

---

### 9. Elden Ring — CachyOS Advantage

**V2 claim:** 45-51 FPS, CPU bottleneck.

**Community data shows:** One user reports +20% FPS on CachyOS vs Bazzite.

| Evidence | Source | User |
|----------|--------|------|
| "+20% fps in Elden Ring in favour of Cachy" | bc250-chat part 350:873 | Unnamed |
| "with pretty aggressive OCs im between 45-55ish fps 1080p mostly low settings" | bc250-chat part 265:571 | Unnamed |
| "FPS remains the same when I lower the graphics to minimum" | bc250-chat part 265:777 | Unnamed |

**Action:** Add note about distro-specific performance (CachyOS may give +20% in CPU-bound games like Elden Ring).

---

### 10. New Game Performance Data (Not in V2)

| Game | Reported FPS | Source | User |
|------|-------------|--------|------|
| Forza Horizon 5 | 40-100 FPS | bc250-chat part 269:212,220 | Unnamed |
| Stellar Blade | 50-80 FPS at 1440p | bc250-chat part 351:116, part 24:659 | fforduck, Unnamed |
| Helldivers 2 | 40-60 FPS | bc250-chat part 7:379 | Unnamed |
| Valheim | 40-80 FPS (mitigations=off) | bc250-chat part 87:737 | Unnamed |
| GTA V Enhanced (RT) | Smooth on Mesa 26 | bc250-chat part 262:860 | Unnamed |
| Oblivion Remaster | 30-75 FPS (3440x1440, FG) | bc250-chat part 311:156,208,270 | Unnamed |
| RDR2 | 31-80 FPS across presets | bc250-chat part 340:928 | Unnamed |
| Marvel Rivals | 100-190 FPS | bc250-chat part 350:693 | Unnamed |
| God of War 3 (RPCS3) | ~42 FPS at 1080p | bc250-chat part 156:798 | Unnamed |

**Action:** Add these benchmarks to V2 game benchmarks with user attribution.

---

## Confirmed Correct (No Change Needed)

| Topic | V2 Claim | Community Confirmation |
|-------|----------|----------------------|
| GPU max clock | 2000 stock / 2230 patched | Confirmed, well-replicated |
| BIOS P3.00 | Recommended | Confirmed by multiple users |
| PTM7950 | Best thermal interface | Gold standard, universally recommended |
| Arctic P12 Pro/Max | Top fan choices | Both still community standard |
| IOMMU must be disabled | Confirmed | Not disputed |
| Mesa 25.1 minimum | Confirmed | Messaged by dozens of users |
| Smokeless_UMAF danger | Confirmed | Not disputed |

---

*Generated by cross-referencing V2 documentation against 839 Discord export files (bc250-chat, bc250-resources, bc250-flex-chat, benchmarks, new May 2026 exports). Each item is traced to the specific source file, line number, and community member. Items marked "Unnamed" where the Discord export format truncated the username.*

---

## Help-Thread FAQ Additions (2026-05-14)

Extracted 13 resolved FAQs from 120 help-thread exports. Added to documentation:

| FAQ | Added To | Source (help-thread user) |
|-----|----------|--------------------------|
| Power on 1 sec then off (bad PSU) | 10-troubleshooting.md | gredzikk |
| GPU hang 1-2h (VRAM overheating) | 10-troubleshooting.md | gdong0921_04971, baramin |
| Blue artifacts (poor GPU bin) | 10-troubleshooting.md | sajonsmk |
| Green screen (GDDR6 reball needed) | 10-troubleshooting.md | jayawesome |
| Bazzite installer freeze (try CachyOS) | 10-troubleshooting.md | .moosi |
| VRR + CachyOS 6.19 + UGREEN + sound | 08-display-and-audio.md | steffman_ |
| Spider-Man 2 OOM fixes | 07-game-benchmarks.md | hojnikb, _nk10, zerosumpr, newgbaxl |
| Flash.nsh keyboard typo | 02-bios-and-firmware.md | najibc |
| Attribution registry updated | ai/AI_PROTOCOL.md | 17 new users added |

---

## AI Inference Addendum (2026-05-15)

Created `12-ai-inference.md` with cross-verified data from Discord exports and internet sources:

| Section | Key Claims Verified |
|---------|-------------------|
| llama.cpp Vulkan (quick start) | Pre-built vulkan zips, `-ngl 999`, `-cram`, `GGML_VK_FORCE_MAX_ALLOCATION_SIZE` |
| Performance benchmarks | Discord data (hammercoral, __nightfox, xseol) + llama.cpp GitHub benchmark thread #10879 |
| ROCm status | Confirmed gfx1013 not in ROCm matrix; partial work (hammercoral, n3oney) |
| Model compatibility | Fits Qwen-9B, Gemma-12B, MoE-30B; needs 5+ boards for 70B |
| Ollama limitations | ~56% slower due to vendored llama.cpp b7437 (Ollama issue #15601) |
| Multi-board RPC | Only PP, not TP; 1GbE bottleneck (xseol data) |
| Stable Diffusion | stablediffusion.cpp + Vulkan confirmed; 2x vs RX 6600 |

Web sources used: elektricM radv.md, ROCm/TheRock SUPPORTED_GPUS.md, Phoronix (Mesa 25.1 RADV), llama.cpp issue #10879/#15601/#20934.

---

## 40 CU Unlock (2026-05-18)

Community project `duggasco/bc250-40cu-unlock` re-enables all 40 CUs on the BC-250 via kernel patch. Key updates:

| File | Change |
|------|--------|
| 01-hardware-specs.md | GPU CU count: 24x CUs, up to 40 unlockable. 40 CU power data at 1500 MHz (125W) and 2 GHz (181W). |
| 12-ai-inference.md | Full 40 CU Unlock section: 1.61x compute scaling (230→372 tok/s pp512), register mechanism, health testing, install, safety, credits. |
| README.md | Key Facts GPU line: "up to 40 via kernel patch" |

Credits: duggasco (research, repo), filippor (independent testing), scallion_9883 (benchmarks), Claude/Codex (SPI register analysis), kilrah (disable_cu), hojnikb (harvest maps), koloses (bad CU testing), essdee4336 (thermal), big_trov (stable verify), codyrainy (build test).

---

## 40 CU Gaming Benchmarks + Mangohud Fix (2026-05-19)

Extracted from project-forums Discord channel:

| File | Change |
|------|--------|
| 07-game-benchmarks.md | New 40 CU gaming section: Furmark 1080p/1440p (57→153 FPS scaling), Superposition scores (Medium 14004, Extreme 5759), efficiency insight (more CUs + lower clock = cooler same perf) |
| 01-hardware-specs.md | 40 CU idle power (75W vs 69W stock), efficiency insight (big_trov) |
| 10-troubleshooting.md | New mangohud 655% GPU usage fix (hassanthejust — Python daemon intercepts gpu_metrics at 0x1C) |

Credits: big_trov (40CU gaming benchmarks, idle, efficiency), essdee4336 (40CU Furmark 1080p at multiple clocks), hassanthejust (mangohud fix), hojnikb (comparison data).

---

## Cross-Reference Verification Fixes (2026-05-25)

Full audit of 26 repos cloned and cross-referenced against documentation:

| File | Change |
|------|--------|
| 02-bios-and-firmware.md | Removed `(need confirmation)` from MrrZed0/bc-250-bios — URL confirmed valid |
| 05-os-installation.md | Fixed wrong script name: `Arch-setup.sh` → `install.sh` (eabarriosTGC/BC250--ARCH) |
| 05-os-installation.md | Fixed wrong script name: `install.sh` → `oberon_install.sh` (pnbarbeito/bc250-arch) |
| 07-game-benchmarks.md | Fixed duplicate numbering (two items labeled "8.") |
| 10-troubleshooting.md | Fixed typo: "scooter tool" → "scooper tool" |
| 01-hardware-specs.md | Fixed malformed sentence: "48W perfprofile tweak is" → "48W perfprofile tweak" |

Additional findings (requires Discord community follow-up):
- kenavru/BC-250 described as "EFI flash tool" — actually just BIOS files, no flash tool
- Fred78290/nct6687d described as "PWM fan control driver" — actually lm-sensors monitoring driver
- bc250-acpi-fix: doc says "C-States and P-States" but P-States don't work per README
- 5 repos exist but not documented: BC-250-Custom-Case, bc-250-sleeve-adapter, BC250--ARCH, bc250-arch, Magnap-cyan-skillfish-governor

---

## Full Cross-Reference Audit Corrections (2026-05-25)

Full audit of all 14 Revised files (~3,200 lines) against 30+ elektricM docs, 27 repos, 80+ Discord exports, and RAG vector store. 10 parallel agents, 45 corrections total.

### CRITICAL Corrections

| File | Line | Change | Source |
|------|------|--------|--------|
| 01-hardware-specs.md | 17 | GPU perf: "RX 6600" → "Stock 24 CU: Between RX 6600/6600 XT; 40 CU: RX 6700/GTX 1080 Ti" | May 2026 Discord (jpvgaster, big_trov, essdee4336) |
| 02-bios-and-firmware.md | 35 | "[Forced]" → "[Forces]" — Forces is actual BIOS value, not typo | elektricM flashing.md, kenavru README |
| 02-bios-and-firmware.md | 215 | Stock 24 CU temp: 83°C → 79°C | duggasco/README.md, technical-report.md |
| 02-bios-and-firmware.md | 300-301 | Removed "GitHub README is incorrect" claim — it correctly documents WGP granularity | duggasco/README.md, GreatApo fork |
| 04-cooling-guide.md | 25 | "Cutout variant with built-in openings" → "Thicker-fin variant, fewer thicker-gauge fins" | elektricM cooling.md |
| 06-gpu-governor.md | 360 | "RedBoard" → "redbeard1083" | GitHub username confirmation |
| 08-display-and-audio.md | 101-108 | Vulkan_NullVRS: fixed env var (Vulkan_NullVRS=1 → ENABLE_VK_NULLVRS_1=1) and install method | Vulkan_NullVRS README |
| 08-display-and-audio.md | 38, 58 | Fixed two misattributions: gennro→essdee4336 (line 38), gennro→fforduck (line 58) | Discord exports |
| 09-wifi-and-peripherals.md | 70 | Play! 4 ASIN misattribution: B06XBZ38ZJ → B08T9LM3LM (was Play! 3 ASIN) | Cross-file consistency check |
| 10-troubleshooting.md | 397-408 | Split VRS vs 640x480 — were conflated as same issue | Vulkan_NullVRS README, Discord |
| 11-community-and-resources.md | 57,154 | Message count aligned: 7,782→9,716 | elektricM README |
| 01-hardware-specs.md | 77 | Removed unverified "48W perfprofile tweak" claim | No source found in any export or repo |

### MEDIUM Corrections

| File | Line | Change | Source |
|------|------|--------|--------|
| 02-bios-and-firmware.md | 14 | _fanous_ → _fanoush_; "custom fan curve" → "standard fan control" | Discord, elektricM flashing.md |
| 02-bios-and-firmware.md | 228-231 | gennro toolkit: changed to curl + correct script name | gennro/bc250-toolkit README |
| 02-bios-and-firmware.md | 112-114 | Internal flash warning softened — MrrZed0 repo docs it | MrrZed0/README.md |
| 05-os-installation.md | 168-179 | Nobara attribution: mothenjoyer69 → "Discord community discussion" | User not confirmed in exports |
| 07-game-benchmarks.md | 217,236 | Arc Raiders: ~100→60+; Zenless: 40-50→crashes | Discord contradiction resolution |
| 07-game-benchmarks.md | 378 | nexgen3d voltage: 1145→1165 mV | Discord Superposition thread screenshot |
| 09-wifi-and-peripherals.md | 13 | BT version: 5.2→5.3 | Amazon listing |
| 10-troubleshooting.md | 60 | Added 6.19.x kernel recommendation | quick-reference.md |
| 10-troubleshooting.md | 165-203 | Added note: btrfs/SELinux steps from Discord, not performance.md | Source audit |
| 10-troubleshooting.md | 246 | Added (need confirmation) to sajonsmk claim | User not found in exports |
| 11-community-and-resources.md | 25 | ACPI fix: "C-States and P-States" → "C-States (P-States experimental)" | bc250-acpi-fix README |
| README.md | 52 | ACPI fix warning: added P-State caveat | bc250-acpi-fix README |
| 04-cooling-guide.md | 59 | Router quote: removed (need confirmation), attributed to snodrat | bc250-flex-chat export |
| README.md | 48 (new) | Added 6-pin to 8-pin fire hazard warning | Discord confirmation |

### LOW Corrections

| File | Line | Change |
|------|------|--------|
| 05-os-installation.md | 67 | Removed (need confirmation) from bazzite password |
| 05-os-installation.md | 251 | Fixed leading space before chmod |
| 06-gpu-governor.md | 39 | Removed (need confirmation: Manjaro) — confirmed by elektricM docs |
| 06-gpu-governor.md | 233 | Added P-State nuance note (repo says not working, Discord says works) |
| 07-game-benchmarks.md | 30,46,59,60,85,184,233,283 | 8 (need confirmation) → (Discord user) with confirmed source |
| 07-game-benchmarks.md | 59 | 2230 MHz crash and 10/6 VRAM fixes confirmed |
| 10-troubleshooting.md | 151 | MESA_LOADER_DRIVER_OVERRIDE source: "not in source docs" → "Discord bc250-chat" |
| 10-troubleshooting.md | 105,111,121 | 3 (need confirmation) tags removed — Discord sources found |
| 10-troubleshooting.md | 452-453 | 2 (need confirmation) tags removed — Discord sources found |
| 04-cooling-guide.md | 110 | Removed (need confirmation) from screw warning — elektricM confirmed |

### Still Unresolved
- ~60+ (need confirmation) tags remain without source (concentrated in 07-game-benchmarks.md and 11-community-and-resources.md)
- 6+ Printables URLs return transport errors (confirmed still failing as of June 14, 2026)
- ~~5 repos not yet documented~~ ✅ Resolved — added to 11-community-and-resources.md

---

## Cross-Reference Verification Protocol

Created `ai/AI_VERIFICATION_PROTOCOL.md` — standardized multi-layer verification process for future audits.

Protocol features:
- Source hierarchy with "newest wins" rule
- 3-layer verification (RAG, parallel agents, cross-file)
- Finding classification (severity + type taxonomy)
- Full 5-step workflow: Discovery → Analysis → Plan → Execution → Validation
- Standardized report format for machine-parsable output
- Quality assurance gates with pass criteria
- Agent handoff protocol for interrupted cycles

Created by: Claude (Anthropic) via opencode on 2026-05-25

---

## New Discord Exports Audit (2026-05-25)

Reviewed 45 new bc250-chat exports (after May 20, 2026). Key findings added:

| File | Change |
|------|--------|
| 06-gpu-governor.md | Added governor v0.4.0 CPU-based memory clock control; idle power testing (big_trov/pops1cl); min freq 500 MHz default; SMU-plus pprofile autoswitching |
| 07-game-benchmarks.md | dznuts 5300 Superposition 38CU/2200MHz; Death Stranding 2 36CU@1440p+FG=60; S.T.A.L.K.E.R. 2 stock/36CU/FG benchmarks; Subnautica 2; PICO upscaler; memory OC gains minimal |
| 02-bios-and-firmware.md | PS5 40CU patch confirmed (gennro); OCP secondary power limit at 1850-2200MHz; CPU core unlock research update |
| 04-cooling-guide.md | Thermalright Peerless Assassin 120 + 3D bracket + GPU backplate cooler |
| 01-hardware-specs.md | Idle power identical regardless of CU count (big_trov); 64W downclocked idle (pops1cl) |
| README.md | Latest additions section updated |

---

## Full Guild Export + RAG Rebuild + Audit (2026-05-25)

Exported all guild channels and threads after 2026-05-20 (105 new files). Rebuilt RAG index (69,591 → 72,355 chunks). Ran full audit cycle per AI_VERIFICATION_PROTOCOL:

| Layer | Action | Result |
|-------|--------|--------|
| A | RAG queries on all key claims | Most claims score ≥0.70-0.85 — well-supported |
| B | Cross-reference new exports vs docs | 40CU data, governor, OCP already covered |
| C | Cross-file consistency | Fixed duplicate numbering in README warnings |

**Corrections applied:**
- README.md: Removed `(need confirmation)` from FSP500-30AS eBay ID 389522369783 — confirmed by essdee4336 (May 23, 2026)
- README.md: Fixed duplicate "8." numbering in Important Warnings (was 8, 8, 9 → 8, 9, 10)
- ai/rag_query.py: Unified with RAG/rag_query.py (fixed ChromaDB path, added Discord chunk merging, noise filtering, Ollama error handling, stats sampling)

**New exports reviewed:** 105 files from bc250-chat, bc250-flex-chat, bc250-resources, benchmarks, help-thread, project-forums (after 2026-05-20). Key topics: big_trov 40CU efficiency data, SMU Plus troubleshooting, CPU core unlock research (scallion_9883), new Superposition/Furmark scores. All existing docs already reflect these findings.

