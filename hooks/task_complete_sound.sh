#!/bin/bash

# Claude Code hook script to play a pleasant chime when tasks are completed
# This script is triggered by PostToolUse events

#SOUND_FILE="$HOME/.claude/sounds/task_complete.wav"
SOUND_FILE="$HOME/.claude/sounds/work-complete.mp3"

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

# Parse the tool name from the input (optional - could filter by specific tools)
# For now, play chime for any successful tool completion
if [ -f "$SOUND_FILE" ]; then
    play_chime
fi

# Return success (don't interfere with Claude's workflow)
exit 0
