# Advanced Configuration

## Custom Slash Commands

Create custom slash commands in `.claude/commands/`:

```bash
mkdir -p .claude/commands
```

Example: `.claude/commands/review-security.md`
```markdown
---
title: Security Review
description: Review code for security vulnerabilities
---

Review the current codebase for security vulnerabilities including:
- SQL injection risks
- XSS vulnerabilities
- Authentication issues
- Authorization problems
- Data exposure risks

Provide detailed findings with severity levels and remediation steps.
```

Usage: `/review-security`

## Custom Agents

Create specialized agents in `.claude/agents/`:

```bash
mkdir -p .claude/agents
```

Example: `.claude/agents/api-specialist.md`
```markdown
---
name: API Specialist
description: Expert in API design and implementation
model: claude-sonnet-4-5-20250929
---

You are an API design specialist. Focus on:
- RESTful API best practices
- GraphQL schema design
- API documentation
- Error handling
- Rate limiting
- Authentication/Authorization
```

Usage: `@api-specialist` or `/agents`

## Hooks

Create hooks in `.claude/hooks/`:

```bash
mkdir -p .claude/hooks
```

Example: `.claude/hooks/pre-tool-use.sh`
```bash
#!/bin/bash
# Prevent operations on sensitive directories

COMMAND=$(cat | jq -r '.tool_input.command')
BLOCKED="node_modules|\\.env|__pycache__|\\.git/|dist/|build/"

if echo "$COMMAND" | grep -qE "$BLOCKED"; then
    echo "ERROR: Blocked directory pattern" >&2
    exit 2
fi
```

Configure in `.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": {
      "Bash": ".claude/hooks/pre-tool-use.sh"
    }
  }
}
```

## Environment Variables

### Model Selection
```bash
export ANTHROPIC_MODEL="claude-sonnet-4-5-20250929"
export ANTHROPIC_DEFAULT_SONNET_MODEL="claude-sonnet-4-5-20250929"
export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-opus-4-20250514"
```

### Timeouts
```bash
export BASH_DEFAULT_TIMEOUT_MS=120000  # 2 minutes
export BASH_MAX_TIMEOUT_MS=600000      # 10 minutes
export MCP_TIMEOUT=30000               # 30 seconds
export MCP_TOOL_TIMEOUT=60000          # 60 seconds
```

### Debugging
```bash
export ANTHROPIC_LOG=debug
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true
```

### Proxy
```bash
export HTTP_PROXY=http://proxy:8080
export HTTPS_PROXY=http://proxy:8080
export NO_PROXY=localhost,127.0.0.1
```

## Permission Management

### Auto-approve specific tools
In `.claude/settings.json`:
```json
{
  "allowedTools": [
    "Bash(npm install:*)",
    "Bash(git status:*)",
    "Bash(git diff:*)",
    "Read",
    "Write",
    "Edit",
    "Glob",
    "Grep"
  ]
}
```

### Block specific patterns
```json
{
  "ignorePatterns": [
    "node_modules/**",
    ".git/**",
    "*.env*",
    "secrets/**",
    "dist/**"
  ]
}
```

## Status Line Customization

```bash
/statusline
```

Add your shell prompt to Claude Code for context about:
- Current directory
- Git branch
- Node version
- Custom variables

## Output Styles

Create custom output styles in `.claude/output-styles/`:

```markdown
---
name: concise
description: Minimal, concise responses
---

Provide extremely concise responses:
- Use bullet points
- No explanations unless asked
- Show code, not talk about it
- Maximum brevity
```

Use: Select via `/config` or specify in conversations

## Project-level Settings

Create `.claude/settings.json` in your project:
```json
{
  "allowedTools": ["Bash(npm:*)"],
  "ignorePatterns": ["*.test.ts"],
  "customPrompt": "This is a TypeScript project using React and Next.js"
}
```

Commit this file to share settings with your team!

## Vim Mode

Enable vim keybindings:
```
/vim
```

Or in settings:
```json
{
  "vim": true
}
```

## Thinking Mode

Always enable thinking:
```json
{
  "thinking": {
    "enabled": true
  }
}
```

Or trigger per-message:
- "think about this problem"
- "ultrathink this architecture"

## Integration with IDEs

### VS Code
Install the Claude Code extension from the VS Code marketplace.

### Other IDEs
Set environment variable:
```bash
export CLAUDE_CODE_AUTO_CONNECT_IDE=true
```
