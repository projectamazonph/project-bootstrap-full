# Combined Essential Instructions from amph-v2

## Core Principles

### From AGENTS.md - The Five Rules
1. **Zero AI features.** No `openai`, `anthropic`, `langchain`, or any LLM API. No mentor chat, no AI mistake analysis.
2. **One icon set.** Phosphor (light) only. No Heroicons, no Lucide.
3. **One font pairing.** Space Grotesk + JetBrains Mono. No Inter, no system fonts in product UI.
4. **Server actions for mutations.** Reserve API routes for webhooks, file uploads, third-party.
5. **Every admin action logs to AuditLog.** No exceptions.

### From CLAUDE.md - Architecture & Commands
- **Route protection:** `src/lib/route-guards.ts` holds pure, unit-tested route-classification functions.
- **Tool registry:** `src/engine/registry.ts`'s `TOOL_REGISTRY` is the single source of truth for each tool's scenario list.
- **Commands:** `pnpm dev`, `pnpm build`, `pnpm typecheck`, `pnpm lint`, `pnpm test`, `pnpm test:coverage`, `pnpm test:e2e`.

## Voice & Design

### Voice (AGENTS.md)
Direct, plain-spoken, Filipino VA audience. No jargon without definition. No AI-slop phrases.

### Design System (AGENTS.md)
Field Manual. Dense, scannable, utilitarian. Off-white surface. Orange accent (#FF6B35). Type-led hierarchy. No glassmorphism, no gradient orbs, no decorative blurs.

## Technical Standards

### Database (AGENTS.md)
PostgreSQL (dev + production). Schema uses no SQLite-specific features. Every mutable table has `deletedAt`, `createdById`, `updatedById`.

### Code Style (AGENTS.md)
- TypeScript strict. No `any`. Define types or use `unknown` with narrowing.
- Server components by default. `'use client'` only when needed.
- No `console.log` in committed code. Use the structured logger.
- No comments that restate the code. Comment the why, not the what.
- File names: `kebab-case.ts` for non-component files, `PascalCase.tsx` for components.

### Testing (AGENTS.md)
- Vitest for unit + integration.
- Playwright for E2E.
- Tests live next to the code they test: `foo.ts` → `foo.test.ts`.
- Coverage thresholds enforced in CI: 70% on `src/lib` and `src/app/actions`.

## Development Workflow

### Commits (AGENTS.md)
- Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.
- One concern per commit. Don't mix refactor + feature.
- Reference story IDs: `feat(admin): user list table (STORY-027)`.
- Always `git commit` after work. Never leave uncommitted changes.

### Branching (AGENTS.md)
- `main` — production-ready
- `feat/*` — feature branches
- `fix/*` — bugfix branches
- Branch off `main`, PR back to `main`.
- Squash merge.

### CI Requirements (AGENTS.md)
- `pnpm tsc --noEmit` — zero type errors
- `pnpm lint` — zero ESLint errors (includes no-ai-slop)
- `pnpm test` — all tests pass
- `pnpm test:coverage` — coverage above threshold
- `pnpm test:e2e` — Playwright suite passes
- `pnpm build` — production build succeeds
- Lighthouse CI — performance budget met
- `gitleaks detect` — no secrets in diff

## File Dependency Chain (AGENTS.md)
```
src/lib/        ← Pure utilities, no deps
   ↑
src/components/ ← UI primitives, depend on lib
   ↑
src/app/        ← Routes, depend on components + lib
   ↑
tests/          ← Mirror src structure
```

Lower layers must not import from higher layers. `src/lib/auth.ts` cannot import from `src/app/`.

## Don't Do (AGENTS.md)
- Don't add dependencies without updating `package.json` and `pnpm-lock.yaml`.
- Don't use `fetch` directly in components. Use server actions.
- Don't store secrets in code. Use env vars.
- Don't commit `.env*` files. `.env.example` is allowed.
- Don't use emojis in code or commit messages.
- Don't use em-dashes. Use periods, commas, parentheses.
- Don't write generic AI-slop copy.
- Don't ship code without tests for new features (admin and business layer are mandatory).
- Don't ignore the AuditLog. Every admin mutation logs.

## Error Handling (AGENTS.md)
When something breaks:
1. Read the actual error. Don't guess.
2. Reproduce in the smallest possible test.
3. Fix root cause, not symptom.
4. Add a test that would have caught this.
5. Commit fix + test together.

## Memoria Protocol (AGENTS.md)
This repo uses Memoria for cross-agent context. Tag memories with:
- `project:amph-v2`
- `phase:1` (analysis), `2` (planning), `3` (solutioning), `4` (implementation), `5` (enrichment)
- `agent:dusk` (this instance)

## Business Layer (AGENTS.md)
PayMongo for payments (one-time, Philippine peso, GCash/Maya/card/bank). Three pricing tiers. Refund window 7 days. Tax-compliant receipts.

## Admin Panel (AGENTS.md)
`/admin/*` gated by `requireAdmin()`. Every route has search, filter, pagination. Every mutation is audited.