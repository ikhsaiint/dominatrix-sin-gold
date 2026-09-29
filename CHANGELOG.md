# Dominatrix (SiN) Port — Changelog

Base: `dominatrixFixed.zip` (as uploaded).

## Changed

Files:
- `Dominatrix.sh`
- `Dominatrix - Wages of SiN.sh`

### 1. Conditional gl4es override

The launchers now force the bundled gl4es libraries only when PortMaster's CFW libgl configuration selects the gl4es path (`LIBGL_FB` is set).

This avoids forcing gl4es on systems with native desktop OpenGL/Mesa.

### 2. Line-buffered game output

When `stdbuf` is available, game output is run through:

```bash
stdbuf -oL -eL
```

with a fallback to the original direct execution when `stdbuf` is unavailable.

## Repository contents

The repository contains the PortMaster metadata, launchers, README, and project structure. The supplied game-data archive is not intended to be redistributed; users should provide their own SiN: Gold data as described in the README.
