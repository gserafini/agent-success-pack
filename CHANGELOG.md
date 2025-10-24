# Changelog

All notable changes to Agent Success Pack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added

- **Re-initialization Detection** - Script now detects if already initialized
  - Checks for existing PROGRESS.md, CLAUDE.md, and IMPLEMENTATION_CHECKLIST.md
  - Offers 3 options when existing setup detected:
    1. Exit (keep current setup) - default, safest option
    2. Re-configure - update project settings, preserve all content
    3. Re-initialize - backup existing files, start fresh
  - Auto-creates timestamped backups (`.agent-success-pack-backup-YYYYMMDD-HHMMSS`)
  - Re-configure mode updates project name in all documentation files
  - Prevents accidental overwrites of existing work

### Changed

- Init script now safer for running multiple times
- Better user experience when adding framework to existing projects

---

## [1.1.0] - 2025-10-23

### 🎉 Major Enhancement: Intelligent Merge Mode

The init script now intelligently analyzes existing files and offers to enhance them rather than just skip or overwrite!

### Added

- **File Purpose Explanations** - Every file shows its purpose when detected
  - Helps new users understand what they're working with
  - Examples: "PROGRESS.md: Tracks your project progress, session notes, metrics, and blockers"

- **Existing File Analysis** - Automatically reads and summarizes files before prompting
  - Shows size, line count, first line preview
  - Extracts key metrics specific to file type:
    - PROGRESS.md: Current phase, overall progress
    - CLAUDE.md: Project name
    - IMPLEMENTATION_CHECKLIST.md: Phase count, task completion stats
    - ARCHITECTURE_DECISIONS.md: Number of ADRs documented

- **Intelligent Merge Mode** (Option 2) - NEW!
  - Analyzes existing file structure
  - Adds missing Agent Success Pack sections
  - Preserves ALL custom content
  - Smart enhancements:
    - CLAUDE.md: Adds framework reference if missing
    - PROGRESS.md: Adds session tracking section if missing
    - IMPLEMENTATION_CHECKLIST.md: Adds Phase 0 template if missing
    - ARCHITECTURE_DECISIONS.md: Adds ADR format explanation if missing

- **Enhanced Options** - Now 4 options instead of 3:
  1. Keep existing (default, safest - no changes)
  2. Enhance existing (NEW - intelligent merge)
  3. Backup and replace (saves .bak file)
  4. Replace without backup (explicit danger warning)

- **Better UX**:
  - Beautiful formatted output with unicode borders
  - Color-coded options (green=safe, blue=enhance, yellow=backup, red=danger)
  - Clear default shown: `[default: 1]`
  - Descriptive action messages

### Changed

- File prompts now show comprehensive information before asking for action
- Default remains option 1 (keep existing) for maximum safety
- Enhanced visual output with better formatting
- **Bootstrap Script ASCII Art** - Redesigned with cleaner layout
  - "AGENT" in large 6-line block letters (green)
  - "SUCCESS PACK" on single line with decorative brackets (yellow)
  - 56-character box width for full AGENT text
  - Perfect border alignment

### Fixed

- **CRITICAL: BSD sed compatibility** - Enhance mode now works on macOS
  - Fixed `sed` range address error ("command a expects up to 1 address")
  - Rewrote CLAUDE.md and ARCHITECTURE_DECISIONS.md enhancements for BSD sed
  - Uses single address with label loop instead of range addresses
- **ASCII Art Alignment** - Perfect border alignment across all lines
  - Consistent spacing on left and right borders
  - All content properly centered within box

### Use Cases

1. **Existing Projects**: Run init.sh and select "Enhance" to add framework benefits without losing custom content
2. **Framework Upgrades**: Update submodule and enhance files to get new features
3. **Team Onboarding**: File purpose explanations help new team members understand structure
4. **Incremental Adoption**: No longer "all or nothing" - add structure gradually

### Breaking Changes

None - all enhancements are backward compatible.

---

## [1.0.1] - 2025-10-23

### 🛡️ Critical Safety Fix

### Fixed

- **CRITICAL**: init.sh now checks if files exist before overwriting
- Added `create_file_safe()` function with 3 options:
  1. Skip (keep existing)
  2. Backup and overwrite
  3. Overwrite without backup
- Previous behavior would blindly overwrite PROGRESS.md, CLAUDE.md, etc.
- Now safe to re-run in existing projects

### Added

- File existence checks for all generated files
- Automatic .bak backup creation when requested
- User confirmation prompts

---

## [1.0.0] - 2025-10-23

### 🎉 Initial Release

Battle-tested framework extracted from production project (Reentry Map).

### Added

- **Interactive init.sh script**
  - Project details prompts (name, type, tech stack)
  - Customized documentation generation
  - Optional quality tools installation
  - Beautiful colored terminal output

- **Documentation Templates**
  - PROGRESS.md - Session tracking with metrics
  - CLAUDE.md - AI assistant quick reference
  - IMPLEMENTATION_CHECKLIST.md - Phase-based tasks
  - ARCHITECTURE_DECISIONS.md - ADR format

- **Quality Configurations**
  - Prettier config with Tailwind plugin
  - Prettier ignore file
  - Husky git hooks setup

- **Comprehensive Guides**
  - README.md - Overview, quick start, features
  - GETTING_STARTED.md - Detailed setup guide
  - PHILOSOPHY.md - Why this approach works
  - CUSTOMIZATION_GUIDE.md - How to customize

- **Framework Infrastructure**
  - Git submodule ready
  - Template variable replacement
  - Interactive prompts
  - Validation and error handling

### Philosophy

- Phase-based implementation
- Architecture Decision Records (ADRs)
- Progress tracking and session management
- AI-optimized documentation
- Quality standards from day one

---

## Future Enhancements (Planned)

- `scaffold.sh` - Create new projects from scratch
- Web UI for configuration
- More example projects (API, mobile, library)
- Additional templates (API docs, testing guides)
- Template marketplace

---

## Contributing

See issues on [GitHub](https://github.com/gserafini/agent-success-pack/issues) for planned enhancements and ways to contribute.

---

**[Unreleased]**: <https://github.com/gserafini/agent-success-pack/compare/v1.1.0...HEAD>
**[1.1.0]**: <https://github.com/gserafini/agent-success-pack/compare/v1.0.1...v1.1.0>
**[1.0.1]**: <https://github.com/gserafini/agent-success-pack/compare/v1.0.0...v1.0.1>
**[1.0.0]**: <https://github.com/gserafini/agent-success-pack/releases/tag/v1.0.0>
