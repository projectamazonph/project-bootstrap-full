# Design System

> **Canonical design standard for this project.** Every color, font, spacing value, icon, and motion token comes from this document. Anything not in the tokens is a bug. PRs that introduce off-token styles are blocked by CI.

---

## Purpose

A design system is not a Figma file. It is a **lint-enforceable contract** between the design intent and the code that ships. Without a token-backed standard, every contributor (human or AI) invents values ad hoc, and the product drifts toward the default AI aesthetic: blue gradients, glassmorphism, generic illustrations, system fonts, and emoji-laden buttons.

This document defines:

1. The token set (color, typography, spacing, radius, shadow, motion, density, z-index).
2. The AI-slop ban list — visual patterns that read as "made by an LLM" and degrade trust.
3. The icon, illustration, and imagery rules.
4. The linting + CI enforcement.
5. The dark-mode parity requirement.
6. The brownfield adoption playbook.

The anchor decisions are **non-negotiable** unless the project overrides them in a written RFC. They are:

- **One icon set:** Phosphor (light) only.
- **One font pairing:** Space Grotesk + JetBrains Mono.
- **One accent color:** Orange `#FF6B35` (already in use; do not change without a redesign).
- **No glassmorphism, no decorative gradients, no decorative blurs.**

---

## 1. Tokens

All tokens live in a single `tokens/` directory at the project root, authored as [Style Dictionary](https://amzn.github.io/style-dictionary/) JSON and compiled per-platform (CSS variables, Tailwind config, Swift, Kotlin, etc.). The source of truth is JSON; everything else is generated.

### 1.1 Color

| Token | Value | Use |
|---|---|---|
| `color.surface.base` | `#FAF7F2` (off-white) | App background. |
| `color.surface.raised` | `#FFFFFF` | Cards, modals, sheets. |
| `color.surface.sunken` | `#F0EBE3` | Inset wells, code blocks. |
| `color.text.primary` | `#1A1A1A` | Body copy. |
| `color.text.secondary` | `#5C5C5C` | Meta, captions. |
| `color.text.muted` | `#8A8A8A` | Placeholder, disabled. |
| `color.text.inverse` | `#FFFFFF` | On dark / accent. |
| `color.accent.base` | `#FF6B35` | Primary CTA, focus ring, link. |
| `color.accent.hover` | `#E55A28` | Hover state for accent. |
| `color.accent.subtle` | `#FFE4D9` | Accent-tinted background, badges. |
| `color.border.subtle` | `#E5E0D7` | Default dividers. |
| `color.border.strong` | `#1A1A1A` | High-contrast dividers, table headers. |
| `color.status.success` | `#2E7D4F` | Success states. |
| `color.status.warning` | `#B45309` | Warning states. |
| `color.status.danger` | `#B91C1C` | Destructive / error. |
| `color.status.info` | `#1E5A8A` | Informational. |

**Rules:**

- Use only these tokens. No hex literals in component code. Lint will reject `#RRGGBB` outside `tokens/`.
- The dark theme inverts the surface scale and lowers text contrast; it does not introduce new hues.
- Color contrast: WCAG AA minimum (4.5:1 for body, 3:1 for large text and UI components). Lint checks every text/background pair via `color-contrast()`.

### 1.2 Typography

| Token | Value | Use |
|---|---|---|
| `font.family.display` | `Space Grotesk` | Headings, hero. |
| `font.family.body` | `Space Grotesk` | Body copy. (No Inter, no system font stacks in product UI.) |
| `font.family.mono` | `JetBrains Mono` | Code, IDs, table numerics. |
| `font.size.xs` | `12px` | Caption, fine print. |
| `font.size.sm` | `14px` | Body small, table cells. |
| `font.size.base` | `16px` | Body default. |
| `font.size.lg` | `18px` | Lead paragraph. |
| `font.size.xl` | `24px` | H3. |
| `font.size.2xl` | `32px` | H2. |
| `font.size.3xl` | `48px` | H1. |
| `font.size.4xl` | `64px` | Hero only. |
| `font.weight.regular` | `400` | Body. |
| `font.weight.medium` | `500` | Labels. |
| `font.weight.bold` | `700` | Headings, emphasis. |
| `font.lineHeight.tight` | `1.2` | Headings. |
| `font.lineHeight.normal` | `1.5` | Body. |
| `font.lineHeight.relaxed` | `1.7` | Long-form. |

**Rules:**

- No `font-family: Inter, system-ui, sans-serif`. Period. Lint rejects any non-token family.
- No `font-weight: 600` (token is `medium` = 500 or `bold` = 700). 600 is forbidden — it does not exist in the Space Grotesk loading strategy.
- Headings use `tight` line-height; body uses `normal`; long-form uses `relaxed`. Mixing breaks rhythm.

### 1.3 Spacing

4px base scale: `0, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128`.

Tokens: `space.0` through `space.128` (use the pixel value as the suffix).

**Rules:**

- No off-scale values. `padding: 13px` is a lint error.
- Use `space.24` for default card padding, `space.16` for tight padding, `space.32` for section gaps.
- Vertical rhythm: spacing between siblings is always a multiple of `space.8`. Mixed `space.12` and `space.16` in the same column is a bug.

### 1.4 Radius

| Token | Value | Use |
|---|---|---|
| `radius.none` | `0` | Tables, dividers. |
| `radius.sm` | `4px` | Inputs, small chips. |
| `radius.md` | `8px` | Cards, buttons. |
| `radius.lg` | `12px` | Modals, sheets. |
| `radius.full` | `9999px` | Avatars, pill chips. |

**Rules:**

- Pick one radius per surface tier. Do not mix `radius.sm` and `radius.md` on adjacent cards in the same row.
- No `border-radius: 16px`, `20px`, `24px`. Off-scale radii read as "designed by an LLM."

### 1.5 Shadow

| Token | Value | Use |
|---|---|---|
| `shadow.none` | `none` | Flat surfaces. |
| `shadow.sm` | `0 1px 2px rgba(0,0,0,0.06)` | Inputs, raised buttons. |
| `shadow.md` | `0 2px 8px rgba(0,0,0,0.08)` | Cards, popovers. |
| `shadow.lg` | `0 8px 24px rgba(0,0,0,0.12)` | Modals, sheets. |

**Rules:**

- One shadow per elevation tier. No `0 3px 7px rgba(0,0,0,0.11)` — that is not a token.
- No `box-shadow` with multiple stacked layers. If you need that, you need an elevation tier that does not exist yet — file an RFC.
- Shadows are tinted slightly warm (`rgba(0,0,0,0.08)`) to match the off-white surface. Pure black shadows look out of place.

### 1.6 Motion

| Token | Value | Use |
|---|---|---|
| `motion.duration.fast` | `120ms` | Hover, focus, tooltip. |
| `motion.duration.base` | `200ms` | Default transitions. |
| `motion.duration.slow` | `320ms` | Modal open, sheet slide. |
| `motion.easing.standard` | `cubic-bezier(0.2, 0, 0, 1)` | Default. |
| `motion.easing.emphasized` | `cubic-bezier(0.3, 0, 0, 1)` | Enter. |
| `motion.easing.exit` | `cubic-bezier(0.4, 0, 1, 1)` | Exit. |

**Rules:**

- No `transition: all 300ms ease-in-out`. That is the AI default and it makes every interaction feel mushy.
- Pick a token. If you need a new duration, add a token via RFC. Do not invent `180ms` in component code.
- Animation should serve clarity, not delight. If a motion does not communicate a state change, remove it.

### 1.7 Density

| Token | Value | Use |
|---|---|---|
| `density.compact` | `space.8` row padding | Tables, dense lists. |
| `density.standard` | `space.12` row padding | Default. |
| `density.spacious` | `space.16` row padding | Marketing, hero. |

**Rules:**

- Pick one density per page region. Do not switch mid-page.
- Tables default to `compact`. Dashboards default to `standard`. Marketing pages use `spacious`.

### 1.8 Z-Index

| Token | Value | Use |
|---|---|---|
| `z.base` | `0` | Default. |
| `z.raised` | `10` | Sticky headers. |
| `z.dropdown` | `100` | Menus, popovers. |
| `z.sticky` | `200` | Sticky toolbars. |
| `z.modal` | `1000` | Modals, sheets. |
| `z.toast` | `1100` | Toasts, notifications. |
| `z.tooltip` | `1200` | Tooltips. |

**Rules:**

- No `z-index: 9999`. That is the AI default for "I need it on top" and it breaks layering.
- If two layers conflict, the higher tier wins. Toasts always sit above modals; tooltips always sit above toasts.

---

## 2. The AI-Slop Ban List (Visual)

These patterns are **banned** in product UI. They are the visual fingerprint of LLM-generated design: pretty in isolation, generic in aggregate, and corrosive to brand trust.

| Banned pattern | Why | Lint rule |
|---|---|---|
| `linear-gradient` / `radial-gradient` used for decoration (e.g. hero backgrounds) | Reads as "splash page from a 2023 SaaS landing." | `stylelint-declaration-strict-value` rejects `linear-gradient(` in component CSS. Allowed only in `tokens/`. |
| `backdrop-filter: blur(...)` (glassmorphism) | Generic, hides hierarchy, hurts performance. | Banned property. Stylelint plugin rejects. |
| Multiple stacked `box-shadow` layers | Fakes elevation, creates noise. | Each component may reference exactly one shadow token. |
| Decorative SVG blurs or `filter: blur(40px)` "orb" backgrounds | Pure AI visual filler. | Banned. |
| Default OS fonts (Inter, system-ui, -apple-system) in product UI | Destroys the brand pairing. | `stylelint-declaration-strict-value` enforces token family. |
| Font weights outside the 4-token scale (400, 500, 700) | Visual drift; Figma won't match. | Banned values: 300, 600, 800, 900. |
| Off-scale spacing, radius, or shadow values | Component-by-component drift. | Stylelint token strict-value plugin. |
| Emoji in buttons, navigation, or empty states | "Emoji-as-icon" is a 2023 LLM tic. | Use a Phosphor icon. If an icon doesn't exist, file an issue. |
| Generic stock illustrations (people high-fiving, robots shaking hands) | Brand-killing. | Use the project's commissioned illustration set. If none exists, use a Phosphor illustration, not a stock photo. |
| Animated gradients (slowly shifting hues) | Pure 2024 slop. | Banned. |
| Rounded everything (radius > 16px) | Faux-friendly. Off-brand. | Maximum radius is `lg` = 12px. |
| Centered-everything hero with one big heading + one button + one product screenshot | The "AI landing page" template. | Hero must use a deliberate grid; product screenshot must have a labeled callout, not a glowing phone mock. |
| Bright neon glows (`box-shadow: 0 0 40px #00ffff`) | Late-2010s slop that crept back. | Banned. |
| Low-contrast gray-on-gray text | Faux minimalism. | WCAG AA enforced by `color-contrast()` lint. |

**Enforcement:**

```jsonc
// .stylelintrc.json (excerpt)
{
  "plugins": ["stylelint-declaration-strict-value", "stylelint-no-unsupported-browser-features"],
  "rules": {
    "scale-unlimited/declaration-strict-value": [
      ["/color/", "background", "background-color", "border-color", "fill", "stroke"],
      {
        "ignoreValues": ["transparent", "currentColor", "inherit", "initial", "none"]
      }
    ],
    "color-no-hex": [true, { "severity": "error" }],
    "declaration-property-value-disallowed-list": {
      "/^font-family/": ["/^(?!.*var\\(--font-).+/"],
      "backdrop-filter": ["/./"],
      "box-shadow": ["/(?!var\\(--shadow-).+/"]
    },
    "function-disallowed-list": ["linear-gradient", "radial-gradient", "conic-gradient"]
  }
}
```

Tokens themselves may use `linear-gradient` to compile decorative surface tints. Component code may not.

---

## 3. Iconography

- **Source:** Phosphor (light weight only).
- **Size tokens:** `icon.sm = 16px`, `icon.md = 20px`, `icon.lg = 24px`, `icon.xl = 32px`.
- **Stroke:** match the current text color via `currentColor`. Never set a hardcoded stroke color.
- **Banned:** Heroicons, Lucide, Material Icons, Tabler, Feather, emoji.
- **Banned usage:** decorative icons (e.g. a magnifying glass next to every search bar) — icons must indicate an action or status, not decorate.

If Phosphor doesn't have the icon you need:

1. Search [phosphoricons.com](https://phosphoricons.com) for the closest match.
2. If none fits, file a ticket requesting a new icon.
3. **Do not** fall back to another icon set. A missing icon is better than a wrong-family icon.

---

## 4. Imagery

- **Photography:** project-owned or commissioned. No stock photos of "diverse office workers smiling at laptops."
- **Illustrations:** project-commissioned set, single style, single palette. If no set exists, use Phosphor's illustrated style or skip the illustration entirely.
- **Screenshots in marketing:** labeled callouts (numbered, captioned). No floating "hero" device mock with a glow.
- **Banned:** AI-generated stock imagery, unsplash search-result photos, AI-generated avatars.

---

## 5. Dark Mode

Dark mode is **not a flag flip**. It is a parity requirement:

- Every surface token has a dark counterpart. The `color.surface.*` scale inverts.
- Contrast ratios are re-verified per pair.
- Shadows soften (lower opacity) because dark surfaces make shadows look harsher.
- Imagery with embedded white backgrounds is re-exported or wrapped in a surface frame.

**Lint:** Every component must define both light and dark variants. A component that only has a light variant is incomplete.

---

## 6. Reference Component

A correct, fully-tokenized button:

```tsx
// src/components/Button.tsx
import { Icon } from "./Icon";
import styles from "./Button.module.css";

type ButtonProps = {
  variant: "primary" | "secondary" | "ghost";
  size: "sm" | "md" | "lg";
  iconLeft?: PhosphorIcon;
  children: React.ReactNode;
  onClick: () => void;
};

export function Button({ variant, size, iconLeft, children, onClick }: ButtonProps) {
  return (
    <button
      type="button"
      className={`${styles.button} ${styles[variant]} ${styles[size]}`}
      onClick={onClick}
    >
      {iconLeft && <Icon name={iconLeft} size="sm" />}
      {children}
    </button>
  );
}
```

```css
/* src/components/Button.module.css */
.button {
  display: inline-flex;
  align-items: center;
  gap: var(--space-8);
  border-radius: var(--radius-md);
  font-family: var(--font-family-body);
  font-weight: var(--font-weight-medium);
  transition: background-color var(--motion-duration-fast) var(--motion-easing-standard);
}

.primary {
  background: var(--color-accent-base);
  color: var(--color-text-inverse);
  border: 1px solid var(--color-accent-base);
  box-shadow: var(--shadow-sm);
}
.primary:hover { background: var(--color-accent-hover); }

.secondary {
  background: var(--color-surface-raised);
  color: var(--color-text-primary);
  border: 1px solid var(--color-border-strong);
}

.ghost {
  background: transparent;
  color: var(--color-text-primary);
  border: 1px solid transparent;
}

.sm { padding: var(--space-4) var(--space-12); font-size: var(--font-size-sm); }
.md { padding: var(--space-8) var(--space-16); font-size: var(--font-size-base); }
.lg { padding: var(--space-12) var(--space-24); font-size: var(--font-size-lg); }
```

No hex. No literal `16px`. No `box-shadow: 0 2px 4px rgba(0,0,0,0.1)`. Everything is a token. Lint passes; the design system survives a redesign of the underlying values.

---

## 7. Enforcement — CI Gate

Drop into `.github/workflows/ci.yml`:

```yaml
design-system:
  name: Design system lint
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v3

    - name: Install
      run: npm ci

    - name: Build tokens
      run: npm run tokens:build

    - name: Stylelint (token strict-value + ban list)
      run: npx stylelint "src/**/*.{css,scss,tsx,ts}" --max-warnings=0

    - name: Verify no off-token hex in component code
      run: |
        if grep -rEn "#[0-9a-fA-F]{3,8}" src/ --include="*.css" --include="*.tsx" --include="*.ts" | grep -v "tokens/"; then
          echo "ERROR: hex color found outside tokens/. Use a token."
          exit 1
        fi

    - name: Verify no banned patterns
      run: |
        ! grep -rE "linear-gradient\(|backdrop-filter:|filter: blur\(" src/ --include="*.css" --include="*.tsx" || \
          (echo "ERROR: banned visual pattern (gradient/backdrop-filter/blur) found." && exit 1)

    - name: Verify Phosphor only
      run: |
        ! grep -rE "from ['\"](@heroicons|@lucide|@tabler|react-feather|lucide-react|@material-ui/icons)" src/ || \
          (echo "ERROR: banned icon set import. Use Phosphor." && exit 1)

    - name: Contrast check (axe-core)
      run: npx @axe-core/cli http://localhost:3000 --exit
```

A PR that fails any of these is blocked. Token values themselves live in `tokens/` and are exempt from the hex/gradient bans; the bans apply to component code only.

---

## 8. AI Coding Agent Policy

When an AI coding agent (Mavis, Claude Code, Copilot, Cursor) writes UI:

1. **Tokens first, components second.** The agent must import from `tokens/`. Hex literals, off-scale spacing, off-token font families are an immediate rejection.
2. **No "make it pretty" prompt.** "Add a gradient for emphasis" is a banned instruction. The agent must respond with "I cannot add a gradient; the design system bans decorative gradients. Use a token."
3. **No icon library switching.** If Phosphor lacks an icon, the agent files a request, not a fallback to Heroicons.
4. **Dark mode is shipped together.** A new component without a dark variant is incomplete, regardless of how the ticket reads.
5. **Reference components only.** New components are modeled on the canonical examples in this doc, not on whatever the agent trained on. The agent must read `references/DESIGN_SYSTEM.md` (or the project's copy) before generating UI.

The design system is a **contract between intent and code**. Tokens are the wire format. Drift is a bug.

---

## 9. Brownfield Adoption

If you are dropping this standard into a codebase that already has 600 components, half of which use `#3B82F6` and `border-radius: 12px` everywhere:

1. **Adopt the standard, but do not enable the lint on day one.** The repo will be 90% errors and the team will revolt.
2. **Build the tokens first.** Generate the CSS variable layer. Add the tokens to `tokens/`. Nothing in component code changes yet.
3. **Migrate the top 20% most-used components first** — the design-system primitives (Button, Input, Card, Modal, Table, Toast, Tabs). These are reused everywhere, so the migration has outsized impact.
4. **Set the stylelint config to `warn` for the first month**, then `error` after the migration crosses 70%.
5. **No mass find-and-replace.** A regex that replaces `#3B82F6` with `var(--color-accent-base)` will produce visual regressions. Migrate file-by-file, with visual review.
6. **Track token coverage** as a metric: `% of source files using only token values`. Aim for 100% over 3–4 sprints.

The standard is the destination. The ramp is the path. Teams that try to flip the switch instantly never finish the migration; teams that adopt the standard incrementally finish in a quarter.

---

## 10. Quick Reference

| Question | Answer |
|---|---|
| Can I use `linear-gradient`? | Only in `tokens/`. Not in component code. |
| Can I use a non-Phosphor icon? | No. |
| Can I use `#FF6B35` directly in JSX? | No. Use `var(--color-accent-base)` or the platform binding. |
| Can I use `border-radius: 20px`? | No. Tokens only. |
| Can I use `font-weight: 600`? | No. Use `medium` (500) or `bold` (700). |
| Can I use Inter / system-ui? | Never in product UI. |
| Can I use emoji in a button? | No. Use a Phosphor icon. |
| Can I use a stock photo? | No. |
| Can I add a new token? | Yes — file an RFC and update this doc. |

---

## On Errors

When CI fails on a design-system check:

1. Read the file:line from the linter.
2. Open the file. Identify the off-token value.
3. Replace with the closest token from §1. If no token fits, file an RFC and add one.
4. Run the linter locally: `npx stylelint src/path/to/file.tsx`.
5. If the linter is wrong (false positive), add a **targeted** disable with a justification comment. Never blanket-disable.
