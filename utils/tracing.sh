#!/bin/bash

# Enable color support
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# Internal helper to format prefix with file and line number of the caller
_trace_prefix() {
    local file="${BASH_SOURCE[2]##*/}"  # caller's file name
    local line="${BASH_LINENO[1]}"      # caller's line number
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "[$timestamp] [$file:$line]"
}

info() {
    local prefix=$(_trace_prefix)
    echo -e "${BLUE}${prefix} [INFO]${NC} $*"
}

warn() {
    local prefix=$(_trace_prefix)
    echo -e "${YELLOW}${prefix} [WARN]${NC} $*" >&2
}

error() {
    local prefix=$(_trace_prefix)
    echo -e "${RED}${prefix} [ERROR]${NC} $*" >&2
}

fatal() {
    error "$@"
    exit 1
}
