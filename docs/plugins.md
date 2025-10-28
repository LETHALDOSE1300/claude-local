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
