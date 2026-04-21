#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export MEMORY_GRAPH_PATH="$ROOT/memory/evolution/memory_graph.jsonl"
node .codex/hooks/evolver-session-start.js <<'JSON'
{}
JSON
