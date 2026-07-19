# Project Bootstrap Full

A comprehensive project bootstrapping skill that creates a complete engineering foundation with SOLID architecture, TDD protocols, comprehensive documentation suite, data logic wireframes, and project scaffold. Works for both **greenfield** (new) and **brownfield** (existing) projects.

## 🎯 Overview

**Project Bootstrap Full** is an AI-powered skill that generates complete project foundations with production-ready architecture, documentation, and tooling. Based on proven patterns from `amph-v2` and `amph-v2-greenfield`, this skill handles both new projects and existing codebases with intelligent adaptation.

### ✨ Key Features

- **🔄 Dual Project Support** - Works with both greenfield (new) and brownfield (existing) projects
- **🏗️ SOLID Architecture** - Enforces Clean Architecture with dependency inversion
- **📝 Comprehensive Documentation** - 20+ documentation templates covering all aspects
- **🧪 TDD & SOLID Protocols** - Built-in test-driven development workflows
- **🎨 UI/UX Documentation** - Wireframes, design systems, and user journeys
- **🚀 CI/CD Pipeline** - Complete pipeline configuration and deployment guides
- **🔒 Security & Compliance** - OWASP, GDPR, and security best practices
- **📊 Data Logic Wireframes** - API specifications, database schemas, and data flows
- **🤖 AI Agent Integration** - CLAUDE.md and AGENTS.md for AI-assisted development
- **🔄 Session Management** - Bootstrap, handover, and sprint planning templates

## 🧠 Core Philosophy

This skill follows a strict **Question-First** approach:

1. **Understand completely** before creating anything
2. **Ask intelligent questions** to uncover hidden requirements  
3. **Create proportional documentation** based on project risk
4. **Build one vertical slice** before expanding horizontally
5. **Maintain source-of-truth** files that evolve with the project
6. **Enforce SOLID principles** through architecture, not just code review

## 🔄 Workflow

### Phase 0: Project Type Detection

**Critical First Step:** Automatically detects if this is a **greenfield** (new) or **brownfield** (existing) project.

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

### Phase 1: Intelligent Discovery

Before creating any files, asks questions to understand:

#### Project Identity & Purpose
- Project name and one-sentence summary
- Primary users and problem statement
- Success criteria and non-goals

#### Technical Foundation
- Tech stack (languages, frameworks, databases, tools)
- Deployment target and data sensitivity
- Scalability needs and budget/hosting

#### Architecture & Design
- System boundaries and integration points
- UI requirements and real-time needs
- Architecture preference (monolith, microservices, modular monolith)

#### Development & Operations
- Team size and development timeline
- Testing strategy and CI/CD pipeline
- Monitoring needs and existing systems

#### Business & Domain
- Business rules and pricing model
- Payment processing and email/notification requirements
- Compliance/regulatory requirements (GDPR, HIPAA, SOC2, PCI)

#### Brownfield-Specific Questions (If Existing Project)
- Project history and code quality
- Architecture patterns and team knowledge
- Business criticality and user base
- Integration dependencies and compliance constraints

### Phase 2: Profile & Layout Selection

Based on answers, recommends:
- **Profile**: `prototype`, `standard`, or `production`
- **Layout**: `generic`, `web-app`, `api-service`, `library`, or `monorepo`
- **Architecture**: Traditional, SOLID-layered, or microservices
- **Testing strategy**: Proportional to risk and team capability
- **Mode**: `greenfield` or `brownfield` (determined in Phase 0)

### Phase 2.5: Brownfield Assessment (If Existing Project)

Before scaffolding, performs comprehensive codebase assessment:
- Codebase analysis and directory structure mapping
- Code quality audit (test coverage, linting, type safety)
- Architecture mapping (entry points, data flow, integrations)
- Documentation gap analysis
- Migration strategy (preserve, improve, replace)

### Phase 3: Scaffold & Documentation

Creates comprehensive project structure based on project type:

#### Greenfield Mode (New Project)
Creates ALL new files from scratch:

##### Core Documentation
- `README.md` - Project overview with badges, quickstart, architecture diagram
- `AGENTS.md` - AI/agent guidelines for code generation
- `CHANGELOG.md` - Version history (Keep a Changelog format)
- `CONTRIBUTING.md` - Contribution guidelines
- `BOOTSTRAP.md` - Session bootstrap prompt
- `OPERATING_GUIDELINES.md` - Living document with git discipline, TDD protocol
- `SESSION-HANDOVER.md` - Session handoff documentation
- `SESSION-TDD-SOLID-AUDIT.md` - TDD+SOLID audit with tiered issues
- `NEXT-SESSION-PROMPT.md` - Next-session prompt
- `CODEOWNERS` - GitHub CODEOWNERS file
- `LICENSE` - Project license
- `CLAUDE.md` - Architecture overview, layer descriptions
- `SESSION-LOG.md` - Session log with work history
- `SPRINTS.md` - Sprint planning with backlog
- `COMBINED_INSTRUCTIONS.md` - Essential instructions from AGENTS.md + CLAUDE.md

##### Technical Documentation
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
- `docs/SECURITY.md` - Security policies, OWASP requirements
- `docs/CICD.md` - CI/CD pipeline configuration
- `docs/DATABASE_SCHEMA.md` - Database design, migrations
- `docs/USER_STORIES.md` - User stories, acceptance criteria

##### TDD & SOLID Protocols
- `docs/TDD_PROTOCOL.md` - Test-Driven Development workflow
- `docs/SOLID_GUIDELINES.md` - SOLID principles implementation guide
- `docs/CODE_REVIEW.md` - Code review checklist and standards
- `docs/VOICE_GUIDE.md` - Voice and tone guidelines

##### Data Logic Wireframes
- `docs/DATA_FLOW.md` - Data flow diagrams and state management
- `docs/API_SPECIFICATION.md` - API contracts and endpoints
- `docs/DATABASE_SCHEMA.md` - Database design and relationships
- `docs/INTEGRATION_MAP.md` - External system integrations

##### UI/UX Documentation
- `docs/UI_WIREFRAMES.md` - User interface wireframes and flows
- `docs/DESIGN_SYSTEM.md` - Design tokens, components, patterns
- `docs/USER_JOURNEYS.md` - User experience flows and personas
- `docs/UI_COMPONENTS.md` - UI component library and usage guidelines
- `docs/ACCESSIBILITY.md` - WCAG compliance and accessibility guidelines
- `docs/RESPONSIVE_DESIGN.md` - Mobile, tablet, desktop breakpoints
- `docs/ANIMATION_GUIDE.md` - Motion design and micro-interactions
- `docs/UX_WRITING.md` - Microcopy, error messages, content design
- `docs/WIREFRAME_DIAGRAMS.md` - ASCII/text-based wireframe diagrams

##### Production Readiness
- `docs/SECURITY.md` - Security policies, OWASP top 10, compliance
- `docs/DEPLOYMENT.md` - Deployment procedures and runbooks
- `docs/OBSERVABILITY.md` - Logging, metrics, and alerting
- `docs/PERFORMANCE.md` - Performance budgets and monitoring
- `docs/BACKUP_RECOVERY.md` - Backup and disaster recovery plans
- `docs/RELEASE_PROCESS.md` - Release management procedures
- `docs/RATE_LIMITING.md` - API rate limiting, throttling
- `docs/INCIDENT_RESPONSE.md` - Security incident response procedures

#### Brownfield Mode (Existing Project)

**DO NOT** overwrite existing files. Instead:

##### Documentation Strategy
- Create missing docs only (based on gap analysis)
- Update existing docs with missing sections
- Preserve existing patterns and conventions
- Incremental improvement without breaking workflows

##### Documentation Integration Rules
1. Don't break existing workflows
2. Match existing style and conventions
3. Add value, not noise
4. Incremental updates as code changes
5. Preserve history and existing documentation

### Phase 4: Project Scaffold

Creates actual project structure with:

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

## 📦 Documentation Templates

### Session Management Templates
| Template | Purpose | When to Use |
|----------|---------|-------------|
| `BOOTSTRAP.md.tpl` | Session bootstrap prompt with project status, sprint roadmap, quality gate, git rules, and next steps | Start of each development session |
| `SESSION-LOG.md.tpl` | Detailed work history, decisions made, and progress tracking | During development sessions |
| `SPRINTS.md.tpl` | Sprint planning with backlog, velocity tracking, and milestone planning | Sprint planning and tracking |
| `SESSION-HANDOVER.md` | Session handoff with project status, what shipped, architecture patterns | End of development sessions |

### Technical Documentation Templates
| Template | Purpose | When to Use |
|----------|---------|-------------|
| `README.md.tpl` | Project overview with badges, quickstart, and architecture diagram | Project initialization |
| `MVP.md.tpl` | Minimum Viable Product specification | Feature planning |
| `API_SPECIFICATION.md.tpl` | API design, endpoints, rate limiting | API development |
| `WIREFRAME_DIAGRAMS.md.tpl` | ASCII/text-based wireframe diagrams for key screens | UI/UX planning |
| `BUILD_LOG.md.tpl` | Build and deployment history | CI/CD tracking |
| `ERROR_LOG.md.tpl` | Known issues and troubleshooting | Issue tracking |
| `SECURITY.md.tpl` | Security policies, OWASP requirements, compliance | Security planning |
| `CICD.md.tpl` | CI/CD pipeline configuration and deployment | DevOps setup |

### Development Guidelines
| Template | Purpose | When to Use |
|----------|---------|-------------|
| `AGENTS.md.tpl` | AI/agent guidelines for code generation and assistance | AI-assisted development |
| `COMBINED_INSTRUCTIONS.md` | Essential instructions combined from AGENTS.md and CLAUDE.md | Quick reference |
| `OPERATING_GUIDELINES.md.tpl` | Living document with git discipline, TDD protocol, quality gate | Development standards |

## 🛠️ Installation & Usage

### Prerequisites
- Operit AI Assistant
- GitHub account (for repository integration)
- Node.js (for JavaScript/TypeScript projects)

### Quick Start

1. **Invoke the skill** in your Operit assistant:
   ```
   Use project-bootstrap-full to create a new project
   ```

2. **Answer intelligent questions** about your project requirements

3. **Receive complete foundation** with:
   - SOLID architecture scaffold
   - Comprehensive documentation suite
   - TDD and SOLID protocols
   - CI/CD pipeline configuration
   - Session management templates

### Usage Examples

#### Greenfield Project
```
Create a new e-commerce platform with React, Node.js, and PostgreSQL
```

#### Brownfield Project
```
Bootstrap documentation and architecture for my existing React app
```

## 🔗 Integration with Other Skills

This skill works best with:
- **tdd-workflow**: For implementing Test-Driven Development
- **solid-code-design**: For SOLID architecture principles
- **loop-engineering**: For bounded implementation cycles
- **engineering-quality-gates**: For quality verification
- **code-review-and-quality**: For code review standards

## 📋 Output Contract

This skill delivers:
1. Complete project documentation suite (20+ files)
2. SOLID five-layer architecture
3. TDD and SOLID protocol documents
4. Data logic and UI wireframes
5. Functional project scaffold
6. Validation report
7. Implementation roadmap
8. Session handover documentation

## 🎯 Profiles & Layouts

### Profiles
| Profile | Description | Documentation Level |
|---------|-------------|---------------------|
| `prototype` | Quick MVP, minimal docs | Basic README, simple architecture |
| `standard` | Balanced approach | Full documentation suite |
| `production` | Enterprise-grade | Complete docs + security, compliance, monitoring |

### Layouts
| Layout | Description | Best For |
|--------|-------------|----------|
| `generic` | Flexible structure | Most projects |
| `web-app` | Web application optimized | React, Next.js, Vue apps |
| `api-service` | API-focused structure | REST/GraphQL APIs |
| `library` | Reusable library structure | npm packages, SDKs |
| `monorepo` | Multi-package workspace | Large-scale projects |

## 🧩 Architecture Patterns

### SOLID Five-Layer Architecture
1. **Domain Layer** - Pure business logic, entities, value objects
2. **Ports Layer** - Interfaces/contracts only
3. **Use Cases Layer** - Application-specific business rules
4. **Infrastructure Layer** - Adapters implementing ports
5. **Presentation Layer** - UI components, API routes

### Key Principles
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Single Responsibility**: Each class/module has one reason to change
- **Interface Segregation**: Many specific interfaces over general ones
- **Liskov Substitution**: Subtypes must be substitutable for base types
- **Open/Closed**: Open for extension, closed for modification

## 🔄 Brownfield Integration

### Assessment Process
1. **Codebase Analysis** - Map existing structure and dependencies
2. **Quality Audit** - Test coverage, linting, type safety
3. **Architecture Mapping** - Entry points, data flow, integrations
4. **Gap Analysis** - Documentation and tooling gaps
5. **Migration Strategy** - Preserve, improve, replace plan

### Preservation Rules
- Don't break existing workflows
- Match existing style and conventions
- Add value, not noise
- Incremental updates as code changes
- Preserve history and existing documentation

## 🚀 CI/CD Pipeline Features

### Pipeline Stages
1. **Source Stage** - Triggers and checkout
2. **Build Stage** - Compilation and artifact generation
3. **Test Stage** - Unit, integration, E2E tests
4. **Security Stage** - Dependency scanning, SAST
5. **Deploy Stage** - Environment-specific deployment
6. **Monitor Stage** - Health checks and alerting

### Deployment Strategies
- **Blue-Green**: Zero-downtime deployments
- **Canary**: Gradual rollout with monitoring
- **Rolling**: Batch updates with health checks

## 🔒 Security & Compliance

### Security Features
- **OWASP Top 10** protection
- **Dependency scanning** (Snyk, Dependabot)
- **Secret scanning** for hardcoded credentials
- **Container scanning** for Docker images
- **Compliance** (GDPR, HIPAA, SOC2, PCI)

### Security Documentation
- `SECURITY.md` - Security policies and procedures
- `INCIDENT_RESPONSE.md` - Security incident response
- `RATE_LIMITING.md` - API rate limiting and abuse prevention

## 🎨 UI/UX Documentation

### Design System Components
- **Design Tokens** - Colors, typography, spacing
- **Component Library** - Reusable UI components
- **Wireframes** - ASCII/text-based diagrams
- **User Journeys** - Experience flows and personas
- **Accessibility** - WCAG compliance guidelines

### Responsive Design
- Mobile-first approach
- Tablet and desktop breakpoints
- Performance optimization
- Animation and micro-interactions

## 📊 Data Logic Wireframes

### Documentation Types
- **Data Flow Diagrams** - How data moves through the system
- **API Specifications** - REST/GraphQL endpoints
- **Database Schema** - Tables, relationships, migrations
- **Integration Map** - External system connections

## 🤖 AI Agent Integration

### CLAUDE.md
- Architecture overview and layer descriptions
- Design system and component guidelines
- Code generation rules and patterns

### AGENTS.md
- AI/agent guidelines for code generation
- Best practices and anti-patterns
- Collaboration protocols

## 🔄 Session Management

### Session Lifecycle
1. **Bootstrap** - Load project state and context
2. **Development** - Work with TDD and SOLID protocols
3. **Handover** - Document progress and next steps
4. **Sprint Planning** - Track velocity and milestones

### Session Documents
- `BOOTSTRAP.md` - Session initialization
- `SESSION-LOG.md` - Work history and decisions
- `SESSION-HANDOVER.md` - Progress and next steps
- `SPRINTS.md` - Sprint planning and tracking

## 🎯 Quality Gates

### Pre-commit Checks
- Code formatting (Prettier)
- Linting (ESLint)
- Type checking (TypeScript)
- Test execution

### CI/CD Quality Gates
- Unit test coverage > 80%
- Integration test pass
- Security scan clean
- Performance benchmarks met

## 📈 Success Metrics

### Documentation Completeness
- All required documents created
- No placeholder content
- Up-to-date with current codebase

### Architecture Compliance
- SOLID principles followed
- Clean Architecture layers proper
- Dependency direction correct

### Test Coverage
- Unit tests > 80%
- Integration tests for critical paths
- E2E tests for user workflows

## 🔄 Continuous Improvement

### Regular Updates
- Monthly documentation review
- Quarterly architecture assessment
- Annual security audit
- Continuous integration improvements

### Feedback Loops
- Developer experience surveys
- Documentation usability testing
- Architecture decision reviews
- Performance monitoring

## 📚 Resources

### Internal Resources
- [SOLID Principles Guide](docs/SOLID_GUIDELINES.md)
- [TDD Protocol](docs/TDD_PROTOCOL.md)
- [CI/CD Pipeline](docs/CICD.md)
- [Security Policies](docs/SECURITY.md)

### External Resources
- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/)
- [Test-Driven Development by Kent Beck](https://www.oreilly.com/library/view/test-driven-development/9780321146533/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🎯 Success Criteria

### For Greenfield Projects
- ✅ Complete project scaffold created
- ✅ All documentation templates populated
- ✅ SOLID architecture implemented
- ✅ TDD protocols established
- ✅ CI/CD pipeline configured
- ✅ Session management ready

### For Brownfield Projects
- ✅ Existing codebase preserved
- ✅ Missing documentation created
- ✅ Architecture gaps identified
- ✅ Migration strategy defined
- ✅ Quality improvements planned
- ✅ No workflow disruption

## 🔄 Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | [Date] | Initial release with greenfield support | [Author] |
| 1.1 | [Date] | Added brownfield project support | [Author] |
| 1.2 | [Date] | Added CI/CD documentation | [Author] |
| 1.3 | [Date] | Added UI/UX templates | [Author] |
| 1.4 | [Date] | Added rate limiting and security | [Author] |

## 📞 Support

### Getting Help
- **Documentation**: Check this README and docs/ folder
- **Issues**: Create GitHub issue with detailed description
- **Discussions**: Use GitHub Discussions for questions
- **Contact**: [Your Contact Information]

### Contributing
- Follow contribution guidelines in `CONTRIBUTING.md`
- Use pull request workflow
- Maintain documentation updates
- Follow SOLID principles and TDD

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

## 🙏 Acknowledgments

- **amph-v2** - Base project patterns
- **amph-v2-greenfield** - Greenfield project templates
- **Operit AI** - AI assistant platform
- **Clean Architecture** - Robert C. Martin's principles
- **Test-Driven Development** - Kent Beck's methodology

---

**Note:** Never create documentation without understanding the project first. Never skip intelligent questions. Never assume requirements.

**Last Updated:** [Current Date]  
**Maintained by:** [Your Name/Organization]