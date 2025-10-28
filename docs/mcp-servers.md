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
