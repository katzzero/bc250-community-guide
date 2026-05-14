# 01 -- Hardware Specifications

> Board: ASRock AMD BC-250 | Codename: "Ariel" (need confirmation -- not present in elektricM docs; community term) / "Cyan Skillfish"

---

## APU (System-on-Chip)

| Component | Detail |
|-----------|--------|
| **Full Name** | AMD BC-250 "Cyan Skillfish" |
| **Origin** | Cut-down PS5 "Oberon" APU -- 2 CPU cores and 12 GPU CUs disabled |
| **CPU** | 6x Zen 2 cores, ~3.5 GHz fixed base clock |
| **GPU** | 24x RDNA 2 Compute Units (CUs), codename gfx1013 |
| **GPU Base Clock** | 1500 MHz (locked without governor) |
| **GPU Max Clock** | 2000 MHz stock kernel - 2230 MHz with kernel patch + governor |
| **GPU Performance** | Comparable to RX 6600 / GTX 1660 Ti |
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
| VCN (HW encode/decode) | Disabled by Sony | Enabled |

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
| Fan Headers | 2x 4-pin PWM | J1 (primary) and J4003 (secondary) |
| Power Button | Onboard only | No header -- solder for external switch |
| TPM Header | 1 | 18-pin LPC header (TPMS1); no TPM chip included |

### Not Present
- HDMI output
- WiFi (use USB adapter)
- Bluetooth (use USB adapter)
- Thunderbolt
- Secure Boot
- Hardware video encode/decode (VCN firmware blocked by Sony)

---

## Power Consumption Reference

| State | Power Draw | Notes |
|-------|-----------|-------|
| Idle (no governor) | 85-105 W | GPU stuck at 1500 MHz |
| Idle (with governor) | 60-70 W | Community consensus (gennro, dantistnfs); SMU profile 0 saves ~15W vs profile 3 (gennro) |
| Idle (optimized) | 55-70 W | Governor + undervolting; sub-60W claims disputed (NexGen-3D); 48W perfprofile tweak is (need confirmation) |
| Desktop use | 70-90 W | Web browsing, office tasks |
| Light gaming | 120-150 W | Older/esports titles |
| AAA gaming | 160-200 W | Modern titles at 1080p |
| Maximum (Cyberpunk RT) | 235 W | Peak gaming load |
| Stress test (Furmark) | 250-320 W | Not realistic for daily use |

A GPU governor saves 20-30W at idle alone. See [06-GPU Governor](06-gpu-governor.md).

---

## Known Hardware Limitations

1. **IOMMU is broken** -- always disable in BIOS or face display failures
2. **No VCN firmware** -- hardware video encode/decode permanently unavailable
3. **PCIe 2.0 x2 only** -- SSD limited to ~1 GB/s (don't overspend on NVMe)
4. **A68H southbridge** [pops1cl] -- low-end chipset; Ethernet and USB 2.0 run through it, not the GPU (GPU is direct to APU)
5. **GDDR6 runs hot** -- backplate VRAM has no temperature sensor (need confirmation); ensure case airflow
