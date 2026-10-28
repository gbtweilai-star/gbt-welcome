#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_welcome info
PYTHONPATH=src python -m gbt_welcome check --payload '{}'
PYTHONPATH=src python -m gbt_welcome run   --payload '{}'
