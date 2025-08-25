# Enhancement Plan: Interactive Frontend/Backend Project Setup

## Current State Analysis

The existing `init-new-project.sh` script has these limitations:
- Only accepts basic `--type` parameter (web, api, mobile, desktop, ml)
- Framework parameter is cosmetic - no actual setup logic
- No interactive user experience
- Missing framework-specific configurations

## Proposed Enhancement: Interactive Project Setup

### User Experience Flow

1. **Project Type Selection**
   ```
   Choose your project type:
   1) Frontend Application
   2) Backend API
   3) Full-Stack Application
   ```

2. **Frontend Options** (if selected)
   ```
   Choose your frontend framework:
   1) React
      - Vite + React + TypeScript + Tailwind v4
      - Next.js (App Router) + Turbo + Tailwind v4
      - Next.js (Pages Router) + Turbo + Tailwind v4
   2) Vue
      - Vite + Vue 3 + TypeScript + Tailwind v4
      - Nuxt.js
   3) Angular
      - Angular CLI
   4) Svelte
      - SvelteKit
   5) Vanilla JavaScript
      - Vite + Vanilla TS
   ```

3. **Backend Options** (if selected)
   ```
   Choose your backend framework:
   1) Node.js
      - Express + TypeScript
      - Fastify + TypeScript
      - NestJS
      - tRPC + Express
   2) Python
      - FastAPI
      - Django
      - Flask
   3) Go
      - Gin
      - Echo
      - Fiber
   4) Rust
      - Axum
      - Actix Web
   ```

4. **Additional Configuration**
   ```
   Additional setup options:
   - Database: PostgreSQL, MySQL, MongoDB, SQLite, None
   - Authentication: Auth0, Clerk, NextAuth, Custom, None
   - Styling: Tailwind CSS, Styled Components, CSS Modules, None
   - Testing: Jest, Vitest, Playwright, None
   ```

### Technical Implementation Plan

#### Phase 1: Interactive Menu System
- Add interactive prompts using `select` command or custom menu
- Validate user selections
- Store selections in variables for processing

#### Phase 2: Framework-Specific Templates
- Create template directories for each framework combination
- Include package.json, tsconfig.json, and basic file structure
- Add framework-specific development commands to CLAUDE.md

#### Phase 3: Dependency Management
- Auto-install dependencies based on selections
- Set up development scripts in package.json
- Configure build tools and dev servers

#### Phase 4: Claude Code Integration
- Add framework-specific MCP server recommendations
- Include relevant development commands in CLAUDE.md
- Set up project-specific linting and type checking

### File Structure Changes

```
claude-code-init/
├── init-new-project.sh (enhanced)
├── templates/
│   ├── frontend/
│   │   ├── react-vite/
│   │   ├── react-nextjs/
│   │   ├── vue-vite/
│   │   └── vue-nuxt/
│   ├── backend/
│   │   ├── node-express/
│   │   ├── node-fastify/
│   │   ├── python-fastapi/
│   │   └── go-gin/
│   └── shared/
│       ├── claude.template.md
│       ├── project-structure.template.md
│       └── pr-template.md
├── lib/
│   ├── menu-helpers.sh
│   ├── framework-setup.sh
│   └── dependency-installer.sh
└── configs/
    ├── frontend-frameworks.json
    ├── backend-frameworks.json
    └── mcp-servers.json
```

### Implementation Priority

1. **High Priority**
   - Interactive menu system
   - React + Vite template
   - Express + TypeScript template
   - Enhanced CLAUDE.md generation

2. **Medium Priority**
   - Additional framework templates
   - Database integration options
   - MCP server auto-configuration

3. **Low Priority**
   - Authentication setup
   - Advanced tooling configurations
   - CI/CD template generation

## Success Metrics

- User can create a working project in under 2 minutes
- Generated projects include proper Claude Code integration
- All generated projects have working dev/build/test commands
- CLAUDE.md contains accurate, project-specific instructions

## Next Steps

1. Create interactive menu prototype
2. Build React + Vite template
3. Test end-to-end user flow
4. Iterate based on usability feedback