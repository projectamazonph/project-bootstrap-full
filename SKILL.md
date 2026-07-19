---
name: project-bootstrap-full
description: Create a complete project foundation with SOLID architecture, TDD protocols, comprehensive documentation suite, data logic wireframes, and project scaffold. Works for both greenfield (new) and brownfield (existing) projects. Based on amph-v2 and amph-v2-greenfield patterns. Must ask intelligent questions to understand full project requirements before scaffolding.
---

# Project Bootstrap Full

A comprehensive project bootstrapping skill that creates a complete engineering foundation with SOLID architecture, TDD protocols, comprehensive documentation suite, data logic wireframes, and project scaffold. Works for both **greenfield** (new) and **brownfield** (existing) projects. Based on the proven patterns from `amph-v2` and `amph-v2-greenfield`.

## Core Philosophy

This skill follows a strict **Question-First** approach:

1. **Understand completely** before creating anything
2. **Ask intelligent questions** to uncover hidden requirements  
3. **Create proportional documentation** based on project risk
4. **Build one vertical slice** before expanding horizontally
5. **Maintain source-of-truth** files that evolve with the project
6. **Enforce SOLID principles** through architecture, not just code review

## Workflow

### Phase 0: Project Type Detection

**Critical First Step:** Determine if this is a **greenfield** (new) or **brownfield** (existing) project.

#### Greenfield Detection
- New repository or empty directory
- No existing codebase
- Starting from scratch
- **Action:** Proceed to Phase 1 with full greenfield workflow

#### Brownfield Detection
- Existing codebase with history
- Established patterns and conventions
- Multiple contributors or long development history
- **Action:** Proceed to Phase 1 with brownfield assessment first

---

### Phase 1: Intelligent Discovery

Before creating any files, ask questions to understand:

#### Project Identity & Purpose
- **Project name**: What should the project be called?
- **One-sentence summary**: What outcome does this project create?
- **Primary users**: Who will use this system?
- **Problem statement**: What specific problem does this solve?
- **Success criteria**: How will you measure if this project succeeded?
- **Non-goals**: What is explicitly NOT in scope?

#### Technical Foundation
- **Tech stack**: What languages, frameworks, databases, and tools?
- **Deployment target**: Where will this run? (cloud, on-premise, mobile, desktop)
- **Data sensitivity**: What kind of data will it handle?
- **Scalability needs**: Expected user/load growth?
- **Budget/hosting**: Cost constraints or preferred providers?

#### Architecture & Design
- **System boundaries**: What are the main components/modules?
- **Integration points**: What external systems will it connect to?
- **UI requirements**: Web, mobile, CLI, or API-only?
- **Real-time needs**: Does it need live updates, notifications, or streaming?
- **Architecture preference**: Monolith, microservices, or modular monolith?

#### Development & Operations
- **Team size**: Solo developer or team?
- **Development timeline**: Urgent prototype or long-term production system?
- **Testing strategy**: Unit, integration, E2E, or all?
- **CI/CD pipeline**: What build/test/deploy tools?
- **Monitoring needs**: Logging, metrics, alerting requirements?
- **Existing systems**: Legacy code or greenfield project?

#### Business & Domain
- **Business rules**: What are the core business rules?
- **Pricing model**: If applicable, what's the pricing structure?
- **Payment processing**: What payment gateways are needed?
- **Email/notification requirements**: Transactional, marketing, etc.?
- **Compliance/regulatory**: GDPR, HIPAA, SOC2, PCI?

#### Brownfield-Specific Questions (If Existing Project)
- **Project history**: How old is the codebase? Major milestones?
- **Code quality**: Current test coverage? Technical debt level?
- **Architecture patterns**: Existing patterns to preserve?
- **Team knowledge**: Who knows what parts of the system?
- **Business criticality**: What's the cost of downtime?
- **User base**: How many active users? Impact of changes?
- **Integration dependencies**: External systems that can't be changed?
- **Compliance constraints**: Regulatory requirements that must be maintained?

### Phase 2: Profile & Layout Selection

Based on answers, recommend:

- **Profile**: `prototype`, `standard`, or `production`
- **Layout**: `generic`, `web-app`, `api-service`, `library`, or `monorepo`
- **Architecture**: Traditional, SOLID-layered, or microservices
- **Testing strategy**: Proportional to risk and team capability
- **Mode**: `greenfield` or `brownfield` (determined in Phase 0)

### Phase 2.5: Brownfield Assessment (If Existing Project)

Before scaffolding, perform a comprehensive codebase assessment:

#### Codebase Analysis
- **Directory structure**: Map existing folder layout
- **Package.json / requirements.txt**: Catalog all dependencies
- **Configuration files**: Identify existing configs (.eslintrc, tsconfig, etc.)
- **Test setup**: What testing framework exists? Coverage baseline?
- **CI/CD pipeline**: Existing automation and deployment
- **Documentation**: What docs already exist?

#### Code Quality Audit
- **Test coverage**: Run coverage, document baseline
- **Linting**: Run linter, count warnings/errors
- **Type safety**: TypeScript strictness level
- **Dependencies**: Outdated packages, security vulnerabilities
- **Technical debt**: Known pain points from team

#### Architecture Mapping
- **Entry points**: Where does the app start?
- **Data flow**: How does data move through the system?
- **Integration points**: External APIs, databases, services
- **State management**: How is state handled?
- **Error handling**: Existing error patterns
- **Logging**: Current logging approach

#### Documentation Gap Analysis
| Document | Status | Action |
|----------|--------|--------|
| README.md | ✅ Exists / ❌ Missing | Update / Create |
| API docs | ✅ Exists / ❌ Missing | Update / Create |
| Architecture | ✅ Exists / ❌ Missing | Update / Create |
| Testing guide | ✅ Exists / ❌ Missing | Update / Create |
| Deployment | ✅ Exists / ❌ Missing | Update / Create |
| Security | ✅ Exists / ❌ Missing | Update / Create |

#### Migration Strategy
- **Preserve**: What patterns and conventions to keep
- **Improve**: What areas need gradual improvement
- **Replace**: What needs complete overhaul
- **Timeline**: Phased approach to avoid disruption

---

### Phase 3: Scaffold & Documentation

Create comprehensive project structure based on project type:

---

#### Greenfield Mode (New Project)

Create ALL new files from scratch:

#### Core Documentation (Based on amph-v2-greenfield Patterns)
- `README.md` - Project overview with badges, quickstart, and architecture diagram
- `AGENTS.md` - AI/agent guidelines for code generation and assistance
- `CHANGELOG.md` - Version history following Keep a Changelog format
- `CONTRIBUTING.md` - Contribution guidelines for team members
- `BOOTSTRAP.md` - **Session bootstrap prompt** with project status, sprint roadmap, quality gate, git rules, and next steps
- `OPERATING_GUIDELINES.md` - **Living document** with git discipline, TDD protocol, quality gate, architecture rules, naming conventions, and environment variables
- `SESSION-HANDOVER.md` - **Session handoff** with project status, what shipped, architecture patterns, sprint status, open PRs, git rules, quality gate, and daily log
- `SESSION-TDD-SOLID-AUDIT.md` - **TDD+SOLID audit** with tiered issues (Tier A-D), progress tracking, and resolution patterns
- `NEXT-SESSION-PROMPT.md` - **Next-session prompt** with state, rules, patterns, and disclaimers
- `CODEOWNERS` - GitHub CODEOWNERS file for code review assignments
- `LICENSE` - Project license (MIT, Apache 2.0, etc.)
- `CLAUDE.md` - Architecture overview, layer descriptions, and design system
- `SESSION-LOG.md` - **Session log** with detailed work history, decisions made, and progress tracking
- `SPRINTS.md` - **Sprint planning** with backlog, velocity tracking, and milestone planning
- `COMBINED_INSTRUCTIONS.md` - **Essential instructions** combined from AGENTS.md and CLAUDE.md

#### Project Structure
Create complete directory structure from scratch (see Phase 4)

---

#### Brownfield Mode (Existing Project)

**DO NOT** overwrite existing files. Instead:

#### Documentation Strategy
- **Create missing docs only**: Based on gap analysis from Phase 2.5
- **Update existing docs**: Add sections that are missing
- **Preserve existing patterns**: Match naming conventions and style
- **Incremental improvement**: Don't break existing workflows

#### Core Documentation (Add if Missing)
| Document | Brownfield Action |
|----------|-------------------|
| `README.md` | Update with missing sections, don't rewrite |
| `AGENTS.md` | Create if missing, or update with current patterns |
| `CHANGELOG.md` | Create from git history if missing |
| `CONTRIBUTING.md` | Create if missing, or update with current practices |
| `BOOTSTRAP.md` | Create from existing project state |
| `OPERATING_GUIDELINES.md` | Create based on observed patterns |
| `SESSION-HANDOVER.md` | Create as new session record |
| `SESSION-TDD-SOLID-AUDIT.md` | Create based on code quality audit |
| `NEXT-SESSION-PROMPT.md` | Create based on current priorities |
| `CODEOWNERS` | Create if missing, or update |
| `LICENSE` | Preserve existing license |
| `CLAUDE.md` | Create if missing, or update with architecture |
| `SESSION-LOG.md` | Create as new session record |
| `SPRINTS.md` | Create based on current development state |
| `COMBINED_INSTRUCTIONS.md` | Create from existing AGENTS.md + CLAUDE.md |

#### Documentation Integration Rules
1. **Don't break existing workflows**: Preserve what works
2. **Match existing style**: Follow established conventions
3. **Add value, not noise**: Only create docs that provide clear benefit
4. **Incremental updates**: Update docs as code changes
5. **Preserve history**: Don't delete existing documentation

#### Technical Documentation
- `docs/PRD.md` - Product Requirements Document
- `docs/MVP.md` - Minimum Viable Product specification
- `docs/ARCHITECTURE.md` - System architecture with diagrams
- `docs/BUILD_SPEC.md` - Build specifications and configuration
- `docs/ROADMAP.md` - Feature roadmap and milestones
- `docs/TESTING.md` - Testing strategy and protocols
- `docs/DECISIONS.md` - Architecture Decision Records (ADRs)
- `docs/BUILD_LOG.md` - Build and deployment history
- `docs/ERROR_LOG.md` - Known issues and troubleshooting
- `docs/API_SPECIFICATION.md` - API design, endpoints, rate limiting
- `docs/SECURITY.md` - Security policies, OWASP requirements, compliance
- `docs/CICD.md` - CI/CD pipeline configuration and deployment
- `docs/DATABASE_SCHEMA.md` - Database design, migrations, relationships
- `docs/USER_STORIES.md` - User stories, acceptance criteria, backlog

---

#### Brownfield Technical Documentation (Add if Missing)
| Document | Brownfield Action |
|----------|-------------------|
| `docs/PRD.md` | Create based on existing features, not aspirational |
| `docs/MVP.md` | Create to document current state as baseline |
| `docs/ARCHITECTURE.md` | Create from actual codebase structure |
| `docs/BUILD_SPEC.md` | Create from existing build configs |
| `docs/ROADMAP.md` | Create based on current priorities and debt |
| `docs/TESTING.md` | Create from existing test setup + gaps |
| `docs/DECISIONS.md` | Create from git history and ADRs |
| `docs/BUILD_LOG.md` | Create from CI/CD history |
| `docs/ERROR_LOG.md` | Create from known issues |
| `docs/API_SPECIFICATION.md` | Create from existing endpoints |
| `docs/SECURITY.md` | Create based on existing security measures |
| `docs/CICD.md` | Create from existing pipeline configs |
| `docs/DATABASE_SCHEMA.md` | Create from existing schema |
| `docs/USER_STORIES.md` | Create from existing features |

---

#### TDD & SOLID Protocols
- `docs/TDD_PROTOCOL.md` - Test-Driven Development workflow
- `docs/SOLID_GUIDELINES.md` - SOLID principles implementation guide
- `docs/CODE_REVIEW.md` - Code review checklist and standards
- `docs/VOICE_GUIDE.md` - Voice and tone guidelines for content

---

#### Brownfield TDD Documentation (Add if Missing)
| Document | Brownfield Action |
|----------|-------------------|
| `docs/TDD_PROTOCOL.md` | Create from existing test patterns + gaps |
| `docs/SOLID_GUIDELINES.md` | Create based on actual architecture |
| `docs/CODE_REVIEW.md` | Create from existing review practices |
| `docs/VOICE_GUIDE.md` | Create from existing content patterns |

---

#### Data Logic Wireframes
- `docs/DATA_FLOW.md` - Data flow diagrams and state management
- `docs/API_SPECIFICATION.md` - API contracts and endpoints
- `docs/DATABASE_SCHEMA.md` - Database design and relationships
- `docs/INTEGRATION_MAP.md` - External system integrations

---

#### Brownfield Data Logic Documentation (Add if Missing)
| Document | Brownfield Action |
|----------|-------------------|
| `docs/DATA_FLOW.md` | Create from actual data flow |
| `docs/API_SPECIFICATION.md` | Create from existing API patterns |
| `docs/DATABASE_SCHEMA.md` | Create from existing database |
| `docs/INTEGRATION_MAP.md` | Create from existing integrations |

---

#### UI/UX Documentation
- `docs/UI_WIREFRAMES.md` - User interface wireframes and flows
- `docs/DESIGN_SYSTEM.md` - Design tokens, components, and patterns
- `docs/USER_JOURNEYS.md` - User experience flows and personas
- `docs/UI_COMPONENTS.md` - UI component library and usage guidelines
- `docs/ACCESSIBILITY.md` - WCAG compliance and accessibility guidelines
- `docs/RESPONSIVE_DESIGN.md` - Mobile, tablet, desktop breakpoints
- `docs/ANIMATION_GUIDE.md` - Motion design and micro-interactions
- `docs/UX_WRITING.md` - Microcopy, error messages, and content design
- `docs/WIREFRAME_DIAGRAMS.md` - ASCII/text-based wireframe diagrams for key screens

---

#### Brownfield UI/UX Documentation (Add if Missing)
| Document | Brownfield Action |
|----------|-------------------|
| `docs/UI_WIREFRAMES.md` | Create from actual UI patterns |
| `docs/DESIGN_SYSTEM.md` | Create from existing design tokens |
| `docs/USER_JOURNEYS.md` | Create from actual user flows |
| `docs/UI_COMPONENTS.md` | Create from existing components |
| `docs/ACCESSIBILITY.md` | Create from existing a11y measures |
| `docs/RESPONSIVE_DESIGN.md` | Create from existing breakpoints |
| `docs/ANIMATION_GUIDE.md` | Create from existing animations |
| `docs/UX_WRITING.md` | Create from existing content patterns |
| `docs/WIREFRAME_DIAGRAMS.md` | Create from actual UI |

---

#### Production Readiness (if production profile)
- `docs/SECURITY.md` - Security policies, OWASP top 10, and compliance
- `docs/DEPLOYMENT.md` - Deployment procedures and runbooks
- `docs/OBSERVABILITY.md` - Logging, metrics, and alerting
- `docs/PERFORMANCE.md` - Performance budgets and monitoring
- `docs/BACKUP_RECOVERY.md` - Backup and disaster recovery plans
- `docs/RELEASE_PROCESS.md` - Release management procedures
- `docs/RATE_LIMITING.md` - API rate limiting, throttling, and abuse prevention
- `docs/INCIDENT_RESPONSE.md` - Security incident response procedures

---

#### Brownfield Production Readiness (Add if Missing)
| Document | Brownfield Action |
|----------|-------------------|
| `docs/SECURITY.md` | Create from existing security measures |
| `docs/DEPLOYMENT.md` | Create from existing deployment process |
| `docs/OBSERVABILITY.md` | Create from existing monitoring |
| `docs/PERFORMANCE.md` | Create from existing performance data |
| `docs/BACKUP_RECOVERY.md` | Create from existing backup process |
| `docs/RELEASE_PROCESS.md` | Create from existing release process |
| `docs/RATE_LIMITING.md` | Create from existing rate limiting |
| `docs/INCIDENT_RESPONSE.md` | Create from existing incident process |

### Phase 4: Project Scaffold

Create actual project structure with:

#### Configuration Files
- Package manager configs (package.json, pnpm-lock.yaml)
- Linter and formatter configs (ESLint, Prettier)
- Type checking configs (TypeScript strict)
- Test framework configs (Vitest, Playwright)
- Environment templates (.env.example)
- CI/CD pipeline configs (GitHub Actions)

#### Source Structure (SOLID Architecture)
```
project/
├── src/
│   ├── domain/         # Pure business model
│   │   ├── entities/   # Business entities
│   │   ├── values/     # Value objects
│   │   ├── services/   # Domain services
│   │   └── simulator/  # Domain simulators
│   ├── ports/          # Interfaces only
│   │   ├── repositories/
│   │   ├── payment/
│   │   ├── email/
│   │   ├── security/
│   │   └── system/
│   ├── usecases/       # One class per use case
│   ├── infra/          # Adapters implementing ports
│   │   ├── repositories/
│   │   ├── payment/
│   │   ├── email/
│   │   ├── security/
│   │   └── simulator/
│   ├── app/            # Next.js App Router
│   │   ├── actions/
│   │   ├── api/
│   │   └── (dashboard)/
│   ├── composition/    # DI container
│   └── components/     # UI primitives
├── prisma/             # Database schema
├── content/            # Content files
├── tests/              # Test suites
├── docs/               # Documentation
├── scripts/            # Build and utility scripts
└── public/             # Static assets
```

#### Quality Gates
- Pre-commit hooks for formatting and linting
- CI/CD pipeline for automated testing and deployment
- Documentation generation and validation scripts
- Security scanning and dependency auditing

### Phase 5: Validation & Handoff

Run validation checks:
- Documentation completeness
- Project structure integrity
- Test framework setup
- Configuration file validity
- Build system verification
- SOLID architecture compliance
- TDD protocol setup

Provide handoff with:
- Next steps for implementation
- First vertical slice definition
- Acceptance criteria for initial feature
- Recommended development workflow
- Session handover documentation

## Integration with Other Skills

This skill works best with:
- **tdd-workflow**: For implementing Test-Driven Development
- **solid-code-design**: For SOLID architecture principles
- **loop-engineering**: For bounded implementation cycles
- **engineering-quality-gates**: For quality verification
- **code-review-and-quality**: For code review standards

## Output Contract

This skill delivers:
1. Complete project documentation suite
2. SOLID five-layer architecture
3. TDD and SOLID protocol documents
4. Data logic and UI wireframes
5. Functional project scaffold
6. Validation report
7. Implementation roadmap
8. Session handover documentation

Never create documentation without understanding the project first. Never skip intelligent questions. Never assume requirements.