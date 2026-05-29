# 12 -- AI Inference & LLMs

> The BC-250 is capable of running local AI inference, including large language models (LLMs) and image generation (Stable Diffusion), using the Vulkan compute backend. Its 16 GB unified memory and 24 RDNA 2 CUs make it a viable budget option for local AI workloads.

---

## Overview

### What Works

| Tool | Status | Notes |
|------|--------|-------|
| **llama.cpp (Vulkan)** | Confirmed (elektricM radv.md) | Primary path. Pre-built Vulkan binaries work. Use `-ngl 999`. |
| **llama.cpp (ROCm/HIP)** | Partial (Discord community) | hammercoral achieved 2.5-3x speedup over Vulkan but no guide published. As of May 2026, n3oney got partial results. |
| **llama.cpp (RPC/distributed)** | Confirmed (xseol, Discord) | Multi-board via Ethernet. Performance limited by 1GbE. |
| **Ollama (Vulkan)** | Confirmed (Discord community) | Works but lags behind standalone llama.cpp (~56% slower due to vendored old version akandr/bc250). |
| **KoboldCPP** | Confirmed (Discord community) | Uses stablediffusion.cpp / GGML-Vulkan. |
| **LM Studio** | Confirmed, suboptimal (Discord community) | VRAM/system RAM balancing issues on UMA. |
| **Stable Diffusion (stablediffusion.cpp + Vulkan)** | Confirmed (Discord community) | 2x performance vs RX 6600 in one user's test. |
| **vLLM** | Does not work (Discord community) | Not supported. Use llama.cpp RPC for multi-board. |
| **PyTorch / ComfyUI** | Does not work (Discord community) | Vulkan support for torch does not extend to torchvision/torchaudio. |

### Why Vulkan and Not ROCm

The BC-250 GPU is identified as **gfx1013** (Cyan Skillfish), a hybrid RDNA 1.5 architecture. ROCm does not officially support gfx1013 -- the GPU is absent from AMD's compatibility matrix (ROCm docs). The open-source TheRock project tracks gfx1010/gfx1011/gfx1012 but not gfx1013 (ROCm/TheRock). This means rocBLAS lacks pre-compiled kernels for this architecture, requiring manual compilation or workarounds (elektricM radv.md).

For most users, the Vulkan backend via RADV is the reliable path. Recent llama.cpp Vulkan improvements (Wave32 flash attention PR #19625, graphics queue PR #20551) have closed much of the performance gap between Vulkan and HIP backends on AMD hardware (llama.cpp issue #15601).

---

## Quick Start: llama.cpp + Vulkan (Recommended)

### BIOS and Kernel Configuration

Set VRAM to **512MB dynamic** in BIOS. The rest is allocated dynamically via GTT:

```bash
# Add to kernel parameters for ~14 GB VRAM
amdgpu.gttsize=14000 ttm.pages_limit=3584000 ttm.page_pool_size=3584000
```

### Install llama.cpp

```bash
# Create directory and download pre-built Vulkan binary
mkdir -p ~/llama && cd ~/llama
wget https://github.com/ggerganov/llama.cpp/releases/download/b7150/llama-b7150-bin-ubuntu-vulkan-x64.zip
7z e llama-b7150-bin-ubuntu-vulkan-x64.zip && rm llama-b7150-bin-ubuntu-vulkan-x64.zip
```

### Run the Server

```bash
./llama-server -m /path/to/model.gguf -c 40960 -ngl 999 -fa -ctk q4_0 -ctv q4_0 --jinja --host 0.0.0.0 --port 8080
```

Key flags:
- `-ngl 999` -- offload ALL layers to GPU (critical for performance)
- `-fa` -- Flash Attention (requires Mesa 25.1+ with Wave32 support)
- `-ctk q4_0 -ctv q4_0` -- KV cache quantization
- `--jinja` -- use chat template from model file

### Avoid OOM Crashes

The `-cram` flag prevents OOM by limiting context RAM allocation. Without it, llama.cpp defaults to 8 GB system RAM assumption which will cause OOM on the BC-250 (Discord community).

```bash
export GGML_VK_FORCE_MAX_ALLOCATION_SIZE=2000000000  # 2 GB chunks
```

### Headless Mode (Maximum RAM)

```bash
sudo systemctl set-default multi-user.target   # saves ~600 MB vs GUI
```

---

## Performance Benchmarks

### Single Board -- llama.cpp (Vulkan)

Community-tested performance (Discord):

| Model | Quant | Prompt (pp512) | Generation (tg128) | User |
|-------|-------|----------------|--------------------|------|
| TinyLlama 1.1B | Q4_K_M | 326 tok/s | 49.8 tok/s | hammercoral |
| Llama 3.1 8B | Q4_K_M | 281 tok/s | 52.3 tok/s | __nightfox |
| Gemma 3 12B | Q8 | -- | ~30 tok/s | xseol |
| GPT-OSS 20B | Q4 | -- | ~70 tok/s | _fanoush_ |
| Qwen3-Coder-30B-A3B (MoE) | Q4 | -- | ~70 tok/s | machinezer0 |
| MiroThinker-14B | IQ4_XS | -- | 12-15 tok/s | steinbeks |
| Qwen3-4B | Q4_K_XL | -- | ~50 tok/s (after fixing layer offload) | birdetta |
| GLM 4.6V | Q4_K_M | -- | 12 tok/s (6->12 after llama.cpp update) | xseol |

### BC-250 in llama-bench (Standardized Benchmark)

From the official llama.cpp Vulkan benchmark thread (llama.cpp issue #10879, ggml-org):

| Model | Size | Backend | Prompt (pp512) | Generation (tg128) |
|-------|------|---------|----------------|--------------------|
| Llama 2 7B Q4_0 | 3.56 GB | Vulkan | 370.66 tok/s | 62.32 tok/s |
| Llama 2 7B Q4_0 | 3.56 GB | Vulkan (later build) | 356.87 tok/s | 63.14 tok/s |

The BC-250's generation speed is comparable to an RTX 3070 Mobile (63.64 tok/s) and GTX 1080 Ti (64.63 tok/s) on the same benchmark.

### ROCm vs Vulkan Comparison

hammercoral's benchmarks on a single BC-250 (Discord):

| Model | Metric | Vulkan | ROCm/HIP | Speedup |
|-------|--------|--------|----------|---------|
| TinyLlama 1.1B | pp512 | 326 tok/s | 709 tok/s | 2.17x |
| TinyLlama 1.1B | tg128 | 49.8 tok/s | 151 tok/s | 3.03x |
| Llama 3.1 8B | pp512 | 46.6 tok/s | 115 tok/s | 2.48x |
| Llama 3.1 8B | tg128 | 12.2 tok/s | 30 tok/s | 2.46x |

Note: On newer RDNA hardware, Vulkan has been consistently matching or beating ROCm for token generation due to Vulkan-specific Wave32 optimizations (llama.cpp issue #20934). These benchmarks may not reflect the current state.

### Multi-Board RPC (Distributed)

xseol's multi-board data (Discord):

| Model | Boards | Generation | User |
|-------|--------|-----------|------|
| GLM-4.5-Air Q4_K_S | 6 | Starts at 9.5 tok/s | xseol |
| ERNIE-4.5-21B | 2 (Q8) | Starts at 30 tok/s | xseol |
| GPT-OSS-20B | 2 (Q8) | Starts at 23 tok/s | xseol |
| Gemma 3 27B | 2 (Q6_K) | Starts at 9 tok/s | xseol |
| DeepSeek Coder V2 Q4 | 2 | Prompt 48.6, Gen 20.7 tok/s | adaptive__manipulator |

---

## Model Compatibility (Single Board, 16 GB)

### Fits Comfortably
- Qwen 3.5 4B-9B (Q4_K_M) -- ~50 tok/s
- Llama 3.1 8B (Q4_K_M) -- ~52 tok/s
- Gemma 3 12B (Q8) -- ~30 tok/s
- Mistral Nemo 12B (IQ4_K or Q4_K_M)
- Phi-4 (various quants)
- Qwen3-Coder-30B-A3B (MoE, fits as mixture of experts)
- GPT-OSS 20B (Q4) -- ~70 tok/s, cuts it close

### Requires Careful Quantization
- Gemma 4 26B MoE (Q3) -- barely fits, 48K context
- MiroThinker-14B (IQ4_XS)

### Requires Multiple Boards
- 70B models -- requires 5+ boards via RPC
- GPT-OSS 120B -- requires 6+ boards via RPC

---

## ROCm/HIP Status

ROCm on gfx1013 (Cyan Skillfish) is **partial and has known regressions**:

- **hammercoral** achieved working ROCm/HIP/PyTorch compute with "firmware on MEC changed, bios settings, recompiling multiple software stacks" but published no setup guide (Discord).
- **n3oney** (May 2026): Got a single token via ROCm but failed when attempting to offload more layers (Discord).
- **ROCm regression (geenight, May 2026):** Issue filed as ROCm #6313. BC-250 system freezes completely after compute workloads. Worked with ROCm 5.2 on Ubuntu 20.04, but newer versions cause full system freezes requiring power cycle. scallion_9883 confirmed building a custom HIP kernel and warned that memcpy + worker reaping can wedge the board.
- rocBLAS aborts on detection because gfx1013 is not in the GPU list (elektricM radv.md).
- RDNA1 architectures gfx1010/gfx1011 are build-passing in TheRock but gfx1013 is absent (ROCm/TheRock SUPPORTED_GPUS.md).
- Community sentiment: "The last person who had ROCm working promised a guide then disappeared forever" (Discord).
- `HSA_OVERRIDE_GFX_VERSION=10.3.0` may enable partial ROCm stack support but comes with risks and no guarantees.

For most users, **Vulkan is the recommended backend** for all AI inference workloads on the BC-250 (elektricM radv.md).

---

## Ollama Notes

Ollama works with its Vulkan backend on the BC-250 but has two important limitations (Discord community, akandr/bc250 repo):

1. **Outdated vendored llama.cpp**: As of early 2026, Ollama vendors llama.cpp at b7437 (Dec 2025), missing Wave32 flash attention (PR #19625) and graphics queue fixes (PR #20551) that provide ~56% improvement on AMD Vulkan (llama.cpp issue #15601).
2. **VRAM/system RAM balancing**: Unified memory on the BC-250 can cause Ollama to overallocate system RAM under its default assumptions.

For best performance, use standalone llama.cpp directly instead of Ollama.

---

## Stable Diffusion

Stable Diffusion runs via stablediffusion.cpp with the Vulkan backend (Discord community):
- One community member reported 2x performance vs an RX 6600 on the same workload.
- Video/latent models are very slow on a single board.
- The main limitation is the lack of PyTorch ROCm support, which blocks ComfyUI and similar tools.

---

## 40 CU Unlock (Active Community Project)

**Repository:** [duggasco/bc250-40cu-unlock](https://github.com/duggasco/bc250-40cu-unlock)
**Status:** Working, 19 stars, 1 fork (May 2026). 1.61x compute scaling verified.

The BC-250 ships with 24 of 40 RDNA2 CUs active (16 harvested). A kernel patch from duggasco re-enables all 40 CUs. See [01-Hardware Specs](01-hardware-specs.md) for installation, CU masking, and health testing procedures.

### LLM Performance with 40 CUs (llama.cpp Vulkan, Qwen3.5-9B Q4_K_XL)

| Config | pp512 tok/s | Power | Temp | SCLK |
|--------|-------------|-------|------|------|
| Stock 24 CU | 230 | 95W | 79C | 1500 MHz |
| **40 CU unlocked** | **372** | **125W** | **83C** | **1500 MHz** |
| **Ratio** | **1.61x** | +30W | +4C | same |
| 40 CU @ 2 GHz (governor) | 466 | 181W | 96C | 2000 MHz |

**Qwen3.5-9B @ 40 CU (May 2026):** +25% tok/s over 24 CU on llama-server with Q4_K_M.gguf (community test, May 2026). Furmark showed ~50% FPS gain, so LLM workload scales differently than gaming — prompt batching and context size tuning needed for optimal results.

**Recommended sweet spot:** 1500 MHz / 900 mV via cyan-skillfish-governor. 40 CU at 2 GHz hits 96C and requires upgraded cooling (duggasco, scallion_9883).

---

## Community Resources

- **akandr/bc250** (GitHub) -- Ollama + Vulkan inference guide for BC-250
- **kingofgames0880 VC-250 guide** (Discord bc250-resources) -- Complete llama.cpp + Crush CLI setup
- **hammercoral ROCm benchmarks** (Discord bc250-chat) -- Best ROCm performance data available
- **NexGen-3D SteamMachine repo** (GitHub) -- Automated setup scripts for Bazzite including governor + swap
- **scallion_9883 HIP kernel work** (Discord bc250-chat) -- Custom HIP kernel for BC-250, ROCm debugging
- **ROCm issue #6313** -- BC-250 system freeze after compute workloads. Filed by geenight, community investigation ongoing
- **elektricM radv driver guide** -- RADV setup and LLM inference notes (elektricM.github.io/amd-bc250-docs/drivers/radv/)

---

*Sources: elektricM radv.md (primary), Discord bc250-chat (hammercoral, __nightfox, xseol, _fanoush_, steinbeks, deathstalkerjr, adaptive__manipulator, birdetta, machinezer0, n3oney), llama.cpp GitHub benchmark thread #10879, Ollama issue #15601, ROCm/TheRock SUPPORTED_GPUS.md, Phoronix coverage.*

Last modified by: deepseek-v4-pro on 2026-05-29
