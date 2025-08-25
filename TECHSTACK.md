# Tech Stack Selection

Modern, production-ready stacks optimized for Claude Code development workflows.

## 1. Full-Stack Applications
- **Next.js 14+ (App Router)** + TypeScript + Tailwind v4 + Turbo
- **Next.js 14+ (Pages Router)** + TypeScript + Tailwind v4 + Turbo

## 2. Frontend Applications
- **React** + TypeScript + Vite + Tailwind v4
- **Vue 3** + TypeScript + Vite + Tailwind v4  
- **Angular** + TypeScript + Angular CLI + Tailwind v4
- **Svelte** + TypeScript + SvelteKit + Tailwind v4
- **TanStack Start** + TypeScript + Vite + Tailwind v4

## 3. Backend APIs
- **Node.js** + Express + TypeScript + Prisma
- **Node.js** + Fastify + TypeScript + Prisma
- **Node.js** + tRPC + Express + TypeScript + Prisma

## 4. Database Options
- **PostgreSQL** (recommended for production)
- **SQLite** (great for development/prototyping)
- **MongoDB** (document-based projects)
- **None** (API clients or static sites)

## 5. Additional Configurations

### Authentication
- **None** (manual implementation)
- **NextAuth.js** (Next.js projects)
- **Clerk** (modern auth platform)
- **Supabase Auth** (if using Supabase)

### Testing
- **Vitest** (Vite-based projects)
- **Jest** (traditional setup)
- **Playwright** (E2E testing)
- **None** (add later)

### Deployment Targets
- **Vercel** (Next.js optimized)
- **Netlify** (static/JAMstack)
- **Railway** (full-stack apps)
- **Docker** (containerized deployment)

## Stack Combinations

### Recommended Pairings
- **Next.js Full-Stack**: Next.js + PostgreSQL + Vercel
- **React SPA**: React + Vite + Backend API + Netlify  
- **API Service**: Fastify + PostgreSQL + Railway
- **Prototype**: React + Vite + SQLite + Netlify

### MCP Server Recommendations by Stack
- **Next.js**: Browser MCP, Database MCP, Vercel MCP
- **React + Vite**: Browser MCP, HTTP Client MCP
- **TanStack Start**: Browser MCP, HTTP Client MCP, Database MCP
- **Backend APIs**: Database MCP, HTTP Client MCP, Cloud Provider MCP
- **Full-Stack**: Browser MCP + Database MCP + Cloud Provider MCP
