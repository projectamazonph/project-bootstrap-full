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

This directory follows the project-wide [DOCSTRING_STANDARD.md](../../DOCSTRING_STANDARD.md). The TL;DR:

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