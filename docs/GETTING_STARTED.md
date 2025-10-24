# Getting Started with Agent Success Pack

This guide will walk you through adding Agent Success Pack to your project and customizing it for your needs.

---

## Table of Contents

1. [Installation](#installation)
2. [Running the Init Script](#running-the-init-script)
3. [Understanding Generated Files](#understanding-generated-files)
4. [Customizing Templates](#customizing-templates)
5. [Working with AI Assistants](#working-with-ai-assistants)
6. [Daily Workflow](#daily-workflow)
7. [Troubleshooting](#troubleshooting)

---

## Installation

### Option 1: Add to Existing Project (Recommended)

```bash
# Navigate to your project root
cd your-project

# Add as git submodule
git submodule add https://github.com/gserafini/agent-success-pack.git .agent-success-pack

# Run initialization
cd .agent-success-pack
./scripts/init.sh
```

### Option 2: Create New Project

```bash
# Clone the framework
git clone https://github.com/gserafini/agent-success-pack.git
cd agent-success-pack

# Create new project
./scripts/scaffold.sh ../my-new-project
cd ../my-new-project
```

---

## Running the Init Script

The `init.sh` script will ask you questions about your project and generate customized documentation.

### Interactive Prompts

```bash
./scripts/init.sh
```

You'll be asked:

1. **Project Name** (e.g., "My Awesome App")
   - Used in all document headers
   - Sets the tone for documentation

2. **Project Type**
   - `web-app`: Full-stack web application
   - `api-service`: Backend API/microservice
   - `mobile-app`: Mobile application (iOS/Android)
   - `library`: NPM package or library
   - `cli-tool`: Command-line tool
   - `custom`: Custom project type

3. **Tech Stack** (e.g., "Next.js 16, Supabase, TypeScript")
   - Helps AI understand your environment
   - Included in Claude.md and other docs

4. **AI Assistants** (select all that apply)
   - Claude Code
   - GitHub Copilot
   - Cursor
   - Other

5. **Quality Tools Setup**
   - Install ESLint?
   - Install Prettier?
   - Set up Husky hooks?
   - Configure TypeScript strict mode?

### What Gets Generated

After running `init.sh`, you'll have:

```text
your-project/
├── .agent-success-pack/         # Framework submodule
├── PROGRESS.md                   # Session tracking
├── IMPLEMENTATION_CHECKLIST.md  # Phase-based tasks
├── ARCHITECTURE_DECISIONS.md    # Decision log
├── PRODUCT_REQUIREMENTS.md      # Features & requirements
├── TECHNICAL_ARCHITECTURE.md    # Tech details
├── CLAUDE.md                     # Claude Code quick reference
├── SETUP_GUIDE.md                # Environment setup
├── TESTING_STRATEGY.md           # Testing approach
├── DEPLOYMENT_GUIDE.md           # Deploy procedures
├── .github/
│   └── copilot-instructions.md  # Copilot guidance
├── .prettierrc                   # (if selected)
├── .prettierignore              # (if selected)
├── .husky/                       # (if selected)
│   └── pre-commit
└── ... (your existing files)
```

---

## Understanding Generated Files

### PROGRESS.md

**Purpose**: Track sessions, progress, blockers, and goals

**When to use**:
- Start of each session (read to understand current state)
- End of each session (update with accomplishments)
- When stuck (document blockers)

**Structure**:
- Quick Status (visual progress table)
- Current Session Progress
- Completed tasks
- In Progress tasks
- Blockers
- Metrics
- Session Notes

### IMPLEMENTATION_CHECKLIST.md

**Purpose**: Detailed, testable task breakdown

**When to use**:
- Planning implementation phases
- Breaking down large features
- Ensuring nothing is forgotten
- Reviewing with team/stakeholders

**Structure**:
- Organized by phases (0, 1, 2, etc.)
- Each phase has sub-tasks
- Checkboxes for completion tracking
- Acceptance criteria for each task
- Review points for demos

### ARCHITECTURE_DECISIONS.md

**Purpose**: Record **why** decisions were made

**When to use**:
- Before making significant technical decisions
- When choosing between multiple options
- When future you/team needs context

**ADR Format**:
```markdown
## ADR-XXX: Decision Title

**Date**: 2025-10-23
**Status**: Proposed | Accepted | Deprecated | Superseded
**Deciders**: Names
**Tags**: relevant, tags

### Context
What's the situation? What problem are we solving?

### Decision
What did we decide?

### Options Considered
- Option A: Pros, Cons
- Option B: Pros, Cons
- Option C: Pros, Cons

### Rationale
Why did we choose this option?

### Consequences
**Positive**: Benefits
**Negative**: Tradeoffs
```

### CLAUDE.md

**Purpose**: Quick reference for Claude Code

**When to use**:
- AI assistant reads this at session start
- Reference during development
- Update when patterns change

**Contains**:
- Project context
- Tech stack
- File structure
- Development patterns
- Common commands
- Important guidelines

---

## Customizing Templates

All templates support variable replacement:

### Available Variables

- `{{PROJECT_NAME}}` - Your project name
- `{{PROJECT_TYPE}}` - web-app, api-service, etc.
- `{{TECH_STACK}}` - Your technology choices
- `{{TODAY_DATE}}` - Current date
- `{{AUTHOR}}` - Your name
- `{{EMAIL}}` - Your email

### Example Customization

**Before (template)**:
```markdown
# {{PROJECT_NAME}} - Progress

**Tech Stack**: {{TECH_STACK}}
**Type**: {{PROJECT_TYPE}}
```

**After (generated)**:
```markdown
# My Awesome App - Progress

**Tech Stack**: Next.js 16, Supabase, TypeScript
**Type**: Full-stack web application
```

### Optional Sections

Templates mark optional sections:

```markdown
## Optional: Mobile Configuration

<!-- REMOVE IF NOT MOBILE APP -->

Mobile-specific content here

<!-- END OPTIONAL -->
```

**To customize**:
1. Remove optional sections if not needed
2. Modify examples to match your project
3. Add custom sections as needed

---

## Working with AI Assistants

### Claude Code

**Setup**:
1. Generated `CLAUDE.md` is your quick reference
2. Update with project-specific patterns
3. Claude reads this at session start

**Best Practices**:
- Start each session: "Read CLAUDE.md and PROGRESS.md"
- Use TodoWrite tool for task tracking
- Reference ADRs when making decisions
- Update PROGRESS.md at end of session

**Example Session**:
```text
You: Read CLAUDE.md and PROGRESS.md. What's next on our checklist?

Claude: Based on PROGRESS.md, we're in Phase 2: Database Setup.
        The next task is creating the resources table. Let me...
```

### GitHub Copilot

**Setup**:
1. Generated `.github/copilot-instructions.md`
2. Copilot reads this automatically in workspace
3. Update with your coding standards

**Best Practices**:
- Keep instructions focused and specific
- Include code examples
- Update after establishing new patterns
- Reference from commit messages

---

## Daily Workflow

### Starting a Session

```bash
# 1. Open your editor
code .

# 2. Tell AI to read context
# In Claude Code:
"Read CLAUDE.md and PROGRESS.md. What should we work on next?"

# 3. Review the current phase
# Check IMPLEMENTATION_CHECKLIST.md for current phase
```

### During Development

```bash
# Commit frequently (every 15-30 min)
git add .
git commit -m "feat: implement user authentication"

# Pre-commit hooks run automatically:
# - ESLint
# - Prettier
# - Tests (if configured)
```

### Ending a Session

```bash
# 1. Update PROGRESS.md
# - Mark completed tasks
# - Note any blockers
# - Update metrics
# - Add session notes

# 2. Commit documentation
git add PROGRESS.md IMPLEMENTATION_CHECKLIST.md
git commit -m "docs: update progress - completed Phase 2.1"

# 3. Push changes
git push
```

### Weekly Review

```bash
# 1. Review PROGRESS.md metrics
# - Tasks completed
# - Blockers encountered
# - Weekly goals status

# 2. Update IMPLEMENTATION_CHECKLIST.md
# - Check off completed phases
# - Add new tasks discovered

# 3. Plan next week
# - Set weekly goals in PROGRESS.md
# - Prioritize checklist items
```

---

## Troubleshooting

### Init Script Issues

**Problem**: `init.sh: Permission denied`

**Solution**:
```bash
chmod +x .agent-success-pack/scripts/*.sh
```

---

**Problem**: Variables not replaced in templates

**Solution**:
- Ensure you answered all prompts
- Check for typos in variable names
- Re-run init.sh if needed

---

### Git Submodule Issues

**Problem**: Submodule not cloning

**Solution**:
```bash
git submodule update --init --recursive
```

---

**Problem**: Can't update submodule

**Solution**:
```bash
cd .agent-success-pack
git pull origin main
cd ..
git add .agent-success-pack
git commit -m "chore: update agent-success-pack"
```

---

### AI Assistant Issues

**Problem**: AI not following patterns

**Solution**:
- Check CLAUDE.md is up to date
- Explicitly reference in prompts
- Add specific examples to documentation

---

**Problem**: AI loses context mid-session

**Solution**:
- Break into smaller tasks
- Use TodoWrite to track state
- Reference PROGRESS.md regularly

---

## Next Steps

1. ✅ Complete initialization
2. 📖 Read through generated documentation
3. ✏️ Customize templates for your project
4. 🎯 Define Phase 0 in IMPLEMENTATION_CHECKLIST.md
5. 🚀 Start building with clear context!

---

## Additional Resources

- [Customization Guide](CUSTOMIZATION_GUIDE.md) - Deep dive into customization
- [Philosophy](PHILOSOPHY.md) - Why this approach works
- [Examples](../examples/) - Real-world project examples

---

**Need help?** Open an issue on [GitHub](https://github.com/gserafini/agent-success-pack/issues)
