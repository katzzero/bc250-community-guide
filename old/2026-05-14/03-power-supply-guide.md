# 03 — Power Supply Guide

> The BC-250 requires a quality 12V-only PSU with a PCIe 8-pin connector.
> Minimum 300W stock, **400W+ recommended** for overclocking.

---

## ⚡ PSU Requirements Summary

- **Voltage:** 12V only — **NOT** 24V
- **Minimum:** 300W (stock, no OC)
- **Recommended:** 400W+ (with overclocking headroom)
- **Connector:** PCIe 8-pin (6+2 pin)
- **Rail:** Single +12V rail strongly recommended

---

## Flex ATX PSUs (Recommended for Small Cases)

| Model | Wattage | Verdict | Price | Notes |
|-------|---------|---------|-------|-------|
| **FSP500-30AS** | 500W | ⭐ **HIGHLY RECOMMENDED** | ~$10–22 (eBay) | 80+ **Platinum**, single +12V rail, quiet. Has PCIe 6+2 pin cable. 10-pin connector needs PS_ON bridged to GND. |
| **Enhance ENP-7660B** | 600W | ✅ Recommended | ~$50–80 | High quality, more headroom than FSP500. |
| **Apevia ITX-PFC500W** | 500W | ✅ Works | ~$50 | Fully modular, fan-cooled. Fan may not spin properly under load on some units. |
| **Apevia ITX-PFC400W** | 400W | ✅ Budget option | ~$35–45 | Amazon: `B0CWN49V13`. Fully modular, 1U/Flex ATX. |
| **Apevia TFX-PFC500W** | 500W | ✅ Works | ~$60 | TFX form factor (not Flex ATX). 80mm fan, fixed cables. Amazon: `B0CWNDFKHF`. |
| **Metalfish Flex 500W** | 500W | ⚠️ Mixed | ~$37–80 (AliExpress) | 80+ Gold, modular. **Can be noisy.** Some units have protection circuit issues. |
| **Silverstone Flex ATX** | Various | ✅ Works | Varies | Various models, well-regarded brand. |

### ⚠️ Problematic PSUs

| Model | Issue |
|-------|-------|
| Metalfish Flex **600W** (BD650M) | Protection circuit prevents boot with only PCIe 8-pin connected |
| **Any 24V PSU** | BC-250 requires 12V — **will not work** |
| Mean Well GST280A24-C6P | Wrong voltage (24V) |
| Dell DA-2 / DA-220P | Too low wattage (220W) |

---

## Server PSUs (with Breakout Board)

Server PSUs offer excellent value but require a breakout board (~$10–20) and wiring.

| Model | Wattage | Verdict | Price | Notes |
|-------|---------|---------|-------|-------|
| **HP HSTNS-PL28** | 460W | ⭐ Best value | ~$10–15 eBay | Runs at ~50% capacity. Silent. Default fan 1500–1800 RPM. |
| **HP HSTNS-PR28** | 460W | ✅ Works | ~$15 | Silent, provides more than enough power. |
| **HP HSTNS-PL29** | 750W | ✅ Works | ~€15 | Very quiet at low draw. |
| **HP DPS-1200FB** | 1200W | ✅ Works | ~$20–30 | Best documented. Cheap breakout boards available. Massive overkill. |
| **HP HSTNS-PL18** | 750W | ⚠️ Loud | ~$15 | Loud coil whine under load. |
| **HP HSTNS-PL14** | Various | ⚠️ Loud | Varies | Loud coil whine. |
| **Dell D750E-S1** | 750W | ✅ Works | ~$15 | Quiet server PSU. |
| **Dell F495E** | 495W | ✅ Works | Varies | Quiet, 80+ Platinum. |
| **Dell N870P** | 870W | ✅ Works | Varies | 12V @ 71A. Well-documented hack. |

### Breakout Board Sources

| Board | Price | Link |
|-------|-------|------|
| Alkly Designs V2.1 | ~$20 | [alklydesigns.com](https://alklydesigns.com/products/hp-server-psu-breakout-board-v2-1) |
| AliExpress generic | ~$5–10 | Search `1005002523558890` |
| KCORES CSPS-to-ATX | DIY | [GitHub](https://github.com/KCORES/KCORES-CSPS-to-ATX-Converter) |
| Amazon JMT Board | ~$15 | Amazon: `B0CTCLV6Y1` |

### HP Common Slot Connector

Pinout for HP server PSUs:

| Pin | Signal | Notes |
|-----|--------|-------|
| 33 | EN / PS_ON | 3.3V logic |
| 34 | GND | |
| 35 | Power Good | |
| 36 | PS_KILL / PRESENT | Pull to 12V to enable |
| 37 | +12V Standby | Management voltage |

---

## Mean Well / Open Frame PSUs

| Model | Output | Verdict | Price | Notes |
|-------|--------|---------|-------|-------|
| **Mean Well LOP-300-12** | 180W passive / 300W with fan | ⭐ Recommended | ~$40 | 92–94% efficiency, fanless at 180W. Needs 16 AWG wiring. Completely silent without fan. |
| **LRS350-12** | 350W | ✅ Budget | ~$25 | Needs fan mod. |

> **LOP-300-12 spec highlights:**
> - Input: 80–264VAC
> - Output: 12V @ 25A (fan-cooled) / 15A (convection)
> - Efficiency: 92.5%
> - Dimensions: 101.6 × 50.8 × 25.4 mm
> - Built-in 12V/0.5A auxiliary fan output
> - No PS_ON signal — always live when AC is connected. Use AC switch or relay for on/off.

---

## Standard ATX PSUs

Any quality ATX PSU works with the BC-250 when paired with a Flex-to-ATX adapter:

| Model | Verdict |
|-------|---------|
| Corsair SF600 / SF750 | ✅ Works — SFX quality |
| Corsair RM750e / RM750x | ✅ Works — Standard ATX, 80+ Gold |
| Any 400W+ ATX PSU | ✅ Works with adapter |

---

## Wiring & Connectors

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
| 3 | **PS_ON** | **Green** | Short to GND to power on |
| 4 | GND | Black | |
| 5 | GND | Black | |
| 6 | 3.3V | Orange | |
| 7 | GND | Black | |
| 8 | 5VSB | Purple | Standby power |
| 9 | 12V | Yellow | Main power |
| 10 | 12V | Yellow | Main power |

**How to power on:**
- Short **Pin 3 (Green)** to any adjacent GND pin (2, 4, 5, or 7)
- Use: paperclip, jumper wire, momentary switch, or toggle switch
- An **8-pin EPS CPU extension** fits 8 of 10 pins — solder a switch between PS_ON and GND

### Molex Mini-Fit Jr Connector

| Part | Details |
|------|---------|
| Connector | Molex Mini-Fit Jr, 4.20mm pitch |
| Part Number | **0469931011** |
| DigiKey | [Link](https://www.digikey.com/en/products/detail/molex/0469931011/5116026) |

### ⚠️ Safety Warning

**Do NOT use cheap 6-pin to 8-pin PCIe adapters for power delivery** — they will melt. These adapters are only safe for PS_ON jumper use.

---

## ATX Power Control Mod (Advanced)

By [@iamdarkyoshi](https://youtube.com/watch?v=jIhgyB8x3fQ): Allows full ATX PSU control with standby and sleep/wake support.

1. Remove surface-mount inductor (internal 12V-to-5V standby converter)
2. Solder three wires using standard ATX colors:
   - **Violet** = 5V standby → inductor pad
   - **Green** = PS_ON
   - **Grey** = Power Good (optional)
3. Connect to matching ATX PSU colors
4. If PSU uses 3.3V PS_ON (some servers), add a diode to prevent backfeed

Works with: Standard ATX supplies, Dell server PSUs with 12VSB, HP 460W HSTNS-PR17.

---

## Purchase Links

| Item | Source | Link/ASIN |
|------|--------|-----------|
| FSP500-30AS | eBay | Search `389522369783` |
| FSP500 10-pin connector | DigiKey | [0469931011](https://www.digikey.com/en/products/detail/molex/0469931011/5116026) |
| Arctic P12 Pro 5-pack | Amazon | `B0DJDDCG4M` |
| Apevia ITX-PFC400W | Amazon | `B0CWN49V13` |
| Apevia TFX-PFC500W | Amazon | `B0CWNDFKHF` |
| Mean Well LOP-300-12 | DigiKey | [LOP-300-12](https://www.digikey.com/en/products/detail/mean-well-usa-inc/LOP-300-12/22040911) |
| HP Breakout Board V2.1 | Alkly Designs | [Link](https://alklydesigns.com/products/hp-server-psu-breakout-board-v2-1) |
| HP Breakout Board | AliExpress | `1005002523558890` |