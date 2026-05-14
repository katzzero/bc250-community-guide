# 04 — Cooling Guide

> The stock BC-250 heatsink is designed for passive rack cooling. **Active cooling is mandatory for gaming.**

---

## Stock Heatsink — Know What You're Working With

- **Type:** Passive aluminum fin stack
- **Fin orientation:** Vertical, front-to-back
- **Mounting:** Screwed directly to PCB
- **Designed for:** Rack-mounted servers with chassis airflow — **not** desktop use

### Three Heatsink Variants

| Variant | How to Identify | Notes |
|---------|-----------------|-------|
| **9-row** (most common) | QR code next to PCIe 8-pin | Standard version |
| **8-row** | No QR code | Slightly fewer fins |
| **Cutout variant** | Thicker aluminum, built-in openings | Best stock cooling, hardest to modify |

> Quick ID: If you see a **QR code next to the PCIe 8-pin connector**, it's the 9-row variant.

---

## Heatsink Modification

### Method 1: Fin Straightening (Recommended)

The fins in the center are often bent from manufacturing or shipping. Opening them allows airflow through the heatsink.

**Steps:**
1. Remove heatsink from board — **always work off-board**
2. Use needle-nose pliers or flathead screwdriver
3. Carefully push center fins apart
4. Bend progressively — **don't snap fins off**
5. Partial opening maintains structural integrity

**Expected improvement:** 5–10°C

### Method 2: 3D Printed Scooper Tool

- **Print:** [BC-250 Scooper](https://www.printables.com/model/1282906-bc-250-scooper)
- Print in **ASA or PETG** (3 copies needed for full heatsink)
- Safer and more consistent than manual fin bending

### Method 3: Cutting (Advanced / Irreversible)

- Dremel or hacksaw for larger openings
- **WARNING:** Creates metal debris — dangerous near electronics
- Router method possible but "the router bit will eat your heatsink for lunch"
- Fin removal is **irreversible**

---

## Fan Selection

### Top Picks

| Fan | Static Pressure | Speed (RPM) | Airflow | Noise | Notes |
|-----|----------------|-------------|---------|-------|-------|
| **Arctic P12 Pro** | 6.9 mmH₂O | 600–3000 | 77 CFM | 25 dB | ⭐ **Community standard.** Best price/performance. Only sold in 3-packs and 5-packs. |
| **Arctic P12 Max** | 6.9 mmH₂O | 600–3300 | 73 CFM | 52 dB | Higher max speed than Pro. |
| **Arctic P12 Pro PST CO** | 6.9 mmH₂O | 600–3000 | 77 CFM | 25 dB | Dual ball bearing, cable sharing. Premium choice. |
| **Noctua NF-F12 iPPC-3000** | High | Up to 3000 | — | Loud >80% | Premium, expensive. |
| **Noctua NF-A12×25** | High | Up to 2000 | 60 CFM | 22.6 dB | Quietest premium option. Lower static pressure. |
| **Arctic P14 PWM** | 2.4 mmH₂O | Up to 1700 | 73 CFM | 38 dB | Larger 140mm — covers more heatsink area. Quieter. |
| **Wathai 120mm Blower** | 0.81–1.35 mmH₂O | Up to 3000 | 25–38 CFM | 25–45 dB | Blower style — no fin opening needed. Not ideal for main cooling. |

### ⚠️ IMPORTANT: Arctic P12 Pro Availability

The P12 Pro is **NOT sold individually** by Arctic. Available configurations:
- **3-pack:** ~$25 (Amazon `B0DJD8MJ5S`)
- **5-pack:** ~$30 (Amazon `B0DJDDCG4M`)

### Budget Options

- **Xbox One fan** (3300 RPM) — creative repurposing from old consoles
- **Thermalright TL-C12C** — works but much lower static pressure than P12 Pro

---

## Fan Mounting Methods

| Method | Pros | Cons |
|--------|------|------|
| **Zip ties** | Simplest, no mods | Can slip; less secure |
| **Screws** (factory holes) | Most secure | Requires drilling/cutting |
| **Aluminum HVAC tape** | Seals air leaks, good contact | Hard to remove |
| **CPU cooler brackets** | Repurposed arms | May not fit perfectly |
| **3D printed shroud** | Best airflow, clean look | Requires 3D printer |

### Push vs. Pull Configuration

- **Single fan in center** = best for most builds
- Avoid two fans right next to each other (creates dead zone over APU core)
- **Push + pull** (one each side) > push + push
- **92mm fan on back** helps with backplate VRAM cooling

---

## Thermal Interface — What to Use Where

| Location | Recommended | Thickness | Notes |
|----------|-------------|-----------|-------|
| **APU Die** | PTM7950 Phase Change Pad | 0.2–0.25 mm | ⭐ Strongly recommended over paste. 4–15°C cooler. Lasts indefinitely. Amazon: `B0DHRR78H7` |
| **Front (VRMs)** | Thermal pads | 1.0–1.5 mm | Some boards ship with 1mm; upgrade to 1.5mm if temps are high |
| **Back (VRAM)** | Thermal pads | 2.0 mm | 8× GDDR6 chips generate significant heat |

### PTM7950 Application Guide

1. Clean APU die and heatsink copper with isopropyl alcohol
2. Peel plastic from one side, apply to die
3. Peel second plastic layer
4. Torque heatsink screws evenly (cross pattern)
5. **First boot may show 80–90°C** — this is normal, it "cooks in" during initial thermal cycles

### Alternative: Thermal Putty

- **Fehonda LTP81** or similar
- Self-squeezes to correct thickness — no measuring needed
- Apply generously
- "I stopped using thermal pads for everything. I use thermal putty." — community member

### Thermal Paste Rankings (if not using PTM7950)

| Paste | Conductivity | Notes |
|-------|-------------|-------|
| Thermal Grizzly Duronaut | 17.3 W/mK | ⭐ Best paste — 15°C drop reported |
| Thermal Grizzly Kryonaut | 12.5 W/mK | Better — 3–5°C drop vs MX-6 |
| Arctic MX-6 | 10.0 W/mK | Good — MX-6 is the current version, MX-5 is discontinued |
| Arctic MX-5 | 8.5 W/mK | Discontinued — replaced by MX-6 |

---

## Temperature Reference

### Idle Temperatures

| Range | Assessment |
|-------|------------|
| 30–40°C | 🟢 Excellent (AIO liquid cooling, well-ventilated case) |
| 38–45°C | 🟢 Good (PTM7950 + P12 Pro + opened fins) |
| 45–55°C | 🟡 Adequate (stock paste, unmodified heatsink) |
| 55–65°C | 🔴 Poor — needs repaste/fin opening |

### Gaming Temperatures

| Range | Assessment |
|-------|------------|
| 60–65°C | 🟢 Excellent (AIO or P12 Pro + PTM + opened fins) |
| 65–75°C | 🟢 Good (single 120mm fan, decent paste) |
| 75–85°C | 🟡 Acceptable (stock cooling, moderate OC) |
| 85–90°C | 🟠 Throttling — improve cooling |
| 100–110°C | 🔴 Critical — shutdown imminent |

### Stress Test Temperatures (Furmark)

| Temp | Assessment |
|------|------------|
| 80–85°C | Normal with good air cooling |
| 90–96°C | High — check paste and airflow |
| 108°C | Extreme OC without adequate cooling |

### With Liquid Cooling (240mm AIO)

- Gaming power draw: ~340W (Furmark + CPU stress)
- GPU stable up to 4.1 GHz CPU / 2300 MHz GPU

---

## Recommended Setup (TL;DR)

1. ✅ Open heatsink fins in center (scooper tool or fin bending)
2. ✅ PTM7950 phase change pad on APU die
3. ✅ 1.5mm pads on front, 2.0mm on back (or thermal putty)
4. ✅ Arctic P12 Pro zip-tied or mounted over opened section
5. ✅ Optional: 92mm fan on backplate for VRAM cooling
6. ✅ Fan curve: 30% @ 40°C → 50% @ 60°C → 75% @ 70°C → 100% @ 80°C

---

## 3D-Printed Fan Shrouds & Accessories

| Design | Link | Notes |
|--------|------|-------|
| ViRazY Fan Shroud (140mm + 120mm) | [Printables](https://www.printables.com/model/1339540) | Intake + exhaust combo |
| Cooling Solution | [Printables](https://www.printables.com/model/1385007) | Full cooling solution |
| 140mm Fan Mod (4U12G case) | [Printables](https://www.printables.com/model/1674470) | For Asrock 4U12G case |
| BC-250 Scooper (fin tool) | [Printables](https://www.printables.com/model/1282906) | Essential for fin work |
| BC-250 Shell Case | [Printables](https://www.printables.com/model/1228207) | Simple enclosure |
| Minimal Case + Flex PSU | [Printables](https://www.printables.com/model/1423572) | Compact Flex ATX build |
| BC-250 Case (ATX PSU) | [Printables](https://www.printables.com/model/1553599) | For standard ATX PSUs |
| BC-250 Sleeve Adapter | [GitHub](https://github.com/onemorecap/bc-250-sleeve-adapter) | 120mm fan adapter |
| BC-250 Custom Case | [GitHub](https://github.com/isaacalvex/BC-250-Custom-Case) | Alternative enclosure |

---

## VRAM Cooling — Don't Forget the Back!

The GDDR6 memory chips sit on the **back of the board** and have **no temperature sensor**. Overheating causes:
- Pixel artifacts during gaming
- System crashes after 30–60 minutes
- Instability at high settings

**Solutions:**
1. Apply 2mm thermal pads to backplate VRAM chips
2. Ensure case has positive airflow over backplate
3. Mount a small fan (80mm) blowing directly on backplate
4. Attach aluminum heatsink plate to back of board

> 🔑 **Key takeaway:** Front cooling alone isn't enough. Pay attention to the back!