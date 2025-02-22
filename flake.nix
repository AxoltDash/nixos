{
  description = "Configuración de NixOS y Home Manager con Flakes";

  inputs = {
    # Nixpkgs: Repositorio de paquetes
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprgrass
    hyprland.url = "github:hyprwm/Hyprland";
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";  # Cambia esto si usas otra arquitectura (ej. "aarch64-linux")
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;  # Permitir paquetes no libres
      };
    in {
      # Configuración de NixOS
      nixosConfigurations."dash" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix   # Configuración del sistema
          ./nixos/hardware-configuration.nix        # Configuración del hardware
          home-manager.nixosModules.home-manager  # Integrar Home Manager con NixOS
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.axolt = import ./home/home.nix;  # Configuración de usuario con Home Manager
          }
        ];
      };
    };
}

