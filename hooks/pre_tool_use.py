#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.8"
# ///

import json
import sys
import re
from pathlib import Path

def is_dangerous_rm_command(command: str) -> bool:
    """
    Comprehensive detection of dangerous rm commands.
    Matches various forms of rm -rf and similar destructive patterns.
    """
    normalized = ' '.join(command.lower().split())

    # Pattern 1: Standard rm -rf variations
    patterns = [
        r'\brm\s+.*-[a-z]*r[a-z]*f',  # rm -rf, rm -fr, rm -Rf, etc.
        r'\brm\s+.*-[a-z]*f[a-z]*r',  # rm -fr variations
        r'\brm\s+--recursive\s+--force',  # rm --recursive --force
        r'\brm\s+--force\s+--recursive',  # rm --force --recursive
        r'\brm\s+-r\s+.*-f',  # rm -r ... -f
        r'\brm\s+-f\s+.*-r',  # rm -f ... -r
    ]

    # Check for dangerous patterns
    for pattern in patterns:
        if re.search(pattern, normalized):
            return True

    # Pattern 2: Check for rm with recursive flag targeting dangerous paths
    dangerous_paths = [
        r'/',           # Root directory
        r'/\*',         # Root with wildcard
        r'~',           # Home directory
        r'~/',          # Home directory path
        r'\$HOME',      # Home environment variable
        r'\.\.',        # Parent directory references
        r'\*',          # Wildcards in general rm -rf context
        r'\.',          # Current directory
        r'\.\s*$',      # Current directory at end of command
    ]

    if re.search(r'\brm\s+.*-[a-z]*r', normalized):  # If rm has recursive flag
        for path in dangerous_paths:
            if re.search(path, normalized):
                return True

    return False


# Utilities that can erase data, format drives, or destructively modify volumes.
# Each entry: (pattern, human-readable reason)
DANGEROUS_DISK_COMMANDS: list[tuple[str, str]] = [
    # Disk/partition erasure & formatting
    (r'\bdd\b', "dd can overwrite entire drives"),
    (r'\bmkfs\b', "mkfs formats and destroys existing data on a partition"),
    (r'\bmkfs\.\w+', "mkfs variant formats and destroys existing data"),
    (r'\bmkswap\b', "mkswap formats a partition as swap"),
    (r'\bshred\b', "shred securely overwrites files/devices"),
    (r'\bwipefs\b', "wipefs wipes filesystem signatures"),
    (r'\bblkdiscard\b', "blkdiscard discards all sectors on a block device"),
    (r'\bsgdisk\b', "sgdisk can manipulate/destroy GPT partition tables"),
    (r'\bsfdisk\b', "sfdisk can overwrite partition tables"),
    (r'\bfdisk\b', "fdisk can modify/destroy partition tables"),
    (r'\bcfdisk\b', "cfdisk can modify/destroy partition tables"),
    (r'\bparted\b', "parted can modify/destroy partition tables"),
    (r'\bgdisk\b', "gdisk can modify/destroy partition tables"),
    # Volume/RAID/LVM management
    (r'\bmdadm\b', "mdadm can create/destroy RAID arrays"),
    (r'\blvcreate\b', "lvcreate can overwrite data on LVM volumes"),
    (r'\blvremove\b', "lvremove destroys LVM logical volumes"),
    (r'\blvresize\b', "lvresize can cause data loss on LVM volumes"),
    (r'\bvgcreate\b', "vgcreate can overwrite data on LVM volume groups"),
    (r'\bvgremove\b', "vgremove destroys LVM volume groups"),
    (r'\bpvcreate\b', "pvcreate can overwrite data on physical volumes"),
    (r'\bpvremove\b', "pvremove destroys LVM physical volume metadata"),
    (r'\bdmsetup\b', "dmsetup can remove/modify block devices"),
    # Filesystem-level destruction
    (r'\btruncate\b', "truncate can zero out files"),
    # Crypto/LUKS
    (r'\bcryptsetup\b', "cryptsetup can format/erase LUKS volumes"),
]


def is_dangerous_disk_command(command: str) -> tuple[bool, str]:
    """
    Check if a command uses any utility that can erase, format,
    or destructively modify drives/volumes.
    Returns (is_dangerous, reason).
    """
    for pattern, reason in DANGEROUS_DISK_COMMANDS:
        if re.search(pattern, command):
            return True, reason
    return False, ""

def is_git_branch_delete(command: str) -> bool:
    """
    Detect git branch deletion (including the `git br` alias).
    Matches `git branch|br` followed somewhere by `-d`, `-D`, a combined
    short-flag containing d/D (e.g. `-rD`), or `--delete`.
    """
    pattern = r'\bgit\s+(branch|br)\b.*?\s(-[a-zA-Z]*[dD]\b|--delete\b)'
    return bool(re.search(pattern, command))


def is_env_file_access(tool_name, tool_input):
    """
    Check if any tool is trying to access .env files containing sensitive data.
    """
    if tool_name in ['Read', 'Edit', 'MultiEdit', 'Write', 'Bash']:
        # Check file paths for file-based tools
        if tool_name in ['Read', 'Edit', 'MultiEdit', 'Write']:
            file_path = tool_input.get('file_path', '')
            if '.env' in file_path and not file_path.endswith('.env.sample'):
                return True
        
        # Check bash commands for .env file access
        elif tool_name == 'Bash':
            command = tool_input.get('command', '')
            # Pattern to detect .env file access (but allow .env.sample)
            env_patterns = [
                r'\b\.env\b(?!\.sample)',  # .env but not .env.sample
                r'cat\s+.*\.env\b(?!\.sample)',  # cat .env
                r'echo\s+.*>\s*\.env\b(?!\.sample)',  # echo > .env
                r'touch\s+.*\.env\b(?!\.sample)',  # touch .env
                r'cp\s+.*\.env\b(?!\.sample)',  # cp .env
                r'mv\s+.*\.env\b(?!\.sample)',  # mv .env
            ]
            
            for pattern in env_patterns:
                if re.search(pattern, command):
                    return True
    
    return False

def main():
    try:
        # Read JSON input from stdin
        input_data = json.load(sys.stdin)
        
        tool_name = input_data.get('tool_name', '')
        tool_input = input_data.get('tool_input', {})
        
        # Check for .env file access (blocks access to sensitive environment files)
        if is_env_file_access(tool_name, tool_input):
            print("BLOCKED: Access to .env files containing sensitive data is prohibited", file=sys.stderr)
            print("Use .env.sample for template files instead", file=sys.stderr)
            sys.exit(2)  # Exit code 2 blocks tool call and shows error to Claude
        
        # Check for dangerous Bash commands
        if tool_name == 'Bash':
            command = tool_input.get('command', '')

            # Block rm -rf commands
            if is_dangerous_rm_command(command):
                print("BLOCKED: Dangerous rm command detected and prevented", file=sys.stderr)
                sys.exit(2)

            # Block disk/volume destructive utilities
            is_dangerous, reason = is_dangerous_disk_command(command)
            if is_dangerous:
                print(f"BLOCKED: {reason}", file=sys.stderr)
                sys.exit(2)

            # Block git branch deletion (including `git br` alias)
            if is_git_branch_delete(command):
                print("BLOCKED: git branch deletion is not allowed without explicit user action", file=sys.stderr)
                sys.exit(2)
        
        # Ensure log directory exists
        log_dir = Path.cwd() / '.claude/data/logs'
        log_dir.mkdir(parents=True, exist_ok=True)
        log_path = log_dir / 'pre_tool_use.json'
        
        # Read existing log data or initialize empty list
        if log_path.exists():
            with open(log_path, 'r') as f:
                try:
                    log_data = json.load(f)
                except (json.JSONDecodeError, ValueError):
                    log_data = []
        else:
            log_data = []
        
        # Append new data
        log_data.append(input_data)
        
        # Write back to file with formatting
        with open(log_path, 'w') as f:
            json.dump(log_data, f, indent=2)
        
        sys.exit(0)
        
    except json.JSONDecodeError:
        # Gracefully handle JSON decode errors
        sys.exit(0)
    except Exception:
        # Handle any other errors gracefully
        sys.exit(0)

if __name__ == '__main__':
    main()
