# 03 — Power Supply Guide

> The BC-250 requires a quality 12V-only PSU with a PCIe 8-pin connector.
> Minimum 300W stock, 400W+ recommended for overclocking.

---

## PSU Requirements Summary

- **Voltage:** 12V DC only — NOT 24V
- **Minimum:** 250W on 12V rail (300W+ PSU recommended)
- **Recommended:** 400W+ (with overclocking headroom)
- **Connector:** PCIe 8-pin (6+2 pin)
- **Rail:** Single +12V rail strongly recommended
- **TDP:** 220W rated, up to 235W typical gaming, 320W Furmark OC

---

## Flex ATX PSUs (Recommended for Small Cases)

| Model | Wattage | Verdict | Price | Notes |
|-------|---------|---------|-------|-------|
| **FSP500-30AS** | 500W (396W on 12V rail) | HIGHLY RECOMMENDED | ~$10-22 + shipping (eBay) | 80+ Platinum, single +12V rail. PCIe 6+2 pin. 10-pin needs PS_ON bridged to GND. eBay shipping cost varies outside US. Caveats (gennro): only 396W on 12V rail, known coil whine at no-load, can fail under sustained high draw (reported killed at 350W+ sustained). |
| **Enhance ENP-7660B** | 600W | Recommended | ~$50-80 | High quality, more headroom. |
| **Apevia ITX-PFC500W** | 500W | Works | ~$50 | Fully modular. Fan may not spin properly under load on some units. |
| **Apevia ITX-PFC400W** | 400W | Budget option | ~$35-45 | Amazon B0CWN49V13. Fully modular, 1U/Flex ATX. |
| **Apevia TFX-PFC500W** | 500W | Works | ~$60 | TFX form factor, 80mm fan, fixed cables. Amazon B0CWNDFKHF. |
| **Metalfish Flex 500W** | 500W | Mixed | ~$37-80 (AliExpress) | 80+ Gold, modular. Can be noisy. Some units have protection circuit issues. |
| **Silverstone Flex ATX** | Various | Works | Varies | Various models, well-regarded. |

### Problematic PSUs

| Model | Issue |
|-------|-------|
| Dell D220P-01 / D250AD-00 | 220W/250W insufficient — "cut out or even break" under gaming load |
| Metalfish Flex 600W (BD650M) | Protection circuit prevents boot with PCIe 8-pin only |
| Any 24V PSU | BC-250 requires 12V — will not work |
| Mean Well GST280A24-C6P | Wrong voltage (24V) |
| Dell DA-2 | Too low wattage |

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
| Alkly Designs V2.1 | ~$20 | alklydesigns.com |
| AliExpress generic | ~$5-10 | Search `1005002523558890` |
| KCORES CSPS-to-ATX | DIY | GitHub KCORES/KCORES-CSPS-to-ATX-Converter |
| Amazon JMT Board | ~$15 | Amazon B0CTCLV6Y1 |

---

## Mean Well / Open Frame PSUs

| Model | Output | Verdict | Price | Notes |
|-------|--------|---------|-------|-------|
| **Mean Well LOP-300-12** | 12V @ 25A (300W) | RECOMMENDED | ~$40 | Medical-grade, 92.5% efficiency, requires custom wiring |
| **LRS350-12** | 350W | Budget | ~$25 | Needs fan mod |

**LOP-300-12 spec highlights:**
- Input: 80-264VAC
- Fanless at 180W, 300W with active fan
- Dimensions: 101.6 x 50.8 x 25.4 mm
- No PS_ON signal — always live when AC is connected

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

### Cable Safety

- Use **16 AWG minimum** wire (18 AWG has caused melted cables)
- Do NOT use SATA-to-PCIe adapters — fire hazard (SATA is rated 54W, board draws 235W)
- Do NOT use cheap 6-pin to 8-pin PCIe adapters for power delivery — they will melt

---

## ATX Power Control Mod (Advanced)

By iamdarkyoshi: Allows full ATX PSU standby and sleep/wake support.

1. Remove surface-mount inductor (internal 12V-to-5V standby converter)
2. Solder three wires: Violet (5VSB) to inductor pad, Green (PS_ON), Grey (Power Good optional)
3. Connect to matching ATX PSU colors

---

## Purchase Links

| Item | Source | Link/ASIN |
|------|--------|-----------|
| FSP500-30AS | eBay | Search 389522369783 |
| FSP500 10-pin connector | DigiKey | 0469931011 |
| Arctic P12 Pro 5-pack | Amazon | B0DJDDCG4M |
| Apevia ITX-PFC400W | Amazon | B0CWN49V13 |
| Apevia TFX-PFC500W | Amazon | B0CWNDFKHF |
| Mean Well LOP-300-12 | DigiKey | LOP-300-12 |
| HP Breakout Board | Alkly Designs | alklydesigns.com |

---

*Sources: elektricM/amd-bc250-docs hardware/power.md (primary), FSP spec sheets (80+ Platinum verified), Discord community. (need confirmation) on eBay/Amazon ASINs not in elektricM docs.*
