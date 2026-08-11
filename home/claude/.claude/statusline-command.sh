#!/usr/bin/env bash
# Claude Code status line — styled after the oh-my-zsh crunch theme
# Input: JSON from Claude Code via stdin

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# ANSI color codes — matching crunch palette
reset=$'\033[0m'
white=$'\033[0;37m'
yellow=$'\033[0;33m'
cyan=$'\033[0;36m'
green=$'\033[0;32m'
red=$'\033[0;31m'
magenta=$'\033[0;35m'

# Time in HH:MM format (matches crunch's %T)
time_str=$(date +%H:%M)

# Shorten cwd to ~ form
home="$HOME"
if [ -n "$cwd" ]; then
  short_cwd="${cwd/#$home/~}"
else
  short_cwd="~"
fi

# Git branch and dirty state (skip optional locks)
git_part=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if git -C "$cwd" -c core.hooksPath=/dev/null status --porcelain 2>/dev/null | grep -q .; then
      # dirty: branch in green, dirty marker in red
      git_part="${white}:${green}${branch}${red} ✗${reset}"
    else
      # clean: branch and marker both in green
      git_part="${white}:${green}${branch} ✓${reset}"
    fi
  fi
fi

# Context progress bar
ctx_str=""
if [ -n "$used" ]; then
  pct=$(printf '%.0f' "$used")
  # Build a 10-char block bar
  filled=$(( pct / 10 ))
  empty=$(( 10 - filled ))
  bar=""
  for i in $(seq 1 $filled);  do bar="${bar}█"; done
  for i in $(seq 1 $empty);   do bar="${bar}░"; done
  # Color by fill level: green <50, yellow 50-80, red >80
  if [ "$pct" -lt 50 ]; then
    bar_color="$green"
  elif [ "$pct" -lt 80 ]; then
    bar_color="$yellow"
  else
    bar_color="$red"
  fi
  ctx_str=" ${bar_color}[${bar}]${reset} ${bar_color}${pct}%${reset}"
fi

# Model (short form, magenta to match crunch's RVM slot)
model_str=""
if [ -n "$model" ]; then
  model_str=" ${white}[${magenta}${model}${white}]${reset}"
fi

printf '%s{%s%s%s}%s %s%s%s%s%s%s' \
  "$white" "$yellow" "$time_str" "$white" "$reset" \
  "$cyan" "$short_cwd" "$reset" \
  "$git_part" "$ctx_str" "$model_str"
