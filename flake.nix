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

    # Zen Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { nixpkgs, home-manager, zen-browser, ... } @ inputs:
    let
      system = "x86_64-linux";  # Cambia esto si usas otra arquitectura (ej. "aarch64-linux")
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;  # Permitir paquetes no libres
      };
    in {
      nixosConfigurations."dash" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };  # Agregar specialArgs como en el ejemplo
        modules = [
          ./configuration.nix
          ./nixos/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.axolt = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };  # Agregar esta línea
          }
        ];
      };
    };
}

