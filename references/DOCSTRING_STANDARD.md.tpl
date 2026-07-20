# Docstring Standard

> **Canonical docstring/JSDoc standard for this project.** Every public function, class, and method MUST follow this guide. PRs that violate it will be blocked by CI.

---

## Purpose

Documentation is a **first-class deliverable**, not an afterthought. In a world where AI coding agents read, write, and refactor our code, the docstring is the contract between human intent and machine behavior. A missing or vague docstring is a latent bug.

This document defines:

1. The required style (Google-style for Python, TSDoc for TypeScript).
2. The minimum set of sections every public symbol must include.
3. The linting and coverage tooling that enforces the standard in CI.
4. The PR-blocking policy.

---

## 1. Scope — What Must Be Documented

| Symbol | Required? | Notes |
|---|---|---|
| Public module/package | Yes | One top-of-file docstring describing the module's purpose. |
| Public class | Yes | Class-level docstring required. |
| Public method on a public class | Yes | Including `__init__` if it takes args. |
| Public function (module-level) | Yes | Including `main()` and CLI entry points. |
| Private function (`_name`) | Recommended | Required if the function is non-trivial (>10 lines or branchy). |
| Property/getter/setter | Yes | Document the underlying contract, not the syntax. |
| Module-level constant | Yes if non-obvious | Document units, valid range, source. |
| Type alias / interface | Yes | One-line minimum. |

If a symbol is exported, it is documented. No exceptions.

---

## 2. Python — Google Style

### 2.1 Canonical Example

```python
def calculate_rectangle_area(width: float, height: float, unit: str = "m") -> float:
    """Calculate the area of a rectangle.

    Multiplies width by height and returns the result. Useful for layout
    calculations in the rendering pipeline.

    Args:
        width: The rectangle's width. Must be positive.
        height: The rectangle's height. Must be positive.
        unit: Unit of measurement label. Used for display only;
            the returned value is always in square units of ``unit``.

    Returns:
        The area as a float, in square units of ``unit``.

    Raises:
        ValueError: If ``width`` or ``height`` is non-positive.

    Example:
        >>> calculate_rectangle_area(3.0, 4.0)
        12.0
    """
    if width <= 0 or height <= 0:
        raise ValueError("dimensions must be positive")
    return width * height
```

### 2.2 Required Sections

Every public function/method docstring **MUST** contain:

1. **One-line summary** — imperative mood ("Calculate…", "Return…", "Parse…"). Period at the end.
2. **(Optional) Extended description** — blank line, then 1–3 sentences of context.
3. **`Args:`** — one entry per parameter, indented, with type-free prose (the type hint is in the signature).
4. **`Returns:`** — what comes back, including the empty/None case.
5. **`Raises:`** — every exception type the function can throw, with the condition.
6. **`Example:`** — at least one doctest-style usage for non-trivial functions.

If a section is genuinely N/A (e.g. a function with no args), omit it — do not write `Args: None`.

### 2.3 Class Docstrings

```python
class InvoiceRepository:
    """Persistent storage for invoice records.

    Wraps a PostgreSQL connection pool and exposes a high-level
    query/mutation API. All methods are thread-safe.

    Attributes:
        pool: The underlying connection pool. Never None after init.
        default_timeout: Default query timeout in seconds.

    Example:
        >>> repo = InvoiceRepository.from_env()
        >>> inv = repo.find_by_id("inv_123")
    """

    def __init__(self, pool: ConnectionPool, default_timeout: float = 30.0):
        """Initialize the repository.

        Args:
            pool: A pre-configured connection pool. The repository
                takes ownership; do not share it across repositories.
            default_timeout: Default per-query timeout, in seconds.
        """
        self.pool = pool
        self.default_timeout = default_timeout
```

### 2.4 Module Docstring

Every `.py` file starts with a module docstring:

```python
"""Invoice domain logic.

This module contains the core invoice entity, validation rules, and
state-machine transitions. It is pure (no I/O) — persistence is handled
by ``invoice_repository``.
"""
```

---

## 3. TypeScript — TSDoc

### 3.1 Canonical Example

```typescript
/**
 * Calculate the area of a rectangle.
 *
 * Multiplies width by height and returns the result. Useful for layout
 * calculations in the rendering pipeline.
 *
 * @param width  - The rectangle's width. Must be positive.
 * @param height - The rectangle's height. Must be positive.
 * @param unit   - Unit of measurement label. Used for display only.
 * @returns The area in square units of `unit`.
 * @throws {RangeError} If `width` or `height` is non-positive.
 *
 * @example
 * ```ts
 * calculateRectangleArea(3, 4); // 12
 * ```
 */
export function calculateRectangleArea(
  width: number,
  height: number,
  unit: string = "px",
): number {
  if (width <= 0 || height <= 0) {
    throw new RangeError("dimensions must be positive");
  }
  return width * height;
}
```

### 3.2 Required Sections

Every exported function/method **MUST** contain:

1. **One-line summary** — imperative mood, period at the end.
2. **`@param`** — one entry per parameter, with a hyphen separator.
3. **`@returns`** — omit only if return type is `void`.
4. **`@throws`** — every error type the function can throw, with the trigger condition.
5. **`@example`** — at least one usage for non-trivial functions.

### 3.3 Class / Interface Docstrings

```typescript
/**
 * Persistent storage for invoice records.
 *
 * Wraps a PostgreSQL connection pool and exposes a high-level
 * query/mutation API. All methods are thread-safe.
 *
 * @example
 * ```ts
 * const repo = InvoiceRepository.fromEnv();
 * const inv = await repo.findById("inv_123");
 * ```
 */
export class InvoiceRepository {
  /**
   * Initialize the repository.
   *
   * @param pool - A pre-configured connection pool. The repository
   *   takes ownership; do not share it across repositories.
   * @param defaultTimeout - Default per-query timeout, in seconds.
   */
  constructor(
    private readonly pool: ConnectionPool,
    private readonly defaultTimeout: number = 30.0,
  ) {}
}
```

---

## 4. Enforcement — Linting & Coverage

### 4.1 Python Toolchain

| Tool | Purpose | Config file |
|---|---|---|
| `pydocstyle` | Style + missing-docstring enforcement | `pyproject.toml` (`[tool.pydocstyle]`) |
| `interrogate` | Docstring **coverage** (the % you must hit) | `pyproject.toml` (`[tool.interrogate]`) |
| `ruff` (rule `D`) | Fast docstring style + missing | `pyproject.toml` (`[tool.ruff.lint] select = ["D"]`) |
| `darglint` | Docstring ↔ signature consistency | `pyproject.toml` (`[tool.darglint]`) |

Minimum coverage threshold: **80%** (`fail-under = 80`).

Recommended `pyproject.toml` snippet:

```toml
[tool.pydocstyle]
convention = "google"
inherit = false
match = "(?!test_).*\\.py"

[tool.interrogate]
fail-under = 80
exclude = ["tests", "migrations", "conftest.py"]
ignore-init-module = true
ignore-magic = true
ignore-private = false
ignore-nested-functions = false
show-uncalled = true
verbose = 2

[tool.ruff.lint]
select = ["D"]
# Allow missing docstrings in tests and __init__.py
[tool.ruff.lint.per-file-ignores]
"tests/**/*.py" = ["D"]
"**/__init__.py" = ["D"]

[tool.darglint]
docstring_style = "google"
strictness = "short"
```

### 4.2 TypeScript Toolchain

| Tool | Purpose | Config file |
|---|---|---|
| `eslint` + `eslint-plugin-jsdoc` | TSDoc style + missing | `.eslintrc.cjs` |
| `typedoc` | API doc generation (build) | `typedoc.json` |

Recommended ESLint rules:

```jsonc
// .eslintrc.cjs (excerpt)
{
  "plugins": ["jsdoc"],
  "rules": {
    "jsdoc/require-jsdoc": [
      "warn",
      {
        "publicOnly": true,
        "require": {
          "FunctionDeclaration": true,
          "MethodDefinition": true,
          "ClassDeclaration": true,
          "ArrowFunctionExpression": false
        },
        "contexts": ["TSInterfaceDeclaration", "TSTypeAliasDeclaration"]
      }
    ],
    "jsdoc/require-param": ["error", { "checkDestructured": false }],
    "jsdoc/require-returns": "error",
    "jsdoc/require-throws": "error",
    "jsdoc/check-alignment": "error"
  }
}
```

### 4.3 Pre-commit Hook

Add to `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/PyCQA/pydocstyle
    rev: 6.3.0
    hooks:
      - id: pydocstyle
        files: '\.py$'
  - repo: https://github.com/econchick/interrogate
    rev: 1.7.0
    hooks:
      - id: interrogate
        args: ["--fail-under=80", "-vv"]
```

### 4.4 CI Gate

A PR **MUST NOT** merge if:

- `pydocstyle` reports any error (Python projects).
- `interrogate --fail-under=80` fails (Python projects).
- `eslint` reports any `jsdoc/*` error (TypeScript projects).
- `ruff` rule `D` reports any error (Python projects, fast path).

The CI job snippet (drop into `.github/workflows/ci.yml`):

```yaml
- name: Docstring coverage (Python)
  if: hashFiles('pyproject.toml') != ''
  run: |
    pip install interrogate pydocstyle darglint
    interrogate -vv --fail-under=80 .
    pydocstyle .

- name: JSDoc lint (TypeScript)
  if: hashFiles('package.json') != ''
  run: |
    npm install --no-save eslint-plugin-jsdoc
    npx eslint 'src/**/*.{ts,tsx}' --rule '{"jsdoc/require-jsdoc": "error"}'
```

---

## 5. AI-Assisted Development Policy

When an AI coding agent (Mavis, Claude Code, Copilot, Cursor, etc.) writes or edits a function:

1. The agent **MUST** write a complete docstring at the same time it writes the function body. Docstring and code are committed together or not at all.
2. The agent **MUST NOT** delete or shorten an existing docstring without an explicit instruction from the human reviewer in the PR description.
3. When refactoring, the agent **MUST** update the docstring to match the new contract. If `Args` or `Returns` change, the docstring is part of the diff.
4. Code review checklists include: "Does every changed public symbol still have a complete, accurate docstring?"

The docstring is the **contract**. The code is the **implementation**. Treat them as inseparable.

---

## 6. Anti-Patterns — Auto-Rejected

The following are **never** acceptable and will fail review:

| Anti-pattern | Why it's bad |
|---|---|
| No docstring on a public function | Forces every reader (human or AI) to reverse-engineer intent. |
| `"""TODO: document this."""` | Lying about documentation. Either write it or mark private. |
| Docstring that just restates the function name | "Calculate the area" on `calculate_area` is noise. |
| Stale docstring (signature changed, doc didn't) | Worse than no docstring — actively misleads. |
| `# type: ignore` style "docstrings" in comments | Comments are not docstrings. Use the right tool. |
| Inconsistent style (Google in one file, NumPy in another) | Breaks tooling and reading flow. Pick one, enforce it. |
| `Args:` with no entries for a function that takes args | Incomplete. Either document them or remove the section. |

---

## 7. Quick Reference Card

| Language | Style | Linter | Coverage Tool | Min % |
|---|---|---|---|---|
| Python | Google | `pydocstyle` + `ruff D` | `interrogate` | 80% |
| TypeScript | TSDoc | `eslint-plugin-jsdoc` | n/a (binary pass/fail) | 100% of public surface |

---

## 8. Bumping the Threshold

The 80% Python floor and the "100% of public surface" TS rule are **starting defaults**, not ceilings. As a project matures:

- **Sprint 0–3:** hold the floor. Don't raise it while the team is still adopting the standard.
- **Sprint 4–8:** if coverage is consistently above 85% with no regressions, raise the floor to **85%** in `pyproject.toml` (`[tool.interrogate] fail-under = 85`) and in `docs/CICD.md`. Bump **both** in the same commit or the CI gate and the documented standard will drift.
- **Sprint 9+:** raise again to 90%, then 95%. Each bump is a separate, reviewable PR.
- **TS projects:** the rule is already "100% of public surface" because TypeScript's tooling is binary — either the docstring is there or it isn't. No gradual ramp.

**Never lower the threshold to make a failing PR pass.** If coverage dropped, the answer is to add docstrings, not weaken the gate. If the gate is wrong (e.g. a new framework forces a different style), open an RFC and update this file in the same PR.

---

## 9. Brownfield Adoption — When the Codebase Already Exists

If you are dropping this standard into a project whose current docstring coverage is well below 80% (e.g. a 2-year-old service at 25%):

1. **Adopt the standard, but do not enable the gate on day one.** Adding `interrogate --fail-under=80` to a 25% codebase will block every PR instantly and the team will revolt.
2. **Measure first.** Run `interrogate -vv .` and capture the report as a build artifact. Commit the report to `docs/SPRINTS.md` as the baseline.
3. **Set a floor you can hit today.** In `pyproject.toml`, set `fail-under = <current_coverage>` so the existing state is the baseline. The standard still applies to all *new* code from this point forward.
4. **Plan a sprint-by-sprint ramp** in `docs/SPRINTS.md`. Example:
   - Sprint 1: raise floor from 25% → 35%. Touch the 3 modules with the lowest coverage and document them properly.
   - Sprint 2: 35% → 50%. Continue file-by-file, ordered by call frequency (most-imported first).
   - Sprint 3: 50% → 70%.
   - Sprint 4: 70% → 80%. The standard's default floor.
5. **No blanket `noqa`.** Every suppression is a targeted `# noqa: D401` with a justification comment, reviewed in PR. Track suppression count as a metric; it should decrease over time, not increase.
6. **New code is held to 80% from day one**, even if the legacy code is below. A new module's docstring coverage is measured separately from the project total if needed.
7. **Surface the ramp in the README's "Documentation" section** so new contributors know the floor is temporary and where the project is heading.

The goal is "every new commit makes the codebase more documented, never less." The ramp is a tool to make that goal achievable, not an excuse to ignore the standard.

---

## On Errors

When CI fails on a docstring check:

1. Read the file:line from the linter output.
2. Open the function and write a real docstring (don't paste a stub).
3. Re-run the linter locally: `pydocstyle path/to/file.py` or `npx eslint path/to/file.ts`.
4. If the linter is wrong (false positive), either fix the function or add a targeted `# noqa: D` (Python) / `// eslint-disable-next-line jsdoc/require-jsdoc` (TS) with a justification comment. **Never blanket-disable.**
5. If you genuinely believe the rule is wrong, open an RFC in `references/OPERATING_GUIDELINES.md` — don't bypass silently.
