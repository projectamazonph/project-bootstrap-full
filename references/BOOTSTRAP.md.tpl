# Session Bootstrap Prompt

**Paste this at the start of a new session.**

---

```
Repo: https://github.com/[org]/[project-name]
Branch: main (squash-only merge, branches auto-delete on merge)
Local: /[workspace]/[project-name]/
Tech: [tech stack]
Architecture: SOLID five-layer (domain/ → ports/ → usecases/ → infra/ → app/)

Docs: AGENTS.md → CLAUDE.md → OPERATING_GUIDELINES.md → SESSION-TDD-SOLID-AUDIT.md → SESSION-HANDOVER.md → docs/build-spec.md → docs/stories/ (story docs live here)
```

**For new sessions, also read `NEXT-SESSION-PROMPT.md`** — it has the
strict-TDD + strict-SOLID + git discipline + initial setup, plus what's
still open (Tier B/C/D from the recent audit).

---

## Status (YYYY-MM-DD)

**Sprint X and Y complete. No open PRs.**

| # | Story | Status |
|---|-------|--------|
| #001 | Feature description | ✅ merged |
| #002 | Feature description | ✅ merged |

**Test counters:** X/Y passing, 0 tsc errors. Recent PRs: #XX (Description, Tier B, +N).

**After any branch switch or `git pull`:** run `npx prisma migrate dev` if the schema has new models that need migration.

---

## Quality gate

```bash
cd /[workspace]/[project-name]
./node_modules/.bin/tsc --noEmit && ./node_modules/.bin/vitest run
```

For vitests that import the container (which uses Prisma):
```bash
DATABASE_URL="postgresql://test:test@localhost:5432/[project]_test" \
JWT_SECRET="test-secret-at-least-32-bytes-long-please" \
  ./node_modules/.bin/vitest run
```

---

## Git rules

- One story = one branch = one PR
- `git checkout -b feature/story-XXX` from `main`
- Stage specific paths only: `git add src/domain/entities/Badge.ts tests/unit/domain/entities/Badge.test.ts`
- Never `git add .`
- Squash-merge into `main`
- Conventional commits: `feat(story-035): description`
- Bypass husky for local commits: `git -c core.hooksPath=/dev/null commit`
- Direct push to `main` blocked by GH repo rules — all commits go through PRs

## Sprint roadmap

See `docs/sprint-plan.md` for the full X-sprint, Y-story plan.

| Sprint | Theme | Status |
|--------|-------|--------|
| 1 | Foundation | ✅ done |
| 2 | Core features | next |
| 3+ | TBD | pending |

**Next story to pick up:** STORY-XXX (Description). Depends on STORY-YYY which should be checked first — see the story doc.