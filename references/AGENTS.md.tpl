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
- JSDoc for public functions
- Comments for complex logic
- No comments that restate the code

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