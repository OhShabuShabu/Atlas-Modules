#!/usr/bin/env bash
# ============================================================================
# ATLAS MODULE REGISTRY (Bash)
# ============================================================================
# Central metadata for all Atlas modules.
# Keep in sync with module-registry.nix
#
# Usage: source module-registry.sh
# ============================================================================

# Raw URL for module downloads
readonly ATLAS_MODULES_RAW_URL="https://raw.githubusercontent.com/OhShabuShabu/Atlas-Modules/main"

# Module IDs
readonly MODULE_IDS=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19)

# Module descriptions (one-line summary for UI display)
readonly MODULE_DESC=(
  [1]="performance       CPU governor, TCP BBR, Nix GC tuning"
  [2]="privacy           Mullvad VPN, Mullvad Browser, metadata cleaner"
  [3]="gaming            Steam, MangoHUD, 32-bit graphics"
  [4]="virtualisation    Docker, Podman, libvirt, Looking Glass"
  [5]="minecraft         PrismLauncher, Blockbench, MCASelector"
  [6]="flatpak           Flatpak with Flathub repository"
  [7]="dev               Neovim, VSCodium, bun, opencode"
  [8]="tools             yt-dlp, mpv, btop, ripgrep, bat"
  [9]="extras            Ollama ROCm, animated wallpapers"
  [10]="bluetooth         Bluetooth with Blueman manager"
  [11]="pdf               PDF readers, editors, OCR tools"
  [12]="art               Krita, Inkscape, GIMP, OBS Studio"
  [13]="gpu-amd           AMD GPU initrd kernel module"
  [14]="gpu-intel         Intel GPU initrd kernel module"
  [15]="gpu-nvidia        NVIDIA GPU initrd kernel module"
  [16]="security          System security hardening"
  [17]="shell             ZSH with OhMyZsh, Starship prompt"
  [18]="fonts             Fonts including Nerd Fonts"
  [19]="media             Media codecs, VA-API, VLC, FFmpeg"
)

# Relative file path within the atlas-modules repository
readonly MODULE_FILE=(
  [1]="modules/nixos/performance.nix"
  [2]="modules/nixos/privacy.nix"
  [3]="modules/nixos/gaming.nix"
  [4]="modules/nixos/virtualisation.nix"
  [5]="modules/nixos/minecraft.nix"
  [6]="modules/nixos/flatpak.nix"
  [7]="modules/home/dev.nix"
  [8]="modules/home/tools.nix"
  [9]="modules/nixos/extras.nix"
  [10]="modules/nixos/bluetooth.nix"
  [11]="modules/nixos/pdf.nix"
  [12]="modules/nixos/art.nix"
  [13]="modules/nixos/gpu-amd.nix"
  [14]="modules/nixos/gpu-intel.nix"
  [15]="modules/nixos/gpu-nvidia.nix"
  [16]="modules/nixos/security.nix"
  [17]="modules/nixos/shell.nix"
  [18]="modules/nixos/fonts.nix"
  [19]="modules/nixos/media.nix"
)

# Subdirectory: "nixos" for system modules, "home" for home-manager
readonly MODULE_SUBDIR=(
  [1]="nixos"
  [2]="nixos"
  [3]="nixos"
  [4]="nixos"
  [5]="nixos"
  [6]="nixos"
  [7]="home"
  [8]="home"
  [9]="nixos"
  [10]="nixos"
  [11]="nixos"
  [12]="nixos"
  [13]="nixos"
  [14]="nixos"
  [15]="nixos"
  [16]="nixos"
  [17]="nixos"
  [18]="nixos"
  [19]="nixos"
)

# Module categories for grouping in the UI
readonly MODULE_CATEGORY=(
  [1]="system"
  [2]="privacy"
  [3]="gaming"
  [4]="virtualisation"
  [5]="gaming"
  [6]="system"
  [7]="development"
  [8]="tools"
  [9]="extras"
  [10]="system"
  [11]="system"
  [12]="creative"
  [13]="hardware"
  [14]="hardware"
  [15]="hardware"
  [16]="security"
  [17]="system"
  [18]="system"
  [19]="system"
)

# Module tags for filtering (space-separated)
readonly MODULE_TAGS=(
  [1]="performance nix gc kernel"
  [2]="vpn privacy metadata mullvad"
  [3]="steam gaming overlay mangohud"
  [4]="docker podman vm containers kvm"
  [5]="minecraft prism launcher"
  [6]="flatpak flathub"
  [7]="dev neovim vscode editor git"
  [8]="media downloader tools utilities"
  [9]="ai ml ollama wallpaper"
  [10]="bluetooth bluez blueman"
  [11]="pdf document viewer ocr"
  [12]="art drawing painting creative"
  [13]="gpu amd initrd plymouth"
  [14]="gpu intel initrd plymouth"
  [15]="gpu nvidia initrd plymouth"
  [16]="security hardening firewall audit"
  [17]="shell zsh terminal prompt"
  [18]="fonts typography nerdfonts"
  [19]="media codecs video audio playback"
)

# Module dependencies (space-separated module IDs)
readonly MODULE_DEPS=(
  [1]=""
  [2]=""
  [3]="8"
  [4]=""
  [5]="3"
  [6]=""
  [7]=""
  [8]=""
  [9]=""
  [10]=""
  [11]=""
  [12]=""
  [13]=""
  [14]=""
  [15]=""
  [16]=""
  [17]=""
  [18]=""
  [19]=""
)

# Module descriptions (long form for preview/help)
readonly MODULE_INFO=(
  [1]="Performance tuning: sets CPU governor to performance, enables TCP BBR congestion control, tunes Nix garbage collection, and enables ZRAM compressed swap for improved responsiveness."
  [2]="Privacy suite: installs Mullvad VPN with kill switch, Mullvad Browser, and automated metadata stripping via mat2 for downloaded files."
  [3]="Gaming environment: Steam with MangoHUD performance overlay, Gamescope session, 32-bit graphics support, and custom Millennium Steam skin assets."
  [4]="Virtualisation: Docker, Podman, and libvirt (virt-manager) with distrobox integration, Looking Glass KVM framebuffer relay, SPICE USB redirection, and nftables VM-forward rules."
  [5]="Minecraft: PrismLauncher for modded Minecraft with modpack support, Blockbench for 3D model editing, and MCASelector for region-file editing."
  [6]="Flatpak: enables Flatpak and adds the Flathub repository automatically on first boot."
  [7]="Development tools: Neovim (LazyVim-ready), VSCodium, bun runtime, opencode AI coding assistant, git/gh/lazygit workflow tools, TypeScript/ESLint/Prettier toolchain."
  [8]="Core CLI utilities: yt-dlp for video downloading, mpv media player, btop/htop monitoring, ripgrep/fd/fzf search tools, bat/eza/jq formatters, compression tools, and fastfetch system info."
  [9]="Extras: Ollama with ROCm GPU acceleration for local LLM inference, linux-wallpaperengine and mpvpaper for animated desktop wallpapers."
  [10]="Bluetooth: enables Bluetooth hardware with experimental features, power-on-boot, and the Blueman GTK management GUI."
  [11]="PDF & documents: Zathura/Evince viewers, pdfarranger/poppler/qpdf manipulation, Pandoc conversion, Tesseract OCR engine."
  [12]="Digital art and creative tools: Krita for painting, Inkscape for vector graphics, GIMP for raster image editing, and OBS Studio for recording/streaming."
  [13]="AMD GPU: loads amdgpu in initrd so Plymouth shows KMS content at native resolution during LUKS passphrase prompt. Only AMD firmware is bundled."
  [14]="Intel GPU: loads i915 in initrd so Plymouth shows KMS content at native resolution during LUKS passphrase prompt. Only Intel firmware is bundled."
  [15]="NVIDIA GPU: loads nouveau in initrd so Plymouth shows KMS content at native resolution during LUKS passphrase prompt. Only NVIDIA firmware is bundled."
  [16]="Security hardening: kernel sysctl hardening (dmesg/kptr/bpf/network), sudo password enforcement, optional fail2ban, and security auditing tools."
  [17]="Shell customization: ZSH with OhMyZsh plugins (git, sudo, extract), syntax highlighting, autosuggestions, Starship prompt, zoxide directory jumper, and thefuck command correction."
  [18]="Font configuration: Inter, Noto Fonts (CJK/Emoji), JetBrains Mono, Fira Code, and optional Nerd Fonts patched variants with proper fontconfig defaults."
  [19]="Media codecs and playback: FFmpeg with hardware acceleration, VLC/mpv/imv players, Intel/Radeon VA-API drivers, and thumbnail generation."
)

# Module versions (semver)
readonly MODULE_VERSION=(
  [1]="1.0.0"
  [2]="1.1.0"
  [3]="2.0.0"
  [4]="1.1.0"
  [5]="1.0.0"
  [6]="1.0.0"
  [7]="2.0.0"
  [8]="1.1.0"
  [9]="1.0.0"
  [10]="1.0.0"
  [11]="1.0.0"
  [12]="1.0.0"
  [13]="1.0.0"
  [14]="1.0.0"
  [15]="1.0.0"
  [16]="1.0.0"
  [17]="1.0.0"
  [18]="1.0.0"
  [19]="1.0.0"
)

# ============================================================================
# Categories (grouped module IDs)
# ============================================================================
readonly MODULE_CATEGORIES=("system" "privacy" "gaming" "virtualisation" "development" "tools" "extras" "creative" "hardware" "security")

# ============================================================================
# Helper Functions
# ============================================================================

# Get the local directory for a module type
get_module_dir() {
  local subdir="$1"
  local base="${ATLAS_MODULES_BASE:-$(cd "$(dirname "$0")/../.." && pwd)}"
  echo "$base/files/modules/optional/$subdir"
}

# Get module short name from description
get_module_name() {
  local id="$1"
  local desc="${MODULE_DESC[$id]}"
  echo "${desc%% *}"
}

# Get modules in a specific category
get_modules_by_category() {
  local target="$1"
  for id in "${MODULE_IDS[@]}"; do
    if [[ "${MODULE_CATEGORY[$id]}" == "$target" ]]; then
      echo "$id"
    fi
  done
}

# Check if a module is installed locally
is_module_installed() {
  local id="$1"
  local file="${MODULE_FILE[$id]}"
  local filename; filename=$(basename "$file")
  local subdir="${MODULE_SUBDIR[$id]}"
  local dest_dir; dest_dir="$(get_module_dir "$subdir")"
  [[ -f "$dest_dir/$filename" ]]
}

# Get reverse dependencies (modules that depend on the given module)
get_reverse_deps() {
  local target="$1"
  for id in "${MODULE_IDS[@]}"; do
    local deps="${MODULE_DEPS[$id]}"
    if [[ "$deps" == *"$target"* ]]; then
      echo "$id"
    fi
  done
}

# Validate module dependencies for all enabled modules
validate_deps() {
  local state="${1:-$(read_state)}"
  local issues=0
  for id in "${MODULE_IDS[@]}"; do
    local enabled; enabled=$(echo "$state" | jq -r ".\"$id\".enabled // false")
    [[ "$enabled" != "true" ]] && continue
    local deps="${MODULE_DEPS[$id]}"
    if [[ -n "$deps" ]]; then
      for dep in $deps; do
        local dep_enabled; dep_enabled=$(echo "$state" | jq -r ".\"$dep\".enabled // false")
        if [[ "$dep_enabled" != "true" ]]; then
          echo "WARN: Module $(get_module_name "$id") depends on $(get_module_name "$dep") which is not enabled" >&2
          issues=1
        fi
      done
    fi
  done
  [[ $issues -eq 0 ]]
}

# Download a single module from the atlas-modules repository
download_module() {
  local id="$1"
  local dest_dir="$2"
  local file="${MODULE_FILE[$id]}"
  local filename; filename=$(basename "$file")
  local url="$ATLAS_MODULES_RAW_URL/$file"

  mkdir -p "$dest_dir"

  if command -v curl &>/dev/null; then
    CURL_CMD=(curl)
  else
    CURL_CMD=(nix run nixpkgs#curl --)
  fi

  if timeout 30 "${CURL_CMD[@]}" -sSo "$dest_dir/$filename" "$url" 2>/dev/null; then
    return 0
  fi
  # Retry once
  if timeout 30 "${CURL_CMD[@]}" -sSo "$dest_dir/$filename" "$url" 2>/dev/null; then
    return 0
  fi
  rm -f "$dest_dir/$filename"
  return 1
}

# Get the filename on disk for a module
get_module_filename() {
  local id="$1"
  local file="${MODULE_FILE[$id]}"
  basename "$file"
}
