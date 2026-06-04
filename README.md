# YoRHa-Modules

Optional NixOS and Home Manager modules for the YoRHa NixOS configuration.

## Structure

```
├── flake.nix              # Flake entry point (flake-parts + haumea)
├── flake.lock             # Pinned inputs for reproducibility
├── module-registry.nix    # Nix module registry
├── module-registry.sh     # Bash module registry (keep in sync with .nix)
├── .github/workflows/     # CI pipeline
├── modules/
│   ├── nixos/             # 18 NixOS system modules (+ default.nix)
│   └── home/              # 2 Home Manager modules (+ default.nix)
├── lib/                   # Shared library functions (loaded via haumea)
└── assets/                # Preconfigured browser profiles, Steam skin
```

## Usage

### As a flake input

```nix
inputs.yorha-modules.url = "github:OhShabuShabu/Atlas-Modules/main";
```

### Import individual NixOS modules

```nix
{
  imports = [
    inputs.yorha-modules.nixosModules.performance
    inputs.yorha-modules.nixosModules.privacy
  ];
}
```

### Import all NixOS modules

```nix
{
  imports = [ inputs.yorha-modules.nixosModules.default ];
}
```

### Import Home Manager modules

```nix
{
  imports = [
    inputs.yorha-modules.homeModules.tools
    inputs.yorha-modules.homeModules.dev
  ];
  # or all:
  # imports = [ inputs.yorha-modules.homeModules.default ];
}
```

## Module Reference

| ID | Name | Category | Description |
|----|------|----------|-------------|
| 1 | performance | system | CPU governor, TCP BBR, Nix GC, ZRAM |
| 2 | privacy | privacy | Mullvad VPN/Browser, metadata stripping |
| 3 | gaming | gaming | Steam, MangoHUD, Gamescope |
| 4 | virtualisation | virtualisation | Docker, Podman, libvirt, Looking Glass |
| 5 | minecraft | gaming | PrismLauncher, Blockbench |
| 6 | flatpak | system | Flatpak + Flathub |
| 7 | dev | development | Neovim, VSCodium, bun, opencode |
| 8 | tools | tools | yt-dlp, mpv, btop, ripgrep, bat |
| 9 | extras | extras | Ollama ROCm, animated wallpapers |
| 10 | bluetooth | system | Bluez, Blueman |
| 11 | pdf | system | Zathura, Evince, OCR tools |
| 12 | art | creative | Krita, Inkscape, GIMP, OBS |
| 13 | gpu-amd | hardware | AMD GPU initrd module |
| 14 | gpu-intel | hardware | Intel GPU initrd module |
| 15 | gpu-nvidia | hardware | NVIDIA GPU initrd module |
| 16 | security | security | Kernel hardening, fail2ban |
| 17 | shell | system | ZSH + OhMyZsh, Starship |
| 18 | fonts | system | Fonts including Nerd Fonts |
| 19 | media | system | Codecs, VA-API, VLC, FFmpeg |
| 20 | odysseus | services | Docker-based AI workspace |

## Configuration Options

Where applicable, modules expose options under `yorha.modules.<name>`:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `yorha.modules.performance.enable` | bool | false | Enable performance tuning |
| `yorha.modules.performance.zramPercent` | int | 50 | ZRAM size as percentage of RAM |
| `yorha.modules.performance.cpuGovernor` | string | `performance` | CPU frequency governor |
| `yorha.modules.privacy.enable` | bool | false | Enable privacy suite |
| `yorha.modules.privacy.username` | string | `yusa` | Username for privacy config |
| `yorha.modules.privacy.enableAutoMetadataStrip` | bool | `false` | Auto-strip metadata from Downloads on boot |
| `yorha.modules.gaming.enable` | bool | false | Enable gaming environment |
| `yorha.modules.virtualisation.enable` | bool | false | Enable virtualisation tools |
| `yorha.modules.virtualisation.username` | string | `yusa` | Username for libvirt group |
| `yorha.modules.minecraft.enable` | bool | false | Enable Minecraft tools |
| `yorha.modules.flatpak.enable` | bool | false | Enable Flatpak + Flathub |
| `yorha.modules.bluetooth.enable` | bool | false | Enable Bluetooth support |
| `yorha.modules.pdf.enable` | bool | false | Enable PDF and document tools |
| `yorha.modules.art.enable` | bool | false | Enable digital art tools |
| `yorha.modules.extras.enable` | bool | false | Enable extras (Ollama ROCm, wallpapers) |
| `yorha.modules.gpu-amd.enable` | bool | false | Enable AMD GPU initrd module |
| `yorha.modules.gpu-intel.enable` | bool | false | Enable Intel GPU initrd module |
| `yorha.modules.gpu-nvidia.enable` | bool | false | Enable NVIDIA GPU initrd module |
| `yorha.modules.gpu-nvidia.useProprietary` | bool | false | Use proprietary NVIDIA driver |
| `yorha.modules.security.enable` | bool | false | Enable security hardening |
| `yorha.modules.security.fail2ban` | bool | false | Enable fail2ban |
| `yorha.modules.shell.enable` | bool | false | Enable shell customization |
| `yorha.modules.shell.defaultShell` | enum | `zsh` | Default shell (zsh, bash, fish) |
| `yorha.modules.fonts.enable` | bool | false | Enable font configuration |
| `yorha.modules.fonts.nerdy` | bool | true | Include Nerd Fonts |
| `yorha.modules.media.enable` | bool | false | Enable media codecs |
| `yorha.modules.media.hardwareAcceleration` | bool | true | Enable HW video acceleration |
| `yorha.modules.odysseus.enable` | bool | false | Enable Odysseus AI workspace |
| `yorha.modules.dev.enable` | bool | false | Enable development tools |
| `yorha.modules.tools.enable` | bool | false | Enable core CLI utilities |
| `yorha.notifications.usernames` | list of string | `["yusa"]` | Users for notifications |

## Development

```bash
# Enter dev shell (includes nixpkgs-fmt, statix, deadnix, nix-doc)
nix develop

# Check flake
nix flake check

# Format code
nix fmt

# Lint with statix
statix check
```

## Changelog

### 3.0.0
- **flake-parts**: Migrated flake structure to `flake-parts` — replaces `forAllSystems` with `perSystem`, enabling modular flake composition
- **haumea**: Added `haumea` for auto-loading `lib/` directory — library functions are now discovered automatically
- **importTree**: Auto-discovers NixOS and Home Manager modules from `modules/` directories (no more manual module listings in `flake.nix`)
- **lib/notifications.nix**: Moved to `modules/nixos/notifications.nix` (it was always a NixOS module, not a library function)
- **flake.nix**: Reduced from 74 lines to ~60 with cleaner separation of concerns

### 2.1.0
- **All modules**: Added `enable` option toggle — every module now supports `yorha.modules.<name>.enable`
- **gpu-nvidia.nix**: Fixed critical `mkIf` bug (called with 3 args instead of 2) — replaced with `if/then/else`
- **module-registry.nix**: Fixed `getModulePath` path resolution (used `../modules/` instead of `modules/`)
- **module-registry.nix**: Implemented `readModuleState` stub — now reads from `state.json` at eval time
- **gpu-amd.nix / gpu-intel.nix**: Added `enable` option for consistency with gpu-nvidia
- **CI**: Extended `deadnix` to check root-level files; added shellcheck for `module-registry.sh`
- **README**: Fixed module count (19 → 18 modules + default.nix); updated options table with all enable toggles

### 2.0.0
- **BREAKING**: Renamed option namespace from `atlas.modules.*` → `yorha.modules.*`
- **BREAKING**: Renamed notifications from `atlas.notifications.*` → `yorha.notifications.*`
- **BREAKING**: Renamed state paths from `/persistent/etc/atlas-modules/` → `/persistent/etc/yorha-modules/`
- **BREAKING**: Renamed env vars from `ATLAS_MODULE_*` → `YORHA_MODULE_*`
- **BREAKING**: Renamed flake input from `atlas-modules` → `yorha-modules`
- **CI**: Added statix, deadnix, and formatting checks to CI pipeline
- **CI**: Added `.pre-commit-config.yaml` for pre-commit hooks
- Added `.envrc` for direnv support

### 1.1.0
- **shell.nix**: Fixed `defaultShell` option now properly respected by `users.defaultUserShell`
- **gaming.nix**: Removed duplicate `mangohud`/`gamescope` from `environment.systemPackages`
- **media.nix**: Migrated from deprecated `hardware.opengl` to `hardware.graphics`
- **flatpak.nix**: Added `--system` flag to `flatpak remote-add`
- **performance.nix**: Added configurable options (`enable`, `zramPercent`, `cpuGovernor`)
- **gpu-nvidia.nix**: Added `enable` and `useProprietary` options; documented driver choice
- **dev.nix**: Removed duplicate `github-cli` package
- **odysseus.nix**: Removed `exec` from service script; added dedicated Docker bridge interface
- **virtualisation.nix**: Removed Podman (conflict with Docker); use a separate profile to enable both
- **privacy.nix**: Fixed `RemainAfterExit` without `ExecStop`
- **lib/default.nix**: Fixed asset paths (relative to repo root, not lib/)
- **notifications.nix**: Changed `username` (string) to `usernames` (list of strings)
- **module-registry.nix**: Fixed broken `getModulePath` referencing nonexistent `optional/` subdirectory
- **module-registry.sh**: Fixed broken `get_module_dir` path; optimized `_is_known_file` to O(1) using associative array
- **flake.nix**: Replaced placeholder Cachix public key with real key
