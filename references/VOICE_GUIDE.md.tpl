# Voice & Writing Guide

> **Canonical writing standard for this project.** Every word in the product UI, marketing copy, error messages, empty states, documentation, commit messages, and PR descriptions is bound by this guide. CI fails on the most common AI-slop phrases. A new contributor (human or AI) reads this before writing a single string.

---

## Purpose

The voice of a product is the **first credibility signal** a user reads. AI-generated copy is a recognizable tell: vague claims, hedge words, "leverage", "robust", "seamless", and a kind of apologetic enthusiasm that sounds like a 2023 SaaS landing page. None of that builds trust, and most of it actively erodes it.

This document defines:

1. The voice register and audience.
2. The banned-phrase list (with rationale).
3. Punctuation and typography rules (the em-dash ban, etc.).
4. Sentence-level rules (length, voice, hedge words, adjectives).
5. Microcopy rules (buttons, labels, tooltips, error messages, empty states).
6. The lint enforcement (Vale + custom ESLint rule).
7. The AI-agent policy.
8. The brownfield adoption playbook.

If a string ends up in the product and isn't covered by this guide, that's a documentation gap — add a section, don't bypass the rule.

---

## 1. Voice Register

**Audience:** Direct, plain-spoken, Filipino VA users (and operators serving them). Smart, time-poor, allergic to marketing fluff. They want to know what something does, what it costs, and what to do next — in that order.

**Tone:** Professional, warm, direct. Not corporate. Not casual-faux-friendly ("Hey there, friend!"). Not academic. Think *experienced colleague explaining a system to a competent new hire over coffee* — not *startup pitch deck*.

**Personality anchors:**

- **Plain over clever.** "Delete account" beats "Bid this account farewell."
- **Specific over general.** "Save 3 hours per week" beats "Save time."
- **Active over passive.** "We sent the email" beats "The email was sent."
- **Confident over hedged.** "This will fail" beats "This may potentially fail in some cases."
- **Warm but not soft.** Friendly phrasing is fine; condescending phrasing is not. "We couldn't find that page" is fine. "Oops! Looks like you took a wrong turn!" is banned.

**What we are not:**

- Not a 2010s SaaS landing page.
- Not a corporate annual report.
- Not a Hacker News comment.
- Not an Apple keynote.
- Not a customer service script that says "Your satisfaction is our top priority."

---

## 2. Banned Phrases

The following phrases are **banned** in product UI, marketing copy, documentation, commit messages, and PR descriptions. The list is opinionated and intentionally long — the AI-slop vocabulary is large, and partial enforcement gives a worse product than no enforcement.

### 2.1 The Banned-Phrase List

| Banned phrase | Why it's banned | Suggested replacement |
|---|---|---|
| `leverage` | Corporate filler. Adds nothing. | `use` |
| `seamless` / `seamlessly` | Marketing word; doesn't describe anything concrete. | (delete) or `without interruption` |
| `robust` | Says "this won't break" without saying how. | name the actual property (`tested`, `versioned`, `retry-safe`) |
| `cutting-edge` | Empty. | (delete) |
| `world-class` | Unverifiable. | (delete) or name the metric |
| `best-in-class` | Same. | (delete) |
| `next-generation` | Same. | (delete) |
| `state-of-the-art` | Same. | (delete) |
| `unlock` (as a verb) | Marketing verb. | name the actual outcome (`access`, `enable`, `view`) |
| `harness the power of` | Marketing fluff. | (delete) |
| `in today's fast-paced world` | Empty opener. | start with the actual point |
| `dive into` | Cringe. | (delete) or `look at` |
| `dive deep` | Same. | (delete) |
| `in conclusion` | High-school essay-ism. | (delete) |
| `to summarize` | Same. | (delete) |
| `it's important to note` | Usually introducing something not important. | (delete) |
| `it's worth noting` | Same. | (delete) |
| `navigate the complexities` | AI-fluff. | name the actual complexity |
| `in the realm of` | Same. | (delete) |
| `a plethora of` | Same. | `many` or the actual count |
| `myriad of` | Same. | `many` |
| `plethora` | Same. | `many` |
| `delve` / `delve into` | AI tic. | `look at`, `examine` |
| `elevate` | Marketing verb. | `improve`, `raise`, or be specific |
| `elevate your` | Same. | name the actual change |
| `supercharge` | Marketing. | name the actual speedup |
| `game-changer` | Marketing. | name the actual change |
| `game-changing` | Same. | (delete) |
| `revolutionary` | Marketing. | (delete) |
| `transformative` | Same. | (delete) |
| `empower` | Marketing verb. | `enable` |
| `empowering` | Same. | (delete) |
| `unleash` | Marketing. | `release`, `enable` |
| `unparalleled` | Unverifiable. | (delete) |
| `unprecedented` | Same. | (delete) |
| `effortless` / `effortlessly` | Says "this is easy" without checking. | name the actual property |
| `frictionless` | Same. | (delete) or be specific |
| `intuitive` | Says "this is obvious" without checking. | name the actual property |
| `user-friendly` | Same. | (delete) |
| `easy to use` (when it's not) | Lying. | describe the actual interaction |
| `simply` (as filler) | "Simply click here" — patronizing. | (delete) |
| `just` (as filler) | "Just click here" — same. | (delete) |
| `seamless integration` | Empty. | name the actual integration |
| `holistic` | Corporate. | name the actual scope |
| `synergy` | Corporate. | (delete) |
| `synergize` | Same. | (delete) |
| `paradigm shift` | Marketing. | (delete) |
| `disrupt` | Marketing. | `change`, `replace`, or be specific |
| `disruptive` | Same. | (delete) |
| `at the end of the day` | Filler. | (delete) |
| `moving forward` | Filler. | (delete) |
| `going forward` | Same. | (delete) |
| `in this day and age` | Filler. | (delete) |
| `at this point in time` | Same. | (delete) |
| `a lot of` | Vague. | `many`, the number, or be specific |
| `tons of` | Same. | same |
| `very` (as an intensifier) | Lazy. | use a specific word or delete |
| `really` (as an intensifier) | Same. | same |
| `quite` (as a hedge) | Same. | be specific or delete |
| `kind of` (as a hedge) | Same. | same |
| `sort of` (as a hedge) | Same. | same |
| `literally` (when not literal) | Lazy intensifier. | (delete) |
| `actually` (as a filler) | Same. | (delete) |
| `basically` (as a filler) | Same. | (delete) |
| `essentially` (as a filler) | Same. | (delete) |
| `whether you're a...` | Listicles. | cut the list |
| `in this comprehensive guide` | AI-doc tic. | start with the actual content |
| `let's explore` | AI-doc tic. | start with the actual point |
| `let's dive in` | Same. | (delete) |
| `without further ado` | AI-doc tic. | (delete) |
| `buckle up` | AI-doc tic. | (delete) |
| `let's get started` | When the doc has steps. | start with step 1 |
| `are you ready to` | Patronizing. | (delete) |
| `unlock the potential` | Marketing. | name the actual potential |
| `take it to the next level` | Marketing. | (delete) |
| `level up` | Same. | name the actual change |
| `deep dive` | Same. | `detailed look`, `walkthrough` |
| `circle back` | Corporate. | `follow up`, `revisit` |
| `touch base` | Same. | (delete) |
| `synergize our efforts` | Same. | name the actual coordination |
| `low-hanging fruit` | Cliché. | name the actual opportunity |
| `move the needle` | Cliché. | name the actual impact |
| `boil the ocean` | Cliché. | (delete) |
| `drink from the firehose` | Cliché. | (delete) |
| `on the bleeding edge` | Cliché. | (delete) |
| `hit the ground running` | Cliché. | (delete) |
| `think outside the box` | Cliché. | (delete) |

The list is versioned. Banned phrases can be added (rarely removed) via an RFC. The Vale config in §7 is the source of truth for the linter.

### 2.2 Punctuation Bans

| Banned | Why | Replacement |
|---|---|---|
| Em-dash `—` (in body copy) | Telegraphic. The repo's existing rule (see `COMBINED_INSTRUCTIONS.md`) bans it. | Period, comma, colon, parentheses, or rewrite as two sentences. |
| Triple exclamation `!!!` | AI enthusiasm tic. | Delete all but possibly one `!` and only in marketing CTAs. |
| Multiple question marks `??` | Same. | Single `?`. |
| Ellipsis `...` as suspense | AI-doc tic. | (delete) or use a colon |
| ALL CAPS for emphasis (in body copy) | Shouting. | bold or italic, or rewrite |
| Trailing ` :)` or ` :)` emoji | Patronizing. | (delete) |

Em-dashes are allowed in **commit messages** and **code comments** (where brevity wins), but not in product UI, marketing, or documentation.

### 2.3 Emoji Policy

- **Banned in product UI.** No emoji in buttons, error messages, empty states, toasts, or navigation.
- **Banned in body copy** of documentation and marketing.
- **Banned in commit messages** (per existing rule in `COMBINED_INSTRUCTIONS.md`).
- **Allowed:** documentation section markers (`## 🔧 Setup`), the project README badges, the CHANGELOG, marketing hero (sparingly, max one).

If you need a visual marker in UI, use a Phosphor icon. If you need warmth in an empty state, use a sentence — not a smiley.

---

## 3. Sentence-Level Rules

### 3.1 Length

- **Body copy:** aim for 12–20 words per sentence. Up to 25 is fine for technical explanation. Above 30, split.
- **Marketing:** 6–14 words per sentence. Marketing copy that runs long reads as a brochure, not a hook.
- **Documentation:** 15–25 words is fine. Long technical sentences are acceptable if the alternative is fragmentation.
- **Error messages:** 6–14 words. Errors are scanned, not read.
- **Buttons:** 1–3 words. "Sign up", "Save changes", "Delete account". "Click here to begin your journey" is banned.

### 3.2 Voice

Default to **active voice**. Passive voice is acceptable only when the actor is genuinely unknown or irrelevant.

| Active (preferred) | Passive (acceptable when…) |
|---|---|
| "We sent the email." | "The email was sent" (acceptable if the sender is obvious or irrelevant) |
| "The server returned 404." | "404 was returned" (acceptable in error logs) |
| "This rule rejects empty arrays." | "Empty arrays are rejected by this rule" (acceptable in reference docs where the focus is the action) |

If you find yourself writing "is being", "was done by", "has been" — rephrase as active.

### 3.3 Hedge Words

`may`, `might`, `could`, `possibly`, `potentially`, `perhaps`, `seems to`, `appears to` — these all weaken the statement. Use them only when the uncertainty is real.

| Vague | Specific |
|---|---|
| "You may need to restart the server." | "Restart the server." |
| "This could potentially cause an issue." | "This causes X." (or name the actual edge case) |
| "It seems like the request failed." | "The request failed because X." |

When uncertainty is genuine, name it: "This may fail if the cache is empty" is fine. "This may potentially cause issues" is not.

### 3.4 Adjective Budget

Most AI-generated copy uses 2–3 adjectives per noun ("a robust, scalable, modern solution"). Don't.

- **Maximum 1 adjective per noun** in body copy.
- **Maximum 2 adjectives per noun** in marketing (and only if both are doing work).
- "Fast" and "efficient" rarely add information. Cut them.

| Sloppy | Tight |
|---|---|
| "a robust, scalable, modern API" | "a versioned API" |
| "a beautiful, intuitive interface" | "an interface" (let the design speak) |
| "a comprehensive, in-depth guide" | "a guide" or "a detailed guide" |

### 3.5 Specificity

Generic claims are AI-tells. Specific claims are credible.

| Generic | Specific |
|---|---|
| "Save time" | "Save 3 hours per week" |
| "Many users" | "8,200 active users" (or a range) |
| "Fast" | "p95 latency under 200ms" |
| "Reliable" | "99.95% uptime over the last 90 days" |
| "Easy to use" | describe the actual interaction ("Sign in with one click") |

If you cannot be specific, the claim is usually empty and should be cut.

---

## 4. Microcopy Rules

Microcopy is the small text users actually read: button labels, form fields, tooltips, error messages, empty states, confirmation dialogs. It is the most read, most AI-broken, and most-fixable surface in the product.

### 4.1 Buttons

- **1–3 words.** Verb-first. Active.
- "Save", "Save changes", "Delete account", "Sign up", "Continue".
- **Banned:** "Click here", "Learn more", "Find out more", "Get started" (when the action isn't starting), "Submit" (in a context where "Send" or "Save" is more accurate), "Yes" / "No" (use the actual consequence: "Delete", "Cancel").
- CTA color follows the design system: primary CTA = `color.accent.base`. Only one primary CTA per screen.

### 4.2 Form Labels

- **Noun or short noun phrase.** "Email", "Password", "Company name".
- **Banned:** "Please enter your email address" (the field already implies "enter your"), "Your email" (drop "your" — it's implicit), "E-mail" (use "Email" — that's the modern spelling).

### 4.3 Helper Text

- **One sentence.** Specific, not generic.
- **Good:** "We'll send a verification link to this address."
- **Bad:** "Please provide a valid email address for verification purposes." (long, vague, hedge words)

### 4.4 Error Messages

Error messages must answer three questions: **what happened, why, and what to do next.** Never just "An error occurred."

**Structure:** `{What happened in plain language}. {Why, if known}. {What to do next, if possible}.`

| Bad | Good |
|---|---|
| "An error occurred." | "Couldn't save your changes. Check your connection and try again." |
| "Invalid input." | "Email address must include @." |
| "Something went wrong." | "Payment failed. Your card was not charged." |
| "Oops!" | (delete — show the actual error) |
| "Error 500." | "The server hit an unexpected error. We've been notified. Try again in a minute." |

- **No apology theater.** "We apologize for the inconvenience" is banned. Show the action, not the regret.
- **No exclamation marks** in errors. Errors are not exciting.
- **No emoji** in errors.
- **No "Oops", "Whoops", "Uh oh", "Yikes".** These are infantilizing.

### 4.5 Empty States

Empty states must say three things: **what's empty, why, and what to do next.** Never just "No items found."

| Bad | Good |
|---|---|
| "No items found." | "No invoices yet. Create your first invoice to get started." |
| "Nothing here." | "You haven't added any team members. Invite your first teammate." |
| "Empty." | (delete — show a useful state) |

Include a CTA when the action is obvious: an empty invoices list with a "Create invoice" button is better than an empty list with a sentence.

### 4.6 Tooltips

- **One sentence.** Active. Specific.
- **Good:** "Send a copy of this report to your billing email."
- **Bad:** "This will help you keep track of things" (vague, "help you").

### 4.7 Confirmation Dialogs

- **State the consequence, then the action.** "Delete this invoice? It will be removed from your account and cannot be recovered." → buttons: "Cancel" / "Delete invoice".
- **Banned:** "Are you sure?" alone (always state the consequence).
- **Destructive actions are red (`color.status.danger`)** with the destructive button as the rightmost or only emphasized.

### 4.8 Loading States

- **Specific verbs.** "Loading…" is acceptable. "Sending email…", "Saving changes…", "Generating report…" is better.
- **No "Please wait"** in product UI. (Acceptable in support emails.)
- **No spinner-only loading** for operations > 2 seconds; show progress if possible.

### 4.9 Success Messages

- **State the result.** "Invoice saved." / "Email sent to jane@example.com."
- **No "Success!"** alone. Be specific.
- **No "🎉"** or other celebration emoji. A checkmark icon is fine if the design system supports it.

---

## 5. Documentation Voice

Documentation has slightly more leeway than product UI (longer sentences are fine, technical depth is expected) but the same anti-AI rules apply:

- **No "in this guide, we will…"** openers. Start with what the reader is trying to do.
- **No "let's dive in"** section transitions.
- **No "without further ado"** section breaks.
- **Specific examples, not generic ones.** Show real API calls with real shapes. Show real error messages with real remediation.
- **No padding.** If a section can be cut without losing information, cut it.
- **Code blocks are first-class.** A doc with a code block is better than a doc with three paragraphs describing what the code does.

---

## 6. Commit Messages & PR Descriptions

- **Conventional Commits format** is the existing rule (per `COMBINED_INSTRUCTIONS.md`).
- **Subject line:** imperative mood, 50–72 chars, no period.
- **Body:** wrap at 72 chars. Explain *why*, not *what* (the diff shows what).
- **No emoji** in commits or PR titles.
- **No "AI co-authored by" trailer in commit body** is required (use the GitHub co-author trailer in the commit *trailers*, not the body).
- **PR description:** state the problem, the approach, the tradeoffs, and how it was tested. No "this PR implements" filler.

---

## 7. Enforcement — Vale + ESLint

### 7.1 Vale (prose linter)

[Vale](https://vale.sh) is the standard prose linter. Drop a `.vale.ini` at the project root:

```ini
# .vale.ini
StylesPath = .vale/styles
MinAlertLevel = error

Packages = Google, Joblint

[*.{md,mdx}]
# Project-specific rule packs
BasedOnStyles = amph

# Override Google defaults that conflict with our voice
Google.We = NO
Google.WordList = .vale/config/vocabularies/accept.txt

[*.{ts,tsx,js,jsx}]
# Treat user-facing strings (in JSX/TSX) as prose
TokenIgnores = (?s)({/\*.*?\*/}|//.*$)
```

The project's rule pack (`amph/`) lives in `.vale/styles/amph/` and contains:

```
# .vale/styles/amph/BannedPhrases.yml
extends: existence
message: "'%s' is a banned AI-slop phrase. See VOICE_GUIDE.md §2 for the replacement."
level: error
tokens:
  - leverage
  - seamless
  - robust
  - cutting-edge
  - world-class
  - best-in-class
  - next-generation
  - state-of-the-art
  - unlock
  - harness the power of
  - in today's fast-paced world
  - dive into
  - dive deep
  - in conclusion
  - to summarize
  - it's important to note
  - it's worth noting
  - navigate the complexities
  - in the realm of
  - a plethora of
  - myriad of
  - plethora
  - delve
  - elevate
  - supercharge
  - game-changer
  - game-changing
  - revolutionary
  - transformative
  - empower
  - empowering
  - unleash
  - unparalleled
  - unprecedented
  - effortless
  - effortlessly
  - frictionless
  - intuitive
  - user-friendly
  - holistic
  - synergy
  - synergize
  - paradigm shift
  - disrupt
  - disruptive
  - at the end of the day
  - moving forward
  - going forward
  - in this day and age
  - at this point in time
  - kind of
  - sort of
  - comprehensive guide
  - let's explore
  - let's dive in
  - without further ado
  - buckle up
  - unlock the potential
  - take it to the next level
  - level up
  - deep dive
  - circle back
  - touch base
  - low-hanging fruit
  - move the needle
  - boil the ocean
  - drink from the firehose
  - on the bleeding edge
  - hit the ground running
  - think outside the box
```

Plus a `BannedPunctuation.yml`:

```yaml
# .vale/styles/amph/BannedPunctuation.yml
extends: existence
message: "'%s' is banned by VOICE_GUIDE.md §2.2. Use periods, commas, or rewrite."
level: error
tokens:
  # Em-dash in body copy. The Vale pattern matches the em-dash character.
  # Allowed in commit messages; Vale is run on docs/UI files, not commits.
  - "—"
```

Plus a `HedgeWords.yml`:

```yaml
# .vale/styles/amph/HedgeWords.yml
extends: existence
message: "Hedge word '%s' weakens the statement. See VOICE_GUIDE.md §3.3."
level: warning
tokens:
  - may potentially
  - could potentially
  - might possibly
  - seems to be
  - appears to be
  - it's worth mentioning
```

The vocab file (`.vale/config/vocabularies/accept.txt`) lists the project's domain terms so Vale doesn't flag them as misspellings (e.g. "PayMongo", "GCash", "Maya", domain-specific identifiers).

### 7.2 ESLint (inline string linter)

For strings inside `*.ts`/`*.tsx` (button labels, error messages, tooltips), Vale alone won't catch them — the strings live in JSX, not markdown. Add a custom ESLint rule:

```js
// eslint-rules/no-ai-slop.js
const BANNED = require('./banned-phrases.json');

module.exports = {
  meta: { type: 'problem', docs: { description: 'No AI-slop phrases in user-facing strings.' } },
  create(context) {
    return {
      Literal(node) { checkString(context, node.value, node); },
      TemplateElement(node) { checkString(context, node.value.cooked, node); },
      JSXText(node) { checkString(context, node.value, node); },
    };
  },
};

function checkString(context, value, node) {
  if (typeof value !== 'string') return;
  const lower = value.toLowerCase();
  for (const phrase of BANNED) {
    if (lower.includes(phrase)) {
      context.report({ node, message: `Banned AI-slop phrase: "${phrase}". See VOICE_GUIDE.md.` });
    }
  }
}
```

```json
// eslint-rules/banned-phrases.json (subset of §2.1, JSX-relevant)
[
  "leverage", "seamless", "seamlessly", "robust", "cutting-edge",
  "world-class", "best-in-class", "next-generation", "unlock",
  "in today's fast-paced world", "dive into", "dive deep",
  "navigate the complexities", "in the realm of", "delve",
  "elevate", "supercharge", "game-changer", "revolutionary",
  "transformative", "empower", "empowering", "unleash",
  "unparalleled", "unprecedented", "effortless", "effortlessly",
  "frictionless", "intuitive", "user-friendly", "synergy",
  "synergize", "paradigm shift", "disrupt", "disruptive",
  "oops", "whoops", "uh oh", "yikes", "we apologize",
  "your satisfaction is our top priority", "are you sure",
  "without further ado", "let's dive in", "buckle up"
]
```

Wire into `.eslintrc.cjs`:

```js
rules: {
  'no-ai-slop/no-ai-slop': 'error',
}
```

### 7.3 Pre-commit

```yaml
# .pre-commit-config.yaml (excerpt)
repos:
  - repo: https://github.com/errata-ai/vale
    rev: v3.4.1
    hooks:
      - id: vale
        files: '\.(md|mdx)$'
  - repo: local
    hooks:
      - id: eslint-jsx-voice
        name: ESLint — no AI-slop in JSX
        entry: npx eslint 'src/**/*.{ts,tsx}' --rule '{"no-ai-slop/no-ai-slop": "error"}' --max-warnings=0
        language: node
        files: '\.(ts|tsx)$'
```

### 7.4 CI Gate

```yaml
voice-lint:
  name: Voice / writing lint
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v3
    - name: Install Vale
      run: |
        wget -O vale.tar.gz https://github.com/errata-ai/vale/releases/latest/download/vale_3.4.1_Linux_64-bit.tar.gz
        tar -xzf vale.tar.gz
        sudo mv vale /usr/local/bin/
    - name: Run Vale on docs and markdown
      run: vale --config .vale.ini docs/ README.md
    - name: Run ESLint no-ai-slop on JSX
      run: |
        npm ci
        npx eslint 'src/**/*.{ts,tsx}' --rule '{"no-ai-slop/no-ai-slop": "error"}' --max-warnings=0
```

A PR that fails either is blocked. The Vale config is the source of truth for the banned-phrase list; the ESLint list is a subset tuned for JSX.

---

## 8. AI Coding Agent Policy

When an AI coding agent (Mavis, Claude Code, Copilot, Cursor) writes user-facing copy:

1. **The agent must read this guide** before writing the first string. Not "be aware of it" — read it.
2. **The agent must write strings that pass Vale on the first try.** "I'll fix the lint later" is not an acceptable plan; CI will block the PR.
3. **The agent must not invent a phrase and ask the user to lint it.** That puts the cognitive cost on the human. The agent produces lint-clean copy.
4. **The agent must not pad copy.** If a button label can be 2 words, it is 2 words, not 5.
5. **The agent must use the project's domain vocabulary** (the `accept.txt` vocab file). Names like "PayMongo", "GCash", "Maya" are correct; "payment processor" is acceptable in marketing copy but not in product UI where the brand name is the action.
6. **The agent must flag suspected false positives** with a justification comment, not a silent bypass. If a banned phrase is genuinely the right word here, file an RFC and update the guide.

The voice is a **product surface**, not a style preference. Drift is a bug. Vale and ESLint are the type system for English.

---

## 9. Brownfield Adoption

If you are dropping this standard into a project whose copy is already 30% AI-slop (it happens):

1. **Adopt the standard, do not enable the linter on day one.** A 30%-slop codebase will be red across the board and the team will disable the linter.
2. **Run Vale in `suggestion` level for the first month.** Vale still reports issues, but they don't block CI. The team gets a feel for the bar.
3. **Fix the top 20% most-visible surfaces first**: landing page hero, empty states on the 5 main pages, the 10 most common error messages. These are read most often and the cleanup is visible.
4. **Set the ESLint rule to `warn` for the first month**, then `error` after the worst offenders are cleaned.
5. **Track a "slop score"** as a metric: count of Vale errors per 1000 words in `docs/` and `src/`. Aim to halve it per quarter.
6. **Banned-phrase list grows over time, not shrinks.** When a new AI-generated pattern appears in the wild, add it to the list via RFC. The list is a living document; v1.0 is the floor, not the ceiling.

The standard is the destination. The ramp is the path. Teams that try to ship the linter enabled from day one on a slop-laden codebase abandon the standard within a sprint; teams that ramp finish the migration in a quarter.

---

## 10. Quick Reference Card

| Question | Answer |
|---|---|
| Can I use "leverage"? | No. Use "use". |
| Can I use an em-dash? | Not in product UI, docs, or marketing. Allowed in commits. |
| Can I use "robust"? | No. Name the actual property. |
| Can I use "Oops!"? | No. Show the actual error. |
| Can I use emoji? | Not in UI, body copy, or commits. Documented exception: README badges, section markers, CHANGELOG. |
| Can I use "Click here"? | No. Name the destination. |
| Can I use "we apologize"? | No. Show the action. |
| Can I add a new banned phrase? | Yes, via RFC. Update §2.1, the Vale config, and the ESLint rule. |
| Can I exempt a phrase? | Only via RFC. Add a comment, not a bypass. |

---

## On Errors

When CI fails on a voice check:

1. Read the file:line and the banned phrase.
2. Open §2.1 (or the Vale rule) and find the suggested replacement.
3. Rewrite the string. Do not paraphrase the banned phrase to dodge the lint ("leverage" → "harness" still fails the spirit).
4. Re-run the linter locally: `vale path/to/file.md` or `npx eslint path/to/file.tsx`.
5. If the linter is wrong (false positive, e.g. "leverage" used as a noun in a technical context — `leverage` as a finance term is allowed via the vocab file), update the vocab or file an RFC. Never blanket-disable.
