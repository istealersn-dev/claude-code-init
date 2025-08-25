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

# Store script directory before changing directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to determine which agents to copy for new projects
determine_agents() {
    local agents=()
    
    # Frontend agents based on framework
    case "$FRAMEWORK" in
        "react")
            agents+=("frontend/react-vite-expert.md")
            ;;
        "vue")
            agents+=("frontend/vue-expert.md")
            ;;
        "svelte")
            agents+=("frontend/svelte-expert.md")
            ;;
        "nextjs"|"next")
            agents+=("frontend/nextjs-expert.md")
            ;;
        "angular")
            echo "⚠️  Angular agent not available yet. Consider creating one or using general web practices."
            ;;
    esac
    
    # Backend agents based on framework
    case "$FRAMEWORK" in
        "express")
            agents+=("backend/express-expert.md")
            ;;
        "fastify")
            agents+=("backend/fastify-expert.md")
            ;;
        "fastapi")
            agents+=("backend/fastify-expert.md")  # Reuse for similar patterns
            ;;
    esac
    
    # Add database agents for API projects or when database is expected
    if [[ "$PROJECT_TYPE" == "api" ]]; then
        # Default to PostgreSQL for API projects
        agents+=("database/postgresql-expert.md")
    elif [[ "$PROJECT_TYPE" == "web" ]]; then
        # Add SQLite for simple web projects that might need local data
        agents+=("database/sqlite-expert.md")
    fi
    
    # Output the agents array
    printf '%s\n' "${agents[@]}"
}

# Function to copy agents to project
copy_agents() {
    local agents_source_dir="$SCRIPT_DIR/_agents"
    local current_dir="$(pwd)"
    
    if [[ ! -d "$agents_source_dir" ]]; then
        echo "⚠️  Agents directory not found at $agents_source_dir"
        echo "    Make sure this script is in the same directory as the _agents folder"
        return 1
    fi
    
    # Get list of agents to copy
    local agents_to_copy=($(determine_agents))
    
    if [[ ${#agents_to_copy[@]} -eq 0 ]]; then
        echo "🤖 No specific agents available for this project configuration"
        return 0
    fi
    
    # Create .claude/agents directory in the project
    mkdir -p "$current_dir/.claude/agents"
    
    echo "🤖 Setting up expert agents:"
    
    # Copy each determined agent
    for agent in "${agents_to_copy[@]}"; do
        local source_file="$agents_source_dir/$agent"
        local dest_file="$current_dir/.claude/agents/$agent"
        
        if [[ -f "$source_file" ]]; then
            # Create directory structure if needed
            mkdir -p "$(dirname "$dest_file")"
            cp "$source_file" "$dest_file"
            echo "  ✅ Added $(basename "$agent")"
        else
            echo "  ⚠️  Agent not found: $agent"
        fi
    done
    
    return 0
}

# Generate agent information for new projects
generate_agent_info() {
    local agents_to_copy=($(determine_agents))
    
    if [[ ${#agents_to_copy[@]} -eq 0 ]]; then
        echo "No expert agents configured for this project setup."
        echo "You can manually add agents to the \`.claude/agents/\` directory as needed."
        return
    fi
    
    for agent in "${agents_to_copy[@]}"; do
        case "$agent" in
            "frontend/nextjs-expert.md")
                echo "- **nextjs-tailwind-expert**: Next.js 14+ with App Router and Tailwind CSS v4"
                ;;
            "frontend/react-vite-expert.md")
                echo "- **react-vite-tailwind-expert**: React 18+ with Vite and Tailwind CSS"
                ;;
            "frontend/vue-expert.md")
                echo "- **vue-tailwind-expert**: Vue 3 with Composition API and Tailwind CSS"
                ;;
            "frontend/svelte-expert.md")
                echo "- **svelte-tailwind-expert**: Svelte 4+ with SvelteKit and Tailwind CSS"
                ;;
            "backend/express-expert.md")
                echo "- **express-expert**: Express.js with TypeScript and security best practices"
                ;;
            "backend/fastify-expert.md")
                echo "- **fastify-expert**: Fastify with TypeScript and performance optimization"
                ;;
            "database/postgresql-expert.md")
                echo "- **postgresql-expert**: PostgreSQL with Prisma and query optimization"
                ;;
            "database/sqlite-expert.md")
                echo "- **sqlite-expert**: SQLite with development and migration patterns"
                ;;
        esac
    done
    
    echo ""
    echo "These agents provide framework-specific expertise and can be activated using Claude Code."
}

# Create project directory and initialize
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

## Expert Agents
The following expert agents are available for this project:

$(generate_agent_info)

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

# Copy agents to the new project
copy_agents

echo "✅ Project structure created successfully!"
echo ""
echo "📁 Created files:"
echo "  - CLAUDE.md (Claude Code instructions)"
echo "  - PROJECT_STRUCTURE.md (Project organization guide)"
echo "  - .github/PULL_REQUEST_TEMPLATE/default.md (PR template)"
echo "  - README.md (Project documentation)"
echo "  - .claude/agents/ (Expert agents for your tech stack)"
echo ""
echo "🔧 Next steps:"
echo "  1. Update CLAUDE.md with project-specific commands"
echo "  2. Set up your development environment"  
echo "  3. Review the expert agents in .claude/agents/ directory"
echo "  4. Connect relevant MCP servers to Claude Code"
echo "  5. Start coding with Claude Code!"
echo ""
echo "💡 You are now in the $PROJECT_NAME directory. Happy coding!"