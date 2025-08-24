#!/bin/bash

# Claude Code Project Initialization Script
# This script helps engineers set up a new project with Claude Code best practices

set -e

PROJECT_NAME=""
PROJECT_TYPE=""
FRAMEWORK=""

print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -n, --name NAME        Project name (required)"
    echo "  -t, --type TYPE        Project type: web, api, mobile, desktop, ml (required)"
    echo "  -f, --framework FRAMEWORK  Framework: react, vue, angular, express, fastapi, flutter, etc."
    echo "  -h, --help            Show this help message"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        -t|--type)
            PROJECT_TYPE="$2"
            shift 2
            ;;
        -f|--framework)
            FRAMEWORK="$2"
            shift 2
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

if [[ -z "$PROJECT_NAME" || -z "$PROJECT_TYPE" ]]; then
    echo "Error: Project name and type are required"
    print_usage
    exit 1
fi

echo "🚀 Initializing Claude Code project: $PROJECT_NAME"
echo "📋 Project type: $PROJECT_TYPE"
[[ -n "$FRAMEWORK" ]] && echo "⚡ Framework: $FRAMEWORK"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize git if not already initialized
if [[ ! -d ".git" ]]; then
    git init
    echo "✅ Git repository initialized"
fi

# Create Claude Code specific files
echo "📝 Creating Claude Code documentation..."

# Create CLAUDE.md with project-specific instructions
cat > CLAUDE.md << EOF
# Claude Code Instructions for $PROJECT_NAME

## Project Overview
- **Name:** $PROJECT_NAME
- **Type:** $PROJECT_TYPE
$([ -n "$FRAMEWORK" ] && echo "- **Framework:** $FRAMEWORK")
- **Created:** $(date +"%Y-%m-%d")

## Development Commands
<!-- Update these based on your project setup -->
- **Install dependencies:** \`npm install\` or \`yarn install\`
- **Start development:** \`npm run dev\` or \`yarn dev\`
- **Build:** \`npm run build\` or \`yarn build\`
- **Test:** \`npm test\` or \`yarn test\`
- **Lint:** \`npm run lint\` or \`yarn lint\`
- **Type check:** \`npm run typecheck\` or \`yarn typecheck\`

## Code Standards
- Follow existing code conventions in the project
- Use TypeScript where applicable
- Write tests for new functionality
- Ensure all linting and type checking passes before committing

## Session Management
- Always use TodoWrite tool for multi-step tasks
- Mark todos as completed immediately after finishing
- Track progress visually for complex implementations

## MCP Servers
<!-- List any MCP servers that should be connected -->
- [ ] Add relevant MCP servers here

## Notes
- Keep this file updated as the project evolves
- Document any specific patterns or conventions used
- Include important architectural decisions
EOF

# Create project structure documentation
cat > PROJECT_STRUCTURE.md << EOF
# Project Structure for $PROJECT_NAME

## Directory Layout
\`\`\`
$PROJECT_NAME/
├── src/                    # Source code
├── tests/                  # Test files
├── docs/                   # Documentation
├── .github/                # GitHub workflows and templates
├── CLAUDE.md              # Claude Code instructions
├── PROJECT_STRUCTURE.md   # This file
└── README.md              # Project documentation
\`\`\`

## Key Files
- **CLAUDE.md** - Instructions for Claude Code sessions
- **README.md** - Project documentation for developers
- **package.json** - Dependencies and scripts (if applicable)

## Conventions
- Use clear, descriptive file and directory names
- Group related functionality together
- Keep configuration files at the root level
- Document any deviations from standard patterns

Update this file as the project structure evolves.
EOF

# Create GitHub templates directory
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

## Testing
- [ ] Tests pass locally
- [ ] New tests added (if applicable)
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project conventions
- [ ] Self-review completed
- [ ] Documentation updated (if needed)
- [ ] No console.log or debugging code left behind

## Related Issues
Closes #[issue number]

---
🤖 Generated with [Claude Code](https://claude.ai/code)
EOF

# Create a basic README if it doesn't exist
if [[ ! -f "README.md" ]]; then
    cat > README.md << EOF
# $PROJECT_NAME

$([ "$PROJECT_TYPE" = "web" ] && echo "A modern web application built with ${FRAMEWORK:-web technologies}.")
$([ "$PROJECT_TYPE" = "api" ] && echo "A RESTful API service built with ${FRAMEWORK:-modern backend technologies}.")
$([ "$PROJECT_TYPE" = "mobile" ] && echo "A mobile application built with ${FRAMEWORK:-mobile technologies}.")
$([ "$PROJECT_TYPE" = "desktop" ] && echo "A desktop application built with ${FRAMEWORK:-desktop technologies}.")
$([ "$PROJECT_TYPE" = "ml" ] && echo "A machine learning project built with ${FRAMEWORK:-ML frameworks}.")

## Getting Started

### Prerequisites
- Node.js (if applicable)
- Additional requirements based on your stack

### Installation
1. Clone the repository
2. Install dependencies: \`npm install\` or \`yarn install\`
3. Start development: \`npm run dev\` or \`yarn dev\`

### Development
See [CLAUDE.md](./CLAUDE.md) for Claude Code specific instructions and development guidelines.

## Project Structure
See [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) for detailed information about the project organization.

## Contributing
1. Create a feature branch
2. Make your changes
3. Ensure all tests pass
4. Create a pull request

## License
[Add your license here]
EOF
fi

echo "✅ Project structure created successfully!"
echo ""
echo "📁 Created files:"
echo "  - CLAUDE.md (Claude Code instructions)"
echo "  - PROJECT_STRUCTURE.md (Project organization guide)"
echo "  - .github/PULL_REQUEST_TEMPLATE/default.md (PR template)"
echo "  - README.md (Project documentation)"
echo ""
echo "🔧 Next steps:"
echo "  1. cd $PROJECT_NAME"
echo "  2. Update CLAUDE.md with project-specific commands"
echo "  3. Set up your development environment"
echo "  4. Connect relevant MCP servers to Claude Code"
echo "  5. Start coding with Claude Code!"