#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
get_controls

GAMEDIR=/$directory/ports/dominatrix
BINARY=sin.${DEVICE_ARCH}

mkdir -p "$GAMEDIR/conf"
cd "$GAMEDIR"

export XDG_DATA_HOME="$GAMEDIR/conf"

> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

export LD_LIBRARY_PATH="$GAMEDIR/libs.${DEVICE_ARCH}:$LD_LIBRARY_PATH"
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

if [ -f "${controlfolder}/libgl_${CFW_NAME}.txt" ]; then
  source "${controlfolder}/libgl_${CFW_NAME}.txt"
else
  source "${controlfolder}/libgl_default.txt"
fi

# Force the bundled gl4es only when the CFW's libgl script selected it (it
# exports LIBGL_FB). CFWs with native desktop GL (e.g. Rocknix/Mesa) leave
# LIBGL_FB unset; forcing gl4es there fails with "Could not load EGL library".
if [ -n "$LIBGL_FB" ] && [ -d "$GAMEDIR/gl4es.${DEVICE_ARCH}" ]; then
  export SDL_VIDEO_GL_DRIVER="$GAMEDIR/gl4es.${DEVICE_ARCH}/libGL.so.1"
  export SDL_VIDEO_EGL_DRIVER="$GAMEDIR/gl4es.${DEVICE_ARCH}/libEGL.so.1"
fi

$GPTOKEYB2 "$BINARY" &

pm_platform_helper "$GAMEDIR/$BINARY"

# Line-buffer the game's output so log.txt stays complete if it is killed.
if command -v stdbuf >/dev/null 2>&1; then
  stdbuf -oL -eL ./$BINARY
else
  ./$BINARY
fi

pm_finish
