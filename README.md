## Notes

Thanks to [rohit-n](https://github.com/rohit-n/dominatrix) for creating Dominatrix, a modern native source port of Ritual Entertainment's SiN with widescreen support, a redone gamepad-native control scheme, and a choice of renderers.

This port requires your own copy of SiN: Gold's game data. It is not bundled. Copy the contents of your SiN: Gold install's `base` folder into this port's `dominatrix/base` folder, and (for the Wages of SiN expansion) the `2015` folder into `dominatrix/2015`, without overwriting the `game.so` files already there.

Do not use the SiN Unofficial Patch's files: Dominatrix is not compatible with it. If a `pak2.sin` is present in `dominatrix/base`, remove it (per the upstream author).

Requires glibc 2.34 or newer (dArkOS and other modern CFWs), because the bundled gl4es needs it. It will not load on older ArkOS images based on Ubuntu 19.10.

The bundled `libs.aarch64` (openal-soft 1.24.3, libogg 1.3.6, libvorbis 1.3.7, libtheoradec 1.2.0) are built against a glibc 2.28 baseline with libc++ linked statically, so they need no newer libstdc++, `libmvec` or `libcairo` from the device.

## Controls

| Key | Action |
|--|--|
| Left Analog | Move |
| Right Analog | Look |
| A | Move Up / Jump |
| B | Move Down / Crouch |
| X | Use |
| Y | Inventory Use |
| L1 | Radial Weapon Menu |
| R2 | Attack |
| Start | Pause Menu |
| Select | Console |

Controller input is handled natively by the game itself. See `dominatrix/base/default.cfg` to change bindings.

## Known issues

- **Do not press Apply in the Video menu (including Brightness).** Applying video changes restarts the renderer, which freezes the game on gl4es (reported on Knulli, RGCubeXX). Exit with Start+Select and relaunch. Upstream also reports that the in-game brightness / `vid_gamma` setting has no visible effect, so use the device's own brightness control instead.
- **Look speed:** the right stick follows the game's mouse sensitivity setting (upstream v1.2+). If it feels slow, raise the mouse sensitivity in the Controls menu. The value is saved to `conf/dominatrix/base/config.cfg`.

## Compile

git clone https://github.com/rohit-n/dominatrix.git
cd dominatrix
# Follow the upstream build instructions for aarch64.
# The binary shipped here was taken from an upstream aarch64 release build.

### GL4ES

git clone https://github.com/ptitSeb/gl4es.git
cd gl4es
mkdir build && cd build
cmake .. -DGOA_CLONE=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
make

Copy the resulting `lib/libGL.so.1` and `lib/libEGL.so.1` into `dominatrix/gl4es.aarch64/`. Requires an aarch64 build environment, native or emulated (e.g. Docker with binfmt).
