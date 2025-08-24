# Claude Code Project Initialization System

A comprehensive toolkit to help engineers efficiently initialize new projects or migrate existing projects to use Claude Code with best practices, proper documentation, and optimized workflows.

## Quick Start

### For New Projects

```bash
# Clone this repository
git clone https://github.com/istealersn-dev/claude-code-init.git
cd claude-code-init

# Initialize a new project
./init-new-project.sh --name my-project --type web --framework react
```

### For Existing Projects  

```bash
# Navigate to your existing project
cd /path/to/existing/project

# Initialize Claude Code workflow
/path/to/claude-code-init/init-existing-project.sh

# Set up MCP servers
/path/to/claude-code-init/setup-mcp-servers.sh --type web --framework react
```

## What This System Provides

### 📋 Core Scripts

- **`init-new-project.sh`** - Creates new project with Claude Code best practices
- **`init-existing-project.sh`** - Migrates existing projects to Claude Code workflow  
- **`setup-mcp-servers.sh`** - Automatically configures MCP servers based on project type

### 📚 Documentation & Guides

- **`mcp-setup-guide.md`** - Comprehensive MCP server setup and troubleshooting
- **`session-management-guide.md`** - Best practices for Claude Code sessions and todo tracking

### 🎯 Generated Project Files

- **`CLAUDE.md`** - Project-specific Claude Code instructions and commands
- **`PROJECT_STRUCTURE.md`** - Documentation of project organization
- **`MIGRATION_CHECKLIST.md`** - Step-by-step migration tracking (existing projects)
- **`.github/PULL_REQUEST_TEMPLATE/`** - PR template with Claude Code attribution

## Supported Project Types

| Type | Frameworks | Features |
|------|------------|----------|
| **Web** | React, Vue, Angular, Next.js, Nuxt, Svelte, Vite | Browser MCP, Design System extraction, Frontend tooling, Tailwind CSS |
| **API** | Express, Fastify, Koa, Hapi | Database MCPs, HTTP client, Cloud provider integration |

## Features

### ✨ Intelligent Project Detection

- Automatically detects project type, framework, and dependencies
- Configures appropriate MCP servers and development commands
- Preserves existing project conventions and patterns

### 🔧 MCP Server Automation

- Installs and configures MCP servers based on project needs
- Supports database, cloud provider, and framework-specific MCPs
- Creates environment templates for easy credential management

### 📊 Session Management

- Provides structured todo tracking guidelines
- Ensures consistent progress visibility
- Facilitates effective team collaboration and handoffs

### 🚀 Team Onboarding

- Standardizes Claude Code usage across engineering teams
- Provides migration checklists and best practices
- Creates consistent project documentation patterns

## Usage Examples

### Initialize React + Vite + Tailwind Project

```bash
./init-new-project.sh \
  --name "my-project" \
  --type web \
  --framework react

cd my-project
../setup-mcp-servers.sh \
  --type web \
  --framework react \
  --database postgres
```

### Migrate Express.js to Fastify.js

```bash
cd /path/to/express-api
/path/to/claude-code-init/init-existing-project.sh --force

/path/to/claude-code-init/setup-mcp-servers.sh \
  --type api \
  --framework fastify \
  --database postgres
```

## Script Options

### init-new-project.sh

```bash
Options:
  -n, --name NAME        Project name (required)
  -t, --type TYPE        Project type: web, api, mobile, desktop, ml
  -f, --framework FRAMEWORK  Specific framework to use
  -h, --help            Show help message
```

### init-existing-project.sh  

```bash
Options:
  -p, --path PATH       Project path (defaults to current directory)
  -f, --force          Overwrite existing Claude Code files
  -h, --help           Show help message
```

### setup-mcp-servers.sh

```bash
Options:
  -t, --type TYPE           Project type (required)
  -f, --framework FRAMEWORK Framework name
  -d, --database DATABASE   Database type: postgres, mysql, mongodb, sqlite
  -c, --cloud CLOUD         Cloud provider: aws, gcp, azure
  --dry-run                 Preview changes without making them
  --config-only             Update config only, skip installations
  -h, --help               Show help message
```

## Generated Project Structure

After initialization, your project will have:

```markdown
project-name/
  CLAUDE.md                           # Claude Code instructions
  PROJECT_STRUCTURE.md               # Project organization guide
  MIGRATION_CHECKLIST.md            # Migration tracking (existing projects)
  .github/
    PULL_REQUEST_TEMPLATE/
    default.md                 # PR template with Claude Code attribution
    .env.mcp                           # MCP environment template
    [your existing project files]
```

## Best Practices Integration

### Session Management

The system promotes effective Claude Code usage through:

- **TodoWrite Integration**: Automatic todo list creation for complex tasks
- **Progress Tracking**: Visible progress indicators for stakeholders
- **Task Decomposition**: Guidelines for breaking down complex work

### Code Quality

- **Linting Integration**: Documented commands for code quality checks
- **Testing Workflows**: Project-specific test execution instructions  
- **Build Process**: Automated build verification steps

### Team Collaboration  

- **PR Templates**: Standardized pull request documentation
- **Migration Tracking**: Checklists for team onboarding
- **Documentation Standards**: Consistent project documentation patterns

## Troubleshooting

### Common Issues

- **MCP Server Installation Failures**: Check `mcp-setup-guide.md` for detailed troubleshooting
- **Permission Errors**: Ensure scripts have execute permissions (`chmod +x`)
- **Configuration Conflicts**: Use `--force` flag to overwrite existing configurations

### Getting Help

- Review the generated `CLAUDE.md` in your project
- Check `mcp-setup-guide.md` for MCP-specific issues
- Consult `session-management-guide.md` for workflow questions

## Advanced Usage

### Custom MCP Servers

Add custom MCP server configurations by modifying the generated `.env.mcp` file and updating your Claude Code configuration.

### Team Standardization

Fork this repository and customize scripts for your organization's specific needs, then distribute to engineering teams.

### CI/CD Integration

Integrate initialization scripts into your project templates and CI/CD pipelines for automated project setup.

## Contributing

This system is designed to be extended and customized for different organizational needs. Key areas for contribution:

- Additional project type support
- Framework-specific optimizations  
- MCP server integrations
- Documentation improvements

## Support

For issues and questions:

1. Check the relevant guide documents first
2. Review generated project documentation
3. Test with `--dry-run` flag to preview changes
4. Consult Claude Code official documentation

---

**Goal**: Streamline Claude Code adoption and maximize engineering productivity through standardized, intelligent project initialization and session management practices.
