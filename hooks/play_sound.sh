#!/bin/bash

# Claude Code hook script to play a sound file
# Usage: play_sound.sh <sound_filename>
# The sound file is expected to reside in $HOME/.claude/sounds/

# Get sound filename from parameter
if [ -z "$1" ]; then
    echo "Error: No sound filename provided" >&2
    exit 1
fi

SOUND_FILE="$HOME/.claude/sounds/$1"

# Function to play sound with fallback options
play_chime() {
    if command -v paplay >/dev/null 2>&1; then
        paplay "$SOUND_FILE" 2>/dev/null &
    elif command -v aplay >/dev/null 2>&1; then
        aplay "$SOUND_FILE" 2>/dev/null &
    elif command -v ffplay >/dev/null 2>&1; then
        ffplay -nodisp -autoexit "$SOUND_FILE" 2>/dev/null &
    elif command -v mpv >/dev/null 2>&1; then
        mpv --no-video --really-quiet "$SOUND_FILE" 2>/dev/null &
    fi
}

# Read JSON input from Claude
input_json=$(cat)

# Play chime if sound file exists
if [ -f "$SOUND_FILE" ]; then
    play_chime
fi

# Return success (don't interfere with Claude's workflow)
exit 0
