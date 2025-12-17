#!/bin/sh
set -eu

cd /app

echo "[tw] Installing Tailwind (v3) + PostCSS + Autoprefixer..."
# v3는 PostCSS 방식이 가장 안정적으로 잘 붙음
npm install -D tailwindcss@3.4.17 postcss autoprefixer

echo "[tw] Writing tailwind.config.cjs ..."
cat > tailwind.config.cjs << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{svelte,js,ts}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

echo "[tw] Writing postcss.config.cjs ..."
cat > postcss.config.cjs << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

echo "[tw] Writing src/app.css (Tailwind directives) ..."
cat > src/app.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

echo "[tw] Done."
