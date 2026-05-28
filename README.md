# Atlas-Modules

Optional NixOS and Home Manager modules for the Atlas NixOS configuration.

## Structure

```
├── flake.nix              # Flake entry point with nixpkgs input
├── module-registry.nix    # Nix module registry (keep in sync with .sh)
├── module-registry.sh     # Bash module registry
├── modules/
│   ├── nixos/             # NixOS system modules
│   │   ├── default.nix    # Auto-import of all NixOS modules
│   │   ├── performance.nix
│   │   ├── privacy.nix
│   │   ├── gaming.nix
│   │   ├── virtualisation.nix
│   │   ├── minecraft.nix
│   │   ├── flatpak.nix
│   │   ├── bluetooth.nix
│   │   ├── pdf.nix
│   │   ├── art.nix
│   │   ├── extras.nix
│   │   ├── gpu.nix        # GPU initrd detection wrapper
│   │   ├── gpu-amd.nix
│   │   ├── gpu-intel.nix
│   │   ├── gpu-nvidia.nix
│   │   ├── security.nix
│   │   ├── shell.nix
│   │   ├── fonts.nix
│   │   └── media.nix
│   └── home/              # Home Manager modules
│       ├── default.nix    # Auto-import of all home modules
│       ├── dev.nix
│       └── tools.nix
├── lib/
│   ├── default.nix        # Library functions
│   └── notifications.nix  # Desktop notification helper
└── assets/
    ├── gaming/millennium/  # Steam Millennium skin config
    └── privacy/mullvadbrowser/  # Mullvad Browser profiles
```

## Usage

### As a flake input

```nix
inputs.atlas-modules.url = "github:OhShabuShabu/Atlas-Modules/main";
```

### Import individual NixOS modules

```nix
{
  imports = [
    inputs.atlas-modules.nixosModules.performance
    inputs.atlas-modules.nixosModules.privacy
  ];
}
```

### Import all NixOS modules

```nix
{
  imports = [ inputs.atlas-modules.nixosModules.default ];
}
```

### Import Home Manager modules

```nix
{
  imports = [
    inputs.atlas-modules.homeModules.tools
    inputs.atlas-modules.homeModules.dev
  ];
  # or all:
  # imports = [ inputs.atlas-modules.homeModules.default ];
}
```

## Configuration Options

Where applicable, modules expose options under `atlas.modules.<name>`:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `atlas.modules.privacy.username` | string | `yusa` | Username for privacy config |
| `atlas.modules.virtualisation.username` | string | `yusa` | Username for libvirt group |
| `atlas.modules.security.enable` | bool | false | Enable security hardening |
| `atlas.modules.security.fail2ban` | bool | false | Enable fail2ban |
| `atlas.modules.shell.enable` | bool | false | Enable shell customization |
| `atlas.modules.fonts.enable` | bool | false | Enable font configuration |
| `atlas.modules.fonts.nerdy` | bool | true | Include Nerd Fonts |
| `atlas.modules.media.enable` | bool | false | Enable media codecs |
| `atlas.modules.media.hardwareAcceleration` | bool | true | Enable HW video acceleration |
| `atlas.notifications.username` | string | `yusa` | Username for notifications |

## Module Categories

- **system**: performance, flatpak, bluetooth, pdf, shell, fonts, media
- **privacy**: privacy
- **gaming**: gaming, minecraft
- **virtualisation**: virtualisation
- **development**: dev
- **tools**: tools
- **extras**: extras
- **creative**: art
- **hardware**: gpu-amd, gpu-intel, gpu-nvidia, gpu
- **security**: security

## Development

```bash
# Syntax check all modules
for f in $(find . -name "*.nix" -not -path "./.git/*"); do
  nix-instantiate --parse "$f"
done
```
