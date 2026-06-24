# Polyhedra

Polyhedra can now run in two modes:

1. Screen saver module (`Polyhedra.saver`)
2. Active wallpaper host (desktop-level app that loads the same saver)

## Build and install the screen saver

```sh
./scripts/install-saver.sh
```

This builds and installs `~/Library/Screen Savers/Polyhedra.saver`.

## Run as active wallpaper (Objective-C host)

```sh
./scripts/run-wallpaper.sh
```

This compiles `WallpaperRunner/main.m` (if needed), loads the saver bundle, and places it on each display at desktop level.

To stop it, quit the `PolyhedraWallpaper` process.

## Use as both wallpaper and screensaver in macOS settings

After installing the saver, open System Settings and select Polyhedra as your screen saver. On macOS versions that support "Show as Wallpaper", enable that option for the same module.
