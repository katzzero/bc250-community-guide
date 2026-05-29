# 04 - Cooling Guide

The stock BC-250 heatsink is designed for passive rack cooling. Active cooling is mandatory for gaming.

**Community cooling projects:**
- **AMD clip system cooler adapter** (biohazardv2.0 / bioizhere) — 3D-printable mount to attach standard AM4/AM5 clip-based coolers (air or AIO) to the BC-250. Tested with Zalman CNPS4X (92mm air). [Printables](https://www.printables.com/model/1042228-bc250-to-amd-cpu-cooler-mount)

---

## Stock Heatsink - Know What You're Working With

- **Type:** Passive aluminum fin stack
- **Fin orientation:** Vertical, front-to-back
- **Mounting:** Screwed directly to PCB (4 screws to remove)
- **Designed for:** Rack-mounted servers with chassis airflow - not desktop use

Source: elektricM cooling.md (Stock Configuration, Active Cooling Required)

### Three Heatsink Variants

| Variant | How to Identify | Notes |
|---------|-----------------|-------|
| **9-row** (most common) | QR code next to PCIe 8-pin | Standard version (elektricM cooling.md) |
| **8-row** | No QR code | Slightly fewer fins (elektricM cooling.md) |
| **Thicker-fin variant** | Fewer, thicker-gauge aluminum fins | Best stock cooling (elektricM cooling.md) |

Quick ID from elektricM: QR code next to the PCIe 8-pin connector indicates the 9-row variant.

Source: elektricM cooling.md (Stock Configuration - Variants)

---

## Heatsink Modification

### Method 1: Fin Straightening (Recommended)

The fins in the center are often bent from manufacturing or shipping. Opening them allows airflow through the heatsink.

**Steps:**
1. Remove heatsink from board - always work off-board
2. Use needle-nose pliers or flathead screwdriver
3. Carefully push center fins apart
4. Bend progressively - don't snap fins off
5. Partial opening maintains structural integrity

**Expected improvement:** 5-10C

Source: elektricM cooling.md (Fin Straightening, Benefit: 5-10C temperature improvement)

### Method 2: 3D Printed Scooper Tool

- **Print:** BC-250 Scooper (https://www.printables.com/model/1282906) (need confirmation - URL returned transport error)
- Not in elektricM. Source: community design

### Method 3: Cutting (Advanced / Irreversible)

- Dremel or hacksaw for larger openings
- **WARNING:** Creates metal debris - dangerous near electronics
- Router method possible but "the router bit will eat your heatsink for lunch" (snodrat, bc250-flex-chat, Jan 2026)
- Fin removal is irreversible

Source: elektricM cooling.md (Fin Removal - High Risk Modification)

---

## Fan Selection

### Top Picks

| Fan | Static Pressure | Speed (RPM) | Airflow | Noise | Notes |
|-----|----------------|-------------|---------|-------|-------|
| **Arctic P12 Pro** | 6.9 mmH2O | 600-3000 | 77 CFM | 39.7 dBA | Community standard. Best price/performance. Only sold in multi-packs. |
| **Arctic P12 Max** | 4.35 mmH2O | 200-3300 | 81 CFM | 0.6 Sone | Higher max speed. Lower static pressure than P12 Pro. |
| **Arctic P12 Pro PST CO** | 6.9 mmH2O | 600-3000 | 77 CFM | 39.7 dBA | Dual ball bearing, cable sharing. |
| **Noctua NF-F12 iPPC-3000** | 7.63 mmH2O | 750-3000 | 110 CFM | 43.5 dBA | Premium industrial. Highest static pressure. |
| **Noctua NF-A12x25** | 2.34 mmH2O | Up to 2000 | 60.1 CFM | 22.6 dBA | Quietest premium option. |
| **Arctic P14 PWM** | 2.40 mmH2O | Up to 1700 | 72.8 CFM | 38 dB(A) | Larger 140mm - covers more heatsink area. |
| **Wathai 120mm Blower** | 0.81-1.35 mmH2O | Up to 3000 | 25-38 CFM | 25-45 dB(A) | Blower style. Not ideal for main cooling. (need confirmation - not in elektricM) |
| **Arctic S12038-8K** | Server fan | Up to 8000 | Very high | Very high | "At 68% speed spanks a P12 Pro" (paul_lionking, May 2026) |

Source notes on fan specs:
- P12 Pro: Arctic official (arctic.de/en/P12-Pro). 3000 RPM / 77 CFM / 6.9 mmH2O. Noise: 39.7 dBA per Cybenetics independent test at max speed. Arctic marketing claims 25 dB(A) at low speed.
- P12 Max: Arctic official spec sheet (arctic.de). Corrected from elektricM which listed 73.3 CFM / 6.9 mmH2O for both Pro and Max. Arctic's own data shows 81 CFM / 4.35 mmH2O for P12 Max.
- P12 Pro PST CO: Arctic official (arctic.de/en/P12-Pro-PST-CO). Same fan performance, dual ball bearing.
- NF-F12 iPPC-3000: Noctua official specs (noctua.at/en/nf-f12-industrialppc-3000-pwm/specification). Our file previously omitted these specs.
- NF-A12x25: elektricM cooling.md
- P14 PWM: elektricM cooling.md

### IMPORTANT: Arctic P12 Pro Availability

The P12 Pro is NOT sold individually by Arctic. Available configurations:
- **3-pack (A-RGB):** Amazon ASIN `B0DJD8MJ5S` - confirmed
- **5-pack (PST, non-RGB):** Amazon ASIN `B0DJDDCG4M` - confirmed

Note: The 3-pack ASIN is the A-RGB version; the 5-pack is the PST (non-RGB, daisy-chain) version.

Sources: Arctic official site, Amazon listings

### CPU Cooler Adapters (May 2026)

Community members are using standard CPU tower coolers with 3D-printed brackets:

| Cooler | Notes | User |
|--------|-------|------|
| **Thermalright Peerless Assassin 120** | Best non-liquid cooler for the money. Requires 3D-printed bracket. Quiet, excellent cooling. Also available as $45 AIO version. | dartzon, pepituwu, May 2026 |
| **Thermalright AIO** | Aqua Elite 240 V2, V4, V6 all confirmed working. V4 ASIN: B0DHZ5LSNP. V6: `B0F98KYG6X` (Amazon CA). | gennro, sousapro, telefragger, May 2026 |
| **MSI AIO** | Used by FrenchHardware YouTube builds | Community, May 2026 |
| **Bykski Custom Waterblock** | Possible future option for extreme AIO/water builds | odinforrest, May 2026 |

dartzon (May 2026) used a Thermalright Peerless Assassin 120 with 3D-printed mounting bracket, coupled with a GPU backplate cooler with fans for VRAM chips. With 36 CU unlocked, Death Stranding 2 ran at ultrawide 1440p@60fps on high settings and temps never exceeded 72C.

### Budget Options

- **Xbox One fan** (3300 RPM) - creative repurposing (need confirmation - not in elektricM)
- **Thermalright TL-C12C** - works but much lower static pressure than P12 Pro (need confirmation - not in elektricM)

---

## Fan Mounting Methods

| Method | Pros | Cons |
|--------|------|------|
| **Zip ties** | Simplest, no mods | Can slip; less secure |
| **Screws (factory holes)** | Most secure | Requires drilling/cutting (elektricM warns NOT to drill heatsink -- see line 115) |
| **Aluminum HVAC tape** | Seals air leaks, good contact | Hard to remove (need confirmation - not in elektricM) |
| **CPU cooler brackets** | Repurposed arms | May not fit perfectly (need confirmation - not in elektricM) |
| **3D printed shroud** | Best airflow, clean look | Requires 3D printer |

Primary methods (zip ties, 3D printed shroud, cardboard/foam shroud) are from elektricM cooling.md (Fan Mounting Options). Screws into heatsink: elektricM warns "Do not drill holes in the heatsink fins to screw fans directly."

### Push vs. Pull Configuration

- **Single fan in center** = best for most builds
- Avoid two fans right next to each other (creates dead zone over APU core)
- **Push + pull** (one each side) > push + push
- **92mm fan on back** helps with backplate VRAM cooling

(need confirmation - push/pull advice not directly in elektricM. 92mm fan advice from elektricM's secondary fan section)

---

## Thermal Interface - What to Use Where

| Location | Recommended | Thickness | Notes |
|----------|-------------|-----------|-------|
| **APU Die** | PTM7950 Phase Change Pad | 0.2-0.25 mm | Recommended in elektricM and prerequisites. 4-15C improvement claimed. ASIN `B0DHRR78H7` (need confirmation). |
| **Front (VRAM/VRMs)** | Thermal pads | 1.5 mm | elektricM cooling.md specifies 1.5mm on front of board |
| **Back (VRAM)** | Thermal pads | 2.0 mm | 8x GDDR6 chips. elektricM cooling.md specifies 2.0mm on back |

Source: elektricM cooling.md (Memory Thermal Pad Replacement: "1.5mm on front of board, 2.0mm on back"). Note: prerequisites.md recommends "1mm or 1.5mm thickness" for backplate VRAM - discrepancy with cooling.md's 2.0mm back spec.

### PTM7950 Application Guide

1. Clean APU die and heatsink copper with isopropyl alcohol
2. Peel plastic from one side, apply to die
3. Peel second plastic layer
4. Torque heatsink screws evenly (cross pattern)
5. **First boot may show 80-90C** - this is normal, it "cooks in" during initial thermal cycles

(need confirmation - application process not in elektricM. First boot behavior from community/Discord.)

### Alternative: Thermal Putty

- **Fehonda LTP81** or similar
- Self-squeezes to correct thickness - no measuring needed
- Apply generously
- "I stopped using thermal pads for everything. I use thermal putty." - community member (need confirmation - not in elektricM)

### Thermal Paste Rankings (if not using PTM7950)

| Paste | Conductivity | Notes |
|-------|-------------|-------|
| Thermal Grizzly Kryonaut | 12.5 W/mK | Best traditional paste. Recommended in elektricM (cooling.md + prerequisites). 3-5C drop vs MX-6 (need confirmation). |
| Arctic MX-6 | 10.0 W/mK | Current version. Recommended in elektricM (cooling.md). |
| Arctic MX-5 | Discontinued | Replaced by MX-6. pops1cl confirmed MX-5 is NOT better than MX-6. |
| Arctic MX-4 | 8.5 W/mK | Good value. Recommended in elektricM (prerequisites.md + cooling.md). |
| Thermal Grizzly Duronaut | ~12.5 W/mK (need confirmation) | Emphasizes long-term stability per Thermal Grizzly. Our file previously claimed 17.3 W/mK - reseller data shows ~12.5 W/mK. 15C drop claim unverified. |

Source: elektricM cooling.md (Recommended Thermal Paste) lists MX-4, MX-6, Kryonaut, NT-H1, Thermalright TFX. Duronaut and conductivity values are NOT in elektricM - from community/Discord sources.

---

## Temperature Reference

### Safe Operating Temperatures (from elektricM cooling.md)

| Component | Idle | Light Load | Gaming | Maximum |
|-----------|------|------------|--------|---------|
| GPU/APU Edge | 40-50C | 50-60C | 65-80C | 90C |
| CPU (Tctl) | 45-55C | 55-65C | 70-85C | 95C |
| Memory (underside) | 40-55C | 50-65C | 55-70C | 80C |

Source: elektricM cooling.md (Safe Operating Temperatures table)

### Community Gaming Temperature Ranges (need confirmation - not in elektricM)

| Range | Assessment |
|-------|------------|
| 60-65C | Excellent (AIO or P12 Pro + PTM + opened fins) |
| 65-75C | Good (single 120mm fan, decent paste) |
| 75-80C | Acceptable (stock cooling) |
| 85-90C | Throttling zone |
| 100-110C | Critical - shutdown imminent |

### Stress Test Temperatures (Furmark) (need confirmation - not in elektricM)

| Temp | Assessment |
|------|------------|
| 80-85C | Normal with good air cooling |
| 90-96C | High - check paste and airflow |
| 108C | Extreme OC without adequate cooling |

### Orientation Considerations (May 2026)

Board orientation affects cooling performance:
- juliuuscaesar reported a **10°C difference** between horizontal and vertical orientation
- big_trov found only 1-2°C difference on his board, with power-plugs-down orientation slightly cooler
- Test your specific board and mounting orientation for optimal thermals

### With Liquid Cooling (240mm AIO)

Confirmed working models: Thermalright Aqua Elite 240 V2, V4, V6; MSI AIO series. Uses standard AM4 clip mounting with 3D-printed bracket (NexGen3D mount). (gennro, sousapro, telefragger, May 2026)

- Gaming power draw: ~340W (Furmark + CPU stress)
- GPU stable up to 4.1 GHz CPU / 2300 MHz GPU
- AM4 clip-style AIOs with printed adapters are the standard approach

### Multi-Fan Control (J4003 Header)

The NCT6686D chip supports **4 additional fan control circuits** via the J4003 header on the board. These can be controlled by software such as [CoolerControl](https://gitlab.com/coolercontrol/coolercontrol) (essdee4336, May 2026). Reference pinout: [mothenjoyer69/bc250-documentation](https://github.com/mothenjoyer69/bc250-documentation/blob/main/hardware.md#j4003).

---

## Recommended Setup (TL;DR)

1. Open heatsink fins in center (scooper tool or fin bending)
2. PTM7950 phase change pad on APU die
3. 1.5mm pads on front, 2.0mm on back (or thermal putty)
4. Arctic P12 Pro zip-tied or mounted over opened section
5. Optional: 92mm fan on backplate for VRAM cooling
6. Fan curve: 30% at 40C - 50% at 60C - 75% at 70C - 100% at 80C

(need confirmation - recommended setup not in elektricM as a numbered list)

---

## 3D-Printed Fan Shrouds & Accessories

| Design | Link | Notes |
|--------|------|-------|
| ViRazY Fan Shroud (140mm + 120mm) | https://www.printables.com/model/1339540 | Intake + exhaust combo (need confirmation - URL returned transport error) |
| Cooling Solution | https://www.printables.com/model/1385007 | Full cooling solution (need confirmation - URL returned transport error) |
| 140mm Fan Mod (4U12G case) | https://www.printables.com/model/1674470 | For Asrock 4U12G case (need confirmation - URL returned transport error) |
| BC-250 Scooper (fin tool) | https://www.printables.com/model/1282906 | Essential for fin work (need confirmation - URL returned transport error) |
| BC-250 Shell Case | https://www.printables.com/model/1228207 | Simple enclosure (need confirmation - URL returned transport error) |
| Minimal Case + Flex PSU | https://www.printables.com/model/1423572 | Compact Flex ATX build (need confirmation - URL returned transport error) |
| BC-250 Case (ATX PSU) | https://www.printables.com/model/1553599 | For standard ATX PSUs (need confirmation - URL returned transport error) |
| BC-250 Sleeve Adapter | https://github.com/onemorecap/bc-250-sleeve-adapter | 120mm fan adapter. Listed in elektricM cooling.md |
| BC-250 Custom Case | https://github.com/isaacalvex/BC-250-Custom-Case | Alternative enclosure. Listed in elektricM cooling.md |

GitHub URLs verified present in elektricM cooling.md (Popular Designs section).

Other Printables models: not verified - all returned transport errors during audit.

---

## VRAM Cooling - Don't Forget the Back!

The GDDR6 memory chips sit on the **back of the board** and have **no temperature sensor**. Overheating causes:
- Pixel artifacts during gaming
- System crashes after 30-60 minutes
- Instability at high settings

Source: elektricM cooling.md (Backplate VRAM Cooling Solutions, Memory Thermal Pad Replacement)

**Solutions:**
1. Apply 2mm thermal pads to backplate VRAM chips (elektricM cooling.md: "Apply 2mm thermal pads directly on backplate VRAM chips")
2. Ensure case has positive airflow over backplate (elektricM cooling.md: Rear Case Airflow)
3. Mount a small fan (80mm) blowing directly on backplate (elektricM cooling.md: Secondary Fan 80mm)
4. Attach aluminum heatsink plate to back of board (elektricM cooling.md: "Attach aluminum heatsink or plate if available")

**Key takeaway:** Front cooling alone isn't enough. Pay attention to the back.

Source: elektricM cooling.md (Backplate VRAM Cooling Solutions)
