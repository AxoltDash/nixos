

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


