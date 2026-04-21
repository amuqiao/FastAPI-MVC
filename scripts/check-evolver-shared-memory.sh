#!/usr/bin/env bash
set -e

export EVOLVER_ROOT=/Users/admin/Downloads/Code/evolver
node .codex/hooks/evolver-session-start.js <<'JSON'
{}
JSON
