<div align="center">
  <h1>Zygisk - Detach</h1>
  <p>Detaches installed apps from the Play Store against its aggressive updating policy.</p>

  [![Latest Release](https://img.shields.io/github/v/release/Othmane-ElAlami/Zygisk-Detach?style=flat-square&color=blue)](https://github.com/Othmane-ElAlami/Zygisk-Detach/releases/latest)
  [![Downloads](https://img.shields.io/github/downloads/Othmane-ElAlami/Zygisk-Detach/total?style=flat-square&color=green)](https://github.com/Othmane-ElAlami/Zygisk-Detach/releases)
  [![License](https://img.shields.io/github/license/Othmane-ElAlami/Zygisk-Detach?style=flat-square)](https://github.com/Othmane-ElAlami/Zygisk-Detach/blob/master/LICENSE)
</div>

---

This is a fork of the original [zygisk-detach](https://github.com/j-hc/zygisk-detach) by j-hc, tailored with specific enhancements and automated build systems.

## ✨ Features
- **Magisk / Zygisk Compatible**: Fully supports Magisk with Zygisk enabled.
- **KernelSU & KernelSU Next**: KernelSU and KernelSU Next support with a compatible Zygisk implementation.
- **Immediate Effect**: Select apps you wish to detach and changes apply immediately (no reboot required).
- **Multiple Interfaces**: Manage detached apps via CLI, WebUI (on KernelSU), or the [zygisk-detach-app](https://github.com/j-hc/zygisk-detach-app).

## 🚀 Installation

1. Enable Zygisk in Magisk **OR** flash a Zygisk module if you are on KernelSU / KernelSU Next.
2. Download the latest `Zygisk-Detach-vX.Y.Z.zip` from the [Releases](https://github.com/Othmane-ElAlami/Zygisk-Detach/releases) page.
3. Flash the module in your root manager.
4. Reboot your device.

## 🛠️ Usage

### CLI Method
Run the CLI in a terminal app (like Termux):
```sh
su -c detach
```
*(If you are not using Termux, you can use `su -c /data/adb/modules/zygisk-detach/detach`)*

### App Method
Download and install the graphical [zygisk-detach-app](https://github.com/j-hc/zygisk-detach-app) if you prefer not to use the terminal.

### WebUI Method
If you are using KernelSU or KernelSU Next, you can access the module's WebUI directly from the manager app!

### Automatic Detach (`detach.txt`)
To automatically detach apps upon flashing the module, create a `detach.txt` file containing the package names and put it inside the module zip before flashing. The apps will be detached without needing the CLI.

Example `detach.txt`:
```text
com.example.app1
org.example.app2
```

## 🏗️ Building on Windows
This fork includes a custom `build.ps1` PowerShell script to make building on Windows seamless.
1. Clone the repository.
2. Run `.\build.ps1` in PowerShell.
3. The script will fetch the corresponding upstream release, apply this fork's modifications, normalize line endings to LF, and generate a flashable zip!

## 🙏 Credits
- [j-hc](https://github.com/j-hc) - For the original [zygisk-detach](https://github.com/j-hc/zygisk-detach) project and related utilities.
