# Changelog — V2 Corrections from Community Discord Data

This file documents every correction or update discovered by cross-referencing V2 documentation against live community Discord exports (bc250-chat, bc250-resources, bc250-flex-chat, benchmarks, and new May 2026 exports). Each item cites the community member who contributed the information.

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
