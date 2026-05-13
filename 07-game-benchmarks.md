# 07 — Game Benchmarks

> Community-tested performance data for the BC-250 (Cyan Skillfish APU).
> Most tests at **1080p** — the sweet spot for this hardware (~RX 6600 level).

---

## Performance Expectations

| Resolution | Quality | Typical FPS Range | Notes |
|------------|---------|-------------------|-------|
| 1080p | Low | 100–144+ | Esports, older titles |
| 1080p | Medium | 60–100 | Sweet spot for most AAA games |
| 1080p | High | 40–70 | Demanding modern titles |
| 1080p + FSR Quality | High + FSR | 70–100+ | Free performance boost |
| 1440p | Medium + FSR | 50–80 | Playable with upscaling |
| 4K | Low + FSR | 30–40 | Older/less demanding titles only |

---

## AAA Titles

### Cyberpunk 2077

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p High, no RT | ~60 | Stable with decent cooling |
| 1080p Ultra + RT + FG | 61 (no FG), 101 (with FG) | Polish community benchmark, OC GPU |
| 1080p CPU-bound areas | <60 even at lowest | CPU bottleneck in dense areas |
| **Power draw** | **185–235W** | Most demanding game in the library |

**Benchmark scores:**
- Stock (2000 MHz, 1000 mV): **57.66 FPS**
- OC (2230 MHz, 1035 mV): **60.82 FPS**
- With `mitigations=off`: **+18 FPS** boost

**Tips:** Enable FSR Quality for a significant boost. DLSS/Frame Generation works well.

---

### Hogwarts Legacy

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium | ~60 | Needs zram enabled (16 GB RAM is tight) |
| With FSR4 on Proton GE | Playable | RAM headroom is the main constraint |

> ⚠️ **Game needs ~16.5 GB RAM.** Enable zram: `zram-size = ram × 0.75` and close background apps.
> Use **6 GB static VRAM allocation** to avoid OOM crashes.

---

### Red Dead Redemption 2

| Settings | FPS | Notes |
|----------|-----|-------|
| Full graphics (DX11) | Smooth | Heatsink barely warm with 120mm fan |
| 2230 MHz GPU | Crashes | Reduce to 2150 MHz for stability |
| 10/6 VRAM split | Fixed crash | Static allocation avoids ZRAM conflicts |

**Temps:** ~75°C during gameplay.

---

### Spider-Man 2

| Settings | FPS | Notes |
|----------|-----|-------|
| Medium, 6 GB VRAM | ~60 | GPU/CPU around 65°C |
| 1080p native AA, Medium | 55–60 | Textures Medium, rest Low |
| 1440p FSR3 Quality | ~55–60 | Similar to 1080p native |
| Auto VRAM | Crashes after 5–10 min | **Must** use 6 GB+ static allocation |

**Fix:** Add kernel params: `ttm.pages_limit=2490368 ttm.pages_pool_size=2490368`

---

### Elden Ring

| Settings | FPS | Notes |
|----------|-----|-------|
| Any settings | **45–51** | CPU-bound — 4 GHz still not enough for 60 |
| 4K | 30–40 | Playable but choppy |

> ⚠️ **Completely CPU-limited.** Changing resolution/settings doesn't help.
> Fix skybox artifacts: `RADV_DEBUG=nohiz` in Steam launch options.

---

### The Crew Motorfest

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p High | 60 (capped) | GPU OC 2100 MHz, CachyOS with Proton-Cachy |

---

### Alan Wake 2

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p | ~100 (with FG) | Reported playable, frame gen recommended |

---

## Shooters & Action

### Doom Eternal

| Settings | FPS | Notes |
|----------|-----|-------|
| Ultra (not max VRAM) | **100** | Loves Vulkan! |
| 512 MB VRAM | Heavy stuttering | Needs higher VRAM allocation |

### Doom: The Dark Ages (Update 2+)

| Settings | FPS | Notes |
|----------|-----|-------|
| Low / Handheld preset, 1080p, FSR Quality | ~60 | GPU 2230 MHz, CPU stock |

**Fix:** VRS crash — use [Vulkan_NullVRS](https://github.com/bangstk/Vulkan_NullVRS) layer.

### Crimson Desert

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium, no scaling | 38–42 | |

**Fix:** Use Proton Experimental Bleeding-Edge branch with VKD3D RDNA1 fix. Version 1.02 works.

### Death Stranding 2

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Low, FSR 3.1.5 | ~60 (dips to 45) | CPU limited |
| 1080p portable graphics | 30–50 | |

**Fix:** [DS2NetFix mod](https://github.com/jas0n098/DS2NetFix) reduces CPU usage from 90% to 40%.

### Monster Hunter Wilds

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Medium | +12% with `mitigations=off` | |

**Fix:** `sudo rpm-ostree kargs --append='mitigations=off'`

### Doom 2016

| Settings | FPS | Notes |
|----------|-----|-------|
| Max graphics | **100** | Spanish community benchmark |

### Genshin Impact

| Settings | FPS | Notes |
|----------|-----|-------|
| 1080p Ultra | **60 locked** | 65–68°C after 4 hours. Runs great. |

---

## Competitive / Esports

### CS2 (Counter-Strike 2)

| Aspect | Detail |
|--------|--------|
| Performance | **60–80 FPS with stuttering** |
| Notes | GDDR6 as system RAM cripples CPU; bad Linux port even worse than Windows |
| Stability test | Unstable OC crashes CS2 first — add +30 mV if crashes occur |

> 💡 CS2 is the **most sensitive stability test** for overclocks.

### Rocket League

**60 FPS locked at 1080p** — settings maxed. ✅

### Valorant

Expected good performance (not extensively tested; anti-cheat may have Linux challenges).

---

## Single-Player / Story Games

| Game | Performance | Notes |
|------|-------------|-------|
| Half-Life: Alyx | ~80 FPS | CachyOS |
| Hellblade: Senua's Sacrifice | ~180 FPS | High FPS, well-optimized |
| Arc Raiders | ~100 on practice range | High settings |
| Horizon: Zero Dawn | Great at 1080p High | No upscaling needed |
| Horizon: Forbidden West | 45–60 (70–90 with FG) | FSR + frame gen, low settings |
| Hunt: Showdown 1896 | 90–120 with FSR / 20–40 without | |
| Warframe | 75 FPS at 1080p | V-Sync ON, no FSR |
| War Thunder | Playable at 1080p High | Max GPU OC, no RT |
| The Last of Us Part I | 60 FPS locked, 1080p High | |
| The Callisto Protocol | 60–85 at 1080p Medium | 60 locked, hits 85 frequently |
| Tomb Raider (2013) | 100–140 FPS at 1080p Max | |
| Death Stranding | 40–50 FPS at 1080p Max | |
| Zenless Zone Zero | 40–50 FPS at 1080p Max + RT | |
| Diablo IV | Playable | Medium-high settings |
| Baldur's Gate 3 | Playable at 1080p | Lower settings in cities |

### Cities: Skylines 2 (200k population)
**20–30 FPS** — CPU limited (simulation-heavy).

---

## Emulation

| System / Game | FPS | Notes |
|---------------|-----|-------|
| Ratchet & Clank (RPCS3) | 45–60 | Playable |
| Breath of the Wild (Cemu) | — | Works |
| Xenia (Xbox 360) | ❌ | Freezes system — does not work |
| PCSX2 (PS2) | — | Excellent |
| Dolphin (GameCube/Wii) | — | Excellent |

---

## Games That Don't Work

| Game | Reason |
|------|--------|
| **Fortnite** | Easy Anti-Cheat on Linux — cannot run |
| **Final Fantasy VII Rebirth** | Mesh shader incompatibility — RDNA 2 only supports simple shaders |
| **Expedition 33 (Clair Obscur)** | Crashes with 512 MB VRAM — use 6 GB static allocation or `RADV_DEBUG=nohiz` |
| **Palia** | Crashes even with swap enabled |

---

## Launch Options & Tweaks (Quick Reference)

| Game / Fix | Launch Option |
|------------|---------------|
| Fix artifacts (general) | `RADV_DEBUG=nohiz %command%` |
| FPS overlay (any game) | `mangohud %command%` |
| Force RADV driver | `AMD_VULKAN_ICD=RADV %command%` |
| Steam Deck compatibility | `SteamDeck=0 %command%` (Fallout 4, Skyrim SE) |
| FSR4 upgrade for FSR3 | `FSR4_UPGRADE=1 %command%` |
| VRS crash fix (Doom TDA) | Use Vulkan_NullVRS layer |
| CPU performance boost | `mitigations=off` (kernel param) |
| Better shader caching | `__GL_SHADER_DISK_CACHE_SIZE=10737418240` in `/etc/environment` |

### Environment Variables (Add to `/etc/environment`)

```bash
AMD_VULKAN_ICD=RADV
RADV_DEBUG=nohiz
__GL_SHADER_DISK_CACHE_SIZE=10737418240
```

---

## Performance Optimization Tips

1. **1080p is the sweet spot** — 1440p works with FSR, 4K only for older titles
2. **CPU is the main bottleneck** in most modern games (GDDR6 shared memory latency)
3. **Static VRAM of 6 GB** is best for AAA gaming (avoids OOM crashes)
4. **Disable Handheld Daemon** if using Bazzite for gaming:
   ```bash
   sudo systemctl disable --now hhd && sudo systemctl mask hhd
   ```
5. **CachyOS is ~5–10% faster** than Bazzite in raw benchmarks, but less stable
6. **Kernel 6.18.18 LTS** is the current sweet spot — stable + performant
7. **`mitigations=off`** gives ~10–15% FPS boost in CPU-bound games
8. **Keep GPU under 85°C** for long-term stability