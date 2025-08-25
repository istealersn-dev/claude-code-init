# Agent Integration Guide

This guide shows how tech stack agents integrate with your existing commands to provide specialized, context-aware assistance.

## Agent Selection Logic

Agents are automatically selected based on your project's tech stack choices:

```bash
# During project initialization
./init-new-project.sh --name myapp --type web --framework react --database postgres

# This automatically copies:
# - _agents/frontend/react-vite-expert.md (react-vite-tailwind-expert agent)
# - _agents/database/postgresql-expert.md (postgresql-expert agent)
```

## Command Integration Examples

### `/implement` with Tech Stack Agents

**Without Agents (Current):**

```markdown
User: /implement user authentication
Assistant: I'll implement user authentication using general patterns...
```

**With Tech Stack Agents (Enhanced):**

```markdown
User: /implement user authentication
Assistant: I'll implement user authentication using React + Express + PostgreSQL patterns.

*Automatically uses:*
- react-vite-tailwind-expert: For React hooks, context, form handling, and beautiful UI styling
- express-expert: For JWT middleware and route protection
- postgresql-expert: For user table design and indexing
```

### `/scaffold` with Framework-Specific Patterns

**Next.js Project Example:**

```markdown
User: /scaffold UserProfile
Assistant: *Uses nextjs-tailwind-expert agent*

Creating UserProfile with Next.js App Router + Tailwind patterns:
- app/profile/page.tsx (Server Component with styled layout)
- app/profile/edit/page.tsx (Client boundary with form styling)
- components/UserForm.tsx (Client Component with Tailwind styling)
- Server Actions for form handling
- Proper TypeScript integration
- Responsive design with Tailwind utilities
```

**React + Vite Project Example:**

```markdown
User: /scaffold UserProfile  
Assistant: *Uses react-vite-tailwind-expert agent*

Creating UserProfile with React + Vite + Tailwind patterns:
- components/UserProfile/index.tsx (with beautiful Tailwind styling)
- hooks/useUser.ts (custom hook)
- context/UserContext.tsx (if needed)
- Vite-optimized imports and lazy loading
- Component variants with Tailwind utilities
```

### `/test` with Stack-Aware Testing

**Express API Project:**

```markdown
User: /test
Assistant: *Uses express-expert agent*

Running Express.js specific tests:
- Supertest for API endpoint testing
- JWT middleware validation tests
- Database integration tests with test containers
- Request/response validation tests
```

**React Project:**

```markdown
User: /test
Assistant: *Uses react-vite-tailwind-expert agent*

Running React + Vite tests:
- Vitest as test runner (Vite-native)
- React Testing Library for components
- MSW for API mocking
- Component interaction testing
```

### `/security-scan` with Database-Specific Checks

**PostgreSQL Project:**

```markdown
User: /security-scan
Assistant: *Uses postgresql-expert agent*

PostgreSQL-specific security analysis:
- SQL injection vulnerability scanning
- Row-level security policy validation
- Database privilege audit
- Connection security analysis
- Query parameter validation
```

## Agent Combination Patterns

### Full-Stack Next.js + PostgreSQL

```yaml
Active Agents:
  - nextjs-tailwind-expert: App Router, Server Components, Server Actions, Tailwind styling
  - postgresql-expert: Schema design, query optimization

Command Behavior:
  /implement: Uses Next.js patterns with PostgreSQL integration and beautiful UI
  /scaffold: Creates App Router structure with styled components and database models  
  /test: Next.js + PostgreSQL integration testing with UI component testing
  /security-scan: Full-stack security analysis
```

### React SPA + Express API

```yaml
Active Agents:
  - react-vite-tailwind-expert: Modern React patterns, Vite optimization, Tailwind styling
  - express-expert: API development, middleware patterns
  - postgresql-expert: Database design and queries

Command Behavior:
  /implement: Separates frontend/backend implementation
  /scaffold: Creates both React components and API endpoints
  /test: Frontend and backend testing strategies
  /review: Full-stack code review patterns
```

## Agent Context Awareness

Each agent maintains awareness of:

1. **Project Structure**: Adapts to your existing file organization
2. **Dependencies**: Uses your installed packages and versions  
3. **Conventions**: Follows your established code patterns
4. **Integration Points**: Understands how components interact

### Example: Database Integration Awareness

**PostgreSQL Agent** knows when working with:

- **Prisma**: Uses Prisma-specific patterns and migrations
- **Express**: Provides connection pool and middleware patterns
- **Next.js**: Adapts for edge runtime and serverless constraints

**SQLite Agent** knows when working with:

- **Development**: Optimizes for rapid iteration and testing
- **Prisma**: Uses SQLite-specific Prisma configurations
- **Local-first apps**: Provides offline-first patterns

## Command Enhancement Examples

### Enhanced `/implement` Workflow

```bash
User: /implement payment processing
Assistant: 
1. *Detects tech stack: Next.js + PostgreSQL + Tailwind*
2. *Loads relevant agents automatically*
3. *nextjs-tailwind-expert*: Creates Server Actions for payment processing with styled forms
4. *postgresql-expert*: Designs payment tables with proper constraints
5. *Integrates all components with proper error handling and beautiful UI*
```

### Enhanced `/scaffold` with Cross-Stack Awareness

```bash
User: /scaffold OrderManagement
Assistant:
1. *react-vite-tailwind-expert*: Creates React components and hooks with Tailwind styling
2. *express-expert*: Generates API endpoints and middleware
3. *postgresql-expert*: Creates database schema and indexes
4. *Links frontend components to backend endpoints*
5. *Creates integration tests across the stack*
```

## Agent File Structure in Projects

After initialization, your project will have:

```markdown
your-project/
├── .agents/                    # Copied from claude-code-init
│   ├── nextjs-expert.md           # nextjs-tailwind-expert agent
│   └── postgresql-expert.md       # postgresql-expert agent
├── CLAUDE.md                   # Enhanced with agent context
├── src/
└── ...
```

## Configuration Integration

Your `CLAUDE.md` will be enhanced with agent-specific instructions:

```markdown
# Project: MyApp (Next.js + PostgreSQL + Tailwind)

## Active Agents
- **nextjs-tailwind-expert**: App Router patterns, Server Components, Tailwind styling
- **postgresql-expert**: Database design and optimization

## Stack-Specific Commands
- Use `/implement` for Next.js-optimized feature development with beautiful UI
- Use `/scaffold` for App Router component structure with Tailwind styling
- Use `/test` for Next.js + PostgreSQL integration testing with UI components

## Agent Context
- Framework: Next.js 14+ App Router with Tailwind CSS v4
- Database: PostgreSQL with Prisma ORM
- Styling: Integrated Tailwind CSS with design tokens and dark mode
```

This integration creates a **context-aware development environment** where every command understands your exact tech stack and provides optimized assistance accordingly.
