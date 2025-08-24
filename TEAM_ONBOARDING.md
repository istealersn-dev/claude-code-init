# Claude Code Team Onboarding

## Getting Started (2 minutes)

### Installation

```bash
# Clone the initialization toolkit
git clone <internal-repo-url> ~/claude-code-init
```

### For New Projects

```bash
cd ~/claude-code-init
./init-new-project.sh --name "my-app" --type web --framework react
cd my-app
../setup-mcp-servers.sh --type web --framework react --database postgres
```

### For Existing Projects

```bash
cd /path/to/your/existing/project
~/claude-code-init/init-existing-project.sh
~/claude-code-init/setup-mcp-servers.sh --type api --framework express --database postgres
```

## What You Get

After initialization, your project will have:

- **`CLAUDE.md`** - Your personalized Claude Code instruction manual
- **Optimized workflow** - Pre-configured for your project type
- **MCP servers** - Automatically set up for database, cloud, etc.
- **PR templates** - Consistent documentation standards

## First Claude Code Session

1. **Start Claude Code** in your initialized project directory
2. **Ask Claude to read CLAUDE.md** - It will understand your project setup
3. **Use TodoWrite for complex tasks** - Claude will track your progress
4. **Follow the session management patterns** - See `session-management-guide.md`

## Getting Help

- **Project-specific help**: Check your project's `CLAUDE.md`
- **MCP server issues**: See `mcp-setup-guide.md`
- **Session best practices**: See `session-management-guide.md`
- **Team questions**: Ask in #engineering-claude-code Slack channel

## Tips for Success

✅ **Always start with TodoWrite** for multi-step tasks  
✅ **Read your CLAUDE.md** before each session  
✅ **Use MCP servers** - they're pre-configured for your project  
✅ **Follow PR templates** - they include proper attribution  

❌ **Don't skip project initialization** - it saves time later  
❌ **Don't ignore linting commands** - they're in your CLAUDE.md  
❌ **Don't forget to update CLAUDE.md** as your project evolves  

## Examples

**React Web App:**

```bash
./init-new-project.sh --name "dashboard" --type web --framework react
```

**Python API:**

```bash
./init-new-project.sh --name "api-service" --type api --framework fastapi
```

**Mobile App:**

```bash
./init-new-project.sh --name "mobile-app" --type mobile --framework react-native
```

---
**Next Steps:** Try initializing your first project and run through a Claude Code session!
