#!/bin/bash

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Header
echo ""
echo "========================================="
echo "   Claude Code Quickstart Setup"
echo "========================================="
echo ""

# Check if Claude Code is installed
print_status "Checking for Claude Code installation..."
if ! command -v claude &> /dev/null; then
    print_error "Claude Code is not installed!"
    echo ""
    echo "Please install Claude Code first:"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
    exit 1
fi
print_success "Claude Code is installed"

# Check for API key or login
print_status "Checking authentication..."
if [ -z "$ANTHROPIC_API_KEY" ]; then
    print_warning "ANTHROPIC_API_KEY not found in environment"
    echo ""
    echo "You'll need to either:"
    echo "  1. Set ANTHROPIC_API_KEY environment variable"
    echo "  2. Login via 'claude /login' after setup"
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    print_success "API key found"
fi

echo ""
print_status "Installing MCP Servers..."
echo ""

# Install Rube MCP Server
print_status "Adding Rube MCP Server..."
if claude mcp add --transport http rube -s user "https://rube.app/mcp" 2>/dev/null; then
    print_success "Rube MCP Server added"
else
    print_warning "Rube MCP Server may already be installed or failed to add"
fi

print_warning "Note: You'll need to authenticate Rube after first launch"
echo "  1. Run 'claude'"
echo "  2. Type '/mcp'"
echo "  3. Select 'rube' and complete OAuth flow"
echo ""

# Create config directories
print_status "Creating configuration directories..."
mkdir -p config examples docs
print_success "Directories created"

# Create settings template
print_status "Creating configuration templates..."
cat > config/settings.template.json << 'EOF'
{
  "allowedTools": [
    "Bash(npm install:*)",
    "Bash(git:*)",
    "Bash(echo:*)",
    "Bash(node:*)",
    "Read",
    "Write",
    "Edit",
    "Glob",
    "Grep"
  ],
  "ignorePatterns": [
    "node_modules/**",
    ".git/**",
    "dist/**",
    "build/**",
    ".env*",
    "*.log"
  ],
  "autoCompact": true,
  "todoFeatureEnabled": true,
  "thinking": {
    "enabled": true
  }
}
EOF

# Create MCP template
cat > config/mcp.template.json << 'EOF'
{
  "mcpServers": {
    "rube": {
      "type": "http",
      "url": "https://rube.app/mcp"
    }
  }
}
EOF

print_success "Configuration templates created"

# Create example files
print_status "Creating example documentation..."

cat > examples/rube-examples.md << 'EOF'
# Rube MCP Server Examples

## Email (Gmail)
- "Send an email to john@example.com with subject 'Meeting' and body 'Let's meet tomorrow'"
- "Check my latest emails"
- "Reply to the last email from john@example.com"

## Task Management (Notion, Asana, Trello)
- "Create a task in Notion: 'Review PR #123'"
- "Add a card to my Trello board: 'Bug fix for login'"
- "List my tasks for today"

## Communication (Slack)
- "Send a message to #engineering channel: 'Deploy complete'"
- "Check my Slack mentions"
- "React to the last message with thumbs up"

## GitHub
- "Create a GitHub issue: 'Bug in authentication'"
- "List my open pull requests"
- "Comment on PR #456: 'LGTM'"

## Calendar (Google Calendar)
- "Schedule a meeting tomorrow at 2pm for 1 hour"
- "What's on my calendar today?"
- "Cancel my 3pm meeting"

## File Storage (Google Drive, Dropbox)
- "Upload this file to Google Drive"
- "List files in my Documents folder"
- "Share document.pdf with john@example.com"
EOF

cat > examples/workflow-examples.md << 'EOF'
# Development Workflow Examples

## Test Generation
```bash
# Generate tests for a specific file
/generate-tests src/components/Button.tsx

# Generate tests for a component
/generate-tests Button
```

## Git Workflow
```
# Review changes before commit
"Show me all uncommitted changes"

# Create a feature branch
"Create a new branch called feature/user-auth"

# Review and commit
"Review my changes and create a commit with an appropriate message"
```

## Performance Optimization
```
# Analyze performance
"Analyze the performance of this component and suggest improvements"

# Optimize code
"Optimize this function for better performance"
```

## Code Review
```
# Review PR
"Review this pull request for security issues and best practices"

# Check code quality
"Check this code for potential bugs and suggest improvements"
```

## Documentation
```
# Generate docs
"Generate documentation for this API endpoint"

# Create README
"Create a comprehensive README for this project"
```
EOF

# Create documentation files
cat > docs/mcp-servers.md << 'EOF'
# MCP Server Documentation

## Rube

**Type**: HTTP
**URL**: https://rube.app/mcp
**Status**: Free during beta

### Features
- 500+ app integrations
- OAuth 2.1 authentication
- End-to-end encryption
- Multi-step workflows
- Team credential sharing

### Supported Apps Categories
- **Email**: Gmail, Outlook
- **Communication**: Slack, Discord, Teams
- **Project Management**: Notion, Asana, Trello, Jira
- **Code**: GitHub, GitLab, Bitbucket
- **Storage**: Google Drive, Dropbox, OneDrive
- **Calendar**: Google Calendar, Outlook Calendar
- **CRM**: Salesforce, HubSpot
- **Analytics**: Google Analytics
- And 490+ more...

### Setup
1. Add server: `claude mcp add --transport http rube -s user "https://rube.app/mcp"`
2. Start Claude Code: `claude`
3. Authenticate: `/mcp` → select rube → complete OAuth
4. Start using: "Send an email via Gmail"

## Context7

**Purpose**: Library documentation and code examples

### Features
- Up-to-date documentation for popular libraries
- Code snippets and examples
- Version-specific docs
- Search by topic

### Tools
- `resolve-library-id`: Find the correct library ID
- `get-library-docs`: Fetch documentation for a library

### Usage
```
"Show me Next.js routing documentation"
"Get React hooks examples"
"Find MongoDB aggregation syntax"
```

## Adding More MCP Servers

### From Claude Desktop
```bash
claude mcp add-from-claude-desktop
```

### Manually
```bash
# HTTP server
claude mcp add --transport http <name> -s user "<url>"

# Stdio server
claude mcp add --transport stdio <name> -s user "<command>"
```

### Project-level MCP (team sharing)
Create `.mcp.json` in your project root:
```json
{
  "mcpServers": {
    "custom-server": {
      "type": "http",
      "url": "https://your-server.com/mcp"
    }
  }
}
```

Commit this file to share with your team!
EOF

cat > docs/plugins.md << 'EOF'
# Plugin Documentation

## Installed Plugins

### git-workflow
Enhanced Git operations and workflow automation.

**Features**:
- Automated commit message generation
- Branch management
- PR creation and review
- Git hooks integration

### supabase-toolkit
Supabase database and auth integration tools.

**Features**:
- Database schema management
- Query builder assistance
- Auth setup and configuration
- Real-time subscription helpers

### performance-optimizer
Code performance analysis and optimization tools.

**Features**:
- Bundle size analysis
- Runtime performance profiling
- Optimization suggestions
- Memory leak detection

### testing-suite
Comprehensive testing utilities and generators.

**Features**:
- Test generation (`/generate-tests`)
- Test coverage analysis
- Mock generation
- Test running and reporting

### claude-code-templates (Marketplace)
Template marketplace with ready-to-use patterns.

**Features**:
- Project templates
- Component templates
- Configuration templates
- Boilerplate code

## Managing Plugins

### View installed plugins
```
/plugin
```

### Install a plugin
```
/plugin install <plugin-name>
```

### Add a marketplace
```
/plugin marketplace add <url>
```

### Remove a plugin
```
/plugin remove <plugin-name>
```

### Enable/Disable plugins
Plugins can be enabled or disabled via `/plugin` interface

## Creating Custom Plugins

See: https://docs.claude.com/en/docs/claude-code/plugins

Directory structure:
```
.claude/
└── plugins/
    └── my-plugin/
        ├── plugin.json
        ├── commands/
        ├── agents/
        └── hooks/
```
EOF

cat > docs/advanced-config.md << 'EOF'
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
EOF

print_success "Documentation created"

# Create .gitignore
print_status "Creating .gitignore..."
cat > .gitignore << 'EOF'
# Node modules
node_modules/

# Environment files
.env
.env.local
.env.*

# Logs
*.log
npm-debug.log*

# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo

# Claude Code
.claude/sessions/
.claude/.env

# Build output
dist/
build/
EOF

print_success ".gitignore created"

echo ""
echo "========================================="
print_success "Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Set up environment variables (if not already done):"
echo "   export ANTHROPIC_API_KEY=\"your-api-key\""
echo "   export ANTHROPIC_MODEL=\"claude-sonnet-4-5-20250929\""
echo ""
echo "2. Start Claude Code:"
echo "   claude"
echo ""
echo "3. Authenticate MCP servers:"
echo "   Type: /mcp"
echo "   Select: rube"
echo "   Complete: OAuth flow in browser"
echo ""
echo "4. Install plugins (inside Claude Code):"
echo "   /plugin install git-workflow"
echo "   /plugin install supabase-toolkit"
echo "   /plugin install performance-optimizer"
echo "   /plugin install testing-suite"
echo "   /plugin marketplace add https://github.com/davila7/claude-code-templates"
echo ""
echo "5. Explore examples:"
echo "   - examples/rube-examples.md"
echo "   - examples/workflow-examples.md"
echo ""
echo "6. Read documentation:"
echo "   - docs/mcp-servers.md"
echo "   - docs/plugins.md"
echo "   - docs/advanced-config.md"
echo ""
print_success "Happy coding with Claude!"
echo ""
