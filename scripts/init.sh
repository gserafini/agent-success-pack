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

read -p "Project Name (e.g., 'My Awesome App'): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-"Example Project"}

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

# Function to get file purpose description
get_file_purpose() {
    local filename=$1
    case "$filename" in
        "PROGRESS.md")
            echo "Tracks your project progress, session notes, metrics, and blockers"
            ;;
        "CLAUDE.md")
            echo "Quick reference guide for AI assistants (Claude Code, Copilot, etc.)"
            ;;
        "IMPLEMENTATION_CHECKLIST.md")
            echo "Phase-based task breakdown with acceptance criteria and review points"
            ;;
        "ARCHITECTURE_DECISIONS.md")
            echo "Records 'why' decisions were made using ADR (Architecture Decision Record) format"
            ;;
        ".prettierrc")
            echo "Code formatting configuration (auto-formats code on save/commit)"
            ;;
        ".prettierignore")
            echo "Tells Prettier which files to skip when formatting"
            ;;
        *)
            echo "Configuration file"
            ;;
    esac
}

# Function to summarize existing file content
summarize_file() {
    local filepath=$1
    local lines=$(wc -l < "$filepath" 2>/dev/null || echo "0")
    local size=$(du -h "$filepath" 2>/dev/null | cut -f1 || echo "0")
    local first_line=$(head -n 1 "$filepath" 2>/dev/null || echo "")

    echo "  Size: $size ($lines lines)"
    if [ ! -z "$first_line" ]; then
        echo "  First line: ${first_line:0:60}..."
    fi

    # Try to extract key info based on file type
    case "$(basename "$filepath")" in
        "PROGRESS.md")
            local phase=$(grep -m 1 "Current Phase" "$filepath" 2>/dev/null | sed 's/.*: //' || echo "Unknown")
            local progress=$(grep -m 1 "Overall Progress" "$filepath" 2>/dev/null | sed 's/.*: //' || echo "Unknown")
            echo "  Current: $phase"
            echo "  Progress: $progress"
            ;;
        "CLAUDE.md")
            local project=$(grep -m 1 "^\*\*.*\*\* is" "$filepath" 2>/dev/null | sed 's/\*\*//g' | sed 's/ is.*//' || echo "Project")
            echo "  Project: $project"
            ;;
        "IMPLEMENTATION_CHECKLIST.md")
            local phases=$(grep -c "^## Phase" "$filepath" 2>/dev/null || echo "0")
            local completed=$(grep -c "^- \[x\]" "$filepath" 2>/dev/null || echo "0")
            local total=$(grep -c "^- \[.\]" "$filepath" 2>/dev/null || echo "0")
            echo "  Phases defined: $phases"
            echo "  Tasks: $completed completed / $total total"
            ;;
        "ARCHITECTURE_DECISIONS.md")
            local adrs=$(grep -c "^## ADR-" "$filepath" 2>/dev/null || echo "0")
            echo "  ADRs documented: $adrs"
            ;;
    esac
}

# Enhanced function to safely create file with intelligent options
create_file_safe() {
    local filepath=$1
    local filename=$(basename "$filepath")
    local purpose=$(get_file_purpose "$filename")

    if [ -f "$filepath" ]; then
        echo ""
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}⚠  $filename already exists${NC}"
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo -e "${BLUE}Purpose:${NC} $purpose"
        echo ""
        echo -e "${BLUE}Existing file summary:${NC}"
        summarize_file "$filepath"
        echo ""
        echo "What would you like to do?"
        echo ""
        echo "  ${GREEN}1)${NC} Keep existing (safest - no changes)"
        echo "  ${BLUE}2)${NC} Enhance existing (add Agent Success Pack sections if missing)"
        echo "  ${YELLOW}3)${NC} Backup and replace (saves .bak, uses new template)"
        echo "  ${RED}4)${NC} Replace without backup (DANGEROUS - permanent loss)"
        echo ""
        read -p "Select option (1-4) [default: 1]: " FILE_ACTION
        FILE_ACTION=${FILE_ACTION:-1}

        case $FILE_ACTION in
            1)
                echo -e "${GREEN}✓${NC} Keeping existing $filename"
                return 1
                ;;
            2)
                echo -e "${BLUE}⚡${NC} Will enhance $filename (merge mode)"
                # Set flag for merge mode
                MERGE_MODE=true
                return 0
                ;;
            3)
                cp "$filepath" "$filepath.bak"
                echo -e "${YELLOW}✓${NC} Backed up to $filename.bak"
                echo -e "${YELLOW}✓${NC} Replacing $filename"
                MERGE_MODE=false
                return 0
                ;;
            4)
                echo -e "${RED}⚠${NC}  Replacing $filename (no backup)"
                MERGE_MODE=false
                return 0
                ;;
            *)
                echo -e "${GREEN}✓${NC} Keeping existing $filename (default)"
                return 1
                ;;
        esac
    fi

    MERGE_MODE=false
    return 0
}

# Function to enhance existing file by adding missing sections
enhance_file() {
    local filepath=$1
    local filename=$(basename "$filepath")

    echo -e "${BLUE}Analyzing $filename for enhancements...${NC}"

    case "$filename" in
        "CLAUDE.md")
            # Check if Agent Success Pack reference exists
            if ! grep -q "Agent Success Pack" "$filepath" 2>/dev/null; then
                echo -e "${BLUE}→${NC} Adding Agent Success Pack reference"
                # Add reference at top after title
                sed -i.tmp '1,/^# /a\
\
---\
\
**📦 This project uses [Agent Success Pack](https://github.com/gserafini/agent-success-pack)**\
\
A framework for structured, AI-optimized project management. Key docs:\
- **[PROGRESS.md](PROGRESS.md)** - Current status & session notes\
- **[IMPLEMENTATION_CHECKLIST.md](IMPLEMENTATION_CHECKLIST.md)** - Phase breakdown\
- **[ARCHITECTURE_DECISIONS.md](ARCHITECTURE_DECISIONS.md)** - Technical decisions (ADRs)\
\
**At session start**: Read PROGRESS.md to understand current state.\
\
---\
' "$filepath"
                rm -f "$filepath.tmp"
            fi
            ;;
        "PROGRESS.md")
            # Check if session management section exists
            if ! grep -q "Session Notes" "$filepath" 2>/dev/null; then
                echo -e "${BLUE}→${NC} Adding session tracking section"
                cat >> "$filepath" <<'ENHANCE_EOF'

---

## Session Notes

### Session - $(date +%Y-%m-%d)

**Accomplishments**:
- Enhanced with Agent Success Pack framework
- Ready for structured progress tracking

**Next Session**:
- Begin tracking progress systematically
- Use this file at start of each session

ENHANCE_EOF
            fi
            ;;
        "IMPLEMENTATION_CHECKLIST.md")
            # Check if Phase 0 exists
            if ! grep -q "Phase 0" "$filepath" 2>/dev/null; then
                echo -e "${BLUE}→${NC} Adding Phase 0: Foundation template"
                cat >> "$filepath" <<'ENHANCE_EOF'

---

## Phase 0: Foundation & Quality Infrastructure

**Goal**: Set up enterprise-grade development environment and tooling.

### 0.1 Project Setup

- [ ] Configure development environment
- [ ] Set up version control
- [ ] Install dependencies

### 0.2 Quality Tools

- [ ] Configure linting (ESLint)
- [ ] Set up formatting (Prettier)
- [ ] Configure git hooks

**Deliverable**: Fully configured development environment

ENHANCE_EOF
            fi
            ;;
        "ARCHITECTURE_DECISIONS.md")
            # Check if ADR format explanation exists
            if ! grep -q "What are ADRs" "$filepath" 2>/dev/null; then
                echo -e "${BLUE}→${NC} Adding ADR format explanation"
                sed -i.tmp '1,/^# /a\
\
This file tracks significant technical decisions using ADR (Architecture Decision Record) format.\
\
## What are ADRs?\
\
Architecture Decision Records document:\
- **What** decision was made\
- **Why** it was made\
- **What alternatives** were considered\
- **What consequences** it has\
\
---\
' "$filepath"
                rm -f "$filepath.tmp"
            fi
            ;;
    esac

    echo -e "${GREEN}✓${NC} Enhanced $filename"
}

# Create basic CLAUDE.md
if create_file_safe "$PROJECT_ROOT/CLAUDE.md"; then
    if [ "$MERGE_MODE" = true ]; then
        enhance_file "$PROJECT_ROOT/CLAUDE.md"
    else
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
    fi
fi

# Create basic IMPLEMENTATION_CHECKLIST.md
if create_file_safe "$PROJECT_ROOT/IMPLEMENTATION_CHECKLIST.md"; then
    if [ "$MERGE_MODE" = true ]; then
        enhance_file "$PROJECT_ROOT/IMPLEMENTATION_CHECKLIST.md"
    else
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
    fi
fi

# Create ARCHITECTURE_DECISIONS.md
if create_file_safe "$PROJECT_ROOT/ARCHITECTURE_DECISIONS.md"; then
    if [ "$MERGE_MODE" = true ]; then
        enhance_file "$PROJECT_ROOT/ARCHITECTURE_DECISIONS.md"
    else
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
    fi
fi

# Copy quality tool configs if requested
if [[ "$INSTALL_PRETTIER" =~ ^[Yy]$ ]]; then
    if [ -f "$PACK_ROOT/templates/configs/.prettierrc" ]; then
        if create_file_safe "$PROJECT_ROOT/.prettierrc"; then
            cp "$PACK_ROOT/templates/configs/.prettierrc" "$PROJECT_ROOT/"
            echo -e "${GREEN}✓${NC} Copied .prettierrc"
        fi
    fi
    if [ -f "$PACK_ROOT/templates/configs/.prettierignore" ]; then
        if create_file_safe "$PROJECT_ROOT/.prettierignore"; then
            cp "$PACK_ROOT/templates/configs/.prettierignore" "$PROJECT_ROOT/"
            echo -e "${GREEN}✓${NC} Copied .prettierignore"
        fi
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
