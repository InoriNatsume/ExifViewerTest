#!/bin/sh
set -eu

cd /app

if [ ! -f package.json ]; then
  echo "[dev] No package.json found in /app."
  echo "[dev] Run: docker compose run --rm app sh /scripts/init.sh"
  exit 1
fi

if [ ! -d node_modules ]; then
  echo "[dev] node_modules missing. Installing..."
  npm install
fi

exec npm run dev -- --host 0.0.0.0 --port 5173
