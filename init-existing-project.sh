#!/bin/bash

# Claude Code Migration/Refactoring Initialization Script
# This script helps engineers set up Claude Code workflows for existing projects

set -e

PROJECT_PATH="."
FORCE_OVERWRITE=false

print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p, --path PATH       Project path (defaults to current directory)"
    echo "  -f, --force          Overwrite existing Claude Code files"
    echo "  -h, --help           Show this help message"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--path)
            PROJECT_PATH="$2"
            shift 2
            ;;
        -f|--force)
            FORCE_OVERWRITE=true
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Navigate to project directory
cd "$PROJECT_PATH"
PROJECT_NAME=$(basename "$(pwd)")

echo "🔄 Setting up Claude Code for existing project: $PROJECT_NAME"
echo "📍 Project path: $(pwd)"

# Detect project type and framework
detect_project_info() {
    local project_type="unknown"
    local framework="unknown"
    local package_manager="unknown"
    local build_tool="unknown"
    
    # Check for common files to determine project type
    if [[ -f "package.json" ]]; then
        echo "📦 Detected Node.js project"
        
        if [[ -f "yarn.lock" ]]; then
            package_manager="yarn"
        elif [[ -f "pnpm-lock.yaml" ]]; then
            package_manager="pnpm"
        else
            package_manager="npm"
        fi
        
        # Try to detect framework from package.json
        if grep -q "\"react\"" package.json 2>/dev/null; then
            framework="React"
            project_type="web"
        elif grep -q "\"vue\"" package.json 2>/dev/null; then
            framework="Vue"
            project_type="web"
        elif grep -q "\"angular\"" package.json 2>/dev/null; then
            framework="Angular"
            project_type="web"
        elif grep -q "\"express\"" package.json 2>/dev/null; then
            framework="Express"
            project_type="api"
        elif grep -q "\"fastify\"" package.json 2>/dev/null; then
            framework="Fastify"
            project_type="api"
        elif grep -q "\"next\"" package.json 2>/dev/null; then
            framework="Next.js"
            project_type="web"
        elif grep -q "\"nuxt\"" package.json 2>/dev/null; then
            framework="Nuxt.js"
            project_type="web"
        elif grep -q "\"svelte\"" package.json 2>/dev/null; then
            framework="Svelte"
            project_type="web"
        else
            project_type="web"
        fi
    elif [[ -f "requirements.txt" ]] || [[ -f "pyproject.toml" ]] || [[ -f "setup.py" ]]; then
        echo "🐍 Detected Python project"
        project_type="api"
        package_manager="pip"
        
        if [[ -f "requirements.txt" ]] && grep -q "fastapi" requirements.txt 2>/dev/null; then
            framework="FastAPI"
        elif [[ -f "requirements.txt" ]] && grep -q "django" requirements.txt 2>/dev/null; then
            framework="Django"
        elif [[ -f "requirements.txt" ]] && grep -q "flask" requirements.txt 2>/dev/null; then
            framework="Flask"
        fi
    elif [[ -f "Cargo.toml" ]]; then
        echo "🦀 Detected Rust project"
        project_type="api"
        package_manager="cargo"
        build_tool="cargo"
    elif [[ -f "go.mod" ]]; then
        echo "🐹 Detected Go project"
        project_type="api"
        package_manager="go"
        build_tool="go"
    elif [[ -f "pom.xml" ]]; then
        echo "☕ Detected Maven Java project"
        project_type="api"
        package_manager="maven"
        build_tool="mvn"
    elif [[ -f "build.gradle" ]] || [[ -f "build.gradle.kts" ]]; then
        echo "☕ Detected Gradle project"
        project_type="api"
        package_manager="gradle"
        build_tool="gradle"
    fi
    
    echo "PROJECT_TYPE=$project_type"
    echo "FRAMEWORK=$framework"
    echo "PACKAGE_MANAGER=$package_manager"
    echo "BUILD_TOOL=$build_tool"
}

# Get project detection info
PROJECT_INFO=$(detect_project_info)
eval "$PROJECT_INFO"

# Function to create or update CLAUDE.md
create_claude_md() {
    local claude_file="CLAUDE.md"
    
    if [[ -f "$claude_file" && "$FORCE_OVERWRITE" != "true" ]]; then
        echo "⚠️  CLAUDE.md already exists. Use --force to overwrite or manually update it."
        return
    fi
    
    cat > "$claude_file" << EOF
# Claude Code Instructions for $PROJECT_NAME

## Project Overview
- **Name:** $PROJECT_NAME
- **Type:** $PROJECT_TYPE
$([ "$FRAMEWORK" != "unknown" ] && echo "- **Framework:** $FRAMEWORK")
$([ "$PACKAGE_MANAGER" != "unknown" ] && echo "- **Package Manager:** $PACKAGE_MANAGER")
- **Migrated to Claude Code:** $(date +"%Y-%m-%d")

## Development Commands
$(generate_dev_commands)

## Code Standards
- Follow existing code conventions in the project
- Maintain current testing patterns
- Ensure all existing tooling continues to work
- Review and update dependencies carefully during refactoring

## Migration Notes
- This project was migrated to use Claude Code workflows
- Existing patterns and conventions should be preserved
- Refactoring should be done incrementally
- Test thoroughly after any structural changes

## Session Management
- Always use TodoWrite tool for multi-step tasks
- Mark todos as completed immediately after finishing
- Track progress visually for complex refactoring work
- Break large refactoring tasks into smaller, manageable chunks

## MCP Servers
<!-- Add MCP servers relevant to this project type -->
$(generate_mcp_suggestions)

## Architecture Notes
- Document any important architectural decisions
- Note any legacy patterns that need special attention
- Include migration guidelines for team members

## Notes
- Keep this file updated as refactoring progresses
- Document any new patterns introduced
- Track technical debt and improvement opportunities
EOF
    
    echo "✅ Created/updated CLAUDE.md"
}

# Generate development commands based on detected project type
generate_dev_commands() {
    case "$PACKAGE_MANAGER" in
        "npm")
            echo "- **Install dependencies:** \`npm install\`"
            echo "- **Start development:** \`npm run dev\` or \`npm start\`"
            echo "- **Build:** \`npm run build\`"
            echo "- **Test:** \`npm test\` or \`npm run test\`"
            echo "- **Lint:** \`npm run lint\`"
            echo "- **Type check:** \`npm run typecheck\` (if TypeScript)"
            ;;
        "yarn")
            echo "- **Install dependencies:** \`yarn install\`"
            echo "- **Start development:** \`yarn dev\` or \`yarn start\`"
            echo "- **Build:** \`yarn build\`"
            echo "- **Test:** \`yarn test\`"
            echo "- **Lint:** \`yarn lint\`"
            echo "- **Type check:** \`yarn typecheck\` (if TypeScript)"
            ;;
        "pnpm")
            echo "- **Install dependencies:** \`pnpm install\`"
            echo "- **Start development:** \`pnpm dev\` or \`pnpm start\`"
            echo "- **Build:** \`pnpm build\`"
            echo "- **Test:** \`pnpm test\`"
            echo "- **Lint:** \`pnpm lint\`"
            echo "- **Type check:** \`pnpm typecheck\` (if TypeScript)"
            ;;
        "pip")
            echo "- **Install dependencies:** \`pip install -r requirements.txt\`"
            echo "- **Start development:** \`python main.py\` or \`uvicorn main:app --reload\` (FastAPI)"
            echo "- **Test:** \`pytest\` or \`python -m pytest\`"
            echo "- **Lint:** \`flake8\` or \`ruff check\`"
            echo "- **Format:** \`black .\` or \`ruff format\`"
            ;;
        "cargo")
            echo "- **Build:** \`cargo build\`"
            echo "- **Run:** \`cargo run\`"
            echo "- **Test:** \`cargo test\`"
            echo "- **Format:** \`cargo fmt\`"
            echo "- **Lint:** \`cargo clippy\`"
            ;;
        "go")
            echo "- **Build:** \`go build\`"
            echo "- **Run:** \`go run .\`"
            echo "- **Test:** \`go test ./...\`"
            echo "- **Format:** \`go fmt ./...\`"
            echo "- **Lint:** \`golangci-lint run\`"
            ;;
        "maven")
            echo "- **Build:** \`mvn compile\`"
            echo "- **Run:** \`mvn exec:java\`"
            echo "- **Test:** \`mvn test\`"
            echo "- **Package:** \`mvn package\`"
            ;;
        "gradle")
            echo "- **Build:** \`./gradlew build\`"
            echo "- **Run:** \`./gradlew run\`"
            echo "- **Test:** \`./gradlew test\`"
            ;;
        *)
            echo "<!-- Update these commands based on your project setup -->"
            echo "- **Install dependencies:** [Add command]"
            echo "- **Start development:** [Add command]"
            echo "- **Build:** [Add command]"
            echo "- **Test:** [Add command]"
            echo "- **Lint:** [Add command]"
            ;;
    esac
}

# Generate MCP server suggestions
generate_mcp_suggestions() {
    echo "<!-- Consider adding these MCP servers based on your project type: -->"
    case "$PROJECT_TYPE" in
        "web")
            echo "- [ ] Browser automation MCP (for E2E testing)"
            echo "- [ ] Database MCP (if using database)"
            echo "- [ ] Design system MCP (for UI consistency)"
            ;;
        "api")
            echo "- [ ] Database MCP server"
            echo "- [ ] HTTP client MCP (for API testing)"
            echo "- [ ] Kubernetes MCP (if using K8s)"
            ;;
        *)
            echo "- [ ] Add relevant MCP servers for your project type"
            ;;
    esac
}

# Create migration checklist
create_migration_checklist() {
    cat > MIGRATION_CHECKLIST.md << 'EOF'
# Claude Code Migration Checklist

## Initial Setup
- [ ] CLAUDE.md created with project-specific instructions
- [ ] Development commands documented and tested
- [ ] Git workflows updated with Claude Code PR template
- [ ] Team informed about Claude Code integration

## Code Quality Setup
- [ ] Existing linting rules documented in CLAUDE.md
- [ ] TypeScript configuration noted (if applicable)
- [ ] Testing framework and commands verified
- [ ] Build process documented and working

## Documentation
- [ ] README.md reviewed and updated if needed
- [ ] Code conventions documented
- [ ] Architecture decisions captured
- [ ] Migration notes added for team

## MCP Integration
- [ ] Relevant MCP servers identified
- [ ] MCP servers configured and tested
- [ ] Team trained on MCP server usage

## Workflow Integration
- [ ] PR template customized for project needs
- [ ] Git hooks compatible with Claude Code (if any)
- [ ] CI/CD pipeline works with Claude Code changes
- [ ] Session tracking patterns established

## Team Onboarding
- [ ] Team members introduced to Claude Code workflow
- [ ] CLAUDE.md guidelines communicated
- [ ] Session management best practices shared
- [ ] Feedback process established

## Post-Migration
- [ ] First refactoring session completed successfully
- [ ] Team feedback collected and addressed
- [ ] Process improvements identified and implemented
- [ ] Migration checklist archived or updated for future projects

---
Delete this file once migration is complete and all items are checked off.
EOF

    echo "✅ Created migration checklist"
}

# Run the setup
create_claude_md
create_migration_checklist

# Create .github directory and PR template if it doesn't exist
if [[ ! -d ".github/PULL_REQUEST_TEMPLATE" ]]; then
    mkdir -p .github/PULL_REQUEST_TEMPLATE
    
    cat > .github/PULL_REQUEST_TEMPLATE/default.md << 'EOF'
## Summary
Brief description of changes made

## Type of Change
- [ ] Bug fix
- [ ] New feature  
- [ ] Breaking change
- [ ] Documentation update
- [ ] Refactoring
- [ ] Performance improvement
- [ ] Migration/modernization

## Testing
- [ ] Tests pass locally
- [ ] New tests added (if applicable)
- [ ] Manual testing completed
- [ ] Regression testing performed

## Migration Notes (if applicable)
- [ ] Legacy patterns preserved where needed
- [ ] Breaking changes documented
- [ ] Migration path provided for team

## Checklist
- [ ] Code follows existing project conventions
- [ ] Self-review completed
- [ ] Documentation updated (if needed)
- [ ] No debugging code left behind
- [ ] Performance impact considered

## Related Issues
Closes #[issue number]

---
🤖 Generated with [Claude Code](https://claude.ai/code)
EOF
    
    echo "✅ Created GitHub PR template"
fi

echo ""
echo "✅ Migration setup completed successfully!"
echo ""
echo "📁 Created/updated files:"
echo "  - CLAUDE.md (Claude Code instructions)"
echo "  - MIGRATION_CHECKLIST.md (Migration tracking)"
echo "  - .github/PULL_REQUEST_TEMPLATE/default.md (PR template)"
echo ""
echo "🔧 Next steps:"
echo "  1. Review and customize CLAUDE.md for your project"
echo "  2. Test all documented development commands"
echo "  3. Work through the migration checklist"
echo "  4. Set up relevant MCP servers"
echo "  5. Start your first Claude Code session!"
echo ""
echo "💡 Pro tip: Use 'claude-code' command to start a session in this directory"