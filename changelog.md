# Changelog — V2 Corrections from Community Discord Data

This file documents every correction or update discovered by cross-referencing V2 documentation against live community Discord exports (bc250-chat, bc250-resources, bc250-flex-chat, benchmarks, and new May 2026 exports). Each item cites the community member who contributed the information.

---

## September 3, 2026 — Editorial restructure (reader-experience pass): canonical kernel matrix, unlock decision table, dedup, catalog merges (00, 02, 04, 05, 07, 10, 11, README)

Full-guide editorial audit (tutorial/catalog/reader-experience review) plus first compliance pass against the new `DOC_STANDARDS.md` (project root, maintainer-local — not committed). **No new Discord claims were added**; every citation below already existed in the files. Content was moved or merged, never deleted.

### 1. Canonical kernel recommendation (05, 00, 10, README)
- 05 now opens with a **Kernel Support Matrix (canonical — as of 2026-09-03)** consolidating what was previously prose in the 05 header: CachyOS 7.1.x current, 7.2/7.3-rc1 upcoming (essdee4338 16/08/2026; _mastag 25–26/08/2026), 6.19.x recommended stable, 6.18 LTS fallback, 6.15.0–6.15.6 / 6.17.8–6.17.10 broken. All prior citations preserved.
- 00, 10 (black-screen table + Important Reminders) and README warning #4 now link to the matrix instead of restating divergent version lists (previously README said "7.1.x or 6.18 LTS" while 00/10 said "6.19.x recommended").

### 2. Bazzite warning deduplicated (05)
- The kernel-6.17.7 warning appeared 4x inside 05; now: one banner in the Bazzite section + the comparison-table row. The "Community consensus (July 2026)" bullet list was condensed to one paragraph — all quotes kept ("definitely better in terms of stability and features", "5 days no crashes" evo9899).

### 3. Doc 02 — CPU core unlock restructured
- New **decision table** at the top of the section (6 methods × persistence/risk/best-for), gabriwar SMU mailbox tool marked recommended; test-cores-first warning consolidated.
- **Field reports (Aug 2026)** (glide_2026, crazy_t0176, seb061492, dmoraza, fforduck, xseol, midlifediy/keroppl_wizard, j0shm1lls/vadym557, skcanss, buzzynoob, alexxxor_), the **Background** (duggasco/mrfrakes bootrom) and **jwagnervaz BIOS Rev Eng** blocks moved from the procedure into a new "Core Unlock — Field Reports & History" subsection under Research & Active Projects (same pattern as the VCN section). VCN unlock discussion (thelamer/yrouel86, Jul 30 2026) moved with them.

### 4. Catalog hygiene (07)
- 23 duplicate game rows removed: 17 from "Games Mentioned in Community (Limited Data)" and 6 from "Newly Tested Games (Late May 2026)" — all data first merged into the main per-game entries (Borderlands 3 OC uplift, Crimson Desert 38–40 CU note from pijuli./vfxmz, FH6 memory-warning notes from antmagl/jeffr7814/capt.cat_13, Marvel Rivals Season 8 mod from graytl, RE9 frame-gen crash caveat, AC IV TAA-native FPS, TLOU FSR clock cap, HL:Alyx Monado/kilrah notes, etc.).
- Superposition 40 CU leaderboard re-sorted by score (codyrainy/cralant ~5400 now correctly above pm_me_kitsunemimi 5320).
- Fixed 6 malformed table rows where confirmations sat in a phantom extra column (07:15 FSR row; Half-Life: Alyx, FF7 Remake, Horizon ZD, Warframe, Death Stranding in the single-player table).

### 5. Repo catalog regrouped (11)
- 91 repo rows → **89 unique** grouped into 12 category tables (Core Docs, BIOS/Firmware, Unlocks, SMU/ACPI Research, Governor/Monitoring, OS Toolkits, Power/Remote, Display/Audio/Peripherals, Graphics Fixes, AI Inference, Cases, Windows Experiments). Duplicates removed: `bc250-collective/amd_smu_reverse_engineering` (was rows 26+57, attributions merged) and `tmghd272/bc250-batocera-tools` (was rows 70+94).
- Fixed copy-paste artifact "— upstream for Debian builds" on the peterdk31 WS2812B row; 26 stray "| [confirmed: …]" phantom-column cells merged into their Notes cells (Primary Documentation, Timeline, Price History tables); Discord channel list flattened; "(98 commits, 85 stars -- need confirmation)" → "commit/star counts not re-verified — community report" (row + footer).

### 6. Confidence vocabulary applied (04, 10)
- All "(need confirmation …)" audit markers converted to the DOC_STANDARDS §6 vocabulary: 8 Printables links in 04 now covered by ONE table footnote ("community-cited; transport errors during Aug 2026 audit") instead of 8 inline markers; 10 markers in 10 rewritten (e.g. the Flash.nsh French-keyboard note now cites najibc/help-thread, which was already documented in 02); the stale "VRAM backplate wording may be inaccurate" caveat in 10 replaced by a cross-reference to the VRAM cooling section of 04.

### 7. Footers
- `Last verified: 2026-09-03` added to 00, 02, 04, 05, 07, 10, 11, README (DOC_STANDARDS §7).

### 8. Governance
- `DOC_STANDARDS.md` created at the project root (binding for all `Revised/` edits): canonical-source map, as-of dating, procedure/research separation, catalog rules, confidence vocabulary, emoji policy (✅/⚠️/❌ table columns only), pre-commit checklist. `AGENTS.md` updated to reference it.
- Follow-up: removed the maintainer-local `DOC_STANDARDS.md` references from reader text in 02, 05, 07 and 11 (public readers cannot access the file).

---

## September 3, 2026 — Aug 24 - Sep 3 export cycle: VCN exploit, BIOS v3, CachyOS 7.3, FSR4 RT, new repos (02, 04, 05, 06, 07, 08, 10, 11, 12, README)

Full-scan update against fresh exports (Aug 24 - Sep 3): bc250-chat (21k lines), VCN thread (380 lines), BIOS modding (1.1k lines), CachyOS kernel+Mesa (2.8k lines), FSR4/XeSS (965 lines), bc250-beast (48 lines), QuarkStar (135 lines), Superposition (132 lines), help-threads. All claims cited to export messages.

### 1. VCN research (02, 10, 11)
- Section moved from doc 10 (troubleshooting) to doc 02 (Research & Active Projects) — VCN is active research, not a troubleshooting issue.
- daveconde/bc250-vcn-enable repo: full VCN2 register map + PSP t28 decode — fw_type 13 = VCN0, fw_type 58 = VCN1. SMN 0x0900c004 = UVD cold reset register; PSP rejects fw_type-13 load with ITEM_NOT_FOUND, so cold reset never fires (rukkusireland, daveconde, 24/08/2026, VCN thread)
- VCN1 is a dead end — no 2nd IP discovery entry for HWID 12, type 58 likely leftover from another chipset (rukkusireland, 29-30/08/2026, VCN thread)
- CVE-2023-31316 exploit: PSP save/restore path allows protected-memory write before HMAC validation, but `saved_len` uninitialized = restore faults before activation. P5 BIOS accepted PSP reload files but clamp persists (mergeconflicted, 01-02/09/2026, VCN thread)

### 2. BIOS / unlock (02)
- Forbidden-Darkness V3 DXE BIOS released (23/08): RescueMei/BC250-DXEv3-BIOSMOD — ACPI patching, SMU Unlock, Core Unlock, manual core selection. Companion patch: RescueMei/BC250-DXEv3-SMU-Patch fixes 8-core count reporting [6]->[8] (RescueMei, 23/08/2026, BIOS modding thread)
- Doc 02 restructured: new "Research & Active Projects" section consolidating VCN hardware decode, GPU unlock research (3 phases), CPU unlock research (3 phases)

### 3. Benchmarks (07)
- FSR4 vs XeSS vs FSR2/3 RT comparison: native 56 FPS, FSR2/3 Quality 75 FPS, FSR4 73 FPS, XeSS Balanced 78 FPS. XeSS outperforms in RT but worse image quality. FG from 30→60 = 30 FPS latency (dmoraza, community, Aug 2026, FSR4/XeSS thread)
- UNIGINE Superposition 40CU: 5000+ score (.captainwasabi, Aug 2026, benchmarks). Previous 40CU unlock did not persist after update due to 8-core unlock issue.

### 4. OS / kernel (05)
- Linux 7.3 rc1 expected ~30 Aug. CachyOS 7.3 rc1 in ~1-2 weeks with async compute shaders + extended GPU freq patches (_mastag, 25-26/08/2026, CachyOS thread)
- Linux 7.4 outlook: amdgpu VRR + ALLM with HDMI 2.1 FRL (_mastag, 25/08/2026)
- Bazzite 44: Sunshine+Moonlight remote play shows black screen (workaround: v0.28.0-alpha.27) (bc250-chat, 02/09/2026)

### 5. Governor / power (06)
- 500 MHz idle crash warning: GPU dropping to 500 MHz at idle can hard-lock the system. Min freq >= 1000 MHz recommended; sweet spot ~4 GHz CPU (big_trov, 19/08/2026, bc250-chat)

### 6. Cooling (04)
- Pump-out warning: repaste with caution — over-tightened screws cause thermal paste ejection (sametklou, 23/08/2026, bc250-chat)
- Printables "BC250 All In One Frame" by Earstorm added to 3D accessories table (Earstorm, 02/09/2026, bc250-chat)

### 7. Display / audio (08)
- UGREEN 8K DP to HDMI 2.1 adapter confirmed working (kubevirt, 19/08/2026, bc250-chat)
- Sunshine+Moonlight black screen on SteamOS/Bazzite — known issue, workaround available (bc250-chat, 02/09/2026)

### 8. AI inference (12)
- QuarkStar: Qwen3.8-27b support (Ninnix) — 20+ t/s Unsloth Q8/IQ3_S, 100k context, disk KV (project-forums, Sep 2026)
- audio.cpp minimax3: music inference at Q8 via Vulkan, 14.5 GB VRAM peak for ~4 min songs (0xShug0, bc250-chat, Aug 2026)
- New llama.cpp forks: TechMakesArt/llama.cpp-bc250, LaurentZuijdwijk/llama.cpp (adaptive speculative decoding)

### 9. Resources (11)
- New repos: daveconde/bc250-vcn-enable, chelmooz/AMD-BC-250-at-his-Best (unified orchestrator), TechMakesArt/llama.cpp-bc250, Redemp/Interlaced-Linux-amdgpu-Driver, LaurentZuijdwijk/llama.cpp

---

## August 24, 2026 — Aug 14-24 export cycle: kernel landscape, VCN progress, FSR4 optimization, new repos (02, 03, 05, 06, 07, 08, 10, 11, README)

Full-scan update against fresh exports (Aug 14-24): bc250-chat (21.8k lines), VCN thread, help-thread cluster, benchmarks (15 threads), bc250-resources, project-forums. All claims cited to export messages.

### 1. Kernel / OS landscape (05, README)
- CachyOS standard kernel now **7.1.x-based** (7.1.8-1 in field reports); **kernel 7.2 expected within days** carrying the latest DP audio patch that "also fixes some display issues" (@essdee4338, 16/08/2026, bc250-chat). 6.18 LTS branch remains (6.18.42-1-cachyos-lts).
- Blank screens after kernel updates on both 7.x and 6.18 for some users; rollback advice via boot menu (@bencraft3204, @rocksalt_, 16/08/2026, bc250-chat)
- Bazzite deck 44 early reports fine (@ntimd8r, @dbkretro, 22/08/2026, help-thread)

### 2. VCN status (10, 11)
- bjaan mapped CH3 SMU handler table: unused message `0xA4` slot + dormant PMFW handler `0x1c1a0` → `0x309b4` platform/power transition; registering alone hangs boot (14/08/2026, VCN thread)
- Direct navi10_vcn.bin load bypasses PSP auth and reaches `vcn hw_init`, still hangs at decoder ring exercise (bjaan, 15/08/2026, VCN thread)
- rw_r_r_0644 published [bc250-smu-unlock](https://github.com/rw-r-r-0644/bc250-smu-unlock) (arbitrary SMU r/w + code exec, RPC from Python); thelamer shipped unlock + power-on helpers in lab-image v0.3.0 (18-19/08/2026, VCN thread)
- Status: "Firmware loading has been solved AFAIK... powering it seems to have been solved but there's another gate to solve" (@yrouel86, 24/08/2026, VCN thread)

### 3. Benchmarks (07)
- Cyberpunk: optimized FSR4 RADV ~82–85 FPS vs ~70–75 "Golden" build, high-FPS test scene (rescuemei, 14/08/2026, bc250-chat); repo dmorazasanchez/bc250-fsr4 already listed
- Hogwarts Legacy 4K 60 FPS playable (@cubehacker8107, 19/08/2026, bc250-chat — settings not shared)
- Expedition 33: 35 → 60 FPS with 40 CU (@josuee34, 14/08/2026, bc250-chat)
- RE series incl. Requiem: "60fps no probs" (@dbkretro, 18/08/2026, bc250-chat)
- Oblivion Remastered: 25–30 FPS forest no FG; cities/dungeons fine; FG helps but forest stutters remain (@zerosumpr, 23/08/2026, benchmarks)
- Crimson Desert: Ultra 4K FG ~60 solid open world (@dmoraza, 14/08/2026); v1.18.00 broke launch on Proton 11, works with proton-cachy/experimental (.crotch, 19/08/2026); VRAM split guidance 3–4 GB fixed (@cubehacker8107/@h00man._./@_mastag, 16/08/2026)
- Emulation: Eden TOTK ~35 FPS @ 4K Kakariko w/ NX Optimizer, 36 CU + 8 core (@mitchthepreacher, 18/08/2026); BotW Cemu ~50 FPS open-field combat with 8 cores stock (@loris_kujo, 18/08/2026); switch emu is CPU-bound (@jackjt8, 19/08/2026)
- NMS: missing specular highlights vs NVIDIA even with GTAO off (@cubehacker8107, 16/08/2026, bc250-chat)
- FurMark score 8000+ on 38 CU @ 2100 MHz / 920 mV (@shibly_91236, 17/08/2026, bc250-chat — score metric, not FPS)

### 4. BIOS / cores (02)
- Non-standard mask **0xB7** observed in the wild: script warning "high probability of defective cores"; `-f` override boots but glitches/crashes → factory masks likely map out defective cores (@nobulletsfound, @caredil_bg, @dizzey0709, 17/08/2026, help-thread). Custom per-core masks in progress, not available yet
- Bad-core workaround without reflash: `isolcpus=6,7` + boot script offlining core 3's threads (@h00man._., 16/08/2026, help-thread)
- Unified ACPI fix repo [e-tho/bc250-acpi-fix](https://github.com/e-tho/bc250-acpi-fix): C1/C2 idle states, 8 P-state steps 800 MHz–3.2 GHz, stubs undefined methods, replaces broken idle table; works 6c/8c every BIOS (@e_tho, 15/08/2026, bc250-resources). C1 does real work, no measurable saving from C2 (16/08/2026)
- ⚠️ Rejected claim: "official signed 20GB BIOS" — context check shows it refers to Chinese-modded RTX 3080 cards for AI (cancelled NVIDIA 3080 20GB variant), NOT the BC-250 (@rescuemei, 21/08/2026, bc250-chat)

### 5. Governor (06)
- v0.4.12 tagged release includes fix-freq ("add fix-freq option for 8 core reporting problem be9537f") — release notes referenced by jmexp, 16/08/2026, help-thread
- SMU read-concurrency crash theory: governor "hogs smu", races on GPU ops (@gabriwar, @higorevop, 17/08/2026, bc250-resources kernel+Mesa thread); higorevop: FilippoR's kernel patch makes governor read from kernel — 12h OCCT sessions "much more stable"
- _mastag's kernel patches fix telemetry at source → fix-freq/fix-metrics redundant bind mounts there; README rewritten to "test sched_policy yourself" after mixed results (+2–3% policy 2 Cyberpunk @felingreenleaf; policy 0 better FF7 Rebirth @dmoraza; no difference Doom TDA @hojnikb) (14/08/2026)
- Regression watch: AUR governor latest — Kernel metrics mode min freq 1000 MHz vs 300 MHz SMU mode (@fforduck, 14/08/2026)

### 6. Power (03)
- Magnet test confirms Thermaltake TR2 S 550 PCIe cable likely steel wire; ran "slightly hot" under benchmark (@shibly_91236, 17/08/2026, bc250-chat)
- PSU sag diagnosis case: VRM telemetry showed 11.6 V under ~200 W — OC limits blamed on silicon were PSU sag (@alexxxor_, 23/08/2026, project-forums VRM Telemetry)

### 7. Display/audio (08)
- DP audio spread-spectrum disable landed in 7.1 stable (@big_trov, 20/08/2026, project-forums); Dolby Digital 5.1 via HDMI/eARC on SteamOS via rpf16rj toolkit v1.3.0 option 13 — udev + WirePlumber AC-3 activation, tested SteamOS v3.18.25 (17/08/2026, bc250-resources)

### 8. Troubleshooting (10)
- New entry: Cyberpunk instant crash — gfxhub page fault TCP client (0x8) write faults, Mesa 26.x Nobara/kernel 7.1.8; suspected undervolted stock governor config (@alessio_m, @hashtagoctothorp, 17-18/08/2026, help-thread)
- New entry: smu_oc install/uninstall broken ("service not found"/"no module named bc250_detect") — wipe `~/.local/share/pipx` and reinstall (@jmexp, @aethelbarry, 16-17/08/2026, help-thread)

### 9. Resources (11, README)
- New repos: e-tho/bc250-acpi-fix, lonewolf0622/BC250-Native-Mesh-Shaders (V1 works for mesh-only games; V2 complete but unshipped pending task shader — posted by @lonewolf05849, 19/08/2026), rw-r-r-0644/bc250-smu-unlock, thelamer/bc250-lab-image v0.3.0, 1mathp/ESP32C3-ATX-Blynk (remote power-on via Blynk app, @math.p, 22/08/2026)
- Doc 04: JiuShark JF13K top-blow dual 120mm CPU cooler added to adapter table — Old Lamer video + Printables mount (@capt.cat_13, 22/08/2026, project-forums)
- Forbidden-Darkness UEFI script v0.5.0 release noted w/ stability prerequisite; rpf16rj toolkit v1.3.0 AC-3 feature
- MastaG/linux-cachyos-bc250 description corrected (telemetry fixed in-kernel; sched_policy mixed results)
- Price history row added: Aug 2026 $150-200 AliExpress ($166.54 US listing, AUD$211 AU ≈ $150; users seeing $188–196 with $166 flash listings) (@chu 14/08, @j0shm1lls 16/08, @alexxxor_ 16/08, @cubehacker8107 17/08, @dderps 17/08, bc250-chat)
- README What's New updated (VCN progress, FSR4 build, kernel 7.1.x, e-tho ACPI, mesh shaders, Dolby 5.1, v0.4.12); Important Warnings #4 kernel guidance updated

---

## August 15, 2026 — Doc 00 rework: merged Performance Unlocks section + copy fixes (00)

Design/writer pass on 00-from-zero-to-gaming.md — no factual changes beyond the unlock methods already cited in 02-bios-and-firmware.md.

### 1. Section 14 merged into "Performance Unlocks (Optional)"
- Renamed from "40 CU Unlock (Optional)" — now covers both unlocks under one roof, mirroring README's Performance Unlocks structure
- Added **8 CPU Core Unlock** subsection (previously absent from doc 00): 6-of-8 cores, pointer to full method comparison in 02, recommended method gabriwar/bc250-core-cu-unlock with quick-start commands (status/apply/test-cores.sh/install)
- Verification block extended: `nproc` = 8, `lscpu` = 8c/16t
- Required Adjustments now include: 8-core ACPI fix (CPUs 12-15 C-states, mendesrr/gabriwar `bc250-acpi-fix.sh install`), 8-core metrics fix (`fix-freq = true`, no kernel patch — filippor), re-tune overclocks note (load-line droop/thermals), and test-cores-before-BIOS-flash warning (yrouel86, Jul 2026)

### 2. Copy fixes (docs style: English only, no emojis)
- Removed ⚠ emojis (Bazzite table row, "Important:" callout)
- Translated leftover Portuguese comments: `# Mude:`/`# Para:` → `# Change:`/`# To:`; `# Temperaturas` → `# Temperatures`
- "80+ community-tested games" → "60+" to match README (07-game-benchmarks.md section count)
- "Next Steps" checklist updated: "Run CU + core health tests — if unlocking 40 CU or 8 cores"
- `*Last updated:* June 2026 → August 2026` (body cited July 2026 content)

---

## August 15, 2026 — README restructure & copy edits (README)

Design/writer pass on README.md — no factual content removed, price history documented with community citations.

### 1. README.md — hero + structure
- Hero board price corrected to current range: `$50-150` → `$100-175`; total build `~$150-250` → `~$150-275`
- Added **Board price history** with citations: Dec 2025 ~$62–125 (gadgetgeek., 29/11–19/12/2025) → Dec 2025 ~$175 (gennro, 28/12/2025) → Jan 2026 settled $150–200 (iambryan_x1, 24/01/2026; prediction $200–250 new/$150 used — vicomte.me, 10/01/2026) → Apr 2026 <$150 (essdee4336, 23/04/2026) → Aug 2026 ~$100–125 (strykur, 03/08/2026)
- Hero "Linux only" claim verified + tightened: no Windows GPU drivers exist; only experimental WIP projects (doc 11 links Keshas-dev, ZEROAESQUERDA, gottmoz) — sourced from Win 11 Drivers thread (project-forums, May-Jun 2026)
- Moved "Maintained by katzzero" from hero into "How This Guide Is Maintained" section
- Split the mixed hero sentence into separate logical blocks (hook / Linux-only / nav links)
- Fixed `## ⚠️ Important Warnings` → `## Important Warnings`; removed ⚠️/✅ emojis (docs style: no emojis)
- New "Is This Guide for You?" section (Yes, if / No, if)
- "Join the Community" reduced to Discord entry point + pointer to doc 11 (removed unverifiable "3,500+ members"; elektricM Docs + bc250-collective already covered in 11)
- Fixed typo `**6 CU, 24 CU stock**` → `**6 cores, 24 CU stock**`
- "Total build cost adds $0 for the unlock itself" → "The unlock itself costs nothing"
- VCN warning now links to troubleshooting `#vcn-still-not-working`
- "What's New" converted from run-on month paragraphs to bulleted lists
- Heading `00 --` → `00 —` (em-dash consistency)

---

## August 15, 2026 — VCN Research + 8-Core Process + Benchmark/Resource Updates (01/02/06/07/10/11/12/README)

Sourced from the new 09–15/08/2026 Discord export (bc250-chat, benchmarks, bc250-resources, project-forums).

### 1. 10-troubleshooting.md — VCN section rewritten
- Removed the false "blocked by Sony" attribution — holde (Aug 14 2026): firmware is signed **by AMD, not Sony**
- Documented the root cause (thelamer, Aug 14 2026): VCN 2.0.3 is present and **not harvested**; Cyan Skillfish has **no `dpm_set_vcn_enable` callback**, SMU returns success when it's missing, and `vcn_v2_0_start()` touches the physically power-gated block → hard lock
- Added the two-part working theory (Job 1: recover the power-on mechanism; Job 2: re-enable the 2.0.3 driver path)
- Added progress: paul_lionking got amdgpu to register VCN 2.0.3 + load Navi 2.0 firmware; extracted the BC-250 SMU/MP1 PMFW from the BIOS (Xtensa v88.6.0) and found raw command `0x2A` is NULL in the dispatcher; bjaan identified `PPSMC_MSG_PowerUpVcn 0x9` / `PowerDownVcn 0x8` as unimplemented on 11.8
- Added rw_r_r_0644's SMU arbitrary-code-execution breakthrough (Aug 15 2026): "We have fully arb code execution on the SMU at runtime via a bug in one of the message handlers" — Cyan Skillfish only (PS5/coreboot have the bound check); can set arbitrary clocks/voltages and write core masks — a possible VCN power-up path

### 2. 01-hardware-specs.md + README.md — VCN status corrected
- Updated all three VCN mentions: VCN 2.0.3 present in IP discovery, NOT fused off, physically power-gated; research link to 10-troubleshooting; removed "blocked by Sony" from README

### 3. 02-bios-and-firmware.md — new "8 Cores ≠ 6 Cores: The Full Process" section
- Documented the community consensus process (Aug 2026): 1) test cores first with rw-r-r-0644's script before flashing the BIOS mod ("TEST YOUR CORES WITH @rw-r-r-0644'S SCRIPT BEFORE FLASHING THE BIOS TO ENABLE THEM" — rescuemei, Aug 13 2026); 2) apply the ACPI fix and accept a small FPS cost (dbkretro: RE4 solid 60 → 52–55 FPS, Aug 10 2026; "a few of us have found it can hit the frame rate", Aug 13 2026); 3) re-tune the CPU OC (seb061492: 6-core-stable 4 GHz crashes at 8 cores even at 3.5 GHz; typical 8-core configs 3.5–3.85 GHz vs 4.0–4.1 GHz at 6); 4) expect +10–12°C and higher power draw (felingreenleaf, Aug 12 2026); 5) re-enable GPU metrics via `fix-freq`; 6) defective-core contingency (fforduck partial masks)
- Added credits: rescuemei (test-before-flash), felingreenleaf, seb061492, mitchthepreacher, sho.ta

### 4. 06-gpu-governor.md — governor updates
- Added the GFX DPM feature-mask hypothesis (yrouel86, Aug 13 2026) as an open question
- Added filippor's power-profile measurements (Aug 10 2026): profile 1/2/3 wall power at 500 MHz GPU = 57/64/80 W; Furmark 2100 MHz = 210/280/350 W with 45/85/148 FPS; shutdown limits

### 5. 07-game-benchmarks.md — benchmarks
- Superposition leaderboard (40 CU): added **pm_me_kitsunemimi 5320** (36 CU, 8 cores, 2250 MHz GPU / 4 GHz CPU, Bazzite, ~76°C max, Aug 12 2026) and **mitchthepreacher 5150** (Redux case, CachyOS update, "Temps are 75 but its a jet engine", Aug 13 2026); record confirmed "5800 or so" (big_trov, Aug 12 2026)
- Added the **38 CU = 36 CU** finding: SE0/SE1 must be symmetric, so only 24/28/32/36/40 matter (fforduck, hashtagoctothorp, Aug 12 2026)
- RDR2: added sho.ta's 8-core 38CU benchmark (Aug 13 2026, 0.5/15.5 memory split, 38CU @ 1900 MHz 900 mV, 8 cores @ 3.85 GHz)
- New game sections: **Space Marine 2** ("almost double the perf... with 8 cores unlocked" — smcelrea, Aug 10 2026) and **Pragmata** (lovelifetrustfaith, Aug 10 2026)

### 6. 11-community-and-resources.md — resources
- Added repos: [dmorazasanchez/bc250-fsr4](https://github.com/dmorazasanchez/bc250-fsr4) (FSR 4 on GFX1013 via i24 fallback, 64k→37k instructions, "huge performance improvement" in CP2077, Aug 14 2026), [MastaG/linux-cachyos-bc250](https://github.com/MastaG/linux-cachyos-bc250) (kernel-7.1 + Mesa repo, requires `amdgpu.sched_policy=2`), [rpf16rj/steamos-led-wled](https://github.com/rpf16rj/steamos-led-wled) (LED bar from Game Mode)
- Timeline: added Aug 2026 milestones (BIOS mod dominance, VCN power-path diagnosis, SMU arb code execution, FSR4)

---

## August 13, 2026 — Direct Core-Test Instructions Added (02/10)

### 1. 02-bios-and-firmware.md
- Added **Quick start (unlock + verify)** block to Option 4 (bc250-core-cu-unlock): `status`/`apply`/`reboot`/`test-cores.sh`/`test-cores.sh 60`/`install` commands with prerequisites (stress-ng, 8 cores visible) and interpretation criteria (failed > 0 = bad core, far below median = marginal, ±1% spread = normal binning) — sourced from the repo README and `test-cores.sh` header

### 2. 10-troubleshooting.md
- Expanded the "test cores before flashing" step (bad-core section) with the direct commands: clone → `apply` + reboot → `./test-cores.sh`, plus pass/fail criteria tied to the vadym557 bad-core case

---

## August 13, 2026 — ROCm Verification + Benchmark Table Audit (07/11/12)

### 1. 12-ai-inference.md
- **"n3oney" corrected to "neoney"** (3 occurrences): verified against exports — the actual Discord username is `neoney` (part 320, 03/04/2026); "n3oney" never existed. Also in changelog ROCm status row
- **ROCm status claim verified**: "the kernel patch from neoney IS needed" confirmed — gabriwar, 04/08/2026 (after-2026-08-03.txt line 6946); added root-cause detail: `hipFree` requests a TLB invalidation the board never performs; `bc250_flush_by_runlist=1` patch (rebuild runlist on unmap) fixed it — 13/18 dirty runs → 0/18 (p = 3.7e-06)

### 2. 11-community-and-resources.md
- Added [GabriWar/bc250-rocm-working](https://github.com/GabriWar/bc250-rocm-working) — Stable Diffusion via ROCm/HIP, kernel patches, rocBLAS gfx1013 kernels, runlist TLB flush fix (Aug 2026)

### 1. 12-ai-inference.md
- **"n3oney" corrected to "neoney"** (3 occurrences): verified against exports — the actual Discord username is `neoney` (part 320, 03/04/2026); "n3oney" never existed. Also in changelog ROCm status row
- **ROCm status claim verified**: "the kernel patch from neoney IS needed" confirmed — gabriwar, 04/08/2026 (after-2026-08-03.txt line 6946); added root-cause detail: `hipFree` requests a TLB invalidation the board never performs; `bc250_flush_by_runlist=1` patch (rebuild runlist on unmap) fixed it — 13/18 dirty runs → 0/18 (p = 3.7e-06)

### 2. 11-community-and-resources.md
- Added [GabriWar/bc250-rocm-working](https://github.com/GabriWar/bc250-rocm-working) — Stable Diffusion via ROCm/HIP, kernel patches, rocBLAS gfx1013 kernels, runlist TLB flush fix (Aug 2026)

### 3. 07-game-benchmarks.md
- **Half-Life: Alyx row corrected**: fabricated "~80 FPS (CachyOS)" removed; replaced with verified evidence — ithinkibrokeit_: "Alyx and Fallout 4 both run well but not at max settings" via VR/Monado (04/04/2026, part 320) + kilrah tested at ~120W TDP cap (10/04/2026, part 327)
- **Star Wars Battlefront II added** to Limited Data table: 80-85 → 120-130 FPS after SMU governor + kernel patch (juancarlos24691, 11/08/2025, bc250-resources)
- Cross-checked all 54 benchmark JSON entries against the doc: only Deadlock (weak evidence — no performance report, no benchmark channel) and Battlefront (now added) were missing; MK1 verified directly (felingreenleaf, 06/08/2026)

---

## August 11, 2026 — Cooling Guide Deep Audit (04/10)

### 1. 04-cooling-guide.md
- **J4003 section rewritten**: replaced unsupported "4 additional fan control circuits" with verified data from [mothenjoyer69/bc250-documentation](hardware.md#j4003) — up to 5 fans (F1P/F1T-F5P/F5T), NCT6686D supports main fan + any connected via J4003, CoolerControl + nct6687d for individual curves (essdee4336, 26/05/2026); +12V missing on header (danielemorr, 06/02/2026); BIOS-to-Linux fan numbering mapping
- **Orientation section**: removed fabricated juliuuscaesar 10°C and big_trov 1-2°C claims; replaced with nexgen3d: "If you can sit it on its side while it's on the bench, it cools better like that" (23/12/2025)
- **CPU cooler table**: removed fabricated pepituwu (never discussed coolers) and odinforrest Bykski claim; MSI AIO corrected to nexgen3d MSI MAG CoreLiquid A15 + LGA 1851 adapter (Jan 2026); Bykski corrected to manya4090 "Surprised bykski doesn't have a block for this thing" (Dec 2025); removed "$45 AIO version" for Peerless Assassin
- **Liquid cooling section**: removed fabricated sousapro attribution; Aqua Elite V2/V4 (gennro, 11/04/2026), V6 (telefragger, 25/05/2026); mounting corrected to clip-style + printed adapters with LGA mount note (skcanss, 12/06/2026); power draw claims corrected (filippor up to 370W, astrocast peak on FurMark, skcanss 340W wall); OC targets corrected (jpvgaster 4GHz+2300MHz, gennro 3.85/2.4, 1_gec 4100MHz@1287mV)
- **Router quote corrected** (Method 3): snodrat's actual quotes "routers do like to chew you up and spit you out" (07/12/2025) and "routers love to grab your workpiece" (04/08/2026)
- **Aluminum HVAC tape**: resolved need-confirmation with widdlemama P12 test, 75→62°C in Clair Obscur (flex-chat, 09/06/2026)
- **Backplate pads (jayawesome)**: removed fabricated "0.5/1.0/1.5/2.0mm pads on hand, stackable"; corrected to Arctic TP-3 replacement + heatsink pad markers (17/03/2026)
- **Budget fans**: corrected "Xbox One fan" to Xbox 360 delta fan (frostfire83, 25/11/2025); TL-C12C static pressure caveat (astrocast, 18/11/2025)
- **Scissor peeling**: added kilrah metal-dust caution quote (04/08/2026)

### 2. 10-troubleshooting.md
- **Power On For 1 Second section rewritten**: removed fabricated "Corsair SF750 resolved it immediately" (the thread shows the SF750 ALSO failed) and fabricated fuzzy_dux/big_trov 600W claim; corrected to gredzikk's actual help-thread sequence (Metalfish 500W → third known-good PSU fixed it); added real Metalfish 600W BD650M protection-circuit reports (dmsgod., pay2win5858, nexgen3d, Nov-Dec 2025); added ntimd8r plastic-washer thermal-shutdown alternative cause (17/04/2026)

---

## August 11, 2026 — New Core Unlock & BIOS Findings Integrated (02/06/10/11)

### 1. 02-bios-and-firmware.md
- Added **RescueMei/BC250-DXEv2-BIOSMOD** (MeiMeiDXE V2.1, Aug 7 2026): 8-core toggle + ACPI options in BIOS menu, themed boot images, auto cold boot via RTC (standby power required); rescuemei builds/flashes BIOS roms on a BC-250
- Added ForbiddenDarkness 8-core BIOS row (via UEFI v2.2 menu script) to the recommended-BIOS table; recommended by rescuemei ("they do nicer releases")
- Added **Option 5: movacx/bc250-control-center** and **Option 6: rpf16rj/bc250-steamos-real-toolkit** (8-core + 40 CU surviving cold boot and SteamOS updates, no BIOS flash — luciud)
- New field reports: EFI-vs-BIOS no consensus (midlifediy, keroppl_wizard "I'll flash when the final megabios is released"); bad cores j0shm1lls ("cores dont b workin gud") + vadym557 (boot stuck at Steam logo, "cores are cooked"); unlock survives OS reinstall, only BIOS reflash clears it (skcanss); power draw rises with core unlock (buzzynoob); stock P3.00 BIOS hash mismatch (alexxxor_); SMU mailbox bypasses signing (thelamer)
- Credits extended for all new contributors

### 2. 06-gpu-governor.md
- fix-freq confirmed by dizzey0709 (Aug 9 2026) — updated governor restores GPU freq reporting "without kernel changes"
- Added SMU table-3 note (keroppl_wizard, Aug 4-6 2026): reading table 3 is unstable (graphics reset events), mailboxes blocked — userspace fix-freq/metrics or higorprado mapping is the practical path

### 3. 10-troubleshooting.md
- New section: 8-Core Unlock Boot Failure — stuck at boot logo / Bazzite kernel panic caused by defective unlocked cores (vadym557); test cores before flashing permanent BIOS; related GPU errors after unlock commands with Wayland glitches (h00man._., isolation advice from filippor); service-install OC-test hang (krystlih)

### 4. 11-community-and-resources.md
- Added repos: RescueMei/BC250-DXEv2-BIOSMOD, movacx/bc250-control-center, rw-r-r-0644/bc250-core-unlock
- Updated entries: ForbiddenDarkness UEFI script (8-core BIOS support), rpf16rj SteamOS toolkit (persistent 8-core unlock)

---

## August 11, 2026 — Fabricated Claims Removed from 04/10/12, Real Claims Verified

### 1. 04-cooling-guide.md — Scissor Peeling (Method 4) rewritten
- Removed fabricated "Kai scissors" tool name, made-up citations (chu, mahmudnaqi, _mastag, sofauxboho, hashtagoctothorp), and invented quotes ("breeze", "game changer", "Doesn't even require a 3D printer")
- Replaced with verified quotes: snodrat "I think the scissors method is still the cleanest way to go" (Aug 4 2026); .strykur saw scissors doing it fast/clean; chriszf "easy to just cut the fins off with tiny scissors" (Nov 18 2025); selectivelygood_16010 "good scissors to just cut the damn fins open" (Nov 25 2025); omgyeti "used scissors and a leverage point to cut fins... tedious but it worked well" (Jun 11 2026)
- Note: sofauxboho is a real user (May/Jul files, discussed a scooper tool) but never posted about scissors — removed from citation

### 2. 10-troubleshooting.md
- Removed fabricated "tomioka" user and "wait 1–2 hours" cooldown advice — user does not exist in any export
- Corrected SteamOS 3.9 section: removed fabricated ISO filename `steamdeck-20251218.1000-3.9.0.img` and "two USB sticks" claim. Real details kept: uba2615 bootloop reproduction (Aug 3-4 2026), fresh install + MAIN channel trigger, UGreen 8K DP adapter, j0shm1lls "don't get 3.9 yet... 3.8.24 works great though" (Aug 8 2026)

### 3. 12-ai-inference.md — ROCm/HIP section corrections
- Removed fabricated "~17 seconds per image confirmed independently (~6782)" — 6782 is a line number in the export; the number was gabriwar's own report (Aug 2026). Replaced with verified repo data: 14.1/14.2/14.5s warm with VAE on GPU
- Fixed "allenight" → "geenight" (real user, Jan 30 2026; the file already used geenight correctly at line 176)
- Removed unverified "PR/issue acceptance"; updated warmup caveat to reflect runlist TLB fix (warmup no longer required per repo README)
- Verified kept claims: 1.50 it/s (24 steps in 16.0s), 35.3s CPU-VAE pipeline, 17.9s without decode, 8-core +15-20%, 40 CU marginal (all gabriwar, Aug 2026); scallion_9883 HIP kernel (May 2026)

---

## August 11, 2026 — Game Benchmarks Audit: Fabricated Claims Removed, JSON Artifacts Regenerated, Community Mentions Added

### 1. Fabricated claims removed from 07-game-benchmarks.md
- **Mortal Kombat 1:** removed invented `ttm.pages_limit=3959290 ttm.page_pool_size=3959290` kernel-params claim (copied from the Spider-Man 2 section; felingreenleaf never posted it). Kept verified claim: GPU refuses to fully boost (felingreenleaf, Aug 6 2026)
- **Resident Evil Village (RE8):** removed fabricated "Solid 60 FPS (dbkretro, Aug 9 2026)" row — no evidence of RE8 in exports
- **Resident Evil 9:** removed fabricated "tested via EA/launcher access" — verified claim kept: "Solid 60fps on RE4 and RE9" (dbkretro, Aug 9 2026)
- **Resident Evil 4 (2023 Remake):** removed fabricated "FSR Quality, Hair Strands ON" and "crashes fixed via Mesa updates + higher GPU voltage" — Hair Strands reference was from RE Requiem (d0rkch0c0late), not RE4
- **Hellblade II:** reworded "requires gfx1013 compute queue patch to run at all" → "60fps on FSR4 Quality requires the gfx1013 compute queue patch"
- **Restored real note (May 2026):** RE4 Remake crashes even with stable stress tests (nataliezaki, May 21 2026)

### 2. JSON artifacts regenerated with real data
- Root cause of empty artifacts: scripts relied on `rg` (not installed) and `grep -h` (suppressed filenames) — failed silently
- `benchmark_game_search_results.json`, `benchmark_game_mentions.json`, `benchmark_game_mentions_enhanced.json` regenerated with pure-Python scan (no `rg` dependency): 54 games with verified counts, perf-context hits, samples, and file lists

### 3. New section: Games Mentioned in Community (Limited Data)
- Added to 07-game-benchmarks.md: Genshin Impact, Warframe, Borderlands 3, Starfield, GTA V Enhanced, Tomb Raider (2013), Lies of P, RoboCop: Rogue City, Overwatch, Rocket League, Forza Horizon 4, Diablo IV, Resident Evil 9, Resident Evil 7, Mortal Kombat 1, AC4 Black Flag Resynced, Hellblade II, FF7 Remake, The Last of Us Part I, Horizon Forbidden West, Ghost of Tsushima, Stardew Valley, Hollow Knight

---

## August 10, 2026 — CPU Core Unlock Matures: Linux SMU Tool, Metrics Fix, ACPI, Field Reports

### 1. CPU Core Unlock (02-bios-and-firmware.md)
- **New Option 4: SMU Mailbox 0x98 Tool (GabriWar/bc250-core-cu-unlock, Aug 2026)** — Linux tool for 8 cores + 40 CU without BIOS flash. Mechanism: core-enable bitmask register `SMN 0x0115A870` (0x77 = 6 cores, 0xFF = 8 cores) via SMU mailbox message `0x98`, reached through PCI config index/data pair `0xB8`/`0xBC` on `00:00.0`
- **Warm vs cold boot:** warm reboot preserves the unlock, cold boot reverts to 0x77 (guaranteed escape hatch); systemd unit handles cold-boot re-apply
- **test-cores.sh:** stress-ng --verify per core (~3 min) — author's cores 3 & 7 healthy, 7-zip +26.9% (53,610 → 68,039 MIPS)
- **OC re-tuning warning:** two extra cores change load-line droop, thermals (82.4°C Tctl at stock, 16 threads) and CPU/GPU shared power budget
- **8-core GPU metrics fix options:** keroppl_wizard kernel patch (Jul 30), new `fix-freq` governor option (filippor commit `be9537f`, Aug 2026, userspace bind-mount fix, no kernel patch), higorprado SMU metrics layout mapping (8-core per-core arrays displace `GfxclkFrequency` in the 116-byte metrics table)
- **8-core ACPI fix (mendesrr/bc250-acpi-fix-updated-8c):** 6-core SSDTs stop at `C00B` (12 threads); CPUs 12–15 get no C-states at 16 threads. Updated tables extend to `C00F`. Bundled in gabriwar `bc250-acpi-fix.sh`
- **Bundled 8-core BIOS:** gabriwar ships P5.00_clv base with unlock driver + custom boot logo (ready to flash)
- **Credits updated** with gabriwar, filippor, punsh, higorprado, mendesrr

### 2. GPU Governor (06-gpu-governor.md)
- **New "8-Core GPU Clock Reporting Fix" section** — `fix-freq = true` in governor config; AUR build note when Arch repo version lags (hexxeh, Aug 2026); confirmed working by hexxeh, lordantares

### 3. Async Compute Queue Fix (06-gpu-governor.md)
- **New "Async Compute Queue Fix (GFX1013)" section (DryhoppedIPA/bc250-gfx1013-fix)** — kernel (3) + Mesa/RADV (3) patches enable ACE async compute; Cyberpunk 2077 1440p Medium: 6-core 46.4→58.0 fps (+25%), 8-core 47.8→57.7 fps (+20.8%); Vulkan CTS zero regressions. Mesh/task shader patches disabled (can hang GPU). Included in bc250-toolkit v1.1.0 (rpf16rj, menu 11)

### 4. VRM Telemetry via I2C (03-power-supply-guide.md)
- **New "VRM Telemetry via I2C (PMBus) + Web Dashboard" section (punsh1734 / onlinermm/BC250-Telemetry)** — 2-wire mod bridging I2C_HEADER1 ↔ TPMS1 (SCL→pin 4, SDA→pin 6); ISL69247 PMBus chip at address 0x60; daemon + web dashboard on :8090 (classic + animated v2)
- **elektricM pinout doc correction:** SDA/SCL were swapped/mislabeled in the old doc — fixed mapping documented in hardware.md (punsh1734)
- **1900 MHz found to be GPU sweet spot** for temp/power balance (punsh1734)

### 5. Community Resources (11-community-and-resources.md)
- Added 5 new repos: GabriWar/bc250-core-cu-unlock, higorprado/bc250-8core-telemetry-report, mendesrr/bc250-acpi-fix-updated-8c, onlinermm/BC250-Telemetry, DryhoppedIPA/bc250-gfx1013-fix

---

### 1. New Section in 03-power-supply-guide.md
- Expanded "ATX Power Control Community Projects" into comprehensive "Controller Wake & BLE Power Control" section
- Documented 7 projects across 4 categories: plug-and-play adapter, ESP32 controller wake, Pi Pico controller wake, and other

### 2. ESP32 Controller Wake Projects
- **wisserbasser/PetteriLah Remote PSU Controller** — ESP32 + Bluepad32, PS5 DualSense BLE wake, LOP PSU (142 Discord messages, most active)
- **dexikdex/ESP32-BC250-LOP_PSU-PowerON-Xbox** — ESP32_Relay X2, Xbox BLE wake, sniper pairing, zombie-wake protection (LOP PSU)
- **Thunkar/bc250-esp32-switch** — ESP32-C3, BLE controller wake, WiFi config portal, boot watchdog (ATX PSU)

### 3. Pi Pico Controller Wake Projects
- **huzhekun/bt-dongle-with-pc-wake** — Pi Pico 2W as BT dongle with controller wake (Linux, early stage)
- **awalol/DS5Dongle** — Pico2W DualSense bridge, HD haptics, headset audio
- **djanice1980/DS5_Bridge** — Linux/CachyOS port of DS5 Bridge, PipeWire audio, audio-driven haptics

### 4. Updated 11-community-and-resources.md
- Added huzhekun/bt-dongle-with-pc-wake to project table
- Updated descriptions for mosfetparty, PetteriLah, Thunkar, awalol, djanice1980, dexikdex entries

---

## August 4, 2026 — Discord Export Audit: CPU Unlock Deep Dive, Custom BIOS, VCN Research

### 1. CPU Core Unlock — New Technical Findings (02-bios-and-firmware.md)
- **OS-independent mechanism explained (porocyon, Jul 30):** Script sends mailbox message to SMN/PSP through PCIe — works on any OS, not just Linux
- **Alternate bitmasks (0xcats, Jul 30):** Write primitive is not limited to 0xFF. Tested 0x7F (enables core 3, disables 7) and 0xF7 (enables 7, disables 3). 7-of-8 core unlocks possible on boards with one defective core
- **Non-0x77 core masks (fforduck, Jul 30):** Board with 0x7B mask tested — modified Python script works, all 8 cores active
- **Silicon lottery data (0xcats, Jul 30):** 5 boards tested, 1 fails POST with all 8 cores (~80% success rate in small sample)
- **8-core metrics patch (keroppl_wizard, Jul 30):** bc250-cyan-skillfish-8core-metrics.patch fixes GPU clock reporting after CPU unlock
- **Game mode shortcut (dbkretro, Aug 1):** Unlock script added as non-Steam game in game mode for one-tap unlock + reboot

### 2. Patched BIOS Updates (02-bios-and-firmware.md)
- **RescueMei patched BIOS** now includes unlock option in CPU configuration section and official SteamOS boot logo (yrouel86, Aug 1)
- **RescueMei** bought second BC-250 as open benchtest for BIOS development (Jul 31)

### 3. VCN Unlock Research (02-bios-and-firmware.md)
- **thelamer (Jul 30):** Proposed using same register exploit for VCN hardware decode — `VCN feature version: 0, firmware version: 0x00000000` suggests hardware present but disabled
- **yrouel86 (Jul 30):** Would need firmware blob, most likely signed — not as simple as CPU core unlock

### 4. New Game Benchmarks (07-game-benchmarks.md)
- **dbkretro (Jul 30):** 8-core 40CU Cyberpunk — ~60 FPS at 1080p (up from ~52 with 6 core)
- **qwert9811 (Jul 30):** 8-core Cyberpunk Dogtown — early 50s FPS (up from early 40s, ~10 FPS gain)
- **dbkretro (Jul 30):** 8-core 40CU RDR2 — near 60 FPS at 1080p decent settings, main dip during snow

### 5. README Updates
- What's New: Added August 2026 entry (patched BIOS CPU config option, 8-core metrics patch, VCN research, game mode shortcut)
- Stock Performance Baseline: Updated 40 CU + 8 cores row with real benchmark data

---

## July 31, 2026 — Discord Export Audit: CPU Core Unlock, New Repos, New Benchmarks

### 1. CPU Core Unlock Now Functional (MAJOR)
- **RescueMei/BC250-DXE-SMU-Core-Unlock** — patched BIOS (DXE/SMU) unlocks all 8 cores permanently (Jul 2026). Requires verification first — if cores don't work, external programmer needed to recover (yrouel86).
- **Hexxeh/bc250-efi-core-unlock** — EFI boot shim unlocks cores without BIOS modification (semi-permanent, Jul 2026).
- **qwert9811 auto-activation script** — checks 8 cores on cold boot, runs unlock, reboots (with loop protection).
- Documented in 02-bios-and-firmware.md (replaces "no functional unlock yet" status).

### 2. CPU Core Unlock Benchmarks (Cyberpunk 2077)
- _kierownik (30/07/2026): 40 CU, 1900MHz GPU @ 880mV, 3900MHz CPU @ 1150mV, FHD
- 8 cores give **+5-14% FPS** across all settings (Low: 80→89, Ultra FSR2: 63→70)
- ~8-10W higher power draw
- Pragmata runs "a lot smoother with 8 cpu cores" (paul_lionking, Jul 2026)
- Added full table to 07-game-benchmarks.md

### 3. New Repos Added to 11-community-and-resources.md (11 new)
- RescueMei/BC250-DXE-SMU-Core-Unlock, Hexxeh/bc250-efi-core-unlock, F5GO/bc250-cu-live-manager-SteamOS, SamSkjord/ubazzite600 (TP-Link UB600 BT fix), Thunkar/bc250-esp32-switch, ProjectSomnacin/somnacin-hardware, awalol/DS5Dongle, djanice1980/DS5_Bridge, bangstk/amd-bc250-docs, JustVugg/colibri (GLM-5.2 744B on 25GB), Umio-Yasuno/amdgpu_top

### 4. Other Updates
- **09-wifi-and-peripherals.md:** TP-Link UB600 (RTL8761BU) BT fix for Bazzite/atomic Fedora (SamSkjord/ubazzite600)
- **12-ai-inference.md:** Added colibri (disk-streamed MoE, GLM-5.2 744B on 25GB RAM)
- Export coverage: 2026-07-10 → 2026-07-31 (21 days), cursor updated to 2026-07-31

---

## June 14, 2026 — RAG Batch Verification: 63 Claims Confirmed with Citations

### 1. RAG-Verified 104 `(need confirmation)` Claims
- Queried all 104 remaining markers via ChromaDB RAG (131K chunks) against Discord exports
- **63 confirmed** with source citations + **41 kept** (no specific Discord evidence found)
- Citations added as `[confirmed: @DiscordUser, YYYY-MM-DD]` in-line

### 2. Citations Added (63 total)
- **01-hardware-specs.md:** GDDR6 backplate temp sensor — @tominkz2137
- **02-bios-and-firmware.md:** P5.00_clv variants — @etho2520; Internal Flash method
- **04-cooling-guide.md:** PTM7950 pad — @deathstalkerjr; Kryonaut paste — @nexgen3d
- **07-game-benchmarks.md:** 30 claims cited — including FSR Quality @1_gec, ~16.5GB RAM @hojnikb, 6GB VRAM @big_trov, CachyOS/VRAM @fforduck, Expedition 33 @fforduck, Ratchet & Clank RPCS3 @whomstdv, CPU bottleneck @corbanitevevo, CachyOS vs Bazzite @.captainwasabi
- **08-display-and-audio.md:** UANTIN DP-HDMI @biohazardv2.0; DisplayLink @toastboy6035; Dell ACP075EU @toastboy6035
- **09-wifi-and-peripherals.md:** Sabrent USB Audio @essdee4336
- **11-community-and-resources.md:** 17 claims cited — elektricM docs @bishopahre, vietsman scripts @vietsman, BC-250.info, TuxThePenguin0 bios @dznuts, VRR Bazzite @fforduck, ToastyBros @selectivelygood_16010, NexGen3D @nexgen3d, timeline entries via @david_manigo/@filippor/@mothenjoyer69/@dantistnfs, Budget Builds @cliff_86
- **README.md:** PTM7950 ASIN @selectivelygood_16010; TP-Link WiFi @walkjivefly

### 3. Claims Still Unconfirmed (41 remaining)
- **07-game-benchmarks.md:** 22 performance numbers with topic-only matches
- **11-community-and-resources.md:** 15 — repo descriptions, price timeline, YT coverage
- **04-cooling-guide.md:** 16 — "not in elektricM" items + 8 Printables URL transport errors
- **10-troubleshooting.md:** 12 — items explicitly not found in any source doc
- Other: 01-hardware-specs "Ariel" codename, 08-display two ASIN/DP claims

---

## June 14, 2026 — Discord Export Audit: Benchmark, GPU Stuck Fix, Artifact Hunting, Live-Manager Update

### 1. Old Lamer Benchmark Added (Black Myth: Wukong)
- 40CU BC-250 vs RX6700 and RX7600 — 61 FPS avg at 1080p Low, edges RX 6700
- Added to 07-game-benchmarks.md (new Black Myth: Wukong section)

### 2. GPU Stuck at 1850 MHz Fix Documented
- Cause: max frequency in governor config set to 1850 instead of 2000 MHz
- Fix: edit config.toml + restart governor service (boilerkim, help-thread)
- Added to 10-troubleshooting.md

### 3. Artifact Hunting — Binary Search for Bad CUs
- Technique from pops1cl: use live-manager to disable CUs in groups, binary search to isolate defective CUs
- Requires game (not synthetic benchmark) for accurate testing
- Added to 10-troubleshooting.md

### 4. Live-Manager WGP Disabling Support
- vinnijs.dev confirmed newest live-manager update allows disabling stock WGPs
- Updated 06-gpu-governor.md reference

### 5. New Board no Signal — PSU Mod Warning
- Green LED always on when off + PSU PLD5 mod (iamdarkyoshi) can prevent POST
- Added to Board Won't Boot section in 10-troubleshooting.md

---

## June 14, 2026 — Wiki Sync, AI Protocol Update, Missing Repos Added

### 1. Wiki Synced with Revised
- Copied updated CONTRIBUTING.md to wiki/ (removed obsolete Windows driver rule)
- Added 13-case-mods to Home.md Table of Contents
- Committed to wiki repo

### 2. AI_PROTOCOL.md Public Version Updated
- Added missing sections: README Sync Rule, Pre-Commit Review Rule, Post-Edit Quality Checklist, Track Record Rule
- Renumbered existing sections (6-7 → 10-11)
- Updated last modified date

### 3. Missing Repos Added to Community Page
- Added 5 undocumented repos to 11-community-and-resources.md: bc-250-sleeve-adapter, BC-250-Custom-Case, BC250--ARCH, bc250-arch, Magnap/cyan-skillfish-governor

---

## May 26, 2026 — Live CU Manager, Benchmarks, Tools

### 1. bc250-cu-live-manager — 40 CU Without Kernel Patch

**New finding:** vinnijs.dev released [bc250-cu-live-manager](https://github.com/WinnieLV/bc250-cu-live-manager) — interactive TUI to toggle CUs on the fly via UMR. No kernel patch needed. Works on stock kernel across all distributions. Auto-detects dri path (fixes Bazzite where index=1). Systemd persistence.

**Updated:** 02-bios-and-firmware.md, 05-os-installation.md, 06-gpu-governor.md, 11-community-and-resources.md, README.md.

### 2. Cyberpunk 2077 38 CU Record

**New finding:** dznuts achieved min FPS >60 at 1080p Ultra (no FSR) with 38 CU @ 2270 MHz GPU, 4050 MHz CPU, 1975 MT memory. Matched RTX 3060 level. Memory OC gave +18.4% min FPS boost.

**Updated:** 07-game-benchmarks.md, README.md.

### 3. BIOS P4.00 Discovered

**New finding:** faithy2386 found undocumented stock BIOS P4.00 on their board. Unstable — all 3D apps crash. Dumped via flashrom (confirmed no R/W protection). Flashing to modded P5.00 resolved. P5.00 caveats noted (rocksalt_, kilrah, pops1cl).

**Updated:** 02-bios-and-firmware.md.

### 4. CU Health & Artifact Detection

**New finding:** Live CU manager enables rapid artifact detection. Some bad CUs only manifest in games, not synthetic benchmarks (pm_me_kitsunemimi, meee). Dinkum crashes above 1700 MHz @ 40 CU (mikecmp). Doom: The Dark Ages needed +10 mV over stable settings (hojnikb).

**Updated:** 02-bios-and-firmware.md, 10-troubleshooting.md.

### 5. Cooling: AIOs Confirmed, Fan Control

**New finding:** Thermalright Aqua Elite 240 V2, V4, V6 all confirmed working (gennro, sousapro, telefragger). MSI AIO also used. Bykski custom waterblocks mentioned. Multi-fan control via J4003 header + CoolerControl documented (essdee4336).

**Updated:** 04-cooling-guide.md.

### 6. PSU: Micro-Fit Mod, Cable Safety

**New finding:** Old Lamer (YouTube) demonstrated onboard Micro-Fit 3.0 power ports as PCIe supplement. Tested by essdee4336. Melted cable photo evidence (capt.cat_13). Apevia PSU warning (steel wires). Dell DA2 220W running 40 CU undervolted (hoodyracoon).

**Updated:** 03-power-supply-guide.md.

### 7. 40 CU Voltage Guidance

**New finding:** Community consensus: start at 2000 MHz @ 980 mV (vinnijs.dev). Stay below ~1130 mV / 85°C (hojnikb). Silicon lottery varies widely (960-1060 mV for 2000 MHz). Even 1800 MHz @ 40 CU is faster than 24 CU @ 2400 MHz (essdee4336).

**Updated:** 06-gpu-governor.md.

### 8. OS Fixes

**New finding:** CachyOS pacman uses x86_64_v3 by default — fix via Architecture line in pacman.conf (graytl). Bazzite governor issues resolved by rebasing to bazzite:stable (zerosumpr). Hibernate broken on CachyOS (kernel bug — essdee4336, pops1cl).

**Updated:** 05-os-installation.md, 10-troubleshooting.md.

### 9. Rebrand: Unofficial Guide

Repository renamed to `katzzero/bc250-unofficial-community-guide`. All docs updated to reflect: unofficial, made by katzzero, not endorsed by any community.

**Updated:** README.md, CONTRIBUTING.md, all AI protocol files.

---

## HIGH Severity

### 1. VCN Status — V2 is Outdated

**V2 claim:** "No progress, the last person working on it disappeared."

**Community data shows:** Active work IS happening. Users Angablade and holde have poked the SMU to engage the VCN block and are getting partial results. The VCN block is confirmed NOT fused off.

| Evidence | Source | User |
|----------|--------|------|
| "Nothing actually stopping me from poking the SMU commands directly. Because I did it. And that made the registers for the VCN stop being dead registers" | bc250-chat part 331:155 | holde |
| "The driver did see the VCN present after I did that, but ffmpeg didn't return an expected result. I got ONE frame out of it and then ffmpeg crashed" | bc250-chat part 331:266 | holde |
| "Anga sent me over a test script that'll poke the SMU" | bc250-chat part 331:282 | holde |
| "SetSoftMaxVcn 0x4C, SetSoftMinVcn 0x4D" (SMU commands being tested) | bc250-chat part 323:252-253 | Unnamed |
| "neat, my results, active VCN, partially working decode with wrong output, frame encoding probably same" | bc250-chat part 344 | holde |
| "cyan-skillfish-governor-smu would be a good place to inject the correct commands to enable VCN" | bc250-chat part 323:440 | Unnamed |

**Action:** VCN section needs complete rewrite. Status: active research, partial decode achieved, not yet functional.

---

## MEDIUM Severity

### 2. Kernel Recommendations — 6.19.x is the Current Target

**V2 claim:** Recommends 6.18.18 LTS as the primary kernel.

**Community data shows:** No mention of 6.18.18 was found across all 839 export files. The community has moved to kernel 6.19.x, which contains important VRR and DP audio fixes.

| Evidence | Source | User |
|----------|--------|------|
| "All the good stuff that helps this device is already in mesa 26 and kernel 6.19" | bc250-chat part 336:277 | Unnamed |
| "kernel 6.19 has VRR fixes" | bc250-chat part 9:317 | Unnamed |
| "The latest testing release comes with the OGC 6.19.11 kernel. DisplayPort audio works" | bc250-chat part 329:868 | gennro |
| "Testing 6.19 with gpu patch and mesa-git" | bc250-chat part 201:260 | Unnamed |
| Broken kernel ranges confirmed: 6.15.0-6.15.6 and 6.17.8-6.17.10 | Multiple sources | Multiple |

**Action:** Update recommended kernel to 6.19.x. Keep 6.18 stable as fallback but note 6.19 has VRR and DP audio.

---

### 3. Mesa Version — 26 is Now Current

**V2 claim:** "Mesa 25.1+ minimum, 25.3.x recommended."

**Community data shows:** Mesa 26 is actively in use with significant performance improvements.

| Evidence | Source | User |
|----------|--------|------|
| "My Bazzite-deck image from last week is running mesa 26" | bc250-chat part 351:88 | Unnamed |
| "cachy is using the latest mesa 26 which has a lot of fixes and performance improvements in it" | bc250-chat part 350:899 | Unnamed |
| "gains with mesa 26 were no joke. In GTAV enhanced..." (from 3-5fps with RT to smooth) | bc250-chat part 262:860 | Unnamed |
| "We get a little more in Mesa 26 and a little from 6.19" | bc250-chat part 207:488 | Unnamed |
| Mesa-git packages at version "26.0.0_devel.215111" available | channel-export part 6915:15-16 | Chaotic AUR |

**Action:** Update recommendation from "25.3.x" to "26.x recommended, 25.1+ minimum."

---

### 4. VRR — Multiple Paths Now Available

**V2 claim:** Mentions only a custom Bazzite image for VRR.

**Community data shows:** At least four working approaches now exist.

| Evidence | Source | User |
|----------|--------|------|
| "yeah on cachyos VRR is working for me" | bc250-chat part 330:103 | Unnamed |
| "Tested CachyOS and can confirm VRR is working with the Ugreen 8k60hz DP to HDMI 2.1 adaptor" | bc250-chat part 330:301 | Unnamed |
| "VRR is working on the testing build for Bazzite. I use the deck build" | bc250-chat part 331:740 | Unnamed |
| "kernel 6.19 has VRR fixes" | bc250-chat part 349:257 | Unnamed |
| "there is a custom image of bazzite that pulls through the latest stable build but adds the AMD VRR patches" | new-export part 16:308-320 | fforduck |

**Action:** Expand VRR section to document all four approaches: (1) CachyOS native, (2) Bazzite testing branch, (3) custom Bazzite image, (4) kernel 6.19+.

---

## LOW-MEDIUM Severity

### 5. Idle Power Consumption — Range Slightly High

**V2 claim:** "Idle with governor: 65-85W." Also previously claimed 60-70W (Discord-sourced) and referenced perfprofile down to 48W.

**Community data shows:** Actual consensus is 60-70W with SMU governor. The 48W claim from resources is disputed as unverified.

| Evidence | Source | User |
|----------|--------|------|
| "my current idle is about 60W" (after changing SMU profile from 3 to 0) | bc250-chat part 337:418 | gennro |
| "stock ungoverned idle is about 80W, with the GPU governor it's about 40W" (contested claim) | channel-export part 478:19 | neggles |
| "without the patch board with proper fan will hover around 100W on idle, if you use patch, it will idle at 65W" | channel-export part 3822:26 | dantistnfs |
| "measured at the wall with a wattmeter the lowest I've ever gotten the board to idle is like 68 watts" | channel-export part 3767:15 | Unnamed |
| "claims of 45w are BS" | bc250-chat part 48:644 | NexGen-3D |
| "power draw lower than 65 watts has yet to be replicated by anyone in here" | bc250-chat part 12:291 | Unnamed |

**Action:** Refine idle power to "60-70W with SMU governor" (gennro, dantistnfs). Mark sub-60W claims as disputed (NexGen-3D). Add note about SMU profile tuning (profile 0 saves ~15W over profile 3, per gennro).

---

### 6. FSP500-30AS — Missing Caveats

**V2 claim:** 500W, 80+ Platinum. eBay search ID provided.

**Community data shows:** Missing important caveats.

| Evidence | Source | User |
|----------|--------|------|
| "the FSP500 only does 396w on the 12v rail" (not full 500W) | bc250-chat part 342:627 | gennro |
| "FSP500-30AS also commonly emits coil whine when theres no load" | bc250-chat part 105:195 | Unnamed |
| "yeah it took my FSP500 out" (killed by sustained high draw) | bc250-chat part 329:111 | gennro |
| "I was pushing upwards up 350w through that single pcie 8 pin and never melted a wire, but killed the PSU" | bc250-chat part 342:685 | gennro |

**Action:** Add note: 12V rail is 396W (not 500W), known coil whine at no-load, can fail under sustained high draw (gennro).

---

## LOW Severity

### 7. DP Audio Fix — TheFloW Attribution Missing

**V2 claim:** Fixed in Linux 6.19.10+. Bazzite needs custom kernel.

**Community data shows:** Fix was contributed by TheFloW (PS5 Linux developer). Not 100% perfect for all configs.

| Evidence | Source | User |
|----------|--------|------|
| "the guy that added PS5 support to mesa... he says he also fixed displayport audio" | bc250-chat part 304:645 | fanoush_ |
| "We got working dp (and active dp hdmi adapters) audio before GTA 6 thanks to TheFloW" | bc250-chat part 292:807 | Unnamed |
| "it's mostly fixed in newer kernels although audio desynchronization can occur" | bc250-chat part 335:656 | Unnamed |
| "And I still have a hiccup in audio on my 4k TV approximately every 38 seconds (with the active adapter, passive works without issue)" | bc250-chat part 329:906 | gennro |

**Action:** Add attribution to TheFloW. Note that active DP-HDMI adapters may still have intermittent audio issues (gennro).

---

### 8. Sound Blaster Play! 4 — Not Community-Adopted

**V2 claim:** Recommends Creative Sound Blaster Play! 4, ASIN B08T9LM3LM.

**Community data shows:** Zero mentions of Play! 4 or that ASIN across all exports. Community standardizes on generic USB audio dongles.

| Evidence | Source | User |
|----------|--------|------|
| Sabrent USB audio adapter commonly used | bc250-chat part 286:803 | Unnamed |
| UGREEN USB Audio Adapter used | bc250-chat part 59:136 | Unnamed |
| Apple 3.5mm dongle used | bc250-resources 1471566474446372977:334 | Unnamed |
| "just using a usb audio dac and its fine" | bc250-chat part 53:849 | Unnamed |

**Action:** Keep Play! 4 as one option but note it's not community-verified. List commonly-used community options: Sabrent, UGREEN, Apple dongle.

---

### 9. Elden Ring — CachyOS Advantage

**V2 claim:** 45-51 FPS, CPU bottleneck.

**Community data shows:** One user reports +20% FPS on CachyOS vs Bazzite.

| Evidence | Source | User |
|----------|--------|------|
| "+20% fps in Elden Ring in favour of Cachy" | bc250-chat part 350:873 | Unnamed |
| "with pretty aggressive OCs im between 45-55ish fps 1080p mostly low settings" | bc250-chat part 265:571 | Unnamed |
| "FPS remains the same when I lower the graphics to minimum" | bc250-chat part 265:777 | Unnamed |

**Action:** Add note about distro-specific performance (CachyOS may give +20% in CPU-bound games like Elden Ring).

---

### 10. New Game Performance Data (Not in V2)

| Game | Reported FPS | Source | User |
|------|-------------|--------|------|
| Forza Horizon 5 | 40-100 FPS | bc250-chat part 269:212,220 | Unnamed |
| Stellar Blade | 50-80 FPS at 1440p | bc250-chat part 351:116, part 24:659 | fforduck, Unnamed |
| Helldivers 2 | 40-60 FPS | bc250-chat part 7:379 | Unnamed |
| Valheim | 40-80 FPS (mitigations=off) | bc250-chat part 87:737 | Unnamed |
| GTA V Enhanced (RT) | Smooth on Mesa 26 | bc250-chat part 262:860 | Unnamed |
| Oblivion Remaster | 30-75 FPS (3440x1440, FG) | bc250-chat part 311:156,208,270 | Unnamed |
| RDR2 | 31-80 FPS across presets | bc250-chat part 340:928 | Unnamed |
| Marvel Rivals | 100-190 FPS | bc250-chat part 350:693 | Unnamed |
| God of War 3 (RPCS3) | ~42 FPS at 1080p | bc250-chat part 156:798 | Unnamed |

**Action:** Add these benchmarks to V2 game benchmarks with user attribution.

---

## Confirmed Correct (No Change Needed)

| Topic | V2 Claim | Community Confirmation |
|-------|----------|----------------------|
| GPU max clock | 2000 stock / 2230 patched | Confirmed, well-replicated |
| BIOS P3.00 | Recommended | Confirmed by multiple users |
| PTM7950 | Best thermal interface | Gold standard, universally recommended |
| Arctic P12 Pro/Max | Top fan choices | Both still community standard |
| IOMMU must be disabled | Confirmed | Not disputed |
| Mesa 25.1 minimum | Confirmed | Messaged by dozens of users |
| Smokeless_UMAF danger | Confirmed | Not disputed |

---

*Generated by cross-referencing V2 documentation against 839 Discord export files (bc250-chat, bc250-resources, bc250-flex-chat, benchmarks, new May 2026 exports). Each item is traced to the specific source file, line number, and community member. Items marked "Unnamed" where the Discord export format truncated the username.*

---

## Help-Thread FAQ Additions (2026-05-14)

Extracted 13 resolved FAQs from 120 help-thread exports. Added to documentation:

| FAQ | Added To | Source (help-thread user) |
|-----|----------|--------------------------|
| Power on 1 sec then off (bad PSU) | 10-troubleshooting.md | gredzikk |
| GPU hang 1-2h (VRAM overheating) | 10-troubleshooting.md | gdong0921_04971, baramin |
| Blue artifacts (poor GPU bin) | 10-troubleshooting.md | sajonsmk |
| Green screen (GDDR6 reball needed) | 10-troubleshooting.md | jayawesome |
| Bazzite installer freeze (try CachyOS) | 10-troubleshooting.md | .moosi |
| VRR + CachyOS 6.19 + UGREEN + sound | 08-display-and-audio.md | steffman_ |
| Spider-Man 2 OOM fixes | 07-game-benchmarks.md | hojnikb, _nk10, zerosumpr, newgbaxl |
| Flash.nsh keyboard typo | 02-bios-and-firmware.md | najibc |
| Attribution registry updated | ai/AI_PROTOCOL.md | 17 new users added |

---

## AI Inference Addendum (2026-05-15)

Created `12-ai-inference.md` with cross-verified data from Discord exports and internet sources:

| Section | Key Claims Verified |
|---------|-------------------|
| llama.cpp Vulkan (quick start) | Pre-built vulkan zips, `-ngl 999`, `-cram`, `GGML_VK_FORCE_MAX_ALLOCATION_SIZE` |
| Performance benchmarks | Discord data (hammercoral, __nightfox, xseol) + llama.cpp GitHub benchmark thread #10879 |
| ROCm status | Confirmed gfx1013 not in ROCm matrix; partial work (hammercoral, neoney) |
| Model compatibility | Fits Qwen-9B, Gemma-12B, MoE-30B; needs 5+ boards for 70B |
| Ollama limitations | ~56% slower due to vendored llama.cpp b7437 (Ollama issue #15601) |
| Multi-board RPC | Only PP, not TP; 1GbE bottleneck (xseol data) |
| Stable Diffusion | stablediffusion.cpp + Vulkan confirmed; 2x vs RX 6600 |

Web sources used: elektricM radv.md, ROCm/TheRock SUPPORTED_GPUS.md, Phoronix (Mesa 25.1 RADV), llama.cpp issue #10879/#15601/#20934.

---

## 40 CU Unlock (2026-05-18)

Community project `duggasco/bc250-40cu-unlock` re-enables all 40 CUs on the BC-250 via kernel patch. Key updates:

| File | Change |
|------|--------|
| 01-hardware-specs.md | GPU CU count: 24x CUs, up to 40 unlockable. 40 CU power data at 1500 MHz (125W) and 2 GHz (181W). |
| 12-ai-inference.md | Full 40 CU Unlock section: 1.61x compute scaling (230→372 tok/s pp512), register mechanism, health testing, install, safety, credits. |
| README.md | Key Facts GPU line: "up to 40 via kernel patch" |

Credits: duggasco (research, repo), filippor (independent testing), scallion_9883 (benchmarks), Claude/Codex (SPI register analysis), kilrah (disable_cu), hojnikb (harvest maps), koloses (bad CU testing), essdee4336 (thermal), big_trov (stable verify), codyrainy (build test).

---

## 40 CU Gaming Benchmarks + Mangohud Fix (2026-05-19)

Extracted from project-forums Discord channel:

| File | Change |
|------|--------|
| 07-game-benchmarks.md | New 40 CU gaming section: Furmark 1080p/1440p (57→153 FPS scaling), Superposition scores (Medium 14004, Extreme 5759), efficiency insight (more CUs + lower clock = cooler same perf) |
| 01-hardware-specs.md | 40 CU idle power (75W vs 69W stock), efficiency insight (big_trov) |
| 10-troubleshooting.md | New mangohud 655% GPU usage fix (hassanthejust — Python daemon intercepts gpu_metrics at 0x1C) |

Credits: big_trov (40CU gaming benchmarks, idle, efficiency), essdee4336 (40CU Furmark 1080p at multiple clocks), hassanthejust (mangohud fix), hojnikb (comparison data).

---

## Cross-Reference Verification Fixes (2026-05-25)

Full audit of 26 repos cloned and cross-referenced against documentation:

| File | Change |
|------|--------|
| 02-bios-and-firmware.md | Removed `(need confirmation)` from MrrZed0/bc-250-bios — URL confirmed valid |
| 05-os-installation.md | Fixed wrong script name: `Arch-setup.sh` → `install.sh` (eabarriosTGC/BC250--ARCH) |
| 05-os-installation.md | Fixed wrong script name: `install.sh` → `oberon_install.sh` (pnbarbeito/bc250-arch) |
| 07-game-benchmarks.md | Fixed duplicate numbering (two items labeled "8.") |
| 10-troubleshooting.md | Fixed typo: "scooter tool" → "scooper tool" |
| 01-hardware-specs.md | Fixed malformed sentence: "48W perfprofile tweak is" → "48W perfprofile tweak" |

Additional findings (requires Discord community follow-up):
- kenavru/BC-250 described as "EFI flash tool" — actually just BIOS files, no flash tool
- Fred78290/nct6687d described as "PWM fan control driver" — actually lm-sensors monitoring driver
- bc250-acpi-fix: doc says "C-States and P-States" but P-States don't work per README
- 5 repos exist but not documented: BC-250-Custom-Case, bc-250-sleeve-adapter, BC250--ARCH, bc250-arch, Magnap-cyan-skillfish-governor

---

## Full Cross-Reference Audit Corrections (2026-05-25)

Full audit of all 14 Revised files (~3,200 lines) against 30+ elektricM docs, 27 repos, 80+ Discord exports, and RAG vector store. 10 parallel agents, 45 corrections total.

### CRITICAL Corrections

| File | Line | Change | Source |
|------|------|--------|--------|
| 01-hardware-specs.md | 17 | GPU perf: "RX 6600" → "Stock 24 CU: Between RX 6600/6600 XT; 40 CU: RX 6700/GTX 1080 Ti" | May 2026 Discord (jpvgaster, big_trov, essdee4336) |
| 02-bios-and-firmware.md | 35 | "[Forced]" → "[Forces]" — Forces is actual BIOS value, not typo | elektricM flashing.md, kenavru README |
| 02-bios-and-firmware.md | 215 | Stock 24 CU temp: 83°C → 79°C | duggasco/README.md, technical-report.md |
| 02-bios-and-firmware.md | 300-301 | Removed "GitHub README is incorrect" claim — it correctly documents WGP granularity | duggasco/README.md, GreatApo fork |
| 04-cooling-guide.md | 25 | "Cutout variant with built-in openings" → "Thicker-fin variant, fewer thicker-gauge fins" | elektricM cooling.md |
| 06-gpu-governor.md | 360 | "RedBoard" → "redbeard1083" | GitHub username confirmation |
| 08-display-and-audio.md | 101-108 | Vulkan_NullVRS: fixed env var (Vulkan_NullVRS=1 → ENABLE_VK_NULLVRS_1=1) and install method | Vulkan_NullVRS README |
| 08-display-and-audio.md | 38, 58 | Fixed two misattributions: gennro→essdee4336 (line 38), gennro→fforduck (line 58) | Discord exports |
| 09-wifi-and-peripherals.md | 70 | Play! 4 ASIN misattribution: B06XBZ38ZJ → B08T9LM3LM (was Play! 3 ASIN) | Cross-file consistency check |
| 10-troubleshooting.md | 397-408 | Split VRS vs 640x480 — were conflated as same issue | Vulkan_NullVRS README, Discord |
| 11-community-and-resources.md | 57,154 | Message count aligned: 7,782→9,716 | elektricM README |
| 01-hardware-specs.md | 77 | Removed unverified "48W perfprofile tweak" claim | No source found in any export or repo |

### MEDIUM Corrections

| File | Line | Change | Source |
|------|------|--------|--------|
| 02-bios-and-firmware.md | 14 | _fanous_ → _fanoush_; "custom fan curve" → "standard fan control" | Discord, elektricM flashing.md |
| 02-bios-and-firmware.md | 228-231 | gennro toolkit: changed to curl + correct script name | gennro/bc250-toolkit README |
| 02-bios-and-firmware.md | 112-114 | Internal flash warning softened — MrrZed0 repo docs it | MrrZed0/README.md |
| 05-os-installation.md | 168-179 | Nobara attribution: mothenjoyer69 → "Discord community discussion" | User not confirmed in exports |
| 07-game-benchmarks.md | 217,236 | Arc Raiders: ~100→60+; Zenless: 40-50→crashes | Discord contradiction resolution |
| 07-game-benchmarks.md | 378 | nexgen3d voltage: 1145→1165 mV | Discord Superposition thread screenshot |
| 09-wifi-and-peripherals.md | 13 | BT version: 5.2→5.3 | Amazon listing |
| 10-troubleshooting.md | 60 | Added 6.19.x kernel recommendation | quick-reference.md |
| 10-troubleshooting.md | 165-203 | Added note: btrfs/SELinux steps from Discord, not performance.md | Source audit |
| 10-troubleshooting.md | 246 | Added (need confirmation) to sajonsmk claim | User not found in exports |
| 11-community-and-resources.md | 25 | ACPI fix: "C-States and P-States" → "C-States (P-States experimental)" | bc250-acpi-fix README |
| README.md | 52 | ACPI fix warning: added P-State caveat | bc250-acpi-fix README |
| 04-cooling-guide.md | 59 | Router quote: removed (need confirmation), attributed to snodrat | bc250-flex-chat export |
| README.md | 48 (new) | Added 6-pin to 8-pin fire hazard warning | Discord confirmation |

### LOW Corrections

| File | Line | Change |
|------|------|--------|
| 05-os-installation.md | 67 | Removed (need confirmation) from bazzite password |
| 05-os-installation.md | 251 | Fixed leading space before chmod |
| 06-gpu-governor.md | 39 | Removed (need confirmation: Manjaro) — confirmed by elektricM docs |
| 06-gpu-governor.md | 233 | Added P-State nuance note (repo says not working, Discord says works) |
| 07-game-benchmarks.md | 30,46,59,60,85,184,233,283 | 8 (need confirmation) → (Discord user) with confirmed source |
| 07-game-benchmarks.md | 59 | 2230 MHz crash and 10/6 VRAM fixes confirmed |
| 10-troubleshooting.md | 151 | MESA_LOADER_DRIVER_OVERRIDE source: "not in source docs" → "Discord bc250-chat" |
| 10-troubleshooting.md | 105,111,121 | 3 (need confirmation) tags removed — Discord sources found |
| 10-troubleshooting.md | 452-453 | 2 (need confirmation) tags removed — Discord sources found |
| 04-cooling-guide.md | 110 | Removed (need confirmation) from screw warning — elektricM confirmed |

### Still Unresolved
- ~60+ (need confirmation) tags remain without source (concentrated in 07-game-benchmarks.md and 11-community-and-resources.md)
- 6+ Printables URLs return transport errors (confirmed still failing as of June 14, 2026)
- ~~5 repos not yet documented~~ ✅ Resolved — added to 11-community-and-resources.md

---

## Cross-Reference Verification Protocol

Created `ai/AI_VERIFICATION_PROTOCOL.md` — standardized multi-layer verification process for future audits.

Protocol features:
- Source hierarchy with "newest wins" rule
- 3-layer verification (RAG, parallel agents, cross-file)
- Finding classification (severity + type taxonomy)
- Full 5-step workflow: Discovery → Analysis → Plan → Execution → Validation
- Standardized report format for machine-parsable output
- Quality assurance gates with pass criteria
- Agent handoff protocol for interrupted cycles

Created by: Claude (Anthropic) via opencode on 2026-05-25

---

## New Discord Exports Audit (2026-05-25)

Reviewed 45 new bc250-chat exports (after May 20, 2026). Key findings added:

| File | Change |
|------|--------|
| 06-gpu-governor.md | Added governor v0.4.0 CPU-based memory clock control; idle power testing (big_trov/pops1cl); min freq 500 MHz default; SMU-plus pprofile autoswitching |
| 07-game-benchmarks.md | dznuts 5300 Superposition 38CU/2200MHz; Death Stranding 2 36CU@1440p+FG=60; S.T.A.L.K.E.R. 2 stock/36CU/FG benchmarks; Subnautica 2; PICO upscaler; memory OC gains minimal |
| 02-bios-and-firmware.md | PS5 40CU patch confirmed (gennro); OCP secondary power limit at 1850-2200MHz; CPU core unlock research update |
| 04-cooling-guide.md | Thermalright Peerless Assassin 120 + 3D bracket + GPU backplate cooler |
| 01-hardware-specs.md | Idle power identical regardless of CU count (big_trov); 64W downclocked idle (pops1cl) |
| README.md | Latest additions section updated |

---

## Full Guild Export + RAG Rebuild + Audit (2026-05-25)

Exported all guild channels and threads after 2026-05-20 (105 new files). Rebuilt RAG index (69,591 → 72,355 chunks). Ran full audit cycle per AI_VERIFICATION_PROTOCOL:

| Layer | Action | Result |
|-------|--------|--------|
| A | RAG queries on all key claims | Most claims score ≥0.70-0.85 — well-supported |
| B | Cross-reference new exports vs docs | 40CU data, governor, OCP already covered |
| C | Cross-file consistency | Fixed duplicate numbering in README warnings |

**Corrections applied:**
- README.md: Removed `(need confirmation)` from FSP500-30AS eBay ID 389522369783 — confirmed by essdee4336 (May 23, 2026)
- README.md: Fixed duplicate "8." numbering in Important Warnings (was 8, 8, 9 → 8, 9, 10)
- ai/rag_query.py: Unified with RAG/rag_query.py (fixed ChromaDB path, added Discord chunk merging, noise filtering, Ollama error handling, stats sampling)

**New exports reviewed:** 105 files from bc250-chat, bc250-flex-chat, bc250-resources, benchmarks, help-thread, project-forums (after 2026-05-20). Key topics: big_trov 40CU efficiency data, SMU Plus troubleshooting, CPU core unlock research (scallion_9883), new Superposition/Furmark scores. All existing docs already reflect these findings.

