# 08 — Display & Audio

> The BC-250 has **one DisplayPort 1.4 output** and **no HDMI**. Audio must be routed through DP or a USB adapter.

---

## Display Connection Options

| Method | Quality | Audio | Recommended? |
|--------|---------|-------|--------------|
| **Native DisplayPort** | Best | ✅ Full audio | ✅ Best option if your monitor supports DP |
| **Passive DP-to-HDMI** | Good (4K30 / 1080p60) | ✅ Works (usually) | ✅ Good — cheap (~$2 on AliExpress) |
| **Active DP-to-HDMI** | Varies | ⚠️ Often garbled/no audio | ❌ Not recommended |
| **DP-to-USB-C** | Good | ✅ Works | ✅ Good for USB-C monitors |

### Recommended Cable/Adapter

| Product | Type | Notes |
|---------|------|-------|
| Passive DP-to-HDMI (generic) | Passive adapter | Best value — works at 1080p/4K30 with audio, ~$2 AliExpress |
| AmazonBasics DP to HDMI (`B015OW3M1W`) | Passive | Video works, audio hit-or-miss |
| UANTIN DP to HDMI (`B0CYHB956B`) | Passive | Confirmed working, Amazon UK |

### BIOS Display Issue — "No Display in BIOS"

If you can't see the BIOS screen but the OS boots fine:
- **Use a native DP cable** instead of adapters
- **Passive** DP-to-HDMI works; **active** adapters may not show BIOS

---

## Audio Solutions

### Option 1: Audio Over DisplayPort (Best)

Audio is transmitted natively through DisplayPort. If your monitor has speakers or you use a DP-to-HDMI passive adapter, audio should work automatically.

### Option 2: USB Sound Card (Most Reliable Fix)

If audio over DP isn't working, use a USB audio adapter:

| Product | ASIN | Notes |
|---------|------|-------|
| **Creative Sound Blaster Play! 3** | `B06XBZ38ZJ` | ⭐ Best quality — 24-bit/96 kHz, ~$25–30 |
| **SABRENT AU-EMCB** | `B00XM883BK` | Budget option, confirmed working, plug and play |
| Cheap USB-C phone dongle | Various | Works with USB-C to A adapter; Apple USB-C adapter + A-C adapter confirmed |

> ⚠️ The ASIN `B0BQ5VJVWB` that appeared in some older guides is an **Amazon Renewed listing** and may not always be available. The standard retail ASIN is **`B06XBZ38ZJ`**.

---

## Multi-Monitor Setup

| Method | Notes |
|--------|-------|
| **DisplayPort MST Hub** | Works on Bazzite. Does NOT work with DP→HDMI adapters on hub outputs. |
| **DisplayLink Dock** | V7 Universal works (Best Buy `10872445`) — dual HDMI on Bazzite |
| **Dell ACP075EU** | Docking station with DisplayLink + USB DAC — works |

---

## Monitor Recommendations

| Use Case | Recommended Spec |
|----------|-----------------|
| General gaming | 1080p, 144 Hz, IPS panel |
| Best value | 1080p 60 Hz (you won't miss higher refresh at 60 FPS) |
| 1440p gaming | Use FSR Quality to hit 60 FPS |
| 4K | Only for retro/older games at reduced settings |

> 💡 At 1080p native with the BC-250, you'll get the sharpest image and best performance. FSR handles upscaling well if you go higher resolution.