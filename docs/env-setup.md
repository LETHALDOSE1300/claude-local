# Environment Variables Setup

## Quick Start

1. **Create your local `.env` file**:
   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` and add your API key**:
   ```bash
   nano .env
   # or
   vim .env
   ```

3. **Add your actual API key**:
   ```
   ANTHROPIC_API_KEY=sk-ant-your-actual-key-here
   ```

## Security Notes

- ✅ `.env` is already in `.gitignore` - it will **never** be committed
- ✅ The file persists locally across sessions
- ✅ Safe for storing sensitive API keys
- ❌ Never commit `.env` files to version control
- ❌ Never share your `.env` file

## Using Environment Variables

### In Shell Scripts
```bash
# Source the .env file
source .env

# Or use it directly
export $(cat .env | xargs)
```

### In Node.js/JavaScript
```bash
# Install dotenv
npm install dotenv
```

```javascript
// At the top of your file
require('dotenv').config();

// Access variables
const apiKey = process.env.ANTHROPIC_API_KEY;
```

### In Python
```bash
# Install python-dotenv
pip install python-dotenv
```

```python
from dotenv import load_dotenv
import os

load_dotenv()

api_key = os.getenv('ANTHROPIC_API_KEY')
```

### For Claude Code Specifically

Claude Code automatically reads from:
1. System environment variables
2. `~/.bashrc` or `~/.zshrc` exports
3. `.claude/.env` file (if you prefer Claude-specific variables)

## Multiple Environments

You can create environment-specific files:
- `.env` - Default/development
- `.env.local` - Local overrides
- `.env.production` - Production values (for reference only)
- `.env.test` - Test environment

All `.env*` files are gitignored.

## Troubleshooting

### Check if environment variable is loaded:
```bash
echo $ANTHROPIC_API_KEY
```

### Reload environment in current shell:
```bash
source .env
# or
export $(cat .env | xargs)
```

### For persistent system-wide access:
Add to `~/.bashrc` or `~/.zshrc`:
```bash
export ANTHROPIC_API_KEY="your-key-here"
```

Then reload:
```bash
source ~/.bashrc
```
