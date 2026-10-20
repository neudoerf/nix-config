# Copilot Instructions

Personal Nix flake managing NixOS hosts (home-lab VMs), a nix-darwin Mac, Home Manager profiles, and a system-manager config for a non-NixOS work laptop. NixOS servers track stable (`nixpkgs-stable` + `home-manager-stable`, e.g. `nixos-26.05`/`release-26.05`); everything else tracks `nixpkgs-unstable` with Home Manager `master`. Other inputs `follows` the unstable `nixpkgs`. When bumping the stable release, change both stable branch names together.

## Commands

There are no tests, CI, or flake `checks`/`formatter` outputs. Validate by evaluating/building:

```sh
nix flake check                                   # evaluate all outputs (incl. deploy-rs schema)
nix build .#nixosConfigurations.<host>.config.system.build.toplevel   # build one host
nix build .#homeConfigurations.'"tneudoerffer@CPR02395L"'.activationPackage
nix flake update                                  # bump flake.lock (common standalone commit)
```

Apply changes:

```sh
deploy .#<host>                                    # deploy-rs to a NixOS host (runs as root over SSH)
home-manager switch --flake .#tneudoerffer@CPR02395L
system-manager switch --flake .#CPR02395L
darwin-rebuild switch --flake .#nostalgia-for-infinity
```

`size-isnt-everything` is the build host: it has `deploy-rs` installed and signs store paths with `/keys/cache-priv-key.pem`; every VM trusts that key via `defaults/vm.nix`.

## Architecture

- `flake.nix` is the single wiring point. NixOS hosts are listed in the `hosts` list, which generates both `nixosConfigurations` (via `mkHost`) and `deploy.nodes` (deploy target `<host>.neunet.ca`). Adding a host means adding its name to `hosts` and creating `machines/<host>/` (its `hardware-configuration.nix` must set `nixpkgs.hostPlatform`).
- `machines/<host>/configuration.nix` imports its own `hardware-configuration.nix`, `../../defaults/vm.nix`, and whichever `services/*.nix` it hosts. Host files only set `networking` (hostname, firewall ports) and `system.stateVersion`; never change existing `stateVersion` values.
- `defaults/vm.nix` is the shared baseline for all NixOS VMs: user `neudoerf` (fish shell, SSH key, passwordless sudo), flakes enabled, SSH key-only auth, qemu guest agent, containers enabled, and `ip_unprivileged_port_start = 0` (so rootless containers can bind 80/443).
- `services/*.nix` are each a single `virtualisation.oci-containers.containers.<name>` entry, not native NixOS service modules. Secrets and state live on the host under `/volumes/<service>/` (bind mounts plus `environmentFiles = [ /volumes/<service>/.env ]`); nothing secret is stored in this repo. When adding a service, open the needed ports in the importing host's `networking.firewall` (`recent-convert` has the firewall disabled).
- NixOS hosts embed `home-manager/home-server.nix` (lean, evaluated against stable Home Manager) as user `neudoerf`. Keep it independent of `home-cli.nix`: the two are evaluated by different Home Manager versions whose option names can differ.
- Desktop Home Manager is layered: `home-cli.nix` + `home-graphical.nix` (desktop machines; builds the custom Iosevka from `iosevka-neudoerf/*.toml`) + a per-machine file (`cpr02395l.nix`, `nostalgia-for-infinity.nix`) that sets username/home and overrides shared settings with `lib.mkForce`.
- Raw dotfiles (`tmux/`, `wezterm/`, `starship/`, `neovim/`) sit beside the HM modules and are linked via `xdg.configFile.*.source` or `builtins.readFile`; some are currently unreferenced.

## Conventions

- Container conventions: `extraOptions = [ "--pull=always" ]`, `autoStart = true`, and `user = "1000:100"` / `USER_UID=1000`, `USER_GID=100` where the image supports it.
- Formatting follows nixfmt (RFC style): multi-element lists and function argument sets are one item per line.
- NixOS hosts get `nixpkgs.config.allowUnfree = true` from the shared module in `mkHost`; don't pass `pkgs`/`system` to `nixosSystem`.
- Commit messages are short, lowercase, imperative (`add mealie`, `nix flake update`, `factorio -> stable`).
