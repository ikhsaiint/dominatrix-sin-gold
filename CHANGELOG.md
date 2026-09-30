# Dominatrix (SiN) Port — Changelog

Base: `dominatrixFixed_3.zip` / `dominatrix-glibc227.zip` package variants.

## Current runtime update

- Verified `sin.aarch64` requires GLIBC **2.29**.
- Verified bundled `gl4es.aarch64/libGL.so.1` requires GLIBC **2.27**.
- The current package-wide minimum is therefore **GLIBC 2.29**.
- Updated `port.json` from GLIBC 2.34 to **2.29**.
- Updated README documentation to distinguish the GL4ES 2.27 baseline from the game's 2.29 requirement.

## Launcher changes

Files:
- `Dominatrix.sh`
- `Dominatrix - Wages of SiN.sh`

### Conditional gl4es override

The launchers force the bundled gl4es libraries only when PortMaster's CFW libgl configuration selects the gl4es path (`LIBGL_FB` is set).

### Line-buffered game output

When `stdbuf` is available, game output is run through:

```bash
stdbuf -oL -eL
```

with a fallback to direct execution when `stdbuf` is unavailable.

## Repository contents

The repository contains the PortMaster metadata, launchers, README, and project structure. The supplied game-data archive is not intended to be redistributed; users should provide their own SiN: Gold data as described in the README.
