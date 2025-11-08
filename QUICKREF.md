# Quick Reference Guide

## Essential Commands

### Claude Code Basics
```bash
claude                    # Start interactive session
claude --help            # Show help
claude --version         # Show version
claude --print "prompt"  # One-off command (non-interactive)
claude --continue        # Resume last session
```

### Slash Commands
```bash
/help                    # Get help
/mcp                     # Manage MCP servers
/plugin                  # Manage plugins
/model                   # Select model (Sonnet, Opus, Haiku)
/permissions             # Manage tool permissions
/agents                  # List/manage custom agents
/login                   # Login/change account
/status                  # Check system status
/clear                   # Clear conversation
/export                  # Export conversation
```

### Mode Switching
```bash
Shift + Tab              # Toggle auto-accept mode
Tab                      # Toggle thinking display
Ctrl + B                 # Background command
Ctrl + R                 # View full transcript
Ctrl + G                 # Edit in system editor
```

### File Operations
```bash
@file.txt                # @-mention a file
@folder/                 # @-mention a directory
Tab                      # Auto-complete file paths
```

## MCP Server Commands

### Managing Servers
```bash
claude mcp list                              # List all servers
claude mcp add --transport http name url     # Add HTTP server
claude mcp add --transport stdio name cmd    # Add stdio server
claude mcp remove name                       # Remove server
claude mcp add-from-claude-desktop          # Import from Claude Desktop
```

### In-Session Commands
```bash
/mcp                     # View/manage servers
@servername              # Toggle server on/off
```

## Plugin Commands

```bash
/plugin                                      # List plugins
/plugin install <name>                       # Install plugin
/plugin remove <name>                        # Remove plugin
/plugin enable <name>                        # Enable plugin
/plugin disable <name>                       # Disable plugin
/plugin marketplace add <url>                # Add marketplace
/plugin marketplace remove <name>            # Remove marketplace
/plugin validate                             # Validate plugins
```

## Common Tasks

### Start a New Feature
```
"Create a new branch called feature/user-settings"
"I need to add user settings functionality with these requirements: ..."
```

### Review Code
```
"Review my uncommitted changes for bugs and improvements"
"Check this PR for security issues"
```

### Generate Tests
```
/generate-tests src/components/Button.tsx
"Write unit tests for the login function"
```

### Debug Issues
```
"Help me debug this error: [paste error]"
"Why isn't this component rendering?"
```

### Refactor Code
```
"Refactor this component to use hooks"
"Improve the performance of this function"
```

### Work with MCP (Rube)
```
"Send an email via Gmail to john@example.com"
"Create a Notion task: Review PR"
"Check my Slack mentions"
"Create a GitHub issue for the login bug"
```

### Get Documentation (Context7)
```
"Show me Next.js App Router documentation"
"Get React useEffect examples"
"Find Supabase auth documentation"
```

## Thinking Mode Triggers

```
"think about this problem"
"think harder"
"ultrathink this architecture"
```

## Environment Variables

### Setup (Recommended)
```bash
# Use project-level .env file (gitignored, persistent)
cp .env.example .env
nano .env  # Add your API key

# Or add to ~/.bashrc / ~/.zshrc for system-wide access
export ANTHROPIC_API_KEY="your-key"
export ANTHROPIC_MODEL="claude-sonnet-4-5-20250929"
```

### Essential Variables
```bash
ANTHROPIC_API_KEY=your-key
ANTHROPIC_MODEL=claude-sonnet-4-5-20250929
```

### Optional Variables
```bash
BASH_DEFAULT_TIMEOUT_MS=120000        # Bash timeout (2 min)
MCP_TIMEOUT=30000                     # MCP server timeout (30s)
ANTHROPIC_LOG=debug                   # Enable debug logging
CLAUDE_CODE_AUTO_CONNECT_IDE=true     # Auto-connect to IDE
```

See [docs/env-setup.md](docs/env-setup.md) for detailed setup guide.

## Keyboard Shortcuts

### Input
- `Ctrl + C` - Interrupt Claude
- `Ctrl + D` - Exit
- `Ctrl + R` - Search history / View transcript
- `Ctrl + G` - Edit in external editor
- `Ctrl + B` - Run command in background
- `Ctrl + Z` - Undo input (before sending)
- `Enter` - Send message (or queue if Claude is working)

### Navigation (Vim mode enabled)
- `h/j/k/l` - Navigate
- `w/b` - Word movement
- `0/$` - Line start/end
- `dd` - Delete line
- `u` - Undo

### Menu Navigation
- `↑/↓` or `j/k` - Navigate items
- `Enter` - Select
- `Esc` - Cancel

## File Patterns

### Allowed Tools (settings.json)
```json
{
  "allowedTools": [
    "Bash(npm:*)",
    "Bash(git status:*)",
    "Read",
    "Write",
    "Edit"
  ]
}
```

### Ignore Patterns (settings.json)
```json
{
  "ignorePatterns": [
    "node_modules/**",
    ".git/**",
    "*.env*",
    "dist/**"
  ]
}
```

## Quick Troubleshooting

### Claude is slow
- Check thinking mode (Tab to toggle)
- Use Haiku model for faster responses: `/model` → Haiku
- Reduce context by clearing: `/clear`

### MCP server not working
1. Check status: `/mcp`
2. Restart Claude Code
3. Re-authenticate: `/mcp` → select server → Enter

### Permission denied
1. Review permissions: `/permissions`
2. Approve specific tool patterns
3. Or use auto-accept mode: `Shift + Tab`

### API errors
1. Check key: `echo $ANTHROPIC_API_KEY`
2. Re-login: `/login`
3. Check status: `/status`

### Files not loading
1. Check ignore patterns in settings
2. Try explicit @-mention
3. Check file permissions

## Tips & Tricks

1. **Queue messages**: Press Enter while Claude works to queue next message
2. **Background commands**: Ctrl+B for long-running commands (dev servers, etc.)
3. **Real-time steering**: Send messages while Claude works to guide it
4. **File context**: @-mention files before asking questions about them
5. **Thinking for architecture**: Use "ultrathink" for complex design decisions
6. **Save contexts**: Create .claude/CLAUDE.md for project-specific instructions
7. **Share config**: Commit .claude/settings.json and .mcp.json for team
8. **Custom commands**: Add .md files to .claude/commands/ for slash commands
9. **Keyboard navigation**: Use j/k in menus for faster navigation
10. **Auto-complete**: Press Tab for file/folder suggestions

## Getting Help

- `/help` - In-app help
- [Documentation](https://docs.claude.com/en/docs/claude-code)
- [GitHub Issues](https://github.com/anthropics/claude-code/issues)
- [MCP Protocol](https://modelcontextprotocol.io/)

## Version Info

This quickstart is configured for:
- Claude Code 2.0+
- Sonnet 4.5 (claude-sonnet-4-5-20250929)
- Rube MCP Server (beta)
- Context7 MCP Server
