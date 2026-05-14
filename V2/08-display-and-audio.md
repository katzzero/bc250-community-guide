# 08 — Display & Audio

> The BC-250 has **one DisplayPort 1.4 output** and **no HDMI**. Audio must be routed through DP or a USB adapter.

---

## Display Connection Options

| Method | Quality | Audio | Recommended? |
|--------|---------|-------|--------------|
| **Native DisplayPort** | Best (up to 4K@120Hz, HDR10) | ✅ Works (most users) | ✅ Best option if monitor supports DP |
| **Passive DP-to-HDMI** | Good (1080p60 / 1440p60) | ✅ Usually works | ✅ Good value (~$5–10) |
| **Active DP-to-HDMI** | Up to 4K@60Hz+ | ❌ Broken on BC-250 | ❌ Not recommended; ✅ works with MST hubs (pops1cl/Discord) |
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

**DP audio fix:** The DP audio delay issue is fixed in **Linux 6.19.10+** (included in CachyOS). Bazzite users need a custom kernel or must wait for a kernel update. This is the most frequently asked question about audio. (need confirmation — source: Discord pops1cl, not in elektriCM docs)

### Option 2: USB Sound Card (Most Reliable Fix)

If audio over DP isn't working, use a USB audio adapter:

| Product | ASIN | Notes |
|---------|------|-------|
| **Creative Sound Blaster Play! 4** | `B08T9LM3LM` | ⭐ Best quality — 24-bit/192 kHz, ~$25–34 (corrected from Play! 3 per elektriCM source) |
| **SABRENT AU-EMCB** | `B00XM883BK` | Budget option, confirmed working, plug and play (ASIN verified) |
| Cheap USB-C phone dongle | Various | Works with USB-C to A adapter; Apple USB-C adapter + A-C adapter confirmed |

> ⚠️ The ASIN `B0BQ5VJVWB` that appeared in some older guides is an **Amazon Renewed listing** and may not always be available. The standard retail ASIN is **`B08T9LM3LM`** (Play! 4) or **`B06XBZ38ZJ`** (Play! 3). (need confirmation)

---

## Multi-Monitor Setup

| Method | Notes |
|--------|-------|
| **DisplayPort MST Hub** | Works on Bazzite. Maximum 2 screens via MST on BC-250 (elektriCM). Active DP→HDMI adapters work on hub outputs (pops1cl/Discord). ⚠️ More than 2 monitors on an MST hub can crash the amdgpu driver (pops1cl/Discord). |
| **DisplayLink Dock** | USB DisplayLink adapter works for desktop use (not gaming). V7 Universal (Best Buy `10872445`) claimed dual HDMI on Bazzite (need confirmation). |
| **Dell ACP075EU** | Docking station with DisplayLink + USB DAC — claimed works (need confirmation) |

---

## Monitor Recommendations

| Use Case | Recommended Spec |
|----------|-----------------|
| General gaming | 1080p, 144 Hz, IPS panel, DP 1.4 certified cable |
| Best value | 1080p 60 Hz (you won't miss higher refresh at 60 FPS) |
| 1440p gaming | 1440p@144Hz DP monitor, DP 1.4 cable <2m; use FSR Quality to hit 60 FPS |
| 4K | 4K@60Hz monitor with DP; use active DP-to-HDMI adapter for HDMI display + USB audio |

> At 1080p native with the BC-250, you'll get the sharpest image and best performance. FSR handles upscaling well if you go higher resolution.
