# Wireframe Diagrams

## Purpose
ASCII/text-based wireframe diagrams for key screens in the application.

---

## Screen: [Screen Name]
**Route:** `/[route]`
**Purpose:** [What this screen does]

```
┌─────────────────────────────────────────────────────────┐
│ HEADER BAR                                              │
│ [Logo]              [Navigation]           [User Menu]  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │ SIDEBAR                                          │  │
│  │                                                   │  │
│  │  📊 Dashboard                                     │  │
│  │  📁 Projects                                      │  │
│  │  👥 Users                                         │  │
│  │  ⚙️ Settings                                      │  │
│  │                                                   │  │
│  └───────────────────────────────────────────────────┘  │
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │ MAIN CONTENT AREA                                 │  │
│  │                                                   │  │
│  │  [Page Title]                          [Action]   │  │
│  │                                                   │  │
│  │  ┌─────────────────────────────────────────────┐  │  │
│  │  │                                             │  │  │
│  │  │  [Content/Component Area]                   │  │  │
│  │  │                                             │  │  │
│  │  │                                             │  │  │
│  │  └─────────────────────────────────────────────┘  │  │
│  │                                                   │  │
│  │  ┌─────────────────────────────────────────────┐  │  │
│  │  │ Pagination / Footer                         │  │  │
│  │  └─────────────────────────────────────────────┘  │  │
│  │                                                   │  │
│  └───────────────────────────────────────────────────┘  │
│                                                         │
├─────────────────────────────────────────────────────────┤
│ FOOTER                                                  │
└─────────────────────────────────────────────────────────┘
```

### Components
| Component | Location | Purpose |
|-----------|----------|---------|
| Header | Top | Navigation, branding, user menu |
| Sidebar | Left | Primary navigation |
| Main Content | Center | Page-specific content |
| Footer | Bottom | Secondary links, copyright |

---

## Screen: [Mobile View]
**Route:** `/[route]` (mobile)
**Purpose:** [What this screen does on mobile]

```
┌─────────────────────┐
│ ☰  [Logo]     👤    │
├─────────────────────┤
│                     │
│  [Page Title]       │
│                     │
│  ┌───────────────┐  │
│  │               │  │
│  │  [Content]    │  │
│  │               │  │
│  └───────────────┘  │
│                     │
│  ┌───────────────┐  │
│  │ [Action]      │  │
│  └───────────────┘  │
│                     │
├─────────────────────┤
│  🏠  🔍  ➕  👤    │
└─────────────────────┘
```

---

## Navigation Flow

```
[Home] → [Login] → [Dashboard]
                ↓
            [Feature 1] → [Detail View] → [Edit]
                ↓
            [Feature 2] → [List View] → [Create]
                ↓
            [Settings] → [Profile] → [Preferences]
```

---

## State Transitions

```
[Loading] → [Empty State] → [Has Data] → [Error]
     ↓              ↓              ↓           ↓
  Skeleton      CTA to         Display     Retry
  Screens       Create         Data        Button
```

---

## Responsive Breakpoints

| Breakpoint | Width | Layout Changes |
|------------|-------|----------------|
| Mobile | < 640px | Single column, hamburger menu |
| Tablet | 640-1024px | Two columns, collapsible sidebar |
| Desktop | > 1024px | Full layout, persistent sidebar |

---

## Component States

### Button States
```
[Default] → [Hover] → [Active] → [Disabled]
[Loading] → [Success] → [Error]
```

### Form States
```
[Empty] → [Filling] → [Valid] → [Invalid]
[Submitting] → [Success] → [Error]
```

---

## Key Screens Inventory

| Screen | Route | Priority | Status |
|--------|-------|----------|--------|
| Dashboard | `/dashboard` | P0 | ⬜ Not Started |
| Login | `/login` | P0 | ⬜ Not Started |
| Profile | `/settings/profile` | P1 | ⬜ Not Started |
| [Feature] | `/[feature]` | P0 | ⬜ Not Started |