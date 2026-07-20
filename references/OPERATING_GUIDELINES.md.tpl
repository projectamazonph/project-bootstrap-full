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

Required (also run in CI, fails the build if it breaks):
```bash
# TypeScript — JSDoc / TSDoc lint
npx eslint 'src/**/*.{ts,tsx}' --rule '{"jsdoc/require-jsdoc": "error"}'

# Python — if pyproject.toml is present
pydocstyle .
interrogate -vv --fail-under=80 .
ruff check --select D .

# Design system — if DESIGN_SYSTEM.md is present
npx stylelint "src/**/*.{css,scss,tsx,ts}" --max-warnings=0
! grep -rE "linear-gradient\(|backdrop-filter:|filter: blur\(" src/ --include="*.css" --include="*.tsx"
! grep -rEn "#[0-9a-fA-F]{3,8}" src/ --include="*.css" --include="*.tsx" --include="*.ts" | grep -v "tokens/"

# Voice / writing — if VOICE_GUIDE.md is present
vale --config .vale.ini docs/ README.md
npx eslint 'src/**/*.{ts,tsx}' --rule '{"no-ai-slop/no-ai-slop": "error"}' --max-warnings=0
```

Optional (run separately):
```bash
pnpm lint
```

**CI on GitHub runs the same commands.** If CI fails on a PR — tests, typecheck, docstring lint, design-system lint, or voice lint — the PR cannot be merged. The full rules are in three project standards; the TL;DR for each:

- **[DOCSTRING_STANDARD.md](../../DOCSTRING_STANDARD.md)** — every public function/class/method/type has a complete docstring (summary + Args/Returns/Raises + Example). Python coverage ≥ 80% via `interrogate`. TypeScript: `eslint jsdoc/*` is `error`.
- **[DESIGN_SYSTEM.md](../../DESIGN_SYSTEM.md)** — every UI value comes from a token. No hex literals in component code, no off-scale spacing, no non-Phosphor icons, no decorative gradients/glassmorphism/blurs. Linted via stylelint + grep + axe-core.
- **[VOICE_GUIDE.md](../../VOICE_GUIDE.md)** — every user-facing string follows the voice rules. Banned phrases (~80), em-dash ban in body copy, no "Oops!" in errors, no emoji in UI, buttons ≤ 3 words. Linted via Vale + custom ESLint rule.

When an AI agent (Mavis, Claude Code, Copilot, Cursor) writes code or copy, it follows all three standards in the same change. The docstring is the **contract**; the code is the **implementation**; the design tokens and the voice are the **user-facing surface**. They ship together.

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
3. Write the port interface (src/ports/)     — with full TSDoc
4. Write the domain entity  (src/domain/entities/)  — with full TSDoc
5. Write the use case      (src/usecases/)    — with full TSDoc
6. Write the adapter      (src/infra/)        — with full TSDoc
7. Wire in container       (src/composition/container.ts)
8. Write the app layer    (src/app/)          — with full TSDoc
9. pnpm typecheck && pnpm test
10. npx eslint 'src/**/*.{ts,tsx}'          — JSDoc must be clean
11. Stage specific files only
12. Commit, push, open PR
```

Step 3 onward: **the docstring is part of the function, not a follow-up.** A PR that ships a new exported function without a complete docstring is incomplete and will be blocked in review and by CI.

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