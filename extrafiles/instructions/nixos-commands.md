---
My own personal configs to clean all:
1. First, check the generations:
```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```
2. Then, erase all the generations:
```
sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
```
3. Don't forget run the garbage collector (-d / --delete-old):
```
sudo nix-collect-garbage -d
```

> Note, those are root generations, some times the user can have their own generations and that can be removed and listes only without using `sudo` and dont write the `--profile` option and befores

4. Then, you need to clean the bootloader (in my case systemd) you can update whith the same config, or use:
```
sudo nixos-rebuild boot --flake .
```

5. For extra, you can optimize the store removing duplicate links whit:
```
nix-store --optimise
```
