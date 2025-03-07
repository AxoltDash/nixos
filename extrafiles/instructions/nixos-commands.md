## Nixos commands
### Flakes
#### Rebuild the system
```shell
sudo nixos-rebuild switch --flake /etc/nixos
```
#### Update the system:
```shell
sudo nix flake update /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos
```

### Old generations
#### Watch old genetarions:
```shell
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

#### Erase old generations:
```shell
sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
```

### Garbage
This is after delete the generations, and you need execute SUDO for the system and without sudo for the user
```shell
sudo nix-collect-garbage -d
```
#### Clear Hystory
```shell
sudo nix profile wipe-history
```

Force ALL:
```shell
sudo nix store gc && sudo nix-collect-garbage -d && sudo nix profile wipe-history
```

```shell
sudo nix store gc
sudo nix-collect-garbage -d
sudo nix profile wipe-history
```

