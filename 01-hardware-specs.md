# 01 -- Hardware Specifications

> Board: ASRock AMD BC-250 | Codename: "Ariel" (community term, not in elektricM docs) / "Cyan Skillfish"

---

## APU (System-on-Chip)

| Component | Detail |
|-----------|--------|
| **Full Name** | AMD BC-250 "Cyan Skillfish" |
| **Origin** | Cut-down PS5 "Oberon" APU -- 2 CPU cores and 12 GPU CUs disabled |
| **CPU** | 6x Zen 2 cores, ~3.5 GHz fixed base clock |
| **GPU** | 24x RDNA 2 Compute Units (CUs), up to 40 CU unlockable via `bc250-cu-live-manager` (UMR-based, no kernel patch/reboot) or kernel patch (duggasco/bc250-40cu-unlock); codename gfx1013 |
| **GPU Base Clock** | 1500 MHz (locked without governor) |
| **GPU Max Clock** | 2000 MHz stock kernel, 2230 MHz with governor, 2400 MHz community ceiling (OCP hard lock above ~2300 MHz at 40 CU — requires power cable pull to recover) |
| **GPU Performance** | Stock 24 CU: between RX 6600 and RX 6600 XT. 40 CU unlocked: RX 6700 / GTX 1080 Ti level. No INT8 support = no FSR4 (gennro, fforduck) |
| **Memory** | 16 GB GDDR6 (PS5 spec), 14 Gbps, 256-bit bus, ~448 GB/s bandwidth |
| **Memory Split** | Configurable in BIOS -- see [02-BIOS](02-bios-and-firmware.md) |
| **TDP** | 220W typical, up to 235W under extreme load |

### PS5 Comparison

| Feature | BC-250 | PS5 |
|---------|--------|-----|
| CPU Cores | 6 | 8 |
| CPU Clock | ~3.5 GHz fixed | Up to 3.5 GHz (variable) |
| GPU CUs | 24 | 36 |
| GPU Clock | 2000 MHz max (stock) | 2230 MHz (variable) |
| Memory | 16 GB GDDR6 shared | 16 GB GDDR6 unified |
| VCN (HW encode/decode) | Blocked (NOT fused off — research active) | Enabled |

---

## Board Physical Specs

| Spec | Value |
|------|-------|
| Form Factor | Custom mining board (non-standard) |
| Length | ~340 mm / ~310 mm (varies by measurement method) |
| Width | ~115 mm |
| PCB Thickness | Standard |
| Weight | ~400 g (with stock heatsink) |

---

## Connectors & Ports

| Port | Count | Notes |
|------|-------|-------|
| DisplayPort 1.4 | 1 | Full-size, no HDMI -- requires adapter |
| USB 3.0 | 2 | Type-A |
| USB 2.0 | 2 | Type-A |
| Gigabit Ethernet | 1 | Realtek RTL8111H -- no built-in WiFi |
| M.2 2280 Slot | 1 | PCIe 2.0 x2 NVMe or SATA III |
| PCIe 8-pin (6+2) | 1 | Main power connector |
| Fan Headers | 2x 4-pin PWM | J1 (primary, near PCIe connector) and J4003 (secondary) |
| Micro-Fit 3.0 Ports | 2x onboard | Can supplement PCIe 8-pin for 40 CU builds (undocumented feature) |
| Power Button | Onboard only | No header -- solder for external switch |
| TPM Header | 1 | 18-pin LPC header (TPMS1); no TPM chip included |

### Not Present
- HDMI output
- WiFi (use USB adapter)
- Bluetooth (use USB adapter)
- Thunderbolt
- Secure Boot
- Hardware video encode/decode (VCN firmware blocked by Sony; NOT fused off — active community research, partial decode achieved via SMU commands: holde, Angablade)

---

## Power Consumption Reference

| State | Power Draw | Notes |
|-------|-----------|-------|
| Idle (no governor) | 85-105 W | GPU stuck at 1500 MHz |
| Idle (with governor) | 60-70 W | Community consensus (gennro, dantistnfs); SMU profile 0 saves ~15W vs profile 3 (gennro) |
| Idle (optimized) | 55-70 W | Governor + undervolting; sub-60W claims disputed (NexGen-3D) |
| Desktop use | 70-90 W | Web browsing, office tasks |
| Light gaming | 120-150 W | Older/esports titles |
| AAA gaming | 160-200 W | Modern titles at 1080p |
| Maximum (Cyberpunk RT) | 235 W | Peak gaming load |
| Stress test (Furmark) | 250-320 W | Not realistic for daily use |

A GPU governor saves 20-30W at idle alone. See [06-GPU Governor](06-gpu-governor.md).

---

## Known Hardware Limitations

1. **IOMMU is broken** -- always disable in BIOS or face display failures
2. **No VCN firmware** -- hardware video encode/decode blocked by Sony, but VCN block is NOT fused off. Active research: holde and Angablade achieved partial decode via SMU commands (May 2026). Not functional for end users yet.
3. **PCIe 2.0 x2 only** -- SSD limited to ~1 GB/s (don't overspend on NVMe)
4. **A68H southbridge** (discovered by pops1cl) -- low-end chipset; Ethernet and USB 2.0 run through it, not the GPU (GPU is direct to APU)
5. **GDDR6 runs hot** -- backplate VRAM has no temperature sensor; ensure case airflow and backplate cooling with a fan on the rear of the board (essdee4336, thecoolmagnet) [confirmed: @tominkz2137, 12/01/2026]
6. **No INT8 support** -- PS5 APU lacks INT8 instructions required for FSR4; BC-250 will never support FSR4 (gennro, fforduck, May 2026)
7. **Expandable to 40 CUs** -- 16 harvested CUs unlockable via `bc250-cu-live-manager` (UMR-based, no kernel patch, works on stock kernel) or kernel patch ([duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock)). See [02-BIOS & Firmware](02-bios-and-firmware.md) for full procedures.
8. **OCP power limit** -- secondary Over Current Protection triggers hard lock at ~1850-2200 MHz on 40 CU boards (varies per board). 2400 MHz causes OCP hard lock across all tested boards — requires power cable pull to recover (big_trov, codyrainy, cralant). VRM temps are a hidden bottleneck (capt.cat_13).
9. **Micro-Fit power supplement** -- onboard Micro-Fit 3.0 ports can supplement the single PCIe 8-pin for 40 CU builds (Old Lamer/YouTube, tested by essdee4336). Recommended above 260W sustained.

---

## 40 CU Power Reference (Unlocked)

| Config | pp512 tok/s | Power | Temp | SCLK |
|--------|-------------|-------|------|------|
| Stock 24 CU | 230 | 95W | 79C | 1500 MHz (governor) |
| 40 CU unlocked | 372 | 125W | 83C | 1500 MHz (governor) |
| 40 CU @ 2 GHz governor | 466 | 181W | 96C | 2000 MHz |

**Idle comparison (big_trov, May 2026):** At 350 MHz / 700 mV, idle power is essentially identical regardless of CU count: 4 CU = 68W, 24 CU = 69W, 40 CU = 70W. No reason to disable CUs at idle. Downclocking GPU to 50 MHz @ 650 mV gives 64W from wall (pops1cl, FSP500-30AS).

**Efficiency insight (big_trov):** More CUs at lower clocks match the performance of fewer CUs at higher clocks, at significantly lower temperature and power. Example: 40 CU at 1200 MHz = 60 FPS at 73C (30W less than 24 CU at 2000 MHz achieving same FPS).

1500 MHz / 900 mV is the recommended sweet spot for 40 CUs (duggasco, scallion_9883). See [02-BIOS & Firmware](02-bios-and-firmware.md) for full procedures and [07-Game Benchmarks](07-game-benchmarks.md) for 40 CU gaming FPS.