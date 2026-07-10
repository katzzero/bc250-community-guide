# 03 — Power Supply Guide

> The BC-250 requires a quality 12V-only PSU with a PCIe 8-pin connector.
> Minimum 300W stock, 400W+ recommended for overclocking, 500W+ for max OC.

---

## PSU Requirements Summary

- **Voltage:** 12V DC only — NOT 24V
- **Minimum:** 300W on 12V rail (stock operation)
- **Recommended:** 400W+ (moderate overclocking)
- **Max OC:** 500W+ (sustained loads can exceed 420W at wall)
- **Connector:** PCIe 8-pin (6+2 pin)
- **Rail:** Single +12V rail strongly recommended
- **TDP:** 220W rated, up to 235W typical gaming, 320W+ Furmark OC
- **Real-world:** ~120W CPU+VRAM, ~230W GPU at OC load; 480W+ at wall with max OC (nexgen3d)

---

## Flex ATX PSUs (Recommended for Small Cases)

| Model | Wattage | Verdict | Price | Notes |
|-------|---------|---------|-------|-------|
| **FSP500-30AS** | 500W (396W on 12V rail) | HIGHLY RECOMMENDED (US) | ~$10-22 + shipping (eBay) | 80+ Platinum, single +12V rail. PCIe 6+2 pin. 10-pin needs PS_ON bridged to GND. eBay shipping varies outside US. Caveats (gennro): only 396W on 12V rail, known coil whine at no-load, can fail under sustained high draw (reported killed at 350W+ sustained). One unit cooked at 1160mV/2400MHz (nexgen3d). US-only best deal. |
| **Metalfish Flex 500W** | 500W | Best non-US Flex (stock 24 CU only) | ~$37-80 (AliExpress) | 80+ Gold, modular. More efficient than generic cheap PSUs (~63W idle vs 79-84W generic). Build quality rivals Corsair. Stock 40mm fan is loud — replace with 24V GDStime dual ball bearing for quieter operation. Fan may lock up in off position requiring PWR_ON cycle (nexgen3d). **⚠️ Not safe for 40 CU** — melted under sustained 40 CU loads (.strykur, May 2026). For 40 CU, use FSP500 or dual-connector setup instead. |
| **Enhance ENP-7660B** | 600W | High quality | ~$50-80 | Premium build, more headroom. |
| **Apevia ITX-PFC500W** | 500W | Budget | ~$50 | Fully modular. Fan may not spin properly under load. |
| **Apevia ITX-PFC400W** | 400W | Budget | ~$35-45 | Amazon B0CWN49V13. Fully modular, 1U/Flex ATX. |
| **Apevia TFX-PFC500W** | 500W | Works | ~$60 | TFX form factor, 80mm fan, fixed cables. |
| **Silverstone Flex ATX** | Various | Works | Varies | Well-regarded, various models. |

### Problematic PSUs

| Model | Issue |
|-------|-------|
| Dell D220P-01 / D250AD-00 | 220W/250W insufficient — "cut out or even break" under gaming load |
| Metalfish Flex 600W (BD650M) | Protection circuit prevents boot with PCIe 8-pin only |
| Any 24V PSU | BC-250 requires 12V — will not work |
| Mean Well GST280A24-C6P | Wrong voltage (24V) |
| Dell DA-2 | 220W — insufficient for stock operation, but can run 40 CU undervolted at ~1700 MHz (hoodyracoon, May 2026). Not recommended for daily use. |
| Generic no-name Flex PSUs | Hit OCP at ~420W at wall; very inefficient (79-84W idle vs 63W Metalfish); built like "garbage" internally (nexgen3d). Sold under 20+ different word-salad names. Avoid. |

---

## Server PSUs (with Breakout Board)

Server PSUs offer excellent value but require a breakout board (~$10-20) and wiring. They are extremely loud — suitable for rack/garage only.

| Model | Wattage | Verdict | Price | Notes |
|-------|---------|---------|-------|-------|
| **HP DPS-800GB** | 800W | Works | Cheap (secondhand) | Very loud, requires breakout board |
| **Delta DPS-750RB** | 750W | Works | Cheap (secondhand) | Very loud |
| **Bitmain APW3++** | ~2000W | Works | Cheap (secondhand) | 220W idle draw! Not recommended for single board |

### Breakout Board Sources

| Board | Price | Link |
|-------|-------|------|
| Alkly Designs V2.1 | ~$20 | https://alklydesigns.com |
| AliExpress generic | ~$5-10 | Search `1005002523558890` |
| KCORES CSPS-to-ATX | DIY | GitHub KCORES/KCORES-CSPS-to-ATX-Converter |
| Amazon JMT Board | ~$15 | Amazon B0CTCLV6Y1 |

---

## Mean Well / Open Frame PSUs

The Mean Well LOP series has become the community's preferred PSU for custom case builds. They share the same 5" x 3" footprint (127mm x 76mm) for LOP-400/500/600, are ~95% efficient, medical-grade, and more compact than any Flex ATX unit.

| Model | Output | Verdict | Price | Dimensions | Notes |
|-------|--------|---------|-------|------------|-------|
| **Mean Well LOP-300-12** | 12V @ 25A (300W) | Entry level | ~$40 | 101.6 x 50.8 x 25.4 mm | 92.5% eff, fanless at 180W. Becoming underpowered for OC builds — "LOP-300 isn't really going to cut it" (nexgen3d). Now considered entry-level only. |
| **Mean Well LOP-400-12** | 12V @ 33.3A (400W) | RECOMMENDED | ~$65 | 127 x 76.2 x 27.5 mm | 94% eff, 250W convection / 400W with 23CFM fan. 150% peak @ 3s. "Perfect for most of you" running 4000MHz/2400MHz (nexgen3d). Best balance of cost/power. |
| **Mean Well LOP-500-12** | 12V @ 41.6A (500W) | For max OC | ~$78 | 127 x 76.2 x 30.5 mm | 93.5% eff, 320W convection / 500W with fan. Recommended if pushing maximum overclocks. |
| **Mean Well LOP-600-12** | 12V @ 50A (600W) | Top end | ~$84 | 127 x 76.2 x 35 mm | 93% eff, 400W convection / 600W with fan. Most efficient PSU nexgen3d has tested — beats Metalfish and Silverstone SFX 80+ Platinum. 65W idle with full system (pump, fans, RGB). |
| **LRS350-12** | 350W | Budget | ~$25 | Standard | Needs fan mod. |

**LOP series common features:**
- Input: 80-264VAC with active PFC
- No-load power < 0.5W
- Medical-grade (2 x MOPP), ITE, Household, Industrial certifications
- -40 to +80°C operating range
- Built-in 12V/0.5A auxiliary output for external fan
- Built-in remote sense (LOP-400/500/600)
- Output via M3 screw terminals — use yellow automotive loop crimps
- No PS_ON signal — always live when AC is connected
- Requires 23CFM fan for full rated output; convection rating is ~60-65% of max

**Real-world efficiency comparison (nexgen3d, Feb 2026):**
- LOP-600: 65W idle (with pump + 3 fans + RGB + Commander)
- Metalfish 500W: 63W idle (similar)
- Generic no-name Flex: 79-84W idle
- At load, LOP is more efficient than Metalfish and Silverstone SFX 80+ Platinum

**Selection guide:**
- **Stock / light OC:** LOP-300 (under 300W at wall)
- **Moderate OC (4000MHz/2400MHz):** LOP-400
- **Heavy OC (4200MHz/2475MHz+):** LOP-500
- **Maximum OC + headroom:** LOP-600

> LED/Industrial 12V PSUs are NOT recommended — unreliable ripple current and variable quality.

---

## Standard ATX PSUs

Any quality ATX PSU works when paired with PCIe 8-pin cable:

- **Minimum:** 400W total, 20A+ on 12V rail (240W+)
- **Efficiency:** 80 Plus Bronze or better recommended
- **Use existing:** Spare ATX PSU works fine with standard PCIe 8-pin cable

| Model | Verdict |
|-------|---------|
| Corsair SF600 / SF750 | Works — SFX quality |
| Corsair RM750e / RM750x | Works — Standard ATX |
| Any 400W+ ATX PSU | Works |

---

## Wiring and Connectors

### J1000 — PCIe 8-pin (6+2 pin) Pinout

```
[ GND GND GND GND ]
[ GND 12V 12V 12V ]
```

8-pin is preferred for OC loads. 6-pin works for most setups (missing pins are sense/ground).

### FSP500-30AS 10-Pin Pinout

```
_________Latch__________
  3.3V   GND   PS_ON  GND   GND
  3.3V   GND   5VSB   12V   12V
________________________
```

| Pin | Signal | Wire Color | Notes |
|-----|--------|------------|-------|
| 1 | 3.3V | Orange | |
| 2 | GND | Black | |
| 3 | PS_ON | Green | Short to GND to power on |
| 4 | GND | Black | |
| 5 | GND | Black | |
| 6 | 3.3V | Orange | |
| 7 | GND | Black | |
| 8 | 5VSB | Purple | Standby power |
| 9 | 12V | Yellow | Main power |
| 10 | 12V | Yellow | Main power |

### Generic Power-On Methods

**Auto Power-On (default):** Board starts when 12V is applied. Set AUTO_PWRON1 jumper (pins 1-2).

**Power Button (soldering required):** Solder wires to onboard button, connect to momentary switch.

**ATX PSU Control:** Short PS_ON (pin 16, green) to GND for always-on, or wire external switch.

### Cable Safety — Wire Gauge (AWG)

| AWG | Verdict | Max Current (~) | Notes |
|-----|---------|-----------------|-------|
| **12-14 AWG** | Oversized | 20-35A | Too rigid, overkill for BC-250 |
| **16 AWG** | **RECOMMENDED MINIMUM** | 13A | Safest choice for any configuration |
| **18 AWG** | Risky | 9.5A | Works for stock/light OC, but melted in Furmark under 1 min (capt.cat_13) |
| **20-22 AWG** | **DANGER — DO NOT USE** | 5-7A | Will melt under BC-250 load |

- Use **silicone wire** (handles high temperatures), **NEVER PVC/nylon** (melts)
- Avoid **CCA** (Copper-Clad Aluminum) and steel cables — some cheap PSUs (Apevia) use steel
- Be wary of Chinese cables that fake AWG (painted copper or iron)
- Verify the wire is **pure copper** before using
- Do NOT use SATA-to-PCIe adapters — fire hazard (SATA is rated 54W, board draws 235W)
- Do NOT use cheap 6-pin to 8-pin PCIe adapters for power delivery — they will melt
- Avoid Apevia PSUs — reports of steel wires in cables (essdee4336)
- **Metalfish PSUs** also reported to melt under 40 CU loads (.strykur, May 2026)
- The FSP500-30AS cables are high quality and rarely an issue (astrocast, essdee4336)
- **325W from wall** at 2000 MHz / 40 CU in Furmark VK; ~200W during gaming (hecto_77113, May 2026)
- **Single 8-pin safe limit:** ~260W from wall during gaming (dznuts, May 2026). Using 2 connectors (8-pin + Micro-Fit) is safer for 40 CU.
- fforduck warns: 250W+ on single 8-pin at 40 CU significantly increases melting risk.
- **At-wall consumption examples (nexgen3d, 2026):** ~120W CPU/VRAM + ~230W GPU at OC load; total can exceed 420W with Furmark VK + CPU stress, up to 480W+ with Metalfish PSU. LOP-600 measured 65W idle (pump + 3 fans + Commander + RGB).

### Onboard Micro-Fit Power Mod

The BC-250 has proprietary onboard Micro-Fit 3.0 power ports (`J2000` and `J2001`) that can supplement the PCIe connector. These provide additional power delivery paths to the board, reducing load on the PCIe 8-pin cable. Old Lamer (YouTube) demonstrated using them as alternate power delivery to avoid melted cables.

**Important context:** The boards were originally designed to be powered through these Micro-Fit connectors in the mining chassis. The PCIe 8-pin was NOT the primary power path in original use — it was added for repurposing (keroppl_wizard, Jul 2026). Running 40 CU + CPU OC through a single PCIe 8-pin means the connector carries far more current than ever intended.

**Connector Selection Guide:**

| Setup | Power Connectors | Safe For | Notes |
|-------|-----------------|----------|-------|
| **Single 8-pin** | PCIe 8-pin only | Stock 24 CU, light gaming (~200W from wall) | Minimum. Risky at 40 CU or heavy OC. |
| **8-pin + Micro-Fit** | PCIe 8-pin + 1 Micro-Fit | 40 CU daily, gaming (~260W from wall) | Recommended daily setup (dznuts: "two is fine"). Safer but not foolproof. |
| **8-pin + 2 Micro-Fit** | PCIe 8-pin + both J2000 + J2001 | 40 CU OC, Furmark (~325W+ from wall) | Maximum safety. "If you try to run it through the single PCI-E cable, it'll fry" (discombobulateddunce). |
| **2 Micro-Fit only** | Both J2000 + J2001, no PCIe 8-pin | Experimental | Alternative path. Less tested. |

**Micro-Fit safety notes:**
- Connectors held by friction alone — a securing bracket is recommended (astrocast)
- Wire only the middle two pins on both rows to prevent damage if connectors are swapped (cyrixblack)
- Use 16 AWG minimum silicone wire for Micro-Fit connections
- Community PCB adapter: [ded811/BC250-Power-Adapter](https://github.com/ded811/BC250-Power-Adapter) — adapts J2000/J2001 to standard PCIe 8-pin + EPS 8-pin headers (UNTESTED, waiting for fab boards)

essdee4336 tested the Micro-Fit mod: "it did seem to help slightly."

---

## ATX Power Control Community Projects

**BC250 ATX PSU Control Adapter** (pilimmm) — Add-on board for FSP500 10-pin that handles PS_ON automatically. No soldering for basic use. Press button to boot, OS shutdown turns PSU off. Optional isolated button output for BC250's internal power button. Focused on FSP500; 24-pin ATX version planned.
*Discord project-forums, March 2026.*

**BC-250 Remote PSU Controller** (wisserbasser / PetteriLah) — ESP32-based remote power control with web interface and PS5 controller support. Momentary press = power on, hold 5s = force off. OS shutdown puts ATX PSU in standby.
*GitHub: [PetteriLah/BC-250-PC-Remote-Control](https://github.com/PetteriLah/BC-250-PC-Remote-Control)*

---

## ATX Power Control Mod (Advanced)

By iamdarkyoshi: Allows full ATX PSU standby and sleep/wake support.

**Wire gauge specs (iamdarkyoshi, May 2026):**
- Purple (5V standby): spec for 3A max. Testing never exceeded ~2A even with USB-powered monitor.
- Green (PSON) and Grey (PWRGOOD): logic-level signals, few milliamps, any thin wire acceptable.
- Ground return path via main EPS12V ground wires -- no extra ground wire needed.
- 5V standby current drops to ~500mA when powered on (BC250 reroutes main 5V to USB ports).

1. Remove surface-mount inductor (internal 12V-to-5V standby converter)
2. Solder three wires: Violet (5VSB) to inductor pad, Green (PS_ON), Grey (Power Good optional)
3. Connect to matching ATX PSU colors

---

## Purchase Links

| Item | Source | Link/ASIN |
|------|--------|-----------|
| FSP500-30AS | eBay | Search 389522369783 |
| FSP500 10-pin connector | DigiKey | 0469931011 |
| Mean Well LOP-300-12 | DigiKey / Mouser | LOP-300-12 |
| Mean Well LOP-400-12 | Mouser / DigiKey | LOP-400-12 (~$65) |
| Mean Well LOP-500-12 | Mouser / DigiKey / TRC | LOP-500-12 (~$78) |
| Mean Well LOP-600-12 | Mouser / DigiKey / TRC | LOP-600-12 (~$84) |
| Arctic P12 Pro 5-pack | Amazon | B0DJDDCG4M |
| Apevia ITX-PFC400W | Amazon | B0CWN49V13 |
| Apevia TFX-PFC500W | Amazon | B0CWNDFKHF |
| HP Breakout Board | Alkly Designs | alklydesigns.com |

---

*Sources: elektricM/amd-bc250-docs hardware/power.md (primary), FSP spec sheets (80+ Platinum verified), Mean Well official specs (LOP-400/500/600 datasheets), Discord community (nexgen3d, gennro, essdee4336, big_trov, dznuts, hecto_77113, capt.cat_13, astrocast, cyrixblack, fforduck, .strykur). Discord sources verified from export files Jan-May 2026.*
