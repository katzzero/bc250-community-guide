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
| 1080p CPU-bound areas | <60 even at lowest (need confirmation) | CPU bottleneck in dense areas |
| Power draw | Up to 235W | Most demanding game in the library (elektricM docs) |

**Benchmark scores:**
- Stock (2000 MHz, 1000 mV): **57.66 FPS** — elektricM docs
- OC (2230 MHz, 1035 mV): **60.82 FPS** — elektricM docs
- With `mitigations=off`: **+18 FPS** boost — elektricM docs

**Tips:** Enable FSR Quality for a significant boost. DLSS/FSR Frame Generation works well. (elektricM docs)

---

### Hogwarts Legacy

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium | ~60 (need confirmation) | Needs zram enabled (16 GB RAM is tight) |
| With FSR4 on Proton GE | Playable (need confirmation) | RAM headroom is the main constraint |

> Game needs ~16.5 GB RAM (need confirmation). Enable zram: `zram-size = ram x 0.75` and close background apps.
> Use 6 GB static VRAM allocation (need confirmation) to avoid OOM crashes.

---

### Red Dead Redemption 2

| Settings | FPS | Notes |
|----------|-----|-------|
| Full graphics (DX11) | Smooth (45+ FPS min — elektricM docs) | Heatsink barely warm with 120mm fan (need confirmation) |
| 2230 MHz GPU | Crashes (need confirmation) | Reduce to 2150 MHz for stability (need confirmation) |
| 10/6 VRAM split | Fixed crash (need confirmation) | Static allocation avoids ZRAM conflicts (need confirmation) |

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
| Any settings | 45–51 (need confirmation) | CPU-bound — elektricM docs report expected 60 FPS with settings adjustments |
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

**Fix:** VRS crash — use Vulkan_NullVRS layer (need confirmation).

### Crimson Desert

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium, no scaling | 38–42 (need confirmation) | |

**Fix:** Use Proton Experimental Bleeding-Edge branch with VKD3D RDNA1 fix. Version 1.02 works (need confirmation).

### Death Stranding 2

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Low, FSR 3.1.5 | ~60 dips to 45 (need confirmation) | CPU limited |
| 1080p portable graphics | 30–50 (need confirmation) | |

**Fix:** DS2NetFix mod (need confirmation) reduces CPU usage from 90% to 40%.

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
| 1080p Ultra | 60 locked (need confirmation) | 65–68C after 4 hours (need confirmation). Runs great. |

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
| Arc Raiders | ~100 on practice range (need confirmation) | High settings |
| Ghost of Tsushima [Discord user] | 45–60 at 1080p Low | Crashes without game update v1053.5+; runs at 1.7–1.9 GHz GPU OC. Check ProtonDB for AMD GPU fixes. |
| Final Fantasy VII Remake | Playable (need confirmation) | Rebirth broken: "DX12 is not supported on your system" — game checks for specific GPU compatibility (elektricM docs) |
| Horizon: Zero Dawn | Great at 1080p High (need confirmation) | No upscaling needed |
| Horizon: Forbidden West | 45–60 / 70–90 with FG (need confirmation) | FSR + frame gen, low settings |
| Hunt: Showdown 1896 | 90–120 with FSR / 20–40 without (need confirmation) | |
| Forza Horizon 5 [Discord user] | 40–100 FPS | Varies heavily by settings |
| Stellar Blade [fforduck, Discord user] | 50–80 FPS at 1440p | Medium settings, FSR4 |
| Helldivers 2 [Discord user] | 40–60 FPS | |
| Valheim | 40–80 FPS | 80 FPS with mitigations=off (Discord user) |
| GTA V Enhanced (RT) [Discord user] | Smooth on Mesa 26 | Went from 3-5fps crash to smooth with Mesa 26 |
| Oblivion Remaster [Discord user] | 30–75 FPS at 3440x1440 | With/without frame gen |
| Marvel Rivals [Discord user] | 100–190 FPS | |
| Warframe | 75 FPS at 1080p (need confirmation) | V-Sync ON, no FSR |
| War Thunder | Playable at 1080p High (need confirmation) | Max GPU OC, no RT |
| The Last of Us Part I | 60 FPS locked, 1080p Medium-High | elektricM docs |
| The Callisto Protocol | 60–85 at 1080p Medium (need confirmation) | 60 locked, hits 85 frequently |
| Tomb Raider (2013) | 100–140 FPS at 1080p Max (need confirmation) | |
| Death Stranding | 40–50 FPS at 1080p Max (need confirmation) | |
| Zenless Zone Zero | 40–50 FPS at 1080p Max + RT (need confirmation) | |
| Diablo IV | Playable (need confirmation) | Medium-high settings |
| Baldur's Gate 3 | Playable at 1080p (need confirmation) | Lower settings in cities |
| Detroit: Become Human | 60 FPS capped, 1080p Medium | elektricM docs |
| Devil May Cry 5 | 100 FPS, 1080p High | elektricM docs |

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

## Games That Don't Work

| Game | Reason | Source |
|------|--------|--------|
| Fortnite | Easy Anti-Cheat on Linux -- cannot run | elektricM docs |
| Final Fantasy VII Rebirth | "DX12 is not supported on your system" -- game checks for specific GPU compatibility, no fix for BC-250 yet | elektricM docs |
| Spider-Man 2 | Out-of-memory crash with 512MB VRAM. Fixes (help-thread): set 6GB static VRAM in BIOS (_nk10), add TTM kernel params (hojnikb), run 32GB swap script from NexGen3D repo, lower in-game settings (zerosumpr), or add DXVK config overrides (newgbaxl) |
| Expedition 33 (Clair Obscur) | Crashes with 512 MB VRAM -- use 6 GB static allocation or `RADV_DEBUG=nohiz` (need confirmation) | Community report |
| Palia | Crashes even with swap enabled (need confirmation) | Community report |

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
| VRS crash fix (Doom TDA) | Use Vulkan_NullVRS layer (need confirmation) | Community |
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
8. **`mitigations=off`** gives ~10–15% FPS boost in CPU-bound games (elektricM docs: "mitigations=off for +10-15% FPS")
9. **Keep GPU under 85C** for long-term stability (elektricM docs)
10. **Disable Handheld Daemon** if using Bazzite for gaming (need confirmation):
    ```bash
    sudo systemctl disable --now hhd && sudo systemctl mask hhd
    ```
11. **CachyOS may be ~5–10% faster** than Bazzite in raw benchmarks (need confirmation)
