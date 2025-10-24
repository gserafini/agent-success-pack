#!/bin/bash

# Agent Success Pack - Bootstrap Script
# One-liner installation for new or existing projects

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Agent Success Pack - Bootstrap     ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo -e "${RED}Error: Not in a git repository${NC}"
    echo "Please run this from the root of your project's git repository."
    echo ""
    echo "To initialize a git repo:"
    echo "  git init"
    exit 1
fi

# Check if .agent-success-pack already exists
if [ -d ".agent-success-pack" ]; then
    echo -e "${YELLOW}⚠ .agent-success-pack directory already exists${NC}"
    echo ""
    read -p "Reinstall? This will remove and re-add the submodule (y/n): " REINSTALL
    if [[ "$REINSTALL" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}→${NC} Removing existing .agent-success-pack..."
        git rm -rf .agent-success-pack 2>/dev/null || rm -rf .agent-success-pack
        rm -rf .git/modules/.agent-success-pack 2>/dev/null || true
        git config --remove-section submodule..agent-success-pack 2>/dev/null || true
    else
        echo -e "${BLUE}→${NC} Skipping submodule setup, running init..."
        cd .agent-success-pack
        ./scripts/init.sh
        exit 0
    fi
fi

echo -e "${GREEN}Step 1: Adding Agent Success Pack as git submodule...${NC}"
git submodule add https://github.com/gserafini/agent-success-pack.git .agent-success-pack

echo ""
echo -e "${GREEN}Step 2: Initializing submodule...${NC}"
git submodule update --init --recursive

echo ""
echo -e "${GREEN}Step 3: Running interactive setup...${NC}"
echo ""
cd .agent-success-pack
./scripts/init.sh

cd ..

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Bootstrap Complete! 🎉            ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "  1. Review generated documentation files"
echo "  2. Commit the changes:"
echo "     ${YELLOW}git add .${NC}"
echo "     ${YELLOW}git commit -m \"feat: add Agent Success Pack framework\"${NC}"
echo "  3. Start building with clear structure!"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  - PROGRESS.md - Track your progress"
echo "  - CLAUDE.md - Guide for AI assistants"
echo "  - IMPLEMENTATION_CHECKLIST.md - Task breakdown"
echo ""
echo -e "${GREEN}Happy building! 🚀${NC}"
echo ""
