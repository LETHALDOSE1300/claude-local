# Claude Code Quickstart Repository

Complete setup for Claude Code with MCP servers, plugins, and optimized configuration.

## Features

This repository includes:
- **MCP Servers**: Rube (500+ app integrations), Context7 (library documentation)
- **Plugins**: Git workflow, Supabase toolkit, Performance optimizer, Testing suite
- **Templates**: Claude Code templates marketplace
- **Custom Configuration**: Pre-configured settings for optimal development workflow

## Prerequisites

- Node.js (v18 or higher)
- npm or npx
- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- Anthropic API key or Claude subscription

## Quick Start

### 1. Clone this repository

```bash
git clone https://github.com/LETHALDOSE1300/claude-local.git
cd claude-local
```

### 2. Run the setup script

```bash
chmod +x setup.sh
./setup.sh
```

The setup script will:
- Install all MCP servers
- Install all plugins
- Configure Claude Code with optimal settings
- Set up environment variables

### 3. Start Claude Code

```bash
claude
```

## What's Included

### MCP Servers

#### Rube
- **Purpose**: Universal MCP server for 500+ business app integrations
- **URL**: https://rube.app/mcp
- **Apps**: Gmail, Slack, GitHub, Notion, and 497+ more
- **Authentication**: OAuth 2.1 with end-to-end encryption
- **Status**: Free during beta

**Usage Examples**:
- "Send an email via Gmail"
- "Create a task in Notion"
- "Check my Slack messages"
- "Create a GitHub issue"

#### Context7
- **Purpose**: Up-to-date library documentation and code examples
- **Tools**: `resolve-library-id`, `get-library-docs`

**Usage Examples**:
- "Show me Next.js documentation for routing"
- "Get React hooks examples"
- "Find MongoDB query syntax"

### Installed Plugins

1. **git-workflow** - Enhanced Git operations and automation
2. **supabase-toolkit** - Supabase integration tools
3. **performance-optimizer** - Code performance analysis and optimization
4. **testing-suite** - Comprehensive testing utilities
5. **claude-code-templates** - Template marketplace with ready-to-use patterns

### Custom Slash Commands

After setup, you'll have access to:
- `/generate-tests [file-path]` - Generate comprehensive test suites
- All standard Claude Code commands

## Configuration Files

### `.claude/settings.json`
Main configuration file with:
- Tool permissions
- Ignore patterns
- Environment variables
- Custom settings

### `.mcp.json`
Project-level MCP server configuration (shareable with team)

## Manual Setup (if script fails)

### Install MCP Servers

```bash
# Add Rube MCP Server
claude mcp add --transport http rube -s user "https://rube.app/mcp"

# Authenticate Rube (after restart)
# Type /mcp in Claude Code, select rube, and complete OAuth flow
```

### Install Plugins

```bash
# Install plugins via Claude Code
claude

# Then inside Claude Code:
/plugin install git-workflow
/plugin install supabase-toolkit
/plugin install performance-optimizer
/plugin install testing-suite
/plugin marketplace add https://github.com/davila7/claude-code-templates
```

## Environment Variables

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
export ANTHROPIC_API_KEY="your-api-key-here"
export ANTHROPIC_MODEL="claude-sonnet-4-5-20250929"
```

Reload:
```bash
source ~/.bashrc
```

## Usage Tips

### Working with MCP Servers

1. **Check MCP status**: `/mcp` in Claude Code
2. **Authenticate**: Select server and follow OAuth flow
3. **Enable/Disable**: @mention server to toggle

### Using Plugins

- View installed: `/plugin`
- Enable/disable specific plugins as needed

### Best Practices

1. **Start conversations with context**:
   - @mention relevant files
   - Specify which tools you want Claude to use

2. **Use thinking mode for complex tasks**:
   - Say "think" or "ultrathink"
   - Great for architecture decisions

3. **Leverage MCP integrations**:
   - Connect your workflows across apps
   - Automate repetitive tasks

4. **Generate tests automatically**:
   - `/generate-tests path/to/file.ts`

## Troubleshooting

### MCP Server shows "needs authentication"
1. Type `/mcp`
2. Select the server
3. Press Enter to open OAuth flow
4. Complete authentication in browser

### Plugin not loading
```bash
# Restart Claude Code
# Verify installation
/plugin
```

### API Key issues
```bash
# Check environment variable
echo $ANTHROPIC_API_KEY

# Re-login
/login
```

## Project Structure

```
claude-local/
├── README.md              # This file
├── setup.sh              # Automated setup script
├── config/
│   ├── settings.template.json   # Settings template
│   └── mcp.template.json        # MCP config template
├── examples/
│   ├── rube-examples.md        # Rube usage examples
│   └── workflow-examples.md    # Development workflow examples
└── docs/
    ├── mcp-servers.md          # MCP server documentation
    ├── plugins.md              # Plugin documentation
    └── advanced-config.md      # Advanced configuration guide
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT

## Resources

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [MCP Protocol](https://modelcontextprotocol.io/)
- [Rube GitHub](https://github.com/ComposioHQ/Rube)
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)

## Author

Built with Claude Code
