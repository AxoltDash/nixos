# Axolt's NixOS Configuration 🖥️
This repository contains the personal NixOS configuration for Axolt. It includes various settings and packages to set up and maintain the system.

<div align="center">
    <img src="extrafiles/nixos.png" alt="Terminal Welcome" width="100"/>
</div>

## Installation ⚙️
---
You need to clone this repository to your system to use the configuration. You can do this by running the following command:
```shell
git clone https://github.com/AxoltDash/nixos
```

### Flakes ❄️
#### Rebuild the system 🔄
```shell
update 

# Equivalent to:
# sudo nixos-rebuild switch --flake nixos/
```

#### Update the system (flakes) ⬆️
```shell
update-flake

# Equivalent to:
# sudo nix flake update nixos/
```

## Attention ⚠️
This configuration is tailored to my personal needs and preferences. It may not work for you out of the box. You can use it as a reference or a starting point for your own configuration.
Read the instructions/ folder for more information on how to install another thing out of the NixOS configuration.

## To-Do List 📝
- [ ] Modify the file order to make it easier to use in another computers, for example move touching config in another .nix file
- [ ] Rewrite the `instructions/` folder and its configs
- [ ] Add a custom script for configure personal data and not my data (example a global user git config and not mine)

## License 📜

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
