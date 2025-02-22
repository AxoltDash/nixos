# Axolt's NixOS Configuration 🖥️

This repository contains the personal NixOS configuration for Axolt. It includes various settings and packages to set up and maintain the system.

## Installation ⚙️
You need to clone this repository to your system to use the configuration. You can do this by running the following command:
```shell
git clone https://github.com/AxoltDash/nixos
```

### Flakes ❄️
#### Rebuild the system 🔄
```shell
sudo nixos-rebuild switch --flake nixos/
```

#### Update the system ⬆️
```shell
sudo nix flake update nixos/
sudo nixos-rebuild switch --flake nixos/
```

## Attention ⚠️
This configuration is tailored to my personal needs and preferences. It may not work for you out of the box. You can use it as a reference or a starting point for your own configuration.
Read the instructions/ folder for more information on how to install another thing out of the NixOS configuration.

## License 📜

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
