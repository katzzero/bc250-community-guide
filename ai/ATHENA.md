# ATHENA — AI Task & Knowledge Heuristic for Enhanced Navigation & Analysis

**Codename:** ATHENA (Goddess of Wisdom, Crafts, and Strategic Warfare)
**Purpose:** Standard operating procedure for AI agents maintaining the BC-250 Community Guide
**Root:** `/Users/toneves/Documents/resume/`
**Repository:** `https://github.com/katzzero/bc250-community-guide`
**Last Updated:** 2026-05-14

---

## I. Core Principles

### 1. No Lies, No Guessing
Every claim in the documentation must be verified against a source. If a claim cannot be verified, append `(need confirmation)`. Do NOT fabricate specifications, ASINs, URLs, or performance numbers.

### 2. Source of Truth Hierarchy
When conflicting information exists, resolve using this hierarchy:

```
1. elektricM/amd-bc250-docs (GitHub repo) — PRIMARY SOURCE
   Local clone: /Users/toneves/Documents/resume/export/elektricM-docs/
   Online: https://github.com/elektricM/amd-bc250-docs
   Site: https://elektricM.github.io/amd-bc250-docs/

2. Live Discord community exports — SECONDARY SOURCE
   Export directory: /Users/toneves/Documents/resume/export/
   DiscordChatExporter: /Users/toneves/Documents/resume/exporter/DiscordChatExporter.Cli
   Exports may contain newer info that supersedes elektricM

3. Verified web sources — TERTIARY SOURCE
   Amazon ASINs, manufacturer spec sheets, official GitHub repos
```

When Discord data contradicts elektricM, the NEWER information wins (community knowledge evolves). Always note which source was used and attribute the user who provided the information.

### 3. Attribution Rule
If a Discord community member affirms or corrects a claim, add their username in brackets at the point of the claim. Example:
```
Idle power: 60-70W (gennro, dantistnfs)
```
Generic "Discord user" is acceptable only when the username is not available in the export.

### 4. File Structure Rules
```
/Users/toneves/Documents/resume/
  export/
    elektricM-docs/          # Cloned source of truth repo
    bc250-chat/              # Discord exports (352 files)
    bc250-resources/         # Discord forum exports (139 files)
    bc250-flex-chat/         # Discord flex chat exports (47 files)
    benchmarks/              # Discord benchmark exports (104 files)
    new/                     # Recently exported Discord messages
  exporter/                  # DiscordChatExporter binary (gitignored)
  Revised/                   # Git repository root
    .git/
    old/
      2026-05-14/            # Archived previous version
    README.md                # Current V2 docs (community-attributed)
    01-hardware-specs.md     # Current V2 docs
    02-bios-and-firmware.md
    03-power-supply-guide.md
    04-cooling-guide.md
    05-os-installation.md
    06-gpu-governor.md
    07-game-benchmarks.md
    08-display-and-audio.md
    09-wifi-and-peripherals.md
    10-troubleshooting.md
    11-community-and-resources.md
    changelog.md             # Full audit trail
    .gitignore
    CONTRIBUTING.md
  ai/
    ATHENA.md                # This file
```

### 5. Documentation Conventions
- No emojis in documentation files
- No code comments (comments explaining code)
- Markdown tables for structured data
- Code blocks with language identifiers for commands
- Attribution brackets: `[username]` for community-sourced info
- Uncertainty marker: `(need confirmation)` for unverified claims
- Numbered file prefix (01-*, 02-*, etc.) for ordered topics

---

## II. Verification Protocol

### When Adding New Information
1. Check elektricM docs first (local clone at export/elektricM-docs/)
2. If not found, search Discord exports in export/ directory
3. If found in Discord, attribute to the user who posted it
4. If neither source has it, mark as `(need confirmation)`
5. Verify ASINs against Amazon listings
6. Verify technical specs against manufacturer documentation

### When Correcting Existing Information
1. Identify the error
2. Find the correct information in the source of truth
3. Note both the old claim and the correction in changelog.md
4. Update the documentation file with correction + attribution
5. Commit with descriptive message referencing the correction source

### Discord Export Procedure
```bash
# Export recent messages from bc250-chat (channel ID: [REDACTED])
/Users/toneves/Documents/resume/exporter/DiscordChatExporter.Cli export \
  -t "TOKEN" \
  -c CHANNEL_ID \
  -f PlainText \
  -o /Users/toneves/Documents/resume/export/new/ \
  --after YYYY-MM-DD \
  --partition 100

# Export a specific thread
/Users/toneves/Documents/resume/exporter/DiscordChatExporter.Cli export \
  -t "TOKEN" \
  -c THREAD_ID \
  -f PlainText \
  -o /Users/toneves/Documents/resume/export/FILENAME.txt

# List channels in guild (guild ID: [REDACTED])
/Users/toneves/Documents/resume/exporter/DiscordChatExporter.Cli channels \
  -t "TOKEN" \
  -g [REDACTED]

# Export all guild channels (can be slow)
/Users/toneves/Documents/resume/exporter/DiscordChatExporter.Cli exportguild \
  -t "TOKEN" \
  -g [REDACTED] \
  -f PlainText \
  -o /Users/toneves/Documents/resume/export/new/ \
  --include-threads All \
  --parallel 3
```

---

## III. Key Facts Reference

### Board Specs
- APU: AMD BC-250 "Cyan Skillfish" (cut-down PS5 Oberon)
- CPU: 6x Zen 2 cores at ~3.5 GHz fixed
- GPU: 24 RDNA 2 CUs (gfx1013/Cyan Skillfish)
- GPU base clock: 1500 MHz (locked without governor)
- GPU max clock: 2000 MHz stock, 2230 MHz with kernel patch + governor
- Memory: 16 GB GDDR6, 14 Gbps, 256-bit, ~448 GB/s
- TDP: 220W typical, up to 235W gaming, 250-320W stress test
- Display: 1x DisplayPort 1.4 (no HDMI, no WiFi, no BT)
- Storage: 1x M.2 2280 (PCIe 2.0 x2 or SATA III)
- Ethernet: Realtek RTL8111H Gigabit
- USB: 2x USB 3.0 + 2x USB 2.0
- Power: PCIe 8-pin (6+2), 12V only
- Chipset: A68H Bolton-D2H FCH

### BIOS
- Recommended: P3.00 modded (Segfault)
- P5.00 available but dangerous for inexperienced users
- VRAM: 512MB dynamic recommended (~14 GB GTT)
- IOMMU: MUST be disabled (broken)
- CMOS clear required after flash (battery 60s, jumper, or both)

### Software
- Kernel: 6.19.x recommended (gennro), 6.18 LTS stable fallback
  - Avoid: 6.15.0-6.15.6, 6.17.8-6.17.10
- Mesa: 26.x recommended, 25.1+ minimum
- GPU Governor: cyan-skillfish-governor-smu (SMU, no kernel patch)
- Distributions: Fedora 43+, Bazzite, CachyOS, Arch, Debian, Nobara
- Drivers: RADV (Mesa), no Windows drivers exist

### Power
- Idle (no governor): 85-105W
- Idle (with governor): 60-70W (gennro, dantistnfs)
- Gaming: 120-200W
- Peak: 235W (Cyberpunk RT), 250-320W (Furmark)
- FSP500-30AS: 396W on 12V rail, known coil whine, can fail under sustained 350W+ (gennro)

### Cooling
- Stock heatsink: passive aluminum fin stack, requires active fan
- Arctic P12 Pro: 77 CFM, 6.9 mmH2O, 3000 RPM, ~25 dB
- Arctic P12 Max: 81 CFM, 4.35 mmH2O, 3300 RPM
- PTM7950: recommended for APU die
- Thermal pads: 1.5mm front, 2.0mm back

### VCN
- Status: NOT fused off. Active research (holde, Angablade)
- Partial decode achieved via SMU commands
- Not yet functional for end users

### VRR
- Working via: CachyOS native, Bazzite testing, custom Bazzite image, kernel 6.19+
- Adapters: UGREEN 8K DP-to-HDMI 2.1, Cable Matters 8K

### Audio
- DP audio: Fixed in Linux 6.19.10+ (TheFloW via fanoush_)
- Not 100% for active DP-to-HDMI adapters
- USB audio: Sabrent AU-EMCB (B00XM883BK), Creative Sound Blaster Play! 3 (B06XBZ38ZJ)

---

## IV. Git Commit Convention

Format:
```
<topic>: <brief description (max 72 chars)>

<optional details, each correction should cite the source>
```

Examples:
```
Extract new Discord msgs (May 2026): Forza H6/FFVII Remake benchmarks, Gamescope artifact fix, VRR Bazzite image

Apply community corrections from pops1cl: fix southbridge claim, kernel note, MX-5/6 paste, DP audio fix in 6.19.10+

V2: Full cross-check against elektricM source of truth. Every claim verified. Corrections applied...
```

---

## V. Critical Warnings

1. **Smokeless_UMAF can permanently damage the board** — must be in every file that mentions BIOS tools
2. **No Windows GPU drivers exist** — Linux is required for any graphics
3. **IOMMU must be disabled** — causes display failures
4. **SIO1_R chip must NOT be flashed** — will brick SuperIO
5. **6-pin to 8-pin adapters are fire hazards** — SATA is rated for 54W, board draws 235W
6. **Do not use Smokeless_UMAF**
7. **Minimum governor voltage is 700 mV** — below that GPU locks to 1500 MHz
8. **Do NOT drill holes in heatsink** — zip ties or 3D printed shrouds only

---

## VI. Export Directory Contents Reference

```
export/
├── elektricM-docs/        # 36 markdown files, primary source of truth
├── bc250-chat/            # 352 exports, main chat channel
├── bc250-flex-chat/       # 47 exports, flex/build showcase channel
├── bc250-resources/       # 139 exports, forum threads (knowledge base)
├── benchmarks/            # 104 exports, game-specific benchmark threads
├── new/                   # Recently exported data
├── thread-corrections.txt (deleted - contained token data)
├── discord-export.txt     (deleted - contained token data)
└── channel-export [part X].txt (2795 files, older export format)
```

**Key Channel IDs:**
- bc250-chat: [REDACTED]
- bc250-flex-chat: [REDACTED]
- bc250-resources (forum): [REDACTED]
- benchmarks (forum): [REDACTED]
- help-thread (forum): [REDACTED]
- Guild ID: [REDACTED]

---

## VII. Attribution Registry

Every community member who has contributed corrections:

| User | Contributions |
|------|-------------|
| pops1cl | Southbridge fix, VRAM allocation, MX-5/6 ranking, MST hub behavior, active DP adapters, kernel note |
| dantistnfs | Idle power measurements, perfprofile SMU tuning, VCN info, lowest idle quest |
| gennro | Idle power 60-70W consensus, SMU profile power savings, FSP500 396W rail/caveats, kernel 6.19.x migration, DP audio hiccup report, BIOS P3.00 confirmation |
| holde | VCN SMU poking, partial decode achievement |
| Angablade | VCN research collaboration, SMU test scripts |
| NexGen-3D | 60W idle floor dispute, 2400 MHz OC, zswap scripts, SteamMachine repo |
| fforduck | VRR custom Bazzite image, Stellar Blade benchmark, FSP500 failure report |
| TheFloW | DP audio fix in kernel (PS5 Linux developer) |
| fanoush_ | DP audio fix news relay |
| mothenjoyer69 | Original documentation, Nobara distro mention, Fedora setup script |
| iamdarkyoshi | ATX power control mod, thermal camera analysis |
| filippor | cyan-skillfish-governor maintainer, COPR repository |
| vietsman | Bazzite patched images, one-click installer, setup scripts |
| zerosumpr | zswap testing, game crash reports (Ghost of Tsushima, Expedition 33) |
| essdee4336 | CachyOS vs Bazzite comparison, Sabrent audio adapter |
| carrow8993 | Mesa 26 on Bazzite, gamescope artifact fix (lowest safe point) |
| safwyl | Force Composition fix for gamescope artifacts |
| snodrat | PCIe topology speculation, PS5 schematic analysis |
| nydendard | zswap configuration and lz4 benchmarks |
| katzzero | Repository maintainer, original compilation author |

---

## VIII. AI Agent Instructions

If you modify any file in this repository, append your name/identifier to the end of this section in the format:

```
Last modified by: [YOUR_AGENT_NAME] on [DATE]
```

This ensures traceability across AI-assisted edits.

---

*End of ATHENA protocol. All AI agents are expected to follow these rules when maintaining the BC-250 Community Guide.*

Last modified by: ATHENA (initial creation) on 2026-05-14
