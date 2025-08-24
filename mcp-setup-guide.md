# MCP Server Setup Guide for Claude Code

This guide helps engineers set up and configure MCP (Model Context Protocol) servers to enhance Claude Code capabilities for their specific project needs.

## What are MCP Servers?

MCP servers extend Claude Code with specialized tools and integrations. They provide additional capabilities like database access, API interactions, browser automation, and more.

## Common MCP Servers by Project Type

### Web Development Projects
- **Browser MCP**: Automate browser testing and screenshots
- **Design System MCP**: Extract and document design tokens
- **Database MCP**: Direct database queries and schema inspection
- **HTTP Client MCP**: API testing and integration

### API/Backend Projects
- **Database MCP**: Schema management and queries
- **Kubernetes MCP**: Container and deployment management
- **HTTP Client MCP**: External API testing
- **Log Analysis MCP**: Parse and analyze log files

### Mobile Development
- **Device Testing MCP**: Mobile device simulation
- **App Store MCP**: App store metadata and submission
- **Performance MCP**: Mobile performance analysis

### Machine Learning Projects
- **Data Analysis MCP**: Dataset inspection and analysis
- **Model Registry MCP**: ML model versioning and management
- **Jupyter MCP**: Enhanced notebook integration

## Installation Methods

### Method 1: NPM-based MCP Servers
```bash
# Install common MCP servers globally
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-fetch
npm install -g @modelcontextprotocol/server-brave-search
```

### Method 2: Python-based MCP Servers
```bash
# Install using pip
pip install mcp-server-git
pip install mcp-server-postgres
```

### Method 3: Custom MCP Servers
Follow the specific installation instructions for custom MCP servers in their repositories.

## Claude Code Configuration

### Automatic Configuration (Recommended)
Use the provided setup script to automatically configure common MCP servers:

```bash
./setup-mcp-servers.sh --project-type web --framework react
./setup-mcp-servers.sh --project-type api --database postgres
```

### Manual Configuration
Edit your Claude Code configuration file (usually `~/.config/claude-code/config.json`):

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/project"]
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    },
    "postgres": {
      "command": "python",
      "args": ["-m", "mcp_server_postgres"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost:5432/db"
      }
    }
  }
}
```

## MCP Server Recommendations

### Essential for All Projects
- **Filesystem MCP**: Enhanced file operations
- **Fetch MCP**: HTTP requests and web scraping
- **Git MCP**: Advanced git operations

### Web Projects
```json
{
  "browser": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-puppeteer"]
  },
  "design-system": {
    "command": "npx", 
    "args": ["-y", "@modelcontextprotocol/server-design-tokens"]
  }
}
```

### API Projects
```json
{
  "database": {
    "command": "python",
    "args": ["-m", "mcp_server_postgres"],
    "env": {
      "DATABASE_URL": "${DATABASE_URL}"
    }
  },
  "kubernetes": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-kubernetes"]
  }
}
```

### Mobile Projects
```json
{
  "device-testing": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-appium"]
  }
}
```

## Testing MCP Server Setup

### Verification Commands
```bash
# Check if MCP servers are configured
claude-code --list-mcp-servers

# Test specific MCP server functionality
claude-code --test-mcp filesystem
claude-code --test-mcp database
```

### In-Session Testing
Start a Claude Code session and test MCP functionality:

```
1. Start Claude Code in your project
2. Ask Claude to list available MCP tools
3. Test a simple operation (e.g., file listing with filesystem MCP)
4. Verify database connection (if using database MCP)
```

## Troubleshooting

### Common Issues

**MCP Server Not Found**
- Verify installation: `npm list -g @modelcontextprotocol/server-*`
- Check PATH configuration
- Restart Claude Code after installation

**Permission Errors**
- Check file permissions for MCP server executables
- Verify environment variables are set correctly
- Run with appropriate user permissions

**Connection Failures**
- Verify network connectivity for remote servers
- Check firewall settings
- Validate credentials and connection strings

**Database MCP Issues**
- Test database connection independently
- Verify DATABASE_URL format
- Check user permissions in database

### Debug Mode
Enable debug logging for MCP servers:

```bash
export MCP_DEBUG=1
claude-code --verbose
```

## Security Considerations

### Environment Variables
- Never commit database credentials to version control
- Use environment variables for sensitive configuration
- Consider using secret management tools

### Network Access
- Restrict MCP server network access when possible
- Use VPNs for accessing internal resources
- Regularly update MCP servers for security patches

### File System Access
- Limit filesystem MCP to project directories only
- Review file permissions regularly
- Monitor for unusual file access patterns

## Best Practices

### Configuration Management
- Keep MCP configurations in version control (without secrets)
- Use environment-specific configurations
- Document MCP server requirements in CLAUDE.md

### Performance Optimization
- Monitor MCP server resource usage
- Configure appropriate timeouts
- Use connection pooling for database MCPs

### Team Collaboration
- Standardize MCP server configurations across team
- Provide setup scripts for new team members
- Document custom MCP server configurations

## Custom MCP Server Development

For specialized needs, you can develop custom MCP servers:

### Basic Structure
```typescript
// server.ts
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

const server = new Server(
  {
    name: 'custom-server',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Add your custom tools here
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: 'custom-tool',
        description: 'Description of your custom tool',
        inputSchema: {
          type: 'object',
          properties: {},
        },
      },
    ],
  };
});

// Start server
const transport = new StdioServerTransport();
await server.connect(transport);
```

### Integration
Add your custom MCP server to Claude Code configuration and test thoroughly before deploying to your team.

## Support and Resources

- [Official MCP Documentation](https://modelcontextprotocol.io/)
- [Claude Code MCP Integration Guide](https://docs.anthropic.com/claude-code)
- [Community MCP Servers](https://github.com/topics/mcp-server)

## Quick Start Checklist

- [ ] Identify required MCP servers for your project type
- [ ] Install MCP servers using npm/pip/custom installation
- [ ] Configure Claude Code with MCP server settings
- [ ] Test MCP server functionality in a Claude Code session
- [ ] Document MCP configuration in project CLAUDE.md
- [ ] Share setup with team members
- [ ] Monitor and maintain MCP server performance