# 00 — From Zero to Gaming: Complete BC-250 Setup Guide

> Um guia linear passo a passo desde a compra até o primeiro jogo rodando.
> Cada seção linka para o documento detalhado — use este como roteiro principal.

---

## Sumário

1. [Antes de Comprar](#1-antes-de-comprar)
2. [Recebendo a Board](#2-recebendo-a-board)
3. [Montagem: Fonte](#3-montagem-fonte)
4. [Montagem: Cooler](#4-montagem-cooler)
5. [Montagem: Armazenamento e Gabinete](#5-montagem-armazenamento-e-gabinete)
6. [BIOS: Flash](#6-bios-flash)
7. [BIOS: Configuração](#7-bios-configuração)
8. [Primeira Inicialização + Escolha do SO](#8-primeira-inicialização--escolha-do-so)
9. [Instalação do SO](#9-instalação-do-so)
10. [Pós-Instalação: Governor e Drivers](#10-pós-instalação-governor-e-drivers)
11. [Display e Áudio](#11-display-e-áudio)
12. [WiFi e Periféricos](#12-wifi-e-periféricos)
13. [Steam e Jogos](#13-steam-e-jogos)
14. [40 CU Unlock (Opcional)](#14-40-cu-unlock-opcional)
15. [Benchmarks](#15-benchmarks)
16. [Troubleshooting Rápido](#16-troubleshooting-rápido)
17. [Próximos Passos](#17-próximos-passos)

---

## 1. Antes de Comprar

### O que você precisa pedir

| Item | Essencial? | Notas |
|------|-----------|-------|
| **BC-250 board** | ✅ Essencial | AliExpress ou eBay, qualquer BIOS P2.00-P5.00 |
| **Fonte 12V com PCIe 8-pin** | ✅ Essencial | FSP500-30AS (~$15 eBay) é o padrão ouro |
| **Fan 120mm de alta pressão** | ✅ Essencial | Arctic P12 Pro (~$25/5-pack) |
| **Cabo DisplayPort** | ✅ Essencial | DisplayPort nativo é a melhor saída |
| **USB WiFi (se precisar)** | ⚠️ Recomendado | Sem WiFi onboard — TP-Link TX10UB Nano |
| **M.2 NVMe SSD** | ⚠️ Recomendado | Qualquer um, slot é PCIe 2.0 x2 (~1 GB/s max) |
| **Pasta térmica ou PTM7950** | ⚠️ Recomendado | Stock ressecada — MX-4, Kryonaut ou PTM7950 |
| **Gabinete/suporte** | ⚠️ Recomendado | Case 3D, GPU enclosure ou suporte DIY |

**Ordem de compra recomendada:** Board primeiro (AliExpress leva mais tempo), depois o resto.

> Consulte [Prerequisites (elektricM)](../export/elektricM-docs/docs/getting-started/prerequisites.md) para checklist completo.

### Especificações rápidas

- **APU:** 6x Zen 2 + 24 CU RDNA 2 (gfx1013), 16 GB GDDR6 compartilhado
- **TDP:** ~220W (235W pico)
- **Saída de vídeo:** 1x DisplayPort 1.4 (sem HDMI nativo)
- **Armazenamento:** 1x M.2 2280 PCIe 2.0 x2
- **Rede:** 1x Gigabit Ethernet (sem WiFi)
- **IOMMU:** Quebrado — sempre desabilitar no BIOS

> Consulte [01 — Hardware Specs](01-hardware-specs.md) para detalhes completos.

---

## 2. Recebendo a Board

### Checklist de inspeção

- [ ] Heatsink sem danos físicos visíveis
- [ ] Fans (se inclusas) sem pás quebradas
- [ ] Pinos do conector PCIe 8-pin retos
- [ ] Chip BIOS_A1 sem marcas de dano
- [ ] Transistor Q11 próximo ao Nuvoton presente (pode ser arrancado no transporte)

### Heatsink — preparação

1. Remova os 4 parafusos e retire o heatsink
2. **Abra as aletas centrais** — estão amassadas de fábrica (5-10°C de diferença)
3. Use um alicate de bico fino ou a ferramenta "BC-250 Scooper" (Printables)
4. Limpe a pasta térmica velha com álcool isopropílico

> Consulte [04 — Cooling Guide](04-cooling-guide.md) para técnicas de preparação do heatsink.

---

## 3. Montagem: Fonte

### O requisito essencial

A BC-250 precisa de **12V apenas** com um **conector PCIe 8-pin (6+2)**.

| Opção | Veredito | Preço |
|-------|----------|-------|
| **FSP500-30AS** (Flex ATX) | 🏆 Padrão ouro | ~$15 eBay |
| **MeanWell LOP-300-12** | Ótimo para builds ultracompactas | ~$40 DigiKey |
| **ATX 400W+ qualquer** | Funciona se já tiver uma sobrando | ~$0 (reaproveitada) |
| **Server PSU + breakout board** | Funciona mas MUITO barulhenta | ~$20-30 |

### Conexão

1. Fonte ATX: conecte o cabo PCIe 8-pin direto na board
2. FSP500-30AS (10-pin): faça o jumper do PS_ON (verde) ao GND para ligar
3. A placa liga automaticamente quando 12V é aplicado (jumper AUTO_PWRON1: pins 1-2)

### ⚠️ Segurança

- **NUNCA** use adaptador SATA-para-PCIe — risco de incêndio (SATA = 54W, board = 235W)
- **NUNCA** use adaptador 6-pin para 8-pin barato — derrete
- Use **fio 16 AWG ou mais grosso** para extensões
- FSP500-30AS é o padrão por ter cabos de alta qualidade

> Consulte [03 — Power Supply Guide](03-power-supply-guide.md) para pinouts, wiring, e mais fontes.

---

## 4. Montagem: Cooler

### Aplicação da pasta térmica

| Produto | Condutividade | Veredito |
|---------|--------------|----------|
| **PTM7950** (phase change pad) | Excelente (4-15°C melhora) | 🏆 Melhor, mas precisa de ciclos térmicos para "curar" |
| **Thermal Grizzly Kryonaut** | 12.5 W/mK | ✅ Excelente pasta tradicional |
| **Arctic MX-6** | 10.0 W/mK | ✅ Ótima custo-benefício |
| **Arctic MX-4** | 8.5 W/mK | ✅ Boa e barata |

**Aplicação (PTM7950):**
1. Limpe o die e o copper do heatsink com álcool isopropílico
2. Remova o plástico de um lado, aplique no die
3. Remova o segundo plástico
4. Aperte os parafusos em cruz
5. **Primeiro boot vai mostrar 80-90°C** — normal, o pad precisa "cozinhar"

### Montagem do fan

1. Posicione um **fan 120mm de alta pressão estática** (Arctic P12 Pro) sobre o centro do heatsink
2. Prenda com **abraçadeiras (zip ties)** — método mais simples e seguro
3. Conecte ao header **J1** (fan primário, 4-pin PWM)
4. **Configuração recomendada:** push (soprando para dentro do heatsink)

### Thermal pads (VRAM)

- **Frente:** 1.5mm de espessura
- **Verso (GDDR6):** 2.0mm de espessura — CRÍTICO, não tem sensor de temperatura
- **Alternativa:** Thermal putty (Fehonda LTP81) — auto-ajustável

> Consulte [04 — Cooling Guide](04-cooling-guide.md) para fan selection, push-pull, 3D printed shrouds e water cooling.

---

## 5. Montagem: Armazenamento e Gabinete

### SSD M.2

- Qualquer NVMe funciona (PCIe 2.0 x2 = ~1 GB/s max, não vale a pena gastar muito)
- Mínimo 256GB, recomendado 1TB
- SSD SATA também funciona no slot

### Gabinete / Case

| Opção | Descrição |
|-------|-----------|
| **3D printed** | 145+ designs na Printables, categoria por tipo de PSU |
| **GPU enclosure** | Alguns encaixam a BC-250 |
| **DIY** | Standoffs + acrílico/madeira |
| **4U server case** | Original ASRock, fans barulhentas — substituir |

### Montagem final

1. Instale o SSD no slot M.2
2. Monte a board no case/gabinete
3. Conecte o cabo PCIe 8-pin da fonte
4. Conecte o fan no header J1
5. Conecte o cabo DisplayPort ao monitor
6. Conecte teclado/mouse USB
7. (Opcional) Conecte cabo Ethernet para instalação

> Consulte [09 — WiFi & Peripherals](09-wifi-and-peripherals.md) para gabinetes e acessórios.

---

## 6. BIOS: Flash

> **O flash da BIOS modificada é OBRIGATÓRIO.** Sem ela, você não consegue configurar VRAM dinâmica, fan control, e outras opções essenciais.

### O que baixar

1. BIOS modificada: [bc250-bios (GitLab)](https://gitlab.com/TuxThePenguin0/bc250-bios/)
2. Ferramenta de flash USB: [4U12G BIOS Update (GitHub)](https://github.com/kenavru/BC-250/raw/refs/heads/main/4U12G%20BIOS%20Update.zip)
3. BIOS recomendada: `BC250_3.00_CHIPSETMENU.ROM`

### Método USB (Recomendado)

1. Formate um pendrive em **FAT32**
2. Extraia o ZIP e copie o conteúdo para a raiz do pendrive
3. Renomeie a BIOS baixada para `Robin5.00` (R maiúsculo, sem extensão)
4. Pendrive deve conter: `AfuEfix64.efi`, `Flash.nsh`, `Robin5.00`
5. **Remova o SSD** da placa (força boot pelo EFI Shell)
6. Conecte o pendrive, ligue a placa
7. No prompt `Shell>`, digite `blk0:` (com espaço depois dos dois pontos) e Enter
8. Digite `Flash.nsh` e Enter
9. **AGUARDE** — não interrompa por nada, pode levar até 15 minutos
10. A placa reinicia — desligue imediatamente, remova o pendrive

### ⛔ CMOS Clear (CRÍTICO — Não Pule)

Após QUALQUER flash de BIOS, os settings não persistem sem isso:

1. Desligue, remova a fonte da tomada
2. Remova a bateria **CR2032** por **60 segundos**
3. Com a bateria fora, aperte o botão power **5 vezes**
4. Recoloque a bateria, ligue, entre no BIOS (Del)
5. Verifique que o CMOS foi limpo (relógio vai estar errado)
6. Reconfigure o BIOS e salve com F10

> Consulte [02 — BIOS & Firmware](02-bios-and-firmware.md) para métodos alternativos (CH341A, flash interno), pinouts e troubleshooting.

---

## 7. BIOS: Configuração

Entre no BIOS apertando **Delete** durante o boot e configure:

```
Chipset → GFX Configuration:
  Integrated Graphics Controller = [Forced]
  UMA Mode                       = [UMA_SPECIFIED]
  UMA Frame Buffer Size          = [512M]   ← VRAM dinâmico (recomendado)

Advanced → CPU Configuration:
  IOMMU = [Disabled]   ← OBRIGATÓRIO — IOMMU é quebrado

Boot → Boot Mode:
  Boot Mode = [UEFI]
```

### VRAM: Qual modo escolher?

| Modo | VRAM | RAM | Melhor para |
|------|------|-----|-------------|
| **512MB (Dynamic)** | Auto (~11.5 GB) | Auto | ✅ Uso geral |
| 6 GB fixed | 6 GB | 10 GB | AAA gaming sem risco de OOM |
| 8 GB fixed | 8 GB | 8 GB | Workload balanceado |
| 4 GB fixed | 4 GB | 12 GB | Gaming leve, mais RAM de sistema |

512MB dinâmico é o melhor para a maioria. O Linux aloca mais VRAM automaticamente quando necessário.

---

## 8. Primeira Inicialização + Escolha do SO

### Teste de boot

1. Conecte tudo, ligue a fonte
2. A placa deve ligar automaticamente (AUTO_PWRON1)
3. Aperte Del para entrar no BIOS
4. **Não viu o BIOS?** Troque para um cabo DisplayPort nativo (adaptadores podem não iniciar rápido o suficiente)

### Qual SO escolher?

| Distro | Dificuldade | Veredito |
|--------|------------|----------|
| **Bazzite** | Fácil | 🏆 Melhor para gaming, SteamOS-like, funciona out-of-box |
| **Fedora 43+** | Fácil | ✅ Mais documentado, Mesa 25.1+ nativo |
| **CachyOS** | Intermediário | ⚡ Melhor performance, Arch-based |
| **Nobara** | Intermediário | Fedora-based, não imutável, governor fácil |
| **Arch Linux** | Avançado | Controle total, requer configuração manual |
| **Ubuntu 26.04+** | Fácil | Funciona com PPA Mesa |
| **Manjaro** | Fácil | Boota out-of-box |

**⭐ Para iniciantes: Bazzite ou Fedora 43.**

### Kernels quebrados (EVITAR)

⚠️ **6.15.0-6.15.6** e **6.17.8-6.17.10** causam falha de GPU. Use 6.18.18 LTS ou 6.17.11+.

> Consulte [05 — OS Installation](05-os-installation.md) para guias completos de instalação para cada distro.

---

## 9. Instalação do SO

### Preparação

1. Em outro PC, baixe o ISO da distro escolhida
2. Grave no pendrive com **Ventoy** (recomendado), **balenaEtcher** ou **Rufus**
3. Conecte o pendrive na BC-250, ligue

### Bazzite (recomendado para gaming)

1. Use a imagem **non-live installer** (live image tem bugs de login)
2. Boot do pendrive — sem parâmetros especiais necessários
3. Instalação normal (~10-15 min)
4. Senha padrão (se pedir): `bazzite`
5. Reboot

### Fedora 43

1. Boot do pendrive
2. No GRUB, selecione **"Basic Graphics Mode"** (ativa nomodeset automaticamente)
3. Instalação normal
4. Reboot — a tela pode ficar preta (nomodeset ainda ativo, normal)

> Consulte [05 — OS Installation](05-os-installation.md) para instalação em CachyOS, Arch, Debian, Ubuntu, Manjaro e Nobara.

---

## 10. Pós-Instalação: Governor e Drivers

### Passo 1: Instalar o GPU Governor

**O governor é ESSENCIAL.** Sem ele a GPU fica presa em 1500 MHz e o idle consome 85-105W.

**SMU governor (recomendado — não precisa de patch de kernel):**

**Fedora / Nobara:**
```bash
sudo dnf copr enable filippor/bazzite
sudo dnf install cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

**Bazzite (rpm-ostree):**
```bash
sudo dnf copr enable filippor/bazzite
rpm-ostree install cyan-skillfish-governor-smu
systemctl reboot
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

**CachyOS / Arch:**
```bash
yay -S cyan-skillfish-governor-smu
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

**Debian / Ubuntu:**
```bash
wget https://github.com/Magnap/cyan-skillfish-governor/releases/latest/download/cyan-skillfish-governor-smu_amd64.deb
sudo dpkg -i cyan-skillfish-governor-smu_amd64.deb
sudo systemctl enable --now cyan-skillfish-governor-smu.service
```

### Passo 2: Remover nomodeset

**Fedora / GRUB:**
```bash
sudo nano /etc/default/grub
# Mude: GRUB_CMDLINE_LINUX_DEFAULT="quiet nomodeset"
# Para:  GRUB_CMDLINE_LINUX_DEFAULT="quiet"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo reboot
```

**Bazzite (rpm-ostree):**
```bash
rpm-ostree kargs --delete-if-present="nomodeset"
systemctl reboot
```

### Passo 3: ACPI Fix (CPU Power States — Recomendado)

Ativa C-States (idle) e P-States (frequência CPU 800-3200 MHz):

```bash
git clone https://github.com/bc250-collective/bc250-acpi-fix.git
cd bc250-acpi-fix
# Siga o README para sua distro
```

Isso reduz o consumo em idle e permite que a CPU varie frequência.

### Passo 4: Configurar governor (opcional)

Arquivo: `/etc/cyan-skillfish-governor-smu/config.toml`

**Configuração recomendada (uso geral):**
```toml
safe-points = [
    [1000, 700],   # idle
    [1500, 900],   # médio
    [2000, 1000],  # gaming
    [2100, 1025],  # overclock leve
    [2175, 1050],  # overclock moderado
    [2300, 1075],  # overclock máximo (bom air cooling)
]
```

Após alterar: `sudo systemctl restart cyan-skillfish-governor-smu`

### Passo 5: Verificar instalação

```bash
# Mesa (deve ser 25.1+)
glxinfo | grep "OpenGL version"

# GPU (deve mostrar RADV GFX1013, NÃO llvmpipe)
vulkaninfo | grep deviceName

# Governor rodando
systemctl status cyan-skillfish-governor-smu

# Frequência GPU (deve mostrar múltiplas frequências)
cat /sys/class/drm/card1/device/pp_dpm_sclk
```

> Consulte [06 — GPU Governor](06-gpu-governor.md) para config detalhada, overclock, SMU profiles e troubleshooting.

---

## 11. Display e Áudio

### Display

- **Melhor opção:** Cabo DisplayPort nativo (até 4K@120Hz, HDR10, áudio funciona)
- **Segunda opção:** Adaptador DP-to-HDMI passivo (~$5-10, 1080p60/1440p60 com áudio)
- **Evitar:** Adaptador ativo DP-to-HDMI (áudio quebrado na BC-250)

### Áudio

| Solução | Qualidade | Funciona? |
|---------|-----------|-----------|
| Áudio via DP nativo | Ótima | ✅ Sim (kernel 6.19.10+ corrigiu bugs) |
| DP-to-HDMI passivo | Boa | ✅ Sim |
| **USB Sound Card** | Ótima | ✅ **Mais confiável** — Creative Play! 4 (~$25) |
| DP-to-HDMI ativo | Ruim | ❌ Dropouts de áudio |

**Kernel 6.19.10+** inclui o fix de áudio DP do TheFloW (desenvolvedor PS5 Linux).

### VRR (Variable Refresh Rate)

Funciona nativamente no **CachyOS kernel 6.19+** e via imagem customizada no Bazzite.

> Consulte [08 — Display & Audio](08-display-and-audio.md) para mais detalhes sobre VRR, multi-monitor, adapters e NullVRS.

---

## 12. WiFi e Periféricos

### WiFi (sem onboard)

| Adaptador | Chipset | WiFi | BT | Preço |
|-----------|---------|------|-----|-------|
| **TP-Link Archer TX10UB Nano** | MT7921AU | AX900 (WiFi 6) | BT 5.3 | ~$20 |
| **Fenvi FU-AX1800** | MediaTek | AX1800 | BT 5.0 | ~$20 |
| **EDUP AX3000M** | MT7921AU | AX3000 (WiFi 6E) | BT 5.0 | ~$25 |
| **TP-Link Archer T2UB Nano** | — | WiFi 5 | BT 4.2 | ~$15 |

⚠️ Adaptadores com chipset **RTL8822BU** têm melhor suporte in-kernel (Linux 6.12+). Custom kernels (ex: Bazzite performance mode) podem não incluir o driver do seu adaptador — tenha Ethernet como fallback.

### Bluetooth only

- **TP-Link UB500 Plus** (BT 5.3, ~$10-15)
- **EDUP B3536** (BT 5.0, ~$5 AliExpress)

### Ethernet

A BC-250 tem **Realtek RTL8111H Gigabit Ethernet** — plug and play em todas as distros.

### Teclado e Power Button

- **Botão power:** A placa não tem header padrão — ela liga automaticamente quando 12V é aplicado (padrão). Para botão externo: solde fios no botão onboard e mova o jumper AUTO_PWRON1 para pins 2-3
- **Teclado USB padrão** funciona para BIOS

> Consulte [09 — WiFi & Peripherals](09-wifi-and-peripherals.md) para armazenamento, USB accessories, cases e mounting.

---

## 13. Steam e Jogos

### Instalar Steam + Gaming Tools

**Fedora / Nobara:**
```bash
sudo dnf install steam mangohud goverlay
```

**Bazzite:** Steam já vem instalado.

**CachyOS / Arch:**
```bash
sudo pacman -S steam mangohud goverlay
```

### Proton (Rodar Jogos Windows)

1. Abra o Steam → Settings → Compatibility
2. Ative **"Enable Steam Play for all other titles"**
3. Selecione **Proton Experimental** (ou a versão mais recente)

### Launch Options Recomendados

**Para jogos com artefatos gráficos:**
```bash
RADV_DEBUG=nohiz %command%
```

**Para jogos com resolução 640x480 (VRS quebrado):**
```bash
ENABLE_VK_NULLVRS_1=1 %command%
```

**Overlay MangoHud:**
```bash
mangohud %command%
```

### Micro-Stuttering no Bazzite?

```bash
sudo systemctl disable --now hhd
sudo systemctl mask hhd
```

O Handheld Daemon (HHD) do Bazzite reinicia constantemente se não encontra funcionalidades esperadas.

---

## 14. 40 CU Unlock (Opcional)

> Desbloqueia 16 CUs harvesteadas — 24 CU → 40 CU. ~60% mais performance computacional.

### Método Recomendado: bc250-cu-live-manager

**Sem patch de kernel, sem reboot.** Funciona em qualquer distro:

```bash
git clone https://github.com/WinnieLV/bc250-cu-live-manager.git
cd bc250-cu-live-manager
# Siga o README — TUI interativo para ativar CUs individualmente
```

### Verificação

```bash
dmesg | grep active_cu_number        # Deve mostrar 40
RADV_DEBUG=info vulkaninfo --summary 2>&1 | grep num_cu  # Deve mostrar 40
```

### Ajustes Necessários

- **Reduza o clock máximo do governor** para ~1850 MHz (40 CU gera mais calor)
- **Teste estabilidade** — algumas boards têm CUs defeituosas (artefatos visuais)
- Use `bc250-cu-live-manager` para ativar CUs individualmente e testar

> Consulte [02 — BIOS & Firmware](02-bios-and-firmware.md) para health testing, selective masking, crash behavior e troubleshooting de 40 CU.

---

## 15. Benchmarks

Após tudo configurado, teste sua placa:

```bash
# Temperaturas
sensors

# GPU load
cat /sys/class/drm/card1/device/gpu_busy_percent

# Frequência atual
cat /sys/class/drm/card1/device/pp_dpm_sclk

# Vulkan info
vulkaninfo --summary
```

### Benchmark Tools

| Ferramenta | Instalação | O que testa |
|------------|-----------|-------------|
| **Unigine Superposition** | Steam (gratuito) | GPU geral |
| **3DMark** | Steam (pago) | GPU + CPU |
| **Geekbench 6** | Site oficial | CPU + GPU |
| **FurMark** | Site oficial | GPU stress + thermals |
| **7zip benchmark** | `7z b` | CPU compressão |
| **pp512 (LLM)** | Script Python | Inferência AI |

> Consulte [07 — Game Benchmarks](07-game-benchmarks.md) para FPS de 80+ jogos testados pela comunidade.

---

## 16. Troubleshooting Rápido

### Board não liga (sem POST)
1. Limpe CMOS (bateria 60s)
2. Teste outra fonte (PSU ruim é causa #1)
3. Verifique transistor Q11 (pode ter sido arrancado no transporte)
4. Flash BIOS via CH341A

### Tela preta no boot (SO não aparece)
1. Use cabo DisplayPort nativo (não adaptador)
2. Desabilite IOMMU no BIOS
3. Verifique kernel (evite 6.15.0-6.15.6 e 6.17.8-6.17.10)
4. Boot com `nomodeset`, instale governor, remova nomodeset

### GPU não detectada (llvmpipe)
1. Verifique Mesa 25.1+: `glxinfo | grep "OpenGL version"`
2. Verifique kernel: `uname -r`
3. Verifique se nomodeset foi removido
4. Confirme que IOMMU está desabilitado

### GPU presa em 1500 MHz
1. Governor está rodando? `systemctl status cyan-skillfish-governor-smu`
2. Voltagem mínima >= 700 mV? (abaixo disso trava em 1500 MHz)
3. Reinstale o governor

### Temperaturas altas (85°C+)
1. Pasta térmica substituída? (stock ressecada)
2. Aletas do heatsink abertas? (abrir centro = 5-10°C melhora)
3. Fan de alta pressão estática? (P12 Pro > case fan comum)
4. VRAM do verso tem cooling? (sem sensor, superaquecimento silencioso)

### Artefatos visuais em jogos
1. `RADV_DEBUG=nohiz %command%` nos launch options do Steam
2. Se persistir: reduza overclock do governor
3. Se apenas em jogos específicos: instale Vulkan_NullVRS

> Consulte [10 — Troubleshooting](10-troubleshooting.md) para guia completo com todos os erros conhecidos.

---

## 17. Próximos Passos

Sua BC-250 está rodando. Agora você pode:

- [ ] **Otimizar cooling** — water cooling, fan shrouds 3D, push-pull
- [ ] **Tunar governor** — overclock GPU, perf profiles, undervolt
- [ ] **Fazer CU health test** — se for desbloquear 40 CU
- [ ] **Rodar benchmarks** — comparar com a [tabela comunitária](07-game-benchmarks.md)
- [ ] **Configurar AI inference** — Ollama, pp512, ROCm
- [ ] **Imprimir um case customizado** — 145+ designs na Printables
- [ ] **Participar da comunidade** — Discord para suporte, dicas e novos projetos

> Consulte [11 — Community & Resources](11-community-and-resources.md) para links do Discord, GitHub, e projetos da comunidade.
>
> Consulte [12 — AI Inference](12-ai-inference.md) para guia de configuração de LLMs e inferência local.

---

*Guia gerado a partir dos documentos Revised/01-12, export/elektricM-docs, e dados da comunidade Discord (BC-250).*
*Última atualização: Junho 2026.*
