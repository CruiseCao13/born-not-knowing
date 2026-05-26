#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/cruise-site"
REPO_URL="https://github.com/CruiseCao13/born-not-knowing.git"
REPO_PAGE="https://github.com/CruiseCao13/born-not-knowing"
PROJECT_NAME="born-not-knowing"
REQUIRED_NODE_MAJOR=22
REQUIRED_NODE_MINOR=12

echo "========================================"
echo " Born Not Knowing - Deploy Check Script "
echo "========================================"
echo

cd "$PROJECT_DIR"

echo "Current directory:"
pwd
echo

echo "Step 1: Check git repository..."
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: This is not a git repository."
  exit 1
fi

echo "Git repository OK."
echo

echo "Step 2: Check remotes..."
git remote -v
echo

ORIGIN_URL="$(git remote get-url origin 2>/dev/null || true)"

if [ "$ORIGIN_URL" != "$REPO_URL" ]; then
  echo "ERROR: origin is not correct."
  echo "Expected:"
  echo "  $REPO_URL"
  echo "Current:"
  echo "  ${ORIGIN_URL:-none}"
  echo
  echo "Fix manually with:"
  echo "  git remote remove origin"
  echo "  git remote add origin $REPO_URL"
  exit 1
fi

echo "origin OK."
echo

echo "Step 3: Check working tree..."
if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: Working tree is not clean."
  echo
  git status --short
  echo
  echo "Commit or discard changes before deployment."
  exit 1
fi

echo "Working tree clean."
echo

echo "Step 4: Check current branch..."
CURRENT_BRANCH="$(git branch --show-current)"
echo "Current branch: $CURRENT_BRANCH"

if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "ERROR: You are not on main branch."
  echo "Run:"
  echo "  git checkout main"
  exit 1
fi

echo "Branch OK."
echo

echo "Step 5: Check Node version..."
if ! command -v node >/dev/null 2>&1; then
  echo "ERROR: node is not installed or not in PATH."
  exit 1
fi

NODE_VERSION_RAW="$(node -v)"
NODE_VERSION="${NODE_VERSION_RAW#v}"
NODE_MAJOR="$(echo "$NODE_VERSION" | cut -d. -f1)"
NODE_MINOR="$(echo "$NODE_VERSION" | cut -d. -f2)"

echo "Current Node: $NODE_VERSION_RAW"
echo "Required: >= v${REQUIRED_NODE_MAJOR}.${REQUIRED_NODE_MINOR}.0"

if [ "$NODE_MAJOR" -lt "$REQUIRED_NODE_MAJOR" ] || { [ "$NODE_MAJOR" -eq "$REQUIRED_NODE_MAJOR" ] && [ "$NODE_MINOR" -lt "$REQUIRED_NODE_MINOR" ]; }; then
  echo
  echo "ERROR: Node version too old."
  echo "Your current terminal is using $NODE_VERSION_RAW."
  echo "This AstroPaper version requires Node >= v22.12.0."
  echo
  echo "Fix option A, if you use nvm:"
  echo "  nvm install 22"
  echo "  nvm use 22"
  echo
  echo "Fix option B, if you use Homebrew:"
  echo "  brew install node@22"
  echo "  echo 'export PATH=\"/opt/homebrew/opt/node@22/bin:\$PATH\"' >> ~/.zshrc"
  echo "  source ~/.zshrc"
  echo
  echo "Then rerun this script."
  echo
  echo "Cloudflare Pages should also set:"
  echo "  NODE_VERSION = 22.12.0"
  exit 1
fi

echo "Node version OK."
echo

echo "Step 6: Check pnpm..."
if ! command -v pnpm >/dev/null 2>&1; then
  echo "pnpm not found. Enabling Corepack..."
  corepack enable
fi

echo "pnpm version:"
pnpm -v
echo

echo "Step 7: Install dependencies..."
pnpm install
echo

echo "Step 8: Build production site..."
pnpm build
echo

echo "Step 9: Push latest main to GitHub..."
git push origin main
echo

echo "Step 10: Final git status..."
git status
echo

echo "========================================"
echo " Local + GitHub deployment checks passed "
echo "========================================"
echo

echo "GitHub repository:"
echo "$REPO_PAGE"
echo

echo "Now deploy on Cloudflare Pages manually:"
echo
echo "Cloudflare Dashboard:"
echo "  Workers & Pages"
echo "  -> Create application"
echo "  -> Pages"
echo "  -> Connect to Git"
echo "  -> Select GitHub repo: CruiseCao13/$PROJECT_NAME"
echo
echo "Cloudflare Pages settings:"
echo "  Framework preset: Astro"
echo "  Production branch: main"
echo "  Build command: pnpm build"
echo "  Build output directory: dist"
echo "  SSR: no"
echo
echo "Environment variable:"
echo "  NODE_VERSION = 22.12.0"
echo
echo "If pnpm fails on Cloudflare, use this build command instead:"
echo "  corepack enable && pnpm install --frozen-lockfile && pnpm build"
echo

echo "After deploy, check these routes:"
echo "  /"
echo "  /about"
echo "  /now"
echo "  /notes"
echo "  /markets"
echo "  /projects"
echo "  /english"
echo "  /music"
echo "  /principles"
echo "  /search"
echo "  /rss.xml"
echo "  /sitemap-index.xml"
echo

if command -v open >/dev/null 2>&1; then
  echo "Opening GitHub repo..."
  open "$REPO_PAGE"
fi
