# This file is meant to be sourced from other scripts

colorize() { CODE=$1; shift; echo -e '\033[0;'"${CODE}"'m'"$*"'\033[0m'; }
red() { echo -e "$(colorize '1;31' "$@")"; }
green() { echo -e "$(colorize 32 "$@")"; }
yellow() { echo -e "$(colorize 33 "$@")"; }
cyan() { echo -e "$(colorize 36 "$@")"; }
