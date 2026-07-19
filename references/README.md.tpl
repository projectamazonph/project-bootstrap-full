# [Project Name]

<!-- Badges -->
[![CI Status](https://github.com/[owner]/[repo]/actions/workflows/ci.yml/badge.svg)](https://github.com/[owner]/[repo]/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## What This Is

[One-paragraph description of what the project does, who it's for, and why it matters.]

## Quick Start

### Prerequisites
- [Runtime] v[version]
- [Package Manager] v[version]
- [Database] v[version]

### Setup
```bash
# Clone
git clone https://github.com/[owner]/[repo].git
cd [repo]

# Install
[pkg-manager] install

# Configure
cp .env.example .env
# Edit .env with your values

# Database
[pkg-manager] prisma:migrate

# Run
[pkg-manager] dev
```

Open [http://localhost:3000](http://localhost:3000)

## Architecture

```
[ASCII architecture diagram]
```

| Layer | Directory | Purpose |
|-------|-----------|---------|
| Domain | `src/domain/` | Pure business logic |
| Ports | `src/ports/` | Interfaces only |
| Use Cases | `src/usecases/` | One class per use case |
| Infrastructure | `src/infra/` | Adapters implementing ports |
| Application | `src/app/` | Routes and UI |
| Components | `src/components/` | UI primitives |

## Commands

| Command | Description |
|---------|-------------|
| `[pkg] dev` | Start development server |
| `[pkg] build` | Production build |
| `[pkg] start` | Start production server |
| `[pkg] test` | Run unit/integration tests |
| `[pkg] test:e2e` | Run E2E tests |
| `[pkg] lint` | Run linter |
| `[pkg] typecheck` | Type checking |

## Tech Stack

| Category | Technology |
|----------|------------|
| Language | [TypeScript/Python/etc.] |
| Framework | [Next.js/Express/Django] |
| Database | [PostgreSQL/MySQL/MongoDB] |
| ORM | [Prisma/Sequelize/Mongoose] |
| Testing | [Vitest/Jest/Playwright] |
| CI/CD | [GitHub Actions/GitLab CI] |
| Hosting | [Vercel/AWS/GCP] |

## Project Structure

```
[project]/
├── src/
│   ├── domain/         # Pure business model
│   ├── ports/          # Interfaces only
│   ├── usecases/       # One class per use case
│   ├── infra/          # Adapters implementing ports
│   ├── app/            # Routes and pages
│   ├── components/     # UI primitives
│   └── lib/            # Shared utilities
├── prisma/             # Database schema
├── tests/              # Test suites
├── docs/               # Documentation
└── scripts/            # Build scripts
```

## Documentation

- [Product Requirements](docs/PRD.md)
- [MVP Specification](docs/MVP.md)
- [Architecture](docs/ARCHITECTURE.md)
- [API Specification](docs/API_SPECIFICATION.md)
- [Database Schema](docs/DATABASE_SCHEMA.md)
- [Security](docs/SECURITY.md)
- [UI/UX Guidelines](docs/UI_COMPONENTS.md)
- [CI/CD Pipeline](docs/CICD.md)
- [User Stories](docs/USER_STORIES.md)
- [Sprint Planning](SPRINTS.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

[License] - see [LICENSE](LICENSE) for details.