# Insrtructions to install NixOS extras (Recommended)

### Add Proton-GE to Steam
If you want to enable STEAM GE-PROTON, you can do so by following the steps below:
```shell
protonup
```

### Install Rain World Font
If you want the Rain World font (On the user), you can install it with:
```shell
mkdir -p ~/.local/share/fonts
cp -r /etc/nixos/extrafiles/RainWorldSymbols.ttf ~/.local/share/fonts
fc-cache -f -v
```
Check if the font is installed with:
```shell
fc-list | grep "RainWorldSymbols
```

### Install Scripts
You need my .config installation (I need put their in this repo or on another repo):
```shell
sudo chmod +x ~/.config/hypr/scripts/battery_notify.sh 
sudo chmod +x ~/.config/waybar/scripts/waybar-blue-light-filter.sh
```

### Install trim-generattions.sh
This scripts helps you to delete the old generations of your system. Its configurable, but you need to change te name of the path script (this is on `configuration.nix`). Before you need to give its permissions:
```shell
sudo chmod +x /home/axolt/nixos/scripts/trim-generations.sh
```
Now, this script is ready to use. It automatically delete the old generations of your system and it's running thanks to `configuration.nix`.


### Note if you copy hardware-configuration.nix
You need to change the own:
```shell
sudo chown -R axolt:users /home/axolt/nixos/hardware-configuration.nix
```
