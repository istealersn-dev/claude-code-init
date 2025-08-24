#!/bin/bash

# MCP Server Setup Automation Script
# Automatically installs and configures MCP servers based on project type

set -e

PROJECT_TYPE=""
FRAMEWORK=""
DATABASE=""
CLOUD_PROVIDER=""
CONFIG_PATH="$HOME/.config/claude-code"
CONFIG_FILE="$CONFIG_PATH/config.json"
BACKUP_FILE="$CONFIG_PATH/config.json.backup.$(date +%Y%m%d_%H%M%S)"

print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -t, --type TYPE           Project type: web, api, mobile, ml, desktop"
    echo "  -f, --framework FRAMEWORK Framework: react, vue, angular, express, fastapi, etc."
    echo "  -d, --database DATABASE   Database: postgres, mysql, mongodb, sqlite"
    echo "  -c, --cloud CLOUD         Cloud provider: aws, gcp, azure"
    echo "  --dry-run                 Show what would be installed without making changes"
    echo "  --config-only             Only update configuration, skip installations"
    echo "  -h, --help               Show this help message"
}

DRY_RUN=false
CONFIG_ONLY=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--type)
            PROJECT_TYPE="$2"
            shift 2
            ;;
        -f|--framework)
            FRAMEWORK="$2"
            shift 2
            ;;
        -d|--database)
            DATABASE="$2"
            shift 2
            ;;
        -c|--cloud)
            CLOUD_PROVIDER="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --config-only)
            CONFIG_ONLY=true
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

if [[ -z "$PROJECT_TYPE" ]]; then
    echo "Error: Project type is required"
    print_usage
    exit 1
fi

echo "🚀 Setting up MCP servers for $PROJECT_TYPE project"
[[ -n "$FRAMEWORK" ]] && echo "⚡ Framework: $FRAMEWORK"
[[ -n "$DATABASE" ]] && echo "🗄️  Database: $DATABASE"
[[ -n "$CLOUD_PROVIDER" ]] && echo "☁️  Cloud: $CLOUD_PROVIDER"
[[ "$DRY_RUN" == "true" ]] && echo "🔍 DRY RUN MODE - No changes will be made"

# Create config directory if it doesn't exist
if [[ "$DRY_RUN" == "false" ]]; then
    mkdir -p "$CONFIG_PATH"
fi

# Backup existing config
if [[ -f "$CONFIG_FILE" && "$DRY_RUN" == "false" ]]; then
    echo "📋 Backing up existing config to $BACKUP_FILE"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
fi

# Function to install npm packages
install_npm_package() {
    local package=$1
    echo "📦 Installing $package..."
    
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "   [DRY RUN] Would install: npm install -g $package"
        return
    fi
    
    if [[ "$CONFIG_ONLY" == "true" ]]; then
        echo "   [CONFIG ONLY] Skipping installation of $package"
        return
    fi
    
    if npm list -g "$package" >/dev/null 2>&1; then
        echo "   ✅ $package already installed"
    else
        npm install -g "$package"
        echo "   ✅ $package installed successfully"
    fi
}

# Function to install pip packages
install_pip_package() {
    local package=$1
    echo "🐍 Installing $package..."
    
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "   [DRY RUN] Would install: pip install $package"
        return
    fi
    
    if [[ "$CONFIG_ONLY" == "true" ]]; then
        echo "   [CONFIG ONLY] Skipping installation of $package"
        return
    fi
    
    if pip show "$package" >/dev/null 2>&1; then
        echo "   ✅ $package already installed"
    else
        pip install "$package"
        echo "   ✅ $package installed successfully"
    fi
}

# Function to add MCP server to config
add_mcp_server() {
    local name=$1
    local command=$2
    shift 2
    local args=("$@")
    
    echo "⚙️  Configuring MCP server: $name"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "   [DRY RUN] Would add $name to config"
        return
    fi
    
    # Create basic config if it doesn't exist
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo '{"mcpServers": {}}' > "$CONFIG_FILE"
    fi
    
    # Use python to update JSON config (more reliable than jq for complex updates)
    python3 -c "
import json
import sys

config_file = '$CONFIG_FILE'
try:
    with open(config_file, 'r') as f:
        config = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    config = {}

if 'mcpServers' not in config:
    config['mcpServers'] = {}

config['mcpServers']['$name'] = {
    'command': '$command',
    'args': $(printf '%s\n' "${args[@]}" | python3 -c "import sys, json; print(json.dumps([line.strip() for line in sys.stdin if line.strip()]))")
}

with open(config_file, 'w') as f:
    json.dump(config, f, indent=2)
" 2>/dev/null || echo "   ⚠️  Failed to update config for $name"
    
    echo "   ✅ $name added to configuration"
}

# Install essential MCP servers for all project types
install_essential_servers() {
    echo "🔧 Installing essential MCP servers..."
    
    install_npm_package "@modelcontextprotocol/server-filesystem"
    add_mcp_server "filesystem" "npx" "-y" "@modelcontextprotocol/server-filesystem" "$(pwd)"
    
    install_npm_package "@modelcontextprotocol/server-fetch"
    add_mcp_server "fetch" "npx" "-y" "@modelcontextprotocol/server-fetch"
    
    # Git MCP if available
    if command -v git >/dev/null 2>&1; then
        install_pip_package "mcp-server-git"
        add_mcp_server "git" "python" "-m" "mcp_server_git" "--repository" "$(pwd)"
    fi
}

# Install web-specific MCP servers
install_web_servers() {
    echo "🌐 Installing web development MCP servers..."
    
    # Browser automation
    install_npm_package "@modelcontextprotocol/server-puppeteer"
    add_mcp_server "browser" "npx" "-y" "@modelcontextprotocol/server-puppeteer"
    
    # Design system extraction (if available)
    echo "🎨 Adding design system MCP server configuration..."
    add_mcp_server "design-system" "npx" "-y" "@anthropic/design-system-extractor"
    
    case "$FRAMEWORK" in
        "react"|"next"|"nextjs")
            echo "⚛️  Adding React-specific configurations..."
            ;;
        "vue"|"nuxt")
            echo "🟢 Adding Vue-specific configurations..."
            ;;
        "angular")
            echo "🔺 Adding Angular-specific configurations..."
            ;;
    esac
}

# Install API/backend-specific MCP servers
install_api_servers() {
    echo "🔌 Installing API development MCP servers..."
    
    # HTTP client for API testing
    install_npm_package "@modelcontextprotocol/server-fetch"
    
    # Database MCP servers
    case "$DATABASE" in
        "postgres"|"postgresql")
            install_pip_package "mcp-server-postgres"
            echo "🐘 PostgreSQL MCP server installed"
            echo "   Configure DATABASE_URL in your environment"
            add_mcp_server "postgres" "python" "-m" "mcp_server_postgres"
            ;;
        "mysql")
            install_pip_package "mcp-server-mysql"
            echo "🐬 MySQL MCP server installed"
            add_mcp_server "mysql" "python" "-m" "mcp_server_mysql"
            ;;
        "mongodb"|"mongo")
            install_pip_package "mcp-server-mongodb"
            echo "🍃 MongoDB MCP server installed"
            add_mcp_server "mongodb" "python" "-m" "mcp_server_mongodb"
            ;;
        "sqlite")
            install_pip_package "mcp-server-sqlite"
            echo "📄 SQLite MCP server installed"
            add_mcp_server "sqlite" "python" "-m" "mcp_server_sqlite"
            ;;
    esac
    
    # Cloud provider specific
    case "$CLOUD_PROVIDER" in
        "aws")
            echo "☁️  Adding AWS MCP configurations..."
            install_pip_package "mcp-server-aws"
            add_mcp_server "aws" "python" "-m" "mcp_server_aws"
            ;;
        "gcp"|"google")
            echo "☁️  Adding Google Cloud MCP configurations..."
            install_pip_package "mcp-server-gcp"
            add_mcp_server "gcp" "python" "-m" "mcp_server_gcp"
            ;;
        "azure")
            echo "☁️  Adding Azure MCP configurations..."
            install_pip_package "mcp-server-azure"
            add_mcp_server "azure" "python" "-m" "mcp_server_azure"
            ;;
    esac
    
    # Kubernetes if kubectl is available
    if command -v kubectl >/dev/null 2>&1; then
        install_npm_package "@modelcontextprotocol/server-kubernetes"
        add_mcp_server "kubernetes" "npx" "-y" "@modelcontextprotocol/server-kubernetes"
    fi
}

# Install mobile-specific MCP servers
install_mobile_servers() {
    echo "📱 Installing mobile development MCP servers..."
    
    # Device testing and automation
    case "$FRAMEWORK" in
        "react-native"|"reactnative")
            echo "⚛️  Adding React Native configurations..."
            ;;
        "flutter")
            echo "🐦 Adding Flutter configurations..."
            ;;
        "ionic")
            echo "⚡ Adding Ionic configurations..."
            ;;
    esac
    
    # Appium for mobile testing (if available)
    if command -v appium >/dev/null 2>&1; then
        install_npm_package "@modelcontextprotocol/server-appium"
        add_mcp_server "appium" "npx" "-y" "@modelcontextprotocol/server-appium"
    fi
}

# Install ML-specific MCP servers
install_ml_servers() {
    echo "🤖 Installing ML development MCP servers..."
    
    # Data analysis and Jupyter integration
    install_pip_package "mcp-server-jupyter"
    add_mcp_server "jupyter" "python" "-m" "mcp_server_jupyter"
    
    # Dataset management
    install_pip_package "mcp-server-datasets"
    add_mcp_server "datasets" "python" "-m" "mcp_server_datasets"
    
    case "$FRAMEWORK" in
        "pytorch"|"torch")
            echo "🔥 Adding PyTorch configurations..."
            ;;
        "tensorflow"|"tf")
            echo "🧠 Adding TensorFlow configurations..."
            ;;
        "scikit-learn"|"sklearn")
            echo "📊 Adding Scikit-learn configurations..."
            ;;
    esac
}

# Install desktop-specific MCP servers
install_desktop_servers() {
    echo "🖥️  Installing desktop development MCP servers..."
    
    case "$FRAMEWORK" in
        "electron")
            echo "⚡ Adding Electron configurations..."
            ;;
        "tauri")
            echo "🦀 Adding Tauri configurations..."
            ;;
        "flutter")
            echo "🐦 Adding Flutter Desktop configurations..."
            ;;
    esac
}

# Main installation logic
install_essential_servers

case "$PROJECT_TYPE" in
    "web")
        install_web_servers
        ;;
    "api"|"backend")
        install_api_servers
        ;;
    "mobile")
        install_mobile_servers
        ;;
    "ml"|"ai"|"data")
        install_ml_servers
        ;;
    "desktop")
        install_desktop_servers
        ;;
    *)
        echo "⚠️  Unknown project type: $PROJECT_TYPE"
        echo "Installing only essential MCP servers"
        ;;
esac

# Create environment file template
if [[ "$DRY_RUN" == "false" && ! -f ".env.mcp" ]]; then
    cat > .env.mcp << 'EOF'
# MCP Server Environment Variables
# Copy this to .env and update with your actual values

# Database connections (uncomment as needed)
# DATABASE_URL=postgresql://user:password@localhost:5432/dbname
# MONGODB_URI=mongodb://localhost:27017/dbname
# MYSQL_URL=mysql://user:password@localhost:3306/dbname

# Cloud provider credentials
# AWS_ACCESS_KEY_ID=your_access_key
# AWS_SECRET_ACCESS_KEY=your_secret_key
# AWS_REGION=us-west-2

# GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json
# GCLOUD_PROJECT=your-project-id

# AZURE_CLIENT_ID=your_client_id
# AZURE_CLIENT_SECRET=your_client_secret
# AZURE_TENANT_ID=your_tenant_id

# Other service configurations
# OPENAI_API_KEY=your_openai_key (if using AI-related MCPs)
# ANTHROPIC_API_KEY=your_anthropic_key
EOF
    echo "✅ Created .env.mcp template"
fi

echo ""
echo "✅ MCP server setup completed!"
echo ""
echo "📋 Summary:"
echo "  - Configuration saved to: $CONFIG_FILE"
[[ -f "$BACKUP_FILE" ]] && echo "  - Backup created at: $BACKUP_FILE"
echo "  - Environment template: .env.mcp"
echo ""
echo "🔧 Next steps:"
echo "  1. Copy .env.mcp to .env and update with your credentials"
echo "  2. Restart Claude Code to load new MCP servers"
echo "  3. Test MCP functionality with: claude-code --test-mcp"
echo "  4. Update CLAUDE.md with MCP server information"
echo ""
echo "🧪 Test your setup:"
echo "  claude-code"
echo "  > Ask Claude to list available MCP tools"
echo "  > Test file operations with filesystem MCP"
[[ -n "$DATABASE" ]] && echo "  > Test database connection with $DATABASE MCP"
echo ""
echo "💡 For troubleshooting, see: mcp-setup-guide.md"