# Customization Guide

How to customize Agent Success Pack for your specific project needs.

---

## Template Variables

All templates support variable replacement during initialization:

### Built-in Variables

- `{{PROJECT_NAME}}` - Your project name
- `{{PROJECT_TYPE}}` - Type of project (web-app, API, etc.)
- `{{TECH_STACK}}` - Your technology choices
- `{{AUTHOR}}` - Your name
- `{{EMAIL}}` - Your email
- `{{TODAY_DATE}}` - Current date (YYYY-MM-DD format)

### Example

**Template**:
```markdown
# {{PROJECT_NAME}} - Setup Guide

**Author**: {{AUTHOR}}
**Stack**: {{TECH_STACK}}
```

**After init**:
```markdown
# Reentry Map - Setup Guide

**Author**: Gabriel Serafini
**Stack**: Next.js 16, Supabase, TypeScript
```

---

## Customizing Generated Files

After running `init.sh`, you can customize any generated file:

### PROGRESS.md

**Add custom sections**:
```markdown
## Custom Metrics

- **API Calls**: 0
- **Active Users**: 0
- **Data Quality Score**: N/A
```

**Track project-specific metrics**:
```markdown
## Resource Database

- **Total Resources**: 50
- **Verified**: 45 (90%)
- **Pending Verification**: 5
```

### IMPLEMENTATION_CHECKLIST.md

**Add project-specific phases**:
```markdown
## Phase 5: AI Agent Integration

### 5.1 Discovery Agent
- [ ] Implement web scraping
- [ ] Set up OpenAI integration
- [ ] Create enrichment pipeline

### 5.2 Verification Agent
- [ ] Phone number validation
- [ ] Website availability checks
- [ ] Business status verification
```

### CLAUDE.md

**Add project-specific patterns**:
```typescript
// Supabase client pattern
import { createClient } from '@/lib/supabase/server'

export async function getData() {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('table')
    .select('*')

  if (error) throw error
  return data
}
```

---

## Creating Custom Templates

You can add your own templates to the framework:

### 1. Create Template File

```bash
# Add to templates directory
touch .agent-success-pack/templates/development/MY_CUSTOM_DOC.md.template
```

### 2. Use Template Variables

```markdown
# {{PROJECT_NAME}} - Custom Documentation

This is a custom template for {{PROJECT_TYPE}} projects.

**Stack**: {{TECH_STACK}}
**Author**: {{AUTHOR}}
```

### 3. Modify init.sh

Add generation logic to `init.sh`:

```bash
# In init.sh
if [ -f "$PACK_ROOT/templates/development/MY_CUSTOM_DOC.md.template" ]; then
    replace_vars "$PACK_ROOT/templates/development/MY_CUSTOM_DOC.md.template" \
        > "$PROJECT_ROOT/MY_CUSTOM_DOC.md"
    echo -e "${GREEN}✓${NC} Created MY_CUSTOM_DOC.md"
fi
```

---

## Project Type Customization

Different project types need different templates:

### Web Application

Focus on:
- Frontend components
- API routes
- Database schema
- Authentication flow
- Deployment pipeline

### API Service

Focus on:
- Endpoint documentation
- Request/response schemas
- Error handling
- Rate limiting
- API versioning

### Mobile App

Focus on:
- Platform-specific code
- Offline support
- Push notifications
- App store deployment
- Beta testing

### NPM Library

Focus on:
- Public API design
- Documentation for users
- Versioning strategy
- Breaking change management
- Publishing workflow

---

## Quality Tool Configuration

### ESLint

Create custom rules:

```javascript
// eslint.config.mjs
export default [
  {
    rules: {
      // Your custom rules
      'no-console': 'error',
      '@typescript-strict/no-any': 'error'
    }
  }
]
```

### Prettier

Customize formatting:

```json
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "printWidth": 100,
  "trailingComma": "es5"
}
```

### Git Hooks

Add custom hooks:

```bash
# .husky/pre-push
#!/bin/sh
npm test
npm run build
```

---

## AI Assistant Customization

### Claude Code

Add project-specific instructions to CLAUDE.md:

```markdown
## Critical Patterns

### Error Handling
Always use this pattern:
\`\`\`typescript
try {
  const result = await operation()
  return { data: result, error: null }
} catch (error) {
  console.error('Operation failed:', error)
  return { data: null, error: error.message }
}
\`\`\`

### Testing
Every component must have:
- Unit tests for logic
- Integration tests for API calls
- E2E tests for critical paths
```

### GitHub Copilot

Create `.github/copilot-instructions.md`:

```markdown
# Copilot Instructions

## Code Style

- Use async/await over promises
- Prefer const over let
- Always destructure props in components

## Testing

- Write tests alongside code
- Use describe/it blocks
- Mock external dependencies

## Imports

- Use absolute imports from @/
- Group by: external, internal, types
```

---

## Workflow Customization

### Daily Workflow

Modify to fit your process:

```markdown
## My Daily Workflow

1. Pull latest changes
2. Read PROGRESS.md
3. Pick next task from IMPLEMENTATION_CHECKLIST.md
4. Work in focused 25-min sessions (Pomodoro)
5. Commit after each completed subtask
6. Update PROGRESS.md at end of day
```

### Session Template

Create your own session notes format:

```markdown
## Session - {{DATE}}

**Time**: {{START_TIME}} - {{END_TIME}}
**Goal**: {{SESSION_GOAL}}

### What I Did
- Item 1
- Item 2

### What I Learned
- Learning 1
- Learning 2

### Tomorrow
- [ ] Task 1
- [ ] Task 2
```

---

## Examples

### E-commerce Project

```markdown
## Phase 3: Shopping Cart

- [ ] Add to cart functionality
- [ ] Cart persistence
- [ ] Inventory management
- [ ] Checkout flow
```

### SaaS Application

```markdown
## Phase 4: Billing

- [ ] Stripe integration
- [ ] Subscription management
- [ ] Usage tracking
- [ ] Invoice generation
```

### Mobile Game

```markdown
## Phase 2: Game Mechanics

- [ ] Player movement
- [ ] Collision detection
- [ ] Score tracking
- [ ] Power-ups
```

---

## Advanced: Forking the Framework

For heavily customized needs:

### 1. Fork the Repository

```bash
gh repo fork gserafini/agent-success-pack
```

### 2. Modify Templates

Customize all templates to your organization's standards.

### 3. Update init.sh

Add organization-specific logic.

### 4. Use Your Fork

```bash
git submodule add https://github.com/yourorg/agent-success-pack.git .agent-success-pack
```

---

## Need Help?

- Check [GETTING_STARTED.md](GETTING_STARTED.md)
- Read [PHILOSOPHY.md](PHILOSOPHY.md)
- Open an [issue](https://github.com/gserafini/agent-success-pack/issues)

---

**Make it yours!**
