{ config, pkgs, ... }:

{
  # 🔥 Habilitar el driver AMDGPU (gráficos integrados)
  # services.xserver.videoDrivers = [ "amdgpu" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # 🖥️ Mesa y Vulkan para mejor compatibilidad gráfica
  environment.systemPackages = with pkgs; [
    mesa  # Drivers OpenGL/Vulkan
    mesa.opencl
    mesa-demos  # Herramientas para probar OpenGL
    vulkan-tools  # Herramientas Vulkan
    vulkan-validation-layers
    # blender-hip
  ];
  
  # 💻 Cpu
  # hardware.cpu.amd.updateMicrocode = true;

  # 🔋 Manejo de bateria
  services.tlp.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
}

