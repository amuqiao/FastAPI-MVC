#!/usr/bin/env bash
set -e

export MEMORY_GRAPH_PATH="$(cd "$(dirname "$0")/.." && pwd)/memory/evolution/memory_graph.jsonl"
exec codex "$@"
