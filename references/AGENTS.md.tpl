# [Folder Name] AGENTS.md

## Purpose
This directory contains [description of what this folder holds].

---

## Directory Structure
```
[folder]/
├── [file1.ts]         # Purpose
├── [file2.ts]         # Purpose
└── [file3.ts]         # Purpose
```

---

## Coding Standards

### File Naming
- Components: `PascalCase.tsx`
- Utilities: `kebab-case.ts`
- Tests: `*.test.ts` (same name as source)
- Types: `*.types.ts` or inline

### Code Organization
1. Imports (external → internal → relative)
2. Types/Interfaces
3. Constants
4. Main implementation
5. Exports

### Documentation Requirements

This directory follows three project-wide standards. The full rules live in their respective files; the TL;DRs are below.

- **[DOCSTRING_STANDARD.md](../../DOCSTRING_STANDARD.md)** — every public function/class/method/type has a complete docstring (summary + Args/Returns/Raises + Example). See below for the TL;DR.
- **[DESIGN_SYSTEM.md](../../DESIGN_SYSTEM.md)** — every UI value comes from a token. No hex literals, no off-scale spacing, no non-Phosphor icons, no decorative gradients/glassmorphism/blurs. Tokens are the wire format; off-token styles are a bug.
- **[VOICE_GUIDE.md](../../VOICE_GUIDE.md)** — every user-facing string follows the voice rules. Banned phrases, em-dash ban in body copy, no "Oops!", no emoji in UI, buttons ≤ 3 words, error messages state consequence + action. Lint-enforced via Vale + a custom ESLint rule.

### Docstring Standard (TL;DR)

- **Public surface only** is enforced — every exported function, class, method, type, and module-level constant must have a docstring.
- **Style:** TSDoc/JSDoc for TypeScript (this directory), Google-style docstrings for Python. No mixing within a language.
- **Required sections:** one-line summary → `@param` (one per arg) → `@returns` (if not `void`) → `@throws` (if any) → `@example` (for non-trivial functions).
- **Anti-patterns auto-rejected:** missing docstrings, `TODO: document this` placeholders, docstrings that just restate the function name, stale docstrings whose signature has drifted.
- **AI agents** (Mavis, Claude Code, Copilot, Cursor) must write the docstring at the same time they write the function body. No "I'll add docs later."
- Comments are not docstrings. Use `//` for inline notes, `/** */` for the contract.

Reference example (target shape):

```typescript
/**
 * Calculate the area of a rectangle.
 *
 * @param width  - The rectangle's width. Must be positive.
 * @param height - The rectangle's height. Must be positive.
 * @returns The area as `width * height`.
 * @throws {RangeError} If `width` or `height` is non-positive.
 *
 * @example
 * ```ts
 * calculateRectangleArea(3, 4); // 12
 * ```
 */
```

---

## Testing Requirements

### Coverage Target
- **Minimum:** [X]% line coverage
- **Branches:** [X]% branch coverage

### Test Location
- Unit tests: Co-located with source
- Integration tests: `tests/integration/`
- E2E tests: `tests/e2e/`

### Test Naming Convention
```typescript
describe('[Component/Function]', () => {
  describe('[method/action]', () => {
    it('should [expected behavior] when [condition]', () => {
      // Arrange
      // Act
      // Assert
    });
  });
});
```

---

## Common Patterns

### Pattern 1: [Pattern Name]
```typescript
// Example usage
```

### Pattern 2: [Pattern Name]
```typescript
// Example usage
```

---

## Dependencies
- **Internal:** [List internal dependencies]
- **External:** [List key external packages]

---

## File Dependency Chain
```
[file3.ts]  ← [file2.ts]  ← [file1.ts]
     ↑              ↑              ↑
  Business      Domain         Core
  Logic         Services       Utilities
```

---

## Important Notes
- [Critical rule 1]
- [Critical rule 2]
- [Critical rule 3]

---

## On Errors
When debugging issues in this directory:
1. Check [specific thing]
2. Verify [specific thing]
3. Test [specific thing]

When CI fails on a **docstring check** in this directory:
1. Read the file:line from the linter output (`pydocstyle`, `ruff D`, or `eslint jsdoc/*`).
2. Open the function and write a real docstring matching [DOCSTRING_STANDARD.md](../../DOCSTRING_STANDARD.md). Don't paste a stub.
3. Re-run the linter locally before pushing: `pydocstyle path/to/file.py` or `npx eslint path/to/file.ts`.
4. If the linter is wrong, add a **targeted** suppression with a justification comment. Never blanket-disable the rule.

When CI fails on a **design system check** in this directory:
1. Read the file:line from the stylelint / hex-grep / icon-grep output.
2. Open the file. Replace the off-token value with the closest token from [DESIGN_SYSTEM.md](../../DESIGN_SYSTEM.md) §1. If no token fits, file an RFC to add one — don't bypass.
3. Re-run the linter locally: `npx stylelint path/to/file.tsx`.
4. If the linter is wrong, add a **targeted** disable with a justification comment. Never blanket-disable.

When CI fails on a **voice / writing check** in this directory:
1. Read the file:line and the banned phrase from Vale or ESLint.
2. Open [VOICE_GUIDE.md](../../VOICE_GUIDE.md) §2.1 and find the suggested replacement. Rewrite the string — don't paraphrase the banned phrase to dodge the lint.
3. Re-run the linter locally: `vale path/to/file.md` or `npx eslint path/to/file.tsx`.
4. If the phrase is genuinely the right word here (e.g. "leverage" as a finance term), update the vocab file or file an RFC. Never blanket-disable.