#!/bin/sh
set -eu

cd /app

if [ -f package.json ]; then
  echo "[init] package.json already exists. Skip."
  exit 0
fi

echo "[init] Creating Vite project (svelte-ts) in /app ..."
npm create vite@latest . -- --template svelte-ts

echo "[init] Installing dependencies ..."
npm install

echo "[init] Done."
