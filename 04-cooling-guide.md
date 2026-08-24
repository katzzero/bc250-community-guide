# 04 - Cooling Guide

The stock BC-250 heatsink is designed for passive rack cooling. Active cooling is mandatory for gaming.

**Community cooling projects:**
- **AMD clip system cooler adapter** (biohazardv2.0 / bioizhere) — 3D-printable mount to attach standard AM4/AM5 clip-based coolers (air or AIO) to the BC-250. Tested with Zalman CNPS4X (92mm air). [Printables](https://www.printables.com/model/1042228-bc250-to-amd-cpu-cooler-mount)
- **Case mods catalog** — full list of community case designs in [Case Mods & Custom Enclosures](13-case-mods.md)

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

### Heatsink Revisions

Some heatsinks have silkscreened markings showing where to place thermal pads; others do not. iamdarkyoshi (17 Mar 2026) reported owning two BC-250s where only the second unit had these pad-position markings.

### CRITICAL: 4x Nylon Washers Under Heatsink Screws

The heatsink is secured by **4 spring-tensioned screws** that pass through the back of the board. Under each screw head (on the VRAM/backplate side) there is a **clear or black nylon washer** that prevents the screw head from shorting PCB traces.

**What goes wrong:** During disassembly these washers often fall off and are lost. Reassembling without them creates a gap between heatsink and APU die, causing 90-100°C+ temperatures at idle.

**Diagnosis:** If the heatsink cannot be fully tightened (gap remains between die and heatsink), check whether the 4 nylon washers are present and correctly positioned. Shine a light through the side of the board to check for a visible gap.

**Fix:** Retrieve or replace the missing washers, realign them, and retorque. Users who found and re-installed missing washers reported temperatures "slowly decreasing" back to normal.

Sources: mzk10 (4 Dec 2025, 23 Jan 2026), .captainwasabi (23 Jan 2026). mzk10 summarizes: "In my day job it's always DNS. In bc250 chat it's always those damned washers."

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

### Method 4: Scissor Peeling (Community-Verified Preferred)

Community testing confirms scissors outperform pry tools for fin opening. snodrat: "I think the scissors method is still the cleanest way to go"; .strykur saw videos of scissors doing it "fast/clean"; _digitalize_ planned to try it first (snodrat, .strykur, _digitalize_, baalah, kilrah, Aug 4 2026). Caution from the same thread: always remove the cooler and clean all metal dust after dremeling -- kilrah: "do remove that cooler and clean all the metal dust after dremeling... wouldn't do it with it mounted" (04/08/2026).

- **Tool:** Good scissors (normal office scissors work; "good scissors to just cut the damn fins open" -- selectivelygood_16010, Nov 2025)
- **Technique:** Take the heatsink off the board, then cut the fins open with scissors from edge to center, working left + right simultaneously (omgyeti, Jun 2026: "someone used scissors and a leverage point to cut fins... tedious but it worked well")
- **Advantages over Method 1/2:** Cleaner, uniform results, no debris risk, no 3D printing needed

### Method 3: Cutting (Advanced / Irreversible)

- Dremel or hacksaw for larger openings
- **WARNING:** Creates metal debris - dangerous near electronics
- Router method possible but "routers do like to chew you up and spit you out, so I chickened out on that approach" (snodrat, 07/12/2025); "routers love to grab your workpiece and chew it up" (snodrat, 04/08/2026)
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
| **Thermalright Peerless Assassin 120** | Best non-liquid cooler for the money. Requires 3D-printed bracket. Quiet, excellent cooling. | dartzon, May 2026 |
| **Thermalright AIO** | Aqua Elite 240 V2, V4, V6 all confirmed working. V4 ASIN: B0DHZ5LSNP. V6: `B0F98KYG6X` (Amazon CA). | gennro (11/04/2026), telefragger (25/05/2026) |
| **MSI AIO** | MSI MAG CoreLiquid A15 240mm. nexgen3d designed an LGA 1851 adapter bracket for the BC-250 bolt pattern ("AIO Mount design complete, this will adapt the LGA 1851 to the BC250 bolt pattern, specifically designed for the MSI Mag AIO, but may fit others"). | nexgen3d, Jan 2026 |
| **JiuShark JF13K (top-blow, dual 120mm)** | CPU tower cooler alternative for well-overclocked boards — Old Lamer video demonstrates it on the BC-250 with 3D-printed mounting parts ([video](https://www.youtube.com/watch?v=hfJSzgiWb40), [Printables mount](https://www.printables.com/model/1574416-amd-bc-250-with-cpu-cooler)) | capt.cat_13, 22/08/2026 |
| **Bykski Custom Waterblock** | No block exists yet -- "Surprised bykski doesn't have a block for this thing" (manya4090, Dec 2025). | manya4090, Dec 2025 |

dartzon (May 2026) used a Thermalright Peerless Assassin 120 with 3D-printed mounting bracket, coupled with a GPU backplate cooler with fans for VRAM chips. With 36 CU unlocked, Death Stranding 2 ran at ultrawide 1440p@60fps on high settings and temps never exceeded 72C.

### Budget Options

- **Xbox 360 delta fan** - creative repurposing; "To my surprise these little fans move significant amount of air!" (frostfire83, 25/11/2025); another user managed fan speed control with an Xbox 360 E fan (10/12/2025)
- **Thermalright TL-C12C** - works but "an odd choice given its low static pressure rating even compared to a regular Arctic P12" (astrocast, 18/11/2025)

---

## Fan Mounting Methods

| Method | Pros | Cons |
|--------|------|------|
| **Zip ties** | Simplest, no mods | Can slip; less secure |
| **Screws (factory holes)** | Most secure | Requires drilling/cutting (elektricM warns NOT to drill heatsink) |
| **Aluminum HVAC tape** | Seals air leaks, good contact | Hard to remove. Real result: widdlemama "attach my P12 to the heatsink using aluminium foil tape and my temps in Clair Obscur went from 75 to 62" (flex-chat, 09/06/2026) |
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
| **APU Die** | PTM7950 Phase Change Pad | 0.2-0.25 mm | Recommended in elektricM and prerequisites. 4-15C improvement claimed. ASIN `B0F9Y5SCK2`. | [confirmed: @deathstalkerjr, 09/03/2026]
| **Front (VRAM/VRMs)** | Thermal pads | 1.5 mm | elektricM cooling.md + community consensus (vicomte.me, 12 Jan 2026) |
| **Back (VRAM)** | Thermal pads | 2.0 mm | 8x GDDR6 chips. elektricM cooling.md + community consensus (vicomte.me, 12 Jan 2026). jayawesome (17 Mar 2026) replaced pads with Arctic TP-3 and noted the heatsink has markers for additional pads. |

Source: elektricM cooling.md (Memory Thermal Pad Replacement: "1.5mm on front of board, 2.0mm on back"). Community corroboration: vicomte.me (12 Jan 2026) cited Snarks Domain "BC250 Thermal Putty Job" video with the same thickness recommendation. Note: prerequisites.md recommends "1mm or 1.5mm thickness" for backplate VRAM - discrepancy with cooling.md's 2.0mm back spec; the 2.0mm community consensus aligns with cooling.md.

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
| Thermal Grizzly Kryonaut | 12.5 W/mK | Best traditional paste. Recommended in elektricM (cooling.md + prerequisites). 3-5C drop vs MX-6. | [confirmed: @nexgen3d, 10/04/2026]
| Arctic MX-6 | 10.0 W/mK | Current version. Recommended in elektricM (cooling.md). |
| Arctic MX-5 | Discontinued | Replaced by MX-6. pops1cl confirmed MX-5 is NOT better than MX-6. |
| Arctic MX-4 | 8.5 W/mK | Good value. Recommended in elektricM (prerequisites.md + cooling.md). |
| Thermal Grizzly Duronaut | ~12.5 W/mK | Emphasizes long-term stability per Thermal Grizzly. Our file previously claimed 17.3 W/mK - reseller data shows ~12.5 W/mK. 15C drop claim unverified. |

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
- "If you can sit it on its side while it's on the bench, it cools better like that" (nexgen3d, 23/12/2025)
- No quantitative community consensus on orientation differences exists yet
- Test your specific board and mounting orientation for optimal thermals

### With Liquid Cooling (240mm AIO)

Confirmed working models: Thermalright Aqua Elite 240 V2, V4, V6; MSI MAG CoreLiquid A15. Mounting uses a standard clip-style bracket with 3D-printed adapters; note many AIOs/coolers are hook-mount AM5 style, while "the LGA mount would work" (skcanss, 12/06/2026). nexgen3d designed an LGA 1851 adapter for the BC-250 bolt pattern, "specifically designed for the MSI Mag AIO, but may fit others" (10/01/2026). (Aqua Elite: gennro, 11/04/2026 -- "you may get a V2 or a V4 ordering that, but either work"; telefragger V6, 25/05/2026)

- Wall power draw under heavy stress (FurMark / LLM): "up to 370w" (filippor, 16/12/2025); "peak draw... only seen it that high on stress tests like furmark" (astrocast, 14/11/2025); skcanss: "when i see 340w from the wall its slightly worrisome" (15/06/2026)
- Stable OC targets: "overclocked to 4ghz + 2300mhz GPU... I'm pretty sure that's as far the hardware can go in a stable manner" (jpvgaster, 14/01/2026); gennro runs "3.85ghz cpu and 2.4ghz gpu" (11/04/2026); 4100MHz @ 1287mV passing stress tests (1_gec, 10/01/2026)
- Mounting: AMD spring clip mounts + 3D-printed adapters are the standard approach; some AIOs with built-in VRM fans are not compatible with spring clip mounts (james_28091_70948, 19/12/2025)

### Multi-Fan Control (J4003 Header)

The J4003 header connects to the power distribution board and provides PWM/tach pins for up to **five** fans (F1P/F1T through F5P/F5T), per [mothenjoyer69/bc250-documentation](https://github.com/mothenjoyer69/bc250-documentation/blob/main/hardware.md#j4003). The NCT6686D SuperIO chip "supports control for the main fan and any others that have their PWM/tach signal connected via J4003" and, "assuming that the nct6687d module is loaded, you can control the individual fans with something like CoolerControl" (essdee4336, 26/05/2026). Note: the connector is not a standard 3-4 pin header and is missing the +12V pin, so fans need 12V from elsewhere (danielemorr, 06/02/2026); BIOS fan numbering maps to Linux differently (BIOS 1-5 -> Linux 2,3,4,5,1).

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

### Heatsink-to-PCB Thermal Pads

iamdarkyoshi (17 Mar 2026) tested adding thermal pads between the heatsink and PCB directly behind individual GDDR6 memory ICs. The left-side ICs (with pads installed) were visibly cooler than the right-side ones (stock, without pads). This helps conduct heat from the memory chips through the PCB and into the heatsink.

**How to do it:** Reuse extra pad material from the backplate pads, squish it slightly to make it thick enough to contact both surfaces. The target thickness is "just barely thicker than the thermal pads used on the back." iamdarkyoshi recommends scrunching the stock backplate pad material to make it narrower and slightly thicker.

**Note:** Not all heatsinks have markings for these additional pad positions. iamdarkyoshi's second board had silkscreened marker positions; the first did not.

**Key takeaway:** Front cooling alone isn't enough. Pay attention to the back.

Sources: elektricM cooling.md (Backplate VRAM Cooling Solutions), iamdarkyoshi (17 Mar 2026)