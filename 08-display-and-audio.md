# 08 — Display & Audio

> The BC-250 has **one DisplayPort 1.4 output** and **no HDMI**. Audio must be routed through DP or a USB adapter.

---

## Display Connection Options

| Method | Quality | Audio | Recommended? |
|--------|---------|-------|--------------|
| **Native DisplayPort** | Best (up to 4K@120Hz, HDR10) | ✅ Works (most users) | ✅ Best option if monitor supports DP |
| **Passive DP-to-HDMI** | Good (1080p60 / 1440p60) | ✅ Usually works | ✅ Good value (~$5–10) |
| **Active DP-to-HDMI** | Up to 4K@60Hz+ | Broken on BC-250 (direct connection). Works on MST hub outputs (pops1cl/Discord). | Not recommended for direct use; usable with MST hubs |
| **DP-to-USB-C** | Good | ✅ Works | ✅ Good for USB-C monitors (need confirmation) |

### Recommended Cable/Adapter

| Product | Type | Notes |
|---------|------|-------|
| Passive DP-to-HDMI (generic) | Passive adapter | Best value — works at 1080p60/1440p60 with audio, ~$5–10 |
| AmazonBasics DP to HDMI (`B015OW3M1W`) | Passive | Video works, audio hit-or-miss |
| UANTIN DP to HDMI (`B0CYHB956B`) | Passive | Confirmed working, Amazon UK (need confirmation) |

### BIOS Display Issue — "No Display in BIOS"

If you can't see the BIOS screen but the OS boots fine:
- **Use a native DP cable** instead of adapters
- Some adapters don't initialize fast enough for BIOS — try a different adapter or cable

---

## Audio Solutions

### Option 1: Audio Over DisplayPort (Best)

Audio is transmitted natively through DisplayPort. If your monitor has speakers or you use a DP-to-HDMI passive adapter, audio should work automatically.

**DP audio fix:** Fixed in **Linux 6.19.10+** (included in CachyOS, available in Bazzite desktop testing branch). Fix contributed by TheFloW (PS5 Linux developer), relayed by _fanoush_. 

**Adapter audio status (May 2026):**
- **Passive adapters:** Audio works correctly, no issues reported with kernel 6.19+.
- **Active DP-to-HDMI (UGREEN 8K60Hz):** Audio dropouts every ~38 seconds (essdee4336). Active adapters enable 1440p@120Hz but audio quality suffers. 4K not recommended on this board.
- **Passive DP-to-HDMI (generic):** Limited to HDMI 1.4 (1080p60 / 1440p60, no 120Hz). Audio works fine.
- **Note:** Some Bazzite users still report pitch-shifted audio via DP→HDMI even on recent kernels (nataliezaki, May 2026). Native DP connection avoids all audio issues.

### Option 2: USB Sound Card (Most Reliable Fix)

If audio over DP isn't working, use a USB audio adapter:

| Product | ASIN | Notes |
|---------|------|-------|
| **Creative Sound Blaster Play! 4** | `B08T9LM3LM` | ⭐ Best quality — 24-bit/192 kHz, ~$25–34 (corrected from Play! 3 per elektriCM source) |
| **SABRENT AU-EMCB** | `B00XM883BK` | Budget option, confirmed working, plug and play (ASIN verified) |
| Cheap USB-C phone dongle | Various | Works with USB-C to A adapter; Apple USB-C adapter + A-C adapter confirmed |

> ⚠️ The ASIN `B0BQ5VJVWB` that appeared in some older guides is an **Amazon Renewed listing** and may not always be available. The standard retail ASIN is **`B08T9LM3LM`** (Play! 4) or **`B06XBZ38ZJ`** (Play! 3). (need confirmation)

## VRR (Variable Refresh Rate)

VRR is now achievable through multiple paths:

1. **CachyOS** (kernel 6.19): VRR works natively (steffman_, help-thread). Tested with UGREEN 8K DP-to-HDMI 2.1 adapter at 4K 120Hz with VRR and sound all working simultaneously via USB sound card.
2. **Custom Bazzite image**: Community image with AMD VRR kernel patches confirmed working on Bazzite Deck with OLED. Audio desyncs on expensive DP>HDMI adapters, but cheap Aliexpress 4k60hz adapters support VRR without audio issues.
3. **Kernel 6.19+**: Built-in VRR fixes (fforduck/Discord).

**Adapter notes for VRR:**
- **UGREEN 8K DP-to-HDMI 2.1**: Would give 4K 120Hz HDR + VRR if audio gets sorted (currently desyncs on custom Bazzite build).
- **Cheap Aliexpress 4K 60Hz adapters**: Support VRR on kernel 6.19+ and do NOT have audio desync issues -- best current option (fforduck, Apr 2026). Note: earlier community reports (essdee4336, Apr 2026) said cheap adapters do NOT support VRR; resolved by kernel 6.19+ patches.
- **Expensive DP>HDMI adapters**: VRR not supported, audio desync on custom Bazzite builds.

---

## Multi-Monitor Setup

| Method | Notes |
|--------|-------|
| **DisplayPort MST Hub** | Works on Bazzite. Maximum 2 screens via MST on BC-250 (elektriCM). Active DP→HDMI adapters work on hub outputs (pops1cl/Discord). ⚠️ More than 2 monitors on an MST hub can crash the amdgpu driver (pops1cl/Discord). |

**Tested MST Hub Compatibility (elektricM docs):**

| Adapter | Display-out | DP | Display | Audio | Notes |
|---------|-------------|----|---------|-------|-------|
| StarTech MST14DP122DP | DP (2) | 1.4 | Yes | Yes | Worked consistently across different monitors/cables |
| Monoprice 21972 | DP (2) | 1.2 | Mirror only | Yes | Unable to extend displays |
| ENBUER | DP (2) | 1.2? | Mirror only | Yes | Unable to extend displays |
| Generic | HDMI (2) | N/A | No | No | No video or audio |
| **DisplayLink Dock** | USB (DisplayLink) | N/A | Yes (desktop only) | Yes | Desktop use only, not gaming. V7 Universal (Best Buy `10872445`) claimed dual HDMI on Bazzite (need confirmation). |
| **Dell ACP075EU** | USB (DisplayLink) | N/A | Yes (desktop only) | Yes | Docking station with DisplayLink + USB DAC — claimed works (need confirmation) |

---

## Monitor Recommendations

| Use Case | Recommended Spec |
|----------|-----------------|
| General gaming | 1080p, 144 Hz, IPS panel, DP 1.4 certified cable |
| Best value | 1080p 60 Hz (you won't miss higher refresh at 60 FPS) |
| 1440p gaming | 1440p@144Hz DP monitor, DP 1.4 cable <2m; use FSR Quality to hit 60 FPS |
| 4K | 4K@60Hz monitor with DP; use active DP-to-HDMI adapter for HDMI display + USB audio |

> At 1080p native with the BC-250, you'll get the sharpest image and best performance. FSR handles upscaling well if you go higher resolution.

### VRS 640x480 Resolution Fix

Some games render at 640x480 due to broken Variable Rate Shading on Cyan Skillfish. bangstk's [Vulkan_NullVRS](https://github.com/bangstk/Vulkan_NullVRS) layer nullifies VRS commands:

```bash
git clone https://github.com/bangstk/Vulkan_NullVRS.git
cd Vulkan_NullVRS
make
mkdir -p ~/.local/share/vulkan/implicit_layer.d
cp ./Vulkan_NullVRS.json ~/.local/share/vulkan/implicit_layer.d/
cp ./libVulkan_NullVRS.so ~/.local/share/vulkan/implicit_layer.d/
```

Steam launch option: `ENABLE_VK_NULLVRS_1=1 %command%`
