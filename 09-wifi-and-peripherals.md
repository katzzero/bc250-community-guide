# 09 — WiFi & Peripherals

> The BC-250 has **no built-in WiFi or Bluetooth**. You need a USB adapter.

---

## WiFi Adapters

### ✅ Recommended

| Adapter | Chipset | WiFi | Bluetooth | Price | Notes |
|---------|---------|------|-----------|-------|-------|
| **TP-Link Archer TX10UB Nano** | MT7921AU | WiFi 6 (AX900) | BT 5.3 | ~$20 | Most consistently recommended. Works OOTB on Bazzite. Some BT disconnection reports on USB 3.0 ports — use USB 2.0 hub if issues arise. Separate WiFi + BT dongles recommended over combo units. |
| **UGreen AX900** | MT7921AU | WiFi 6 (AX900) | BT 5.3 | ~$20 | Similar to TP-Link AX900. Community tested on Bazzite (Italian sub-thread). Random WiFi drops reported (10s, self-healing). |
| **Fenvi FU-AX1800** | MediaTek | WiFi 6 (AX1800) | BT 5.0+ | ~$20 | "Works perfectly" on Bazzite. |
| **EDUP AX3000M** | MT7921AU | WiFi 6E (AX3000) | BT 5.0+ | ~$25 | Good Linux support, 6E band. |
| **TP-Link Archer T2UB Nano** | Realtek | WiFi 5 + BT 4.2 | BT 4.2 | ~$15 | Budget option. |

> **Official elektricM recommendation:** Realtek **RTL8822BU** chipset (in-kernel driver as of Linux 6.12+). Community testing favors **MediaTek MT7921AU** chipsets for best OOTB experience on Bazzite. If using a Realtek adapter that requires external drivers on Bazzite (immutable OS), prefer CachyOS or compile drivers via DKMS. Recommended driver repo for rtl88x2bu: [cilynx/rtl88x2bu](https://github.com/cilynx/rtl88x2bu).
>
> **Tip:** WiFi/BT combo dongles often cause BT disconnections on USB 3.0 ports. Use separate dongles for WiFi and BT, or plug the BT dongle into a USB 2.0 hub (Italian sub-thread, verified with kernel 6.19+). This applies to all combo adapters.

### ⚠️ Budget / Limited Support

| Adapter | Verdict | Notes |
|---------|---------|-------|
| **TP-Link Archer AC1300** | Works with driver | Requires `rtl88x2bu` driver — manual install |
| **TP-Link Archer TX35U Plus** | Has issues | Requires `rtw89` driver |
| **Comfast / Brostrend AX1800** | Not recommended | Latency and disconnection problems |

> **Note from elektricM:** Some custom kernel builds (e.g., Bazzite "performance mode") may not include your WiFi adapter's driver. Choose adapters with in-kernel drivers (like RTL8822BU) for best compatibility. If WiFi stops working after a kernel change, connect via Ethernet and reinstall the driver.

---

## Bluetooth Only (No WiFi)

If you already have Ethernet and just need Bluetooth:

| Adapter | Bluetooth | Price | ASIN | Notes |
|---------|-----------|-------|------|-------|
| **TP-Link UB500 Plus** | BT 5.3 | ~$10–15 | `B0DHJHMHFS` | Tiny, long range, adjustable antenna |
| **EDUP B3536** | BT 5.0 | ~$5 | Various | Dirt cheap from AliExpress |

---

## Storage — NVMe / SSDs

The BC-250 has a **single M.2 2280 slot** running at **PCIe 2.0 x2 (~1 GB/s max)** — also supports SATA III (~550 MB/s). Don't overspend — even cheap NVMe drives will saturate the bus.

Source: [elektricM specifications](https://elektricm.github.io/amd-bc250-docs/hardware/specifications/)

### ✅ Tested & Working

| Model | Capacity | Price | Notes |
|-------|----------|-------|-------|
| **Crucial P5 Plus** | Any | ~$0.25/GB | Full ~1 GB/s on PCIe 2.0 x2 |
| **Crucial P3** | 2 TB | ~$80 | Great value for bulk storage |
| **Crucial P310** | 1 TB | ~$55 | Tested, reliable |
| **Generic 1 TB NVMe** | 1 TB | ~$50 | Cheap "Amazon" drives work fine |
| **WD / Kioxia / PNY** | 2 TB | ~$100 | Good value, tested |
| **M.2 SATA drives** | Various | Varies | Slot supports SATA III as well |

> Recommended: 512 GB minimum for OS + games. 1 TB+ if you install many titles. 2 TB for bulk storage on a budget.

---

## USB Accessories

| Device | Model | Verdict | Notes |
|--------|-------|---------|-------|
| **USB-C Front Panel** | Duttek Type-E to USB-C (`B09M8J7CNW`) | Works | 10 Gbps USB 3.1 |
| **ATX Breakout Board** | JMT 6Pin (`B0CTCLV6Y1`) | Works | For server PSUs, includes 4x USB 2.0 |
| **USB Audio** | Creative Sound Blaster Play! 4 (`B08T9LM3LM`) | Works | Plug and play — see [08-Display & Audio](08-display-and-audio.md) |
| **USB Audio** | SABRENT AU-EMCB (`B00XM883BK`) | Works | Budget plug-and-play option | [confirmed: @essdee4336, 11/05/2026]
| **DisplayLink Dock** | V7 Universal (Best Buy `10872445`) | Works | Dual HDMI on Bazzite |
| **Dell ACP075EU** | Docking station | Works | Has DisplayLink + USB DAC |
| **2.5 GbE Adapter** | Generic | Finicky | May need manual Linux driver |

---

## Network — Ethernet

The BC-250 has a **built-in Realtek RTL8111H** Gigabit Ethernet port. Linux support is excellent — plug and play.

Source: [elektricM specifications](https://elektricm.github.io/amd-bc250-docs/hardware/specifications/)

For faster networking or WiFi 6E, consider a USB 2.5 GbE adapter, though driver support on Linux can be hit-or-miss.

---

## Keyboard & Input

The BC-250 ships without a power button header. Source: [elektricM specifications](https://elektricm.github.io/amd-bc250-docs/hardware/specifications/).

1. **Solder to onboard button** — two wires to the protruding button on the back of the board, move `AUTO_PWRON1` jumper from pins 1-2 to 2-3
2. **PSU latching switch** — wire PS_ON to GND with a latching switch
3. **USB keyboard for BIOS** — any standard USB keyboard works

> If using a USB numpad or special keyboard, ensure it works during BIOS entry (some exotic layouts may not function correctly when spamming Delete).

---

## Case & Mounting Accessories

| Item | Source | Notes |
|------|--------|-------|
| BC-250 4U Server Case | Original ASRock enclosure | Noisy stock fans — replace with 120mm |
| BC-250 Shell Case (3D print) | [Printables](https://www.printables.com/model/1228207) | Simple enclosure with fan mount — source: [elektricM cases](https://elektricm.github.io/amd-bc250-docs/community/cases/) |
| Fan shrouds | [Printables search for "BC-250"](https://www.printables.com/search/models?q=BC-250) | 145+ community designs documented |
| M3 Heated Inserts | Any | For 3D printed cases |
| Rubber Washers / Standoffs | Any | For vibration dampening |

> For the complete case catalog (145 documented designs as of elektricM docs): [elektricM Case Gallery](https://elektricm.github.io/amd-bc250-docs/community/cases/) — designs with PSU type, dimensions, and build notes. Source: [elektricM cases](https://elektricm.github.io/amd-bc250-docs/community/cases/).