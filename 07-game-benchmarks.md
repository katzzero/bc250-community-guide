# 07 — Game Benchmarks

> Community-tested performance data for the BC-250 (Cyan Skillfish APU).
> Most tests at 1080p — the sweet spot for this hardware (~RX 6600 level).

---

## Performance Expectations

| Resolution | Quality | Typical FPS Range | Notes |
|------------|---------|-------------------|-------|
| 1080p | Low | 100–144+ (need confirmation) | Esports, older titles |
| 1080p | Medium | 80–120+ | Sweet spot for most games (elektricM docs) |
| 1080p | High | 60–100+ | Most titles (elektricM docs) |
| 1080p + FSR Quality | High + FSR | 70–100+ (need confirmation) | Free performance boost |
| 1440p | Medium + FSR | 50–80 (need confirmation) | Playable with upscaling (elektricM docs) |
| 4K | Low + FSR | 30–40 (need confirmation) | Older/less demanding titles only |

---

## AAA Titles

### Cyberpunk 2077

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p High + FSR, no RT | 70–90 | elektricM docs |
| 1080p High + FSR + RT (lighting only) | 50–60 | elektricM docs |
| 1080p Ultra + FSR3.1 | 100+ | elektricM docs |
| 1080p CPU-bound areas | <60 even at lowest (Discord user) | CPU bottleneck in dense areas |
| Power draw | Up to 235W | Most demanding game in the library (elektricM docs) |

**Benchmark scores:**
- Stock (2000 MHz, 1000 mV): **57.66 FPS** — elektricM docs
- OC (2230 MHz, 1035 mV): **60.82 FPS** — elektricM docs
- With `mitigations=off`: **+18 FPS** boost — elektricM docs
- **38 CU, 2270 MHz GPU, 4050 MHz CPU, 1975 MT Memory, Ultra no FSR: min FPS >60** — dznuts (May 2026). Matched RTX 3060 performance level. Memory OC gave **+18.4% min FPS boost**.

**Tips:** Enable FSR Quality for a significant boost. DLSS/FSR Frame Generation works well. (elektricM docs)

---

### Hogwarts Legacy

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium | ~60 (Discord user) | Needs zram enabled (16 GB RAM is tight) |
| With FSR4 on Proton GE | Playable (need confirmation) | RAM headroom is the main constraint |

> Game needs ~16.5 GB RAM (need confirmation). Enable zram: `zram-size = ram x 0.75` and close background apps.
> Use 6 GB static VRAM allocation (need confirmation) to avoid OOM crashes.

---

### Red Dead Redemption 2

| Settings | FPS | Notes |
|----------|-----|-------|
| Full graphics (DX11) | Smooth (45+ FPS min — elektricM docs) | Heatsink barely warm with 120mm fan (need confirmation) |
| 2230 MHz GPU | Crashes (Discord user) | Reduce to 2150 MHz for stability (Discord user) |
| 10/6 VRAM split | Fixed crash (Discord user) | Static allocation avoids ZRAM conflicts (need confirmation) |

**Launch flag:** `-useMaximumSettings` — elektricM docs
**Adapter fix:** May detect as software rendering — change adapter in graphics settings to match `vulkaninfo --summary` output (elektricM docs)
**Temps:** ~75C during gameplay (need confirmation).

---

### Spider-Man 2

| Settings | FPS | Notes |
|----------|-----|-------|
| Medium, 6 GB VRAM | ~60 (need confirmation) | GPU/CPU around 65C |
| 1080p native AA, Medium | 55–60 (need confirmation) | Textures Medium, rest Low |
| 1440p FSR3 Quality | ~55–60 (need confirmation) | Similar to 1080p native |
| Auto VRAM | Crashes after 5–10 min (need confirmation) | Must use 6 GB+ static allocation |

**Fix:** Add kernel params: `ttm.pages_limit=2490368 ttm.pages_pool_size=2490368` (need confirmation)

---

### Elden Ring

| Settings | FPS | Notes |
|----------|-----|-------|
| Any settings | 45–51 (Discord user) | CPU-bound — elektricM docs report expected 60 FPS with settings adjustments |
| 4K | 30–40 (need confirmation) | Playable but choppy |

> Changing resolution/settings may not help (need confirmation).
> Fix skybox artifacts: `RADV_DEBUG=nohiz` in Steam launch options.

---

### The Crew Motorfest

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p High | 60 capped (need confirmation) | GPU OC 2100 MHz, CachyOS with Proton-Cachy |

### Borderlands 3 [Discord user]

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium, 8x AA | ~62 | Eden-6 benchmark; inventory has black box background (cosmetic only) |

### Starfield [Discord user]

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium | 48–60 | 60 FPS capped with frame gen |
| 1080p High | 39–60 | FG: 58–60 FPS |
| 1080p Ultra | 35–60 | FG: 58–60 FPS, temps 64C max |
| 1080p Medium (New Atlantis) | 48–53 | Most demanding location |

> Starfield is surprisingly playable with frame gen. Medium or High preset with FG gives a smooth 60 FPS experience. GPU OC 1000–2220 MHz, P12 Pro fan.

---

### Alan Wake 2

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p | ~100 with FG (need confirmation) | Reported playable, frame gen recommended |

---

## Shooters & Action

### Doom Eternal

| Settings | FPS | Notes |
|----------|-----|-------|
| Ultra (not max VRAM) | 100 (need confirmation) | Loves Vulkan |
| 512 MB VRAM | Heavy stuttering (need confirmation) | Needs higher VRAM allocation |

### Doom: The Dark Ages (Update 2+)

| Settings | FPS | Notes |
|----------|-----|-------|
| Low / Handheld preset, 1080p, FSR Quality | ~60 (need confirmation) | GPU 2230 MHz, CPU stock |

**Fix:** VRS crash — use [Vulkan_NullVRS](https://github.com/bangstk/Vulkan_NullVRS) layer (bangstk, May 2026).

### Crimson Desert

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium, no scaling | 38–42 (need confirmation) | |

**Fix:** Use Proton Experimental Bleeding-Edge branch with VKD3D RDNA1 fix. Version 1.02 works (need confirmation).

### Death Stranding 2

| Settings | FPS | Notes |
|----------|-----|-------|
| 36 CU, ultrawide 1440p High + frame gen | 60 locked | dartzon, CachyOS, Thermalright PA120, GPU backplate cooler, <72C |
| 36 CU, 1440p High, no frame gen | Dips under 60 | CPU bottleneck (dartzon) |
| 1080p Low, FSR 3.1.5 | ~60 dips to 45 | CPU limited |

**PICO upscaler:** PlayStation's FSR equivalent was ported to PC as "PICO" — works on Decima engine games (Horizon, Death Stranding). User reports it's superior to AMD FSR3 (dartzon, May 2026).

**Cooling:** dartzon used Thermalright Peerless Assassin 120 + GPU backplate cooler with fans for VRAM chips. Temps never exceeded 72C with 36 CU unlocked.

### Monster Hunter Wilds

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium | +12% with `mitigations=off` (need confirmation) | |

**Fix:** `sudo rpm-ostree kargs --append='mitigations=off'` (need confirmation)

### Doom 2016

| Settings | FPS | Notes |
|----------|-----|-------|
| Max graphics | 100 (need confirmation) | Spanish community benchmark |

### Forza Horizon 6 [Discord user, May 2026]

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p High + FSR 3.1.5 | 40–60 | Preset High, FSR helped fix pixelated textures |

### Genshin Impact

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Ultra | 60 locked (Discord user) | 65–68C after 4 hours (Discord user). Runs great. |

---

## Competitive / Esports

### CS2 (Counter-Strike 2)

| Aspect | Detail |
|--------|--------|
| Performance (elektricM docs) | **100+ FPS expected at 1080p** |
| Community test (need confirmation) | 60–80 FPS with stuttering in some configurations |
| Stability test (need confirmation) | Unstable OC crashes CS2 first — add +30 mV if crashes occur |

### Rocket League

| Aspect | Detail |
|--------|--------|
| Performance (elektricM docs) | **120+ FPS expected at 1080p** |
| Community test (need confirmation) | 60 FPS locked at 1080p — settings maxed |

### Valorant

Expected: Technical challenges — anti-cheat may have issues on Linux (elektricM docs).

---

## Single-Player / Story Games

| Game | Performance | Notes |
|------|-------------|-------|
| Half-Life: Alyx | ~80 FPS (need confirmation) | CachyOS |
| Hellblade: Senua's Sacrifice | ~180 FPS (need confirmation) | High FPS, well-optimized |
| Arc Raiders | 60+ (Discord user) | Medium, FSR Quality — 60+ FPS, ~69C |
| Ghost of Tsushima [Discord user] | 45–60 at 1080p Low | Crashes without game update v1053.5+; runs at 1.7–1.9 GHz GPU OC. Check ProtonDB for AMD GPU fixes. |
| Final Fantasy VII Remake | Playable (need confirmation) | Rebirth broken: "DX12 is not supported on your system" — game checks for specific GPU compatibility (elektricM docs) |
| Horizon: Zero Dawn | Great at 1080p High (need confirmation) | No upscaling needed |
| Horizon: Forbidden West | 45–60 / 70–90 with FG (need confirmation) | FSR + frame gen, low settings |
| Hunt: Showdown 1896 | 90–120 with FSR / 20–40 without (need confirmation) | |
| Forza Horizon 5 [Discord user] | 40–100 FPS | Varies heavily by settings |
| Stellar Blade [fforduck, Discord user] | 50–80 FPS at 1440p | Medium settings, FSR4 |
| Helldivers 2 [Discord user] | 40–60 FPS | |
| Valheim | 40–80 FPS | 80 FPS with mitigations=off (Discord user) |
| GTA V Enhanced (RT) [Discord user] | Smooth on Mesa 26 | Went from 3-5fps crash to smooth with Mesa 26 (CachyOS ships Mesa 26) |
| Oblivion Remaster [Discord user] | 30–75 FPS at 3440x1440 | With/without frame gen |
| Marvel Rivals [Discord user] | 100–190 FPS | |
| Warframe | 75 FPS at 1080p (need confirmation) | V-Sync ON, no FSR |
| War Thunder | Playable at 1080p High (need confirmation) | Max GPU OC, no RT |
| The Last of Us Part I | 60 FPS locked, 1080p Medium-High | elektricM docs |
| The Callisto Protocol | 60–85 at 1080p Medium (Discord user) | 60 locked, hits 85 frequently |
| Tomb Raider (2013) | 100–140 FPS at 1080p Max (need confirmation) | |
| Death Stranding | 40–50 FPS at 1080p Max (need confirmation) | |
| Zenless Zone Zero | Crashes with "Memory shortage" error (Discord user) | May need workaround |
| Diablo IV | Playable (need confirmation) | Medium-high settings |
| Baldur's Gate 3 | Playable at 1080p (need confirmation) | Lower settings in cities |
| Detroit: Become Human | 60 FPS capped, 1080p Medium | elektricM docs |
| Devil May Cry 5 | 100 FPS, 1080p High | elektricM docs |

### S.T.A.L.K.E.R. 2 (May 2026)

| Config | FPS | Notes |
|--------|-----|-------|
| Stock 24 CU, 2000 MHz | ~55 (drops to high 40s) | Area after opening cinematic |
| Stock + FSR frame gen | High 90s | |
| 36 CU, 2000 MHz | Mostly 60 (drops to high 50s) | |
| 36 CU + FSR frame gen | 110-120 | |

### Subnautica 2 (May 2026)

Runs on CachyOS with Proton Experimental, 40 CU, lower settings (biohazardv2.0).

---

### Cities: Skylines 2 (200k population)
**20–30 FPS** (need confirmation) — CPU limited (simulation-heavy).

---

## Emulation

| System / Game | FPS | Notes |
|---------------|-----|-------|
| Ryujinx (Switch) — TOTK | 20 FPS consistent | Appears to be board limitation (elektricM docs) |
| Ratchet & Clank (RPCS3) | 45–60 (need confirmation) | Playable |
| Breath of the Wild (Cemu) | Works (need confirmation) | |
| Xenia (Xbox 360) | Does not work — freezes system (need confirmation) | |
| PCSX2 (PS2) | Excellent | elektricM docs |
| Dolphin (GameCube/Wii) | Excellent | elektricM docs |
| RPCS3 (PS3) | Good for lighter titles | elektricM docs |

---

## Newly Tested Games (Late May 2026)

| Game | Performance | Notes |
|------|-------------|-------|
| Hitman 2 (40 CU, 1500 MHz) | 160 FPS vs 120 FPS stock | 1.33x CU scaling (itsanarse) |
| Fatal Frame 2 (40 CU) | 60 FPS at 1400-1500 MHz | 24 CU needed 1850-2000 MHz for same -- lower temps/power (maskofsin) |
| MGS3 Delta (40 CU) | 66% FPS boost over 24 CU | big_trov |
| Forza Horizon 6 | Playable via Proton (CachyOS) | Low memory warning after prologue; try 512MB split + zswap (antmagl, jeffr7814); menu FPS drops to 15 (capt.cat_13); works on Proton CachyOS |
| Crimson Desert (38-40 CU) | ~55 FPS FHD, no scaling | +10-15 FPS over 24 CU (pijuli.); CPU-limited in some areas (vfxmz) |
| Marvel Rivals | Playable | Season 8 perf mod on NexusMods (graytl); up to 190 FPS |
| Returnal | Heavy artifacts on marginal 40 CU boards | Good test game for CU health (capt.cat_13) |
| Death Stranding 2 | 36 CU, ultrawide 1440p High + FG: 60 | Well-optimized; CPU bottleneck without FG. See detailed entry above. |
| S.T.A.L.K.E.R. 2 | 24 CU stock: ~55 FPS; 36 CU: ~60; +FG: 110-120 | Big uplift from more CUs. See detailed entry above. |
| Subnautica 2 | Playable at lower settings | Proton Experimental, CachyOS, 40 CU (biohazardv2.0) |
| New Batman (2026) | Runs, GPU bound | 40 CU (codyrainy) |

---

## Games That Don't Work

| Game | Reason | Source |
|------|--------|--------|
| Fortnite | Easy Anti-Cheat on Linux -- cannot run | elektricM docs |
| Final Fantasy VII Rebirth | "DX12 is not supported on your system" -- game checks for specific GPU compatibility, no fix for BC-250 yet | elektricM docs |
| Spider-Man 2 | Out-of-memory crash with 512MB VRAM. Fixes (help-thread): set 6GB static VRAM in BIOS (_nk10), add TTM kernel params (hojnikb), run 32GB swap script from NexGen3D repo, lower in-game settings (zerosumpr), or add DXVK config overrides (newgbaxl) |
| Expedition 33 (Clair Obscur) | Crashes with 512 MB VRAM -- use 6 GB static allocation or `RADV_DEBUG=nohiz` (need confirmation) | Community report |
| Palia | Crashes without workaround (swap may help) (Discord user) | Community report |

---

## Launch Options & Tweaks (Quick Reference)

| Game / Fix | Launch Option | Source |
|------------|---------------|--------|
| Fix artifacts (general, Mesa 25.1+) | `RADV_DEBUG=nohiz %command%` | elektricM docs |
| FPS overlay (any game) | `mangohud %command%` | elektricM docs |
| CPU optimization | `gamemoderun %command%` | elektricM docs |
| Combined (Mesa 25.1+) | `RADV_DEBUG=nohiz mangohud gamemoderun %command%` | elektricM docs |
| Fix compute queue (Mesa < 25.1) | `RADV_DEBUG=nocompute %command%` | elektricM docs |
| Combined with debug (Mesa < 25.1) | `RADV_DEBUG=nohiz DXVK_HUD=fps,gpu MANGOHUD=1 %command%` | elektricM docs |
| Force Vulkan driver | `VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json %command%` | elektricM docs |
| Steam Deck compat (Fallout 4, Skyrim SE) | `SteamDeck=0 %command%` (need confirmation) | Community |
| FSR4 upgrade for FSR3 | `FSR4_UPGRADE=1 %command%` (need confirmation) | Community |
| VRS crash fix (Doom TDA) | Use [Vulkan_NullVRS](https://github.com/bangstk/Vulkan_NullVRS) layer (bangstk) | bangstk, May 2026 |
| CPU performance boost | `mitigations=off` (kernel param) | elektricM docs |
| Larger shader cache | `__GL_SHADER_DISK_CACHE_SIZE=10737418240` in `/etc/environment` | elektricM docs |

### Environment Variables (Add to `/etc/environment`)

```bash
VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json
RADV_DEBUG=nohiz
__GL_SHADER_DISK_CACHE_SIZE=10737418240
```

---

## Performance Optimization Tips

1. **1080p is the sweet spot** — 1440p works with FSR, 4K only for older titles (elektricM docs)
2. **CPU is the main bottleneck** in most modern games (GDDR6 shared memory latency) (need confirmation)
3. **VRAM: 4 GB for most games, 6 GB for demanding AAA titles** (elektricM docs: 4 GB recommended; 6 GB from community)
4. **Use FSR** for free performance boost (elektricM docs)
5. **Update to Mesa 25.1.3+** for best compatibility (elektricM docs)
6. **Try Proton-GE** for better compatibility (elektricM docs)
7. **Kernel 6.19.x** for VRR and DP audio fixes (gennro); 6.18 LTS as stable fallback
8. **Mesa 26.x recommended** — significant RT and performance improvements; 25.1+ minimum
9. **`mitigations=off`** gives ~10–15% FPS boost in CPU-bound games (elektricM docs: "mitigations=off for +10-15% FPS")
10. **Keep GPU under 85C** for long-term stability (elektricM docs)
11. **Disable Handheld Daemon** if using Bazzite for gaming (elektricM docs):
    ```bash
    sudo systemctl disable --now hhd && sudo systemctl mask hhd
    ```
12. **CachyOS may be ~5–10% faster** than Bazzite in raw benchmarks (need confirmation)
13. **40 CU unlock: more CUs at lower clocks** match higher clocks at stock 24 CU — cooler and less power (big_trov: 40 CU at 1200 MHz = 60 FPS at 73C, 30W less than 24 CU at 2000 MHz achieving same FPS). See [02-BIOS](02-bios-and-firmware.md).

---

## 40 CU Unlock — Gaming Benchmarks

Community-tested by big_trov and essdee4336 (May 2026). All runs with P12 Pro fan, opened mid fins, PTM7950, 80mm back fan unless noted.

### Furmark (Vulkan, 1080p)

| Config | FPS | Temp | Power | User |
|--------|-----|------|-------|------|
| 24 CU, 2000 MHz stock | 57 | 77C | — | big_trov |
| 40 CU, 2000 MHz | 91 | 90C | — | big_trov |
| 40 CU, 1850 MHz / 910 mV | 137 | 71C | — | essdee4336 |
| 40 CU, 2000 MHz / 950 mV | 145 | 75C | — | essdee4336 |
| 40 CU, 2150 MHz / 990 mV | 153 | 79C | ~200W | essdee4336 |
| 40 CU, 2200 MHz | — | 98C (instant) | — | big_trov |
| 40 CU, 2230 MHz / 1050 mV | — | — | — | mrfrakes |
| 40 CU, 2300 MHz | 150 | 85C | ~288W | big_trov |
| 40 CU, 1850 MHz / 960 mV (2x 120mm fans) | — | — | — | soulygenius |
| 40 CU, 2000 MHz / 1000 mV (SMU_OC 78C tctl) | — | — | — | stevounit |
| 40 CU, 2300 MHz / 4100 MHz CPU | — | — | — | adixd90 |
| 40 CU, 1920 MHz / 960 mV (MX-7, triple fan) | — | throttled | — | linepanda (May 2026) |
| **38/40 CU, 1900 MHz** | **130** | **84C** | **336W wall** | **pijuli.** |
| **24/40 CU, 2130 MHz (same board)** | **95** | **84C** | **320W wall** | **pijuli.** |

pijuli. tested a 38/40 CU board (2 harvested in SE1 SH0). At 1900 MHz with 38 CUs: 130 FPS, 84C, 336W from wall. Same board at 24 CU/2130 MHz: 95 FPS, 84C, 320W. **35% FPS increase** at equivalent temps with only 16W more from wall. Cooling: P12 Max, middle fins removed, PTM7950, new thermal pads, no cage/no back fan.

### Superposition (40 CU @ 2200 MHz)

| Preset | Score | GPU Clock | CPU Clock | Notes | User |
|--------|-------|-----------|-----------|-------|------|
| Medium | 13507 | 2200 MHz | stock | — | big_trov |
| High | 12491 | 2200 MHz | stock | — | big_trov |
| Medium (4 GHz CPU) | 14004 | 2200 MHz | 4000 MHz | Meager boost from CPU OC | big_trov |
| Extreme (2300 MHz) | 5759 | 2300 MHz | 3500 MHz UV | ~250W at wall | big_trov |
| Extreme (2230 MHz) | — | 2230 MHz | — | 24CU was 235W at 2230 | big_trov |
| Extreme (2100 MHz) | — | 2100 MHz | 4000 MHz | 1020 mV, 40CU | codyrainy |

---

## Superposition Leaderboard (Extreme, 1080p)

### 24 CU (Stock, Unharvest Disabled)

| Rank | User | Score | GPU Clock | CPU Clock | mV | Date |
|------|------|-------|-----------|-----------|-----|------|
| 1 | nexgen3d | 4713 | 2530 MHz | 4175 MHz | 1165 | Jan 2026 |
| 2 | nexgen3d | 4690 | 2530 MHz | 4150 MHz | 1150 | Jan 2026 |
| 3 | nexgen3d | 4668 | 2500 MHz | — | — | Jan 2026 |
| 4 | nexgen3d | 4576 | 2400 MHz | 3850 MHz | — | Mar 2026 |
| 5 | nexgen3d | 4329 | — | — | — | Jan 2026 |
| 6 | nexgen3d | 4317 | — | — | — | Dec 2025 |
| 7 | nexgen3d | 4280 | — | — | — | Dec 2025 |
| 8 | big_trov | ~4200 | 2200 MHz | stock | — | Feb 2026 |
| 9 | big_trov | 3975 | 2000 MHz | 3500 MHz | — | Apr 2026 |
| 10 | .captainwasabi | ~3700 | — | — | — | May 2026 |

nexgen3d runs liquid cooling (MSI AIO), CachyOS, SMU governor. 24 CU community target is 5000 (uncracked).

### 40 CU (Unharvest Enabled)

| Rank | User | Score | GPU Clock | CPU Clock | mV | Notes | Date |
|------|------|-------|-----------|-----------|-----|-------|------|
| 1 | gennro | ~5900 | — | — | — | — | May 2026 |
| 2 | big_trov | 5759 | 2300 MHz | 3500 MHz UV | — | — | May 2026 |
| 3 | dznuts | 5300 | 2200 MHz | — | 1060 | 38 CU, CachyOS | May 2026 |
| 4 | codyrainy | ~5400 | 2100 MHz | 4000 MHz | 1020 | 40 CU | May 2026 |
| 5 | cralant | ~5400 | 2150 MHz | 3800 MHz -15 | 1035 | 40 CU | May 2026 |
| 5 | dznuts | 5300 | 2270 MHz | 4000 MHz | — | 38 CU | May 2026 |
| 6 | land_and_air | — | 2000 MHz | stock | — | — | May 2026 |

40 CU Extreme already surpasses the 24 CU record (4713) by 22%+ at lower clocks (2300 vs 2530 MHz). Theoretically should reach ~6500+ at equivalent clocks. More scores expected as community adopts the unlock. Post your results in the Discord `#benchmarks` channel.

**Max clock findings:** 2400 MHz at 40 CU causes hard OCP lockup requiring power cable pull (reset/power buttons unresponsive) across multiple boards (big_trov, codyrainy, cralant). 2100-2300 MHz is the stable range for most boards. Trimming CUs for higher clocks is not advantageous: big_trov's 32CU @ 2400 MHz scored worse than 40CU @ 2300 MHz, with similar power draw (~270W).

**38 CU voltage findings (May 2026):** 38 CU at 2200 MHz requires ~1050-1060 mV (dznuts). 1085 mV not enough for 2230 MHz with 38 CU. At 2200 MHz, 995 mV is stable for some boards (codyrainy). Power limit and voltage ceiling intersect at ~2200 MHz for most boards, creating a hard stability ceiling.

**Memory OC (May 2026):** dznuts tested memory OC at 1975 MHz CL26 using RobinMemTiming. Only +80 points in Superposition and +1 FPS in Cyberpunk — not worth the instability risk. Memory OC causes 1-in-20 boot failures (no POST).

### Gaming (40 CU)

| Game | Config | FPS | User |
|------|--------|-----|------|
| Furmark VK 1080p | 1200 MHz | 60 FPS at 73C | big_trov |
| Furmark VK 1440p | 2000 MHz | 91 FPS at 90C | big_trov |
| Doom TDA | 1440p, 40 CU | Same FPS as 1080p before unlock | Community report |
| Forza Horizon 6 | 1080p Ultra, 40 CU | ~60 FPS | Community report |
| Helldivers 2 | 40 CU, 2350 MHz | Stable | Community report |
| RE4 Remake | 40 CU, any config | Crashes | Community report |

> **Efficiency insight (big_trov):** More CUs at lower clocks match the performance of fewer CUs at higher clocks, at lower temperature and power. 40 CU @ 1200 MHz = 60 FPS (73C, 30W less than 24 CU @ 2000 MHz achieving same FPS).
> **OCP hard lockup (big_trov, codyrainy, cralant):** 2400 MHz at 40 CU causes hard lockup where reset and power buttons do nothing -- requires pulling power cable. Likely Over Current Protection triggering. Consistent across multiple boards regardless of cooling. One user with AIO reported 2400 MHz stable at 1120 mV.
> **CPU OC affects GPU stability (big_trov, hojnikb):** Increasing CPU from 3500 to 4000 MHz lowered the GPU voltage threshold for hard lockup. Total system power draw matters -- undervolt CPU when pushing GPU limits.
> **Game-specific instability (May 2026):** RE4 Remake crashes even with stable stress tests. Games need more voltage on GPU than synthetic benchmarks to be stable. If benchmarks pass but games crash, increase voltage by 10-15 mV.
> **Voltage wall at 40 CU (big_trov, May 2026):** Two limit curves govern 40 CU stability -- a voltage ceiling and a power limit. These curves intersect at approximately 2200 MHz, creating a hard stability ceiling. Above this point, diminishing returns are severe regardless of cooling. Power consumption: ~250W from wall during gaming, ~350W during Furmark at 40 CU (bytepond, May 2026).
> **Hard limit:** 2300 MHz at 40 CU = ~288W. Stay at or below 2200 MHz for safety with 40 CU.
