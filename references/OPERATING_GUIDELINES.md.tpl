# Operating Guidelines

**[project-name]** — living document. Update after every session.

---

## Git Discipline (Non-negotiable)

### One story = one branch = one PR

Every story gets its own branch, cut from the tip of `main`.

```
git checkout main && git pull origin main
git checkout -b feature/story-XXX
# ... implement ...
git push origin feature/story-XXX
# open PR via GitHub UI or API
```

**Merge order** (checked by PR dependency labels):
1. Feature A → #1
2. Feature B → #2 (depends on #1)
3. Feature C → #3 (depends on #1+#2)

### Commits

- **Conventional format:** `feat(story XXX): description`
- **Scope first:** `feat(story 013)`, `fix(story 013)`, `chore(deps)`
- **Meaningful body:** list files touched, why, what changed
- **Squash-merge into `main`:** one clean commit per story

### Never do this

```
git add .                    # BAD — stages everything
git add --all               # BAD — includes generated files
git commit -a              # BAD — bypasses review intent
git push --force main       # NEVER — main is protected
```

Stage only specific paths:

```bash
git add src/domain/entities/Course.ts tests/unit/course.test.ts
git commit -m "feat(domain): add Course entity with slug validation"
```

---

## TDD Protocol

Every feature follows **red → green → refactor**:

1. **Red:** Write a failing test first. Run `pnpm test` — it must fail.
2. **Green:** Write the minimum implementation to make it pass. No shortcuts.
3. **Refactor:** Clean up, apply SOLID principles, run tests again.

```bash
# Verify green before every commit
pnpm typecheck && pnpm test
```

If those fail → fix the code, not the tests.

---

## Quality Gate

**Every commit must pass before pushing:**

```bash
pnpm typecheck && pnpm test
```

Optional (run separately):
```bash
pnpm lint
```

**CI on GitHub runs the same commands.** If CI fails on a PR, the PR cannot be merged.

---

## Architecture Rules

### Five layers, dependency direction always inward

```
app/         → usecases/ → ports/ ← infra/
              domain/  (imports nothing from outer layers)
```

- `src/domain/` — pure entities, value objects. No imports from any outer layer.
- `src/ports/` — interfaces only. Every method returns `Promise<Result<T, E>>`.
- `src/usecases/` — one class per use case. Constructor-injected ports.
- `src/infra/` — adapters (Prisma, PayMongo, Resend, jose, etc.).
- `src/app/` — Next.js App Router. Server actions are thin shims.
- `src/composition/` — the single DI container.

### ESLint boundary rule

`domain/`, `ports/`, and `usecases/` **cannot** import from `infra/` or `app/`. This is enforced by ESLint. Do not bypass it.

### Result<T, E> across all layer boundaries

Never `throw` from domain, ports, or usecases. Always return `Result.ok(value)` or `Result.err(error)`.

---

## Adding a Feature (Standard Recipe)

```
1. Read the story .md in docs/stories/
2. Write the failing tests  (src/usecases/__tests__/)
3. Write the port interface (src/ports/)
4. Write the domain entity  (src/domain/entities/)
5. Write the use case      (src/usecases/)
6. Write the adapter      (src/infra/)
7. Wire in container       (src/composition/container.ts)
8. Write the app layer    (src/app/)
9. pnpm typecheck && pnpm test
10. Stage specific files only
11. Commit, push, open PR
```

---

## Naming Conventions

| Thing | Convention | Example |
|-------|-----------|---------|
| Use case class | PascalCase, noun | `Login`, `ListCourses` |
| Port interface | PascalCase, noun | `UserRepository` |
| Domain function | camelCase | `createCourse`, `sessionIsValid` |
| Test file | `*.test.ts` | `Login.test.ts` |
| Server action | verb phrase | `enrollStudent` |
| Page route | kebab-case dir | `app/courses/[slug]/page.tsx` |

---

## Environment Variables

Copy `.env.example` → `.env.local` before running locally.

| Variable | Description |
|----------|-------------|
| `DATABASE_URL` | PostgreSQL connection string |
| `JWT_SECRET` | Min 32 chars. Used for HS256 JWT signing. |
| `PAYMENT_SECRET` | Payment gateway sandbox/live secret key |
| `PAYMENT_WEBHOOK_SECRET` | Payment gateway webhook signing secret |
| `EMAIL_API_KEY` | Email service API key |
| `SENTRY_DSN` | Sentry DSN (optional in dev) |
| `EMAIL_VERIFICATION_SECRET` | Min 32 chars. Used for email verification tokens. |

---

## Common Commands

```bash
pnpm dev          # local dev server
pnpm build        # production build
pnpm test         # vitest unit tests
pnpm typecheck    # tsc --noEmit
pnpm lint         # eslint
pnpm prisma:generate   # regenerate Prisma client
pnpm prisma:migrate    # run migrations
```

---

## Reporting Issues

- Bug: use the bug report issue template
- Feature: use the feature request issue template  
- Story work: open a draft PR referencing the story number

---

## Pre-Story Audit Checklist

**Do not start a story until all open audit items are closed.** See
`SESSION-TDD-SOLID-AUDIT.md` for the current open items (Tier B/C/D
from the recent TDD+SOLID audit).

The rule: **"we don't move a story until existing issues are
addressed."** The audit established these patterns — **reuse them**:

- **Pure-helper + thin-shell** for every server action
- **Container as the only data-access path** (no `new InMemory*` in prod)
- **Lazy initialization** for env-dependent adapters (don't throw at
  module load)
- **Per-call env reads** (don't capture at module load)
- **Static-analysis regression guards** for cases where the unit-test
  surface is limited (async server components, framework glue)

See `SESSION-TDD-SOLID-AUDIT.md` for full examples.