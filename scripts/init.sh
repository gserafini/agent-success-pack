#!/bin/bash

# Agent Success Pack - Initialization Script
# Customizes templates for your project

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACK_ROOT="$(dirname "$SCRIPT_DIR")"

# Determine project root (parent of .agent-success-pack or current dir)
if [[ "$(basename "$PACK_ROOT")" == ".agent-success-pack" ]]; then
    PROJECT_ROOT="$(dirname "$PACK_ROOT")"
else
    PROJECT_ROOT="$(pwd)"
fi

echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Agent Success Pack - Init Script   ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}This script will customize templates for your project.${NC}"
echo ""

# Collect project information
echo -e "${YELLOW}Project Information:${NC}"
echo ""

read -p "Project Name (e.g., 'Reentry Map'): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-"My Project"}

echo ""
echo "Project Type:"
echo "  1) Full-stack web application"
echo "  2) Backend API/Microservice"
echo "  3) Mobile application"
echo "  4) NPM library/package"
echo "  5) CLI tool"
echo "  6) Custom"
read -p "Select type (1-6): " PROJECT_TYPE_NUM
PROJECT_TYPE_NUM=${PROJECT_TYPE_NUM:-1}

case $PROJECT_TYPE_NUM in
    1) PROJECT_TYPE="Full-stack web application" ;;
    2) PROJECT_TYPE="Backend API/Microservice" ;;
    3) PROJECT_TYPE="Mobile application" ;;
    4) PROJECT_TYPE="NPM library/package" ;;
    5) PROJECT_TYPE="CLI tool" ;;
    6) read -p "Enter custom project type: " PROJECT_TYPE ;;
    *) PROJECT_TYPE="Full-stack web application" ;;
esac

echo ""
read -p "Tech Stack (e.g., 'Next.js 16, Supabase, TypeScript'): " TECH_STACK
TECH_STACK=${TECH_STACK:-"Not specified yet"}

echo ""
read -p "Your Name: " AUTHOR
AUTHOR=${AUTHOR:-"$(git config user.name 2>/dev/null || echo 'Developer')"}

echo ""
read -p "Your Email: " EMAIL
EMAIL=${EMAIL:-"$(git config user.email 2>/dev/null || echo 'dev@example.com')"}

TODAY_DATE=$(date +%Y-%m-%d)

echo ""
echo -e "${YELLOW}Quality Tools Setup:${NC}"
echo ""

read -p "Install Prettier config? (y/n): " INSTALL_PRETTIER
INSTALL_PRETTIER=${INSTALL_PRETTIER:-y}

read -p "Set up git hooks (Husky)? (y/n): " INSTALL_HUSKY
INSTALL_HUSKY=${INSTALL_HUSKY:-y}

echo ""
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}Configuration Summary:${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo "  Project: $PROJECT_NAME"
echo "  Type: $PROJECT_TYPE"
echo "  Stack: $TECH_STACK"
echo "  Author: $AUTHOR <$EMAIL>"
echo "  Date: $TODAY_DATE"
echo ""
echo "  Install Prettier: $INSTALL_PRETTIER"
echo "  Install Husky: $INSTALL_HUSKY"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo ""

read -p "Proceed with initialization? (y/n): " PROCEED
PROCEED=${PROCEED:-y}

if [[ ! "$PROCEED" =~ ^[Yy]$ ]]; then
    echo -e "${RED}Initialization cancelled.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Generating documentation...${NC}"

# Function to replace variables in templates
replace_vars() {
    local file=$1
    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s/{{PROJECT_TYPE}}/$PROJECT_TYPE/g" \
        -e "s/{{TECH_STACK}}/$TECH_STACK/g" \
        -e "s/{{AUTHOR}}/$AUTHOR/g" \
        -e "s/{{EMAIL}}/$EMAIL/g" \
        -e "s/{{TODAY_DATE}}/$TODAY_DATE/g" \
        "$file"
}

# Create basic PROGRESS.md if template doesn't exist
if [ ! -f "$PACK_ROOT/templates/planning/PROGRESS.md.template" ]; then
    cat > "$PROJECT_ROOT/PROGRESS.md" <<EOF
# $PROJECT_NAME - Development Progress

**Last Updated**: $TODAY_DATE
**Current Phase**: Phase 0 - Foundation & Quality Infrastructure
**Overall Progress**: 0% (Just getting started!)

---

## Quick Status

| Phase                      | Status         | Progress | ETA            |
| -------------------------- | -------------- | -------- | -------------- |
| Phase 0: Foundation        | 🚧 In Progress | 0%       | This Week      |
| Phase 1: Core Features     | ❌ Not Started | 0%       | TBD            |

---

## Current Session Progress

### Completed ✅

- Set up Agent Success Pack framework
- Generated initial documentation

### Next Steps ⏭️

1. Complete Phase 0 tasks in IMPLEMENTATION_CHECKLIST.md
2. Set up development environment
3. Begin building!

---

## Metrics

### Code Quality

- **Tests Written**: 0
- **Tests Passing**: 0
- **Test Coverage**: 0%
- **TypeScript Errors**: 0

---

## Session Notes

### $TODAY_DATE - Initial Setup

**Accomplishments**:
- Initialized project with Agent Success Pack
- Generated documentation framework
- Ready to start development

**Next Session**:
- Define specific implementation phases
- Set up development environment
- Write first tests

---

**Generated with [Agent Success Pack](https://github.com/gserafini/agent-success-pack)**
EOF
    echo -e "${GREEN}✓${NC} Created PROGRESS.md"
fi

# Create basic CLAUDE.md
cat > "$PROJECT_ROOT/CLAUDE.md" <<EOF
# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Context

**$PROJECT_NAME** is a $PROJECT_TYPE.

- **Owner**: $AUTHOR ($EMAIL)
- **Tech Stack**: $TECH_STACK
- **Created**: $TODAY_DATE

## Quick Start

\`\`\`bash
# Install dependencies
npm install

# Run development server
npm run dev

# Run tests
npm test
\`\`\`

## Project Structure

\`\`\`
project/
├── src/                  # Source code
├── tests/                # Test files
└── docs/                 # Documentation
\`\`\`

## Development Patterns

### Code Style

- Use TypeScript with explicit types
- Follow ESLint and Prettier configurations
- Write tests for all new features

### Testing

- Unit tests with Vitest
- E2E tests with Playwright
- Run tests before committing

### Commits

- Follow Conventional Commits format
- feat: New features
- fix: Bug fixes
- docs: Documentation changes
- test: Test additions/changes
- chore: Maintenance tasks

## Common Commands

\`\`\`bash
npm run dev          # Start development server
npm test             # Run tests
npm run build        # Build for production
npm run lint         # Run linter
npm run format       # Format code
\`\`\`

## Important Files

- **PROGRESS.md** - Current project status and session notes
- **IMPLEMENTATION_CHECKLIST.md** - Detailed task breakdown
- **ARCHITECTURE_DECISIONS.md** - Key technical decisions

---

**Update this file as the project evolves!**

Generated with [Agent Success Pack](https://github.com/gserafini/agent-success-pack)
EOF
echo -e "${GREEN}✓${NC} Created CLAUDE.md"

# Create basic IMPLEMENTATION_CHECKLIST.md
cat > "$PROJECT_ROOT/IMPLEMENTATION_CHECKLIST.md" <<EOF
# Implementation Checklist

Detailed task breakdown for building $PROJECT_NAME.

## Legend

- ✅ Complete
- 🚧 In Progress
- ⏳ Blocked
- ❌ Not Started

---

## Phase 0: Foundation & Quality Infrastructure

**Goal**: Set up enterprise-grade development environment and tooling.

**Estimated Time**: 2-4 hours

### 0.1 Project Setup

- [x] Initialize Agent Success Pack
- [ ] Set up version control
- [ ] Configure development environment
- [ ] Install dependencies

### 0.2 Quality Tools

- [ ] Configure TypeScript strict mode
- [ ] Set up ESLint
- [ ] Set up Prettier
- [ ] Configure git hooks

### 0.3 Testing Infrastructure

- [ ] Install Vitest for unit tests
- [ ] Install Playwright for E2E tests
- [ ] Write example tests
- [ ] Set up coverage reporting

**Deliverable**: Fully configured development environment with quality tools

---

## Phase 1: Core Features

**Goal**: Implement core application functionality

**Estimated Time**: TBD

### 1.1 [Define your first feature]

- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

**Deliverable**: [Define deliverable]

---

## Adding More Phases

As you plan your project, add more phases here following this structure:

1. **Phase Number & Name**
2. **Goal** - What is this phase achieving?
3. **Tasks** - Broken down with checkboxes
4. **Deliverable** - What's the concrete output?

---

**Generated with [Agent Success Pack](https://github.com/gserafini/agent-success-pack)**
EOF
echo -e "${GREEN}✓${NC} Created IMPLEMENTATION_CHECKLIST.md"

# Create ARCHITECTURE_DECISIONS.md
cat > "$PROJECT_ROOT/ARCHITECTURE_DECISIONS.md" <<EOF
# Architecture Decision Records (ADRs)

This file tracks significant technical decisions for $PROJECT_NAME.

## What are ADRs?

Architecture Decision Records document:
- **What** decision was made
- **Why** it was made
- **What alternatives** were considered
- **What consequences** it has

---

## ADR-001: Use Agent Success Pack for Project Management

**Date**: $TODAY_DATE
**Status**: Accepted
**Deciders**: $AUTHOR
**Tags**: project-management, documentation

### Context

Need a structured approach to project planning, documentation, and progress tracking.

### Decision

Use [Agent Success Pack](https://github.com/gserafini/agent-success-pack) as the project management framework.

### Rationale

- Provides battle-tested templates
- Optimized for AI-assisted development
- Includes quality tooling setup
- Clear phase-based approach

### Consequences

**Positive**:
- Clear project structure from day one
- Better context for AI assistants
- Consistent documentation
- Quality standards enforced

**Negative**:
- Upfront time investment in setup
- Need to maintain documentation

---

## ADR-002: [Your Next Decision]

**Date**: [Date]
**Status**: Proposed | Accepted | Deprecated
**Deciders**: [Names]
**Tags**: [relevant, tags]

### Context

[What situation prompted this decision?]

### Decision

[What was decided?]

### Options Considered

1. **Option A**: Pros and cons
2. **Option B**: Pros and cons
3. **Option C**: Pros and cons

### Rationale

[Why this option was chosen]

### Consequences

**Positive**:
- [Benefits]

**Negative**:
- [Tradeoffs]

---

**Add new ADRs as you make significant technical decisions!**

Generated with [Agent Success Pack](https://github.com/gserafini/agent-success-pack)
EOF
echo -e "${GREEN}✓${NC} Created ARCHITECTURE_DECISIONS.md"

# Copy quality tool configs if requested
if [[ "$INSTALL_PRETTIER" =~ ^[Yy]$ ]]; then
    if [ -f "$PACK_ROOT/templates/configs/.prettierrc" ]; then
        cp "$PACK_ROOT/templates/configs/.prettierrc" "$PROJECT_ROOT/"
        echo -e "${GREEN}✓${NC} Copied .prettierrc"
    fi
    if [ -f "$PACK_ROOT/templates/configs/.prettierignore" ]; then
        cp "$PACK_ROOT/templates/configs/.prettierignore" "$PROJECT_ROOT/"
        echo -e "${GREEN}✓${NC} Copied .prettierignore"
    fi
fi

if [[ "$INSTALL_HUSKY" =~ ^[Yy]$ ]]; then
    if command -v npm &> /dev/null; then
        cd "$PROJECT_ROOT"
        if [ -f "package.json" ]; then
            echo -e "${BLUE}Installing husky and lint-staged...${NC}"
            npm install --save-dev husky lint-staged
            npx husky init
            echo "npx lint-staged" > .husky/pre-commit
            chmod +x .husky/pre-commit

            # Add lint-staged config to package.json if it doesn't exist
            if ! grep -q "lint-staged" package.json; then
                echo -e "${BLUE}Adding lint-staged config to package.json...${NC}"
                # This would require jq or manual editing, skip for now
                echo -e "${YELLOW}! Please add lint-staged configuration to package.json manually${NC}"
            fi
            echo -e "${GREEN}✓${NC} Installed Husky git hooks"
        else
            echo -e "${YELLOW}! No package.json found, skipping Husky installation${NC}"
        fi
        cd "$PACK_ROOT"
    fi
fi

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Initialization Complete! 🎉       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""
echo "Generated files:"
echo "  - PROGRESS.md"
echo "  - CLAUDE.md"
echo "  - IMPLEMENTATION_CHECKLIST.md"
echo "  - ARCHITECTURE_DECISIONS.md"
if [[ "$INSTALL_PRETTIER" =~ ^[Yy]$ ]]; then
    echo "  - .prettierrc"
    echo "  - .prettierignore"
fi
if [[ "$INSTALL_HUSKY" =~ ^[Yy]$ ]]; then
    echo "  - .husky/pre-commit"
fi
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "  1. Review and customize generated documentation"
echo "  2. Update IMPLEMENTATION_CHECKLIST.md with your phases"
echo "  3. Start building with clear context!"
echo ""
echo -e "${BLUE}Working with AI Assistants:${NC}"
echo "  Claude Code: Start sessions with 'Read CLAUDE.md and PROGRESS.md'"
echo "  GitHub Copilot: Instructions in .github/copilot-instructions.md"
echo ""
echo -e "${GREEN}Happy building!${NC}"
echo ""
