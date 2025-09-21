# Auto Refresh Rate Switcher for Fedora (KDE/Wayland)

This script automatically switches the laptop display refresh rate when AC power
is connected or disconnected.

- On **AC** → sets the maximum refresh rate  
- On **Battery** → sets the refreshrate

## ⚠️ Important information

This script was tested on a **Asus TUF14** laptop laptop with **Fedora 42** with **KDE Plasma 6.4.4** and **Wayland**.

Lower KDE versions, other laptops or similar scripts might get some errors or incompatibilities, please report any issue.

## Requirements

- `kscreen-doctor` (part of KDE Plasma)  
- `systemd --user` (default on Fedora)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/auto-refresh-fedora.git
   cd auto-refresh-fedora
   ```

2. Copy the script:
   ```bash
   mkdir -p ~/.local/bin
   cp bin/set-refresh.sh ~/.local/bin/
   chmod +x ~/.local/bin/set-refresh.sh
   ```

3. Install the systemd files:
   ```bash
   mkdir -p ~/.config/systemd/user
   cp systemd/refreshrate.* ~/.config/systemd/user/
   ```

4. Reload and enable:
   ```bash
   systemctl --user daemon-reload
   systemctl --user enable --now refreshrate.path
   ```

5. Test:
   ```bash
   journalctl --user -u refreshrate.service -f
   ```
   Unplug and replug AC power: you should see refresh rate switching.

## Customization

- Edit `OUTPUT`, `MODE_AC`, `MODE_BAT` in `set-refresh.sh` with IDs obtained from:
  ```bash
  kscreen-doctor -o
  ```
- Check the power supply device name:
  ```bash
  ls /sys/class/power_supply
  ```
  and update `refreshrate.path` if it’s not `ADP0`.

  ---
  
  Default values (`OUTPUT="eDP-1"`, `MODE_AC="1"`, `MODE_BAT="2"`, power supply `ADP0`) are just examples.  
  
  Run `kscreen-doctor -o` and `ls /sys/class/power_supply` to get your actual values.


## Uninstallation

```bash
systemctl --user disable --now refreshrate.path
rm ~/.local/bin/set-refresh.sh
rm ~/.config/systemd/user/refreshrate.*
```
