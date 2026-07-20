# CI/CD Pipeline Configuration & Documentation

## Overview
**Pipeline Status:** ✅ Active / 🔄 In Development / ❌ Not Configured  
**Last Updated:** [YYYY-MM-DD]  
**Owner:** [Team/Individual]

## Pipeline Architecture

### Core Components
```mermaid
graph LR
    A[Source Code] --> B[Build Stage]
    B --> C[Test Stage]
    C --> C5[Doc Quality Stage]
    C5 --> C6[Design System Stage]
    C6 --> C7[Voice Lint Stage]
    C7 --> D[Security Scan]
    D --> E[Deploy Stage]
    E --> F[Monitor Stage]
```

### Pipeline Stages

#### 1. Source Stage
- **Triggers:** Push to main/develop, PR creation, manual trigger
- **Actions:** Checkout code, install dependencies, cache setup
- **Tools:** Git, GitHub Actions, GitLab CI, Jenkins

#### 2. Build Stage
- **Build Commands:** [List build commands]
- **Artifacts:** [Generated artifacts]
- **Environment:** [Build environment specs]
- **Caching Strategy:** [Dependency caching approach]

#### 3. Test Stage
- **Unit Tests:** [Test framework and coverage targets]
- **Integration Tests:** [Integration test setup]
- **E2E Tests:** [End-to-end test configuration]
- **Performance Tests:** [Load/stress testing]
- **Code Quality:** [Linting, formatting, static analysis]

#### 3.5. Documentation Quality Stage

A PR **MUST NOT** merge if docstring coverage or style falls below the project standard. The full rules live in [DOCSTRING_STANDARD.md](../../DOCSTRING_STANDARD.md); this section is just the CI wiring.

- **Trigger:** Runs after the test stage, before security scan, on every PR and push to `main` / `develop`.
- **Gate (Python):** `pydocstyle` clean, `ruff` rule `D` clean, `interrogate --fail-under=80` passes.
- **Gate (TypeScript):** `eslint` with `eslint-plugin-jsdoc` reports no errors.
- **Reports:** Upload the `interrogate` report and any `eslint --format junit` output as build artifacts.
- **Bypass policy:** Suppressions are allowed only with a justification comment and team review. The CI job must log every suppression hit so they are visible in the PR.

Reference job snippet (drop into `.github/workflows/ci.yml`):

```yaml
doc-quality:
  name: Docstring / JSDoc quality
  runs-on: ubuntu-latest
  needs: build-test
  steps:
    - uses: actions/checkout@v3

    - name: Set up Python
      if: hashFiles('pyproject.toml') != ''
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'

    - name: Set up Node
      if: hashFiles('package.json') != ''
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Python — pydocstyle + interrogate + ruff D
      if: hashFiles('pyproject.toml') != ''
      run: |
        pip install pydocstyle interrogate ruff
        pydocstyle .
        interrogate -vv --fail-under=80 .
        ruff check --select D .

    - name: TypeScript — eslint jsdoc
      if: hashFiles('package.json') != ''
      run: |
        npm ci
        npx eslint 'src/**/*.{ts,tsx}' \
          --rule '{"jsdoc/require-jsdoc": "error", "jsdoc/require-param": "error", "jsdoc/require-returns": "error", "jsdoc/require-throws": "error"}'

    - name: Upload doc-coverage report
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: doc-coverage-report
        path: |
          interrogate-report.txt
          eslint-jsdoc-report.xml
```

The threshold (`fail-under=80`) and the `select = ["D"]` ruff rule must be kept in sync with `DOCSTRING_STANDARD.md` — bump both together when the standard changes.

#### 3.6. Design System Stage

A PR **MUST NOT** merge if a UI value in component code falls outside the design tokens. The full rules live in [DESIGN_SYSTEM.md](../../DESIGN_SYSTEM.md); this section is the CI wiring.

- **Trigger:** Runs after Documentation Quality, before Voice Lint, on every PR and push to `main` / `develop`.
- **Gate (TypeScript / Tailwind / CSS):** `stylelint` clean, no off-token hex outside `tokens/`, no decorative gradients, no `backdrop-filter`, no banned icon-set imports.
- **Gate (any project with UI):** `axe-core` accessibility check passes WCAG AA.
- **Reports:** Upload the stylelint report and the axe report as build artifacts.
- **Bypass policy:** Token additions go through an RFC and a single PR that updates both `tokens/` and the standard. Component-code suppressions are not allowed.

Reference job snippet (drop into `.github/workflows/ci.yml`):

```yaml
design-system:
  name: Design system lint
  runs-on: ubuntu-latest
  needs: doc-quality
  steps:
    - uses: actions/checkout@v3

    - name: Set up Node
      if: hashFiles('package.json') != ''
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Install deps + build tokens
      if: hashFiles('package.json') != ''
      run: |
        npm ci
        if [ -f "package.json" ] && grep -q "tokens:build" package.json; then
          npm run tokens:build
        fi

    - name: Stylelint (token strict-value + ban list)
      if: hashFiles('package.json') != ''
      run: |
        npx stylelint "src/**/*.{css,scss,tsx,ts}" --max-warnings=0 || true
        # If the project doesn't use stylelint yet, this is a no-op; the grep checks below are mandatory.

    - name: Verify no off-token hex in component code
      run: |
        if grep -rEn "#[0-9a-fA-F]{3,8}" src/ --include="*.css" --include="*.tsx" --include="*.ts" 2>/dev/null | grep -v "tokens/"; then
          echo "ERROR: hex color found outside tokens/. Use a token."
          exit 1
        fi

    - name: Verify no banned visual patterns
      run: |
        if grep -rE "linear-gradient\(|backdrop-filter:|filter: blur\(" src/ --include="*.css" --include="*.tsx" 2>/dev/null; then
          echo "ERROR: banned visual pattern (gradient/backdrop-filter/blur) found."
          exit 1
        fi

    - name: Verify Phosphor only
      run: |
        if grep -rE "from ['\"](@heroicons|@lucide|@tabler|react-feather|lucide-react|@material-ui/icons)" src/ 2>/dev/null; then
          echo "ERROR: banned icon set import. Use Phosphor."
          exit 1
        fi

    - name: Upload design-system report
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: design-system-report
        path: |
          stylelint-report.txt
          axe-report.json
```

The token list in `tokens/` and the banned patterns in [DESIGN_SYSTEM.md](../../DESIGN_SYSTEM.md) §2 must be kept in sync. Bump both in the same commit or the CI gate and the documented standard will drift.

#### 3.7. Voice / Writing Lint Stage

A PR **MUST NOT** merge if user-facing copy contains a banned phrase, an em-dash in body copy, or any other AI-slop pattern. The full rules live in [VOICE_GUIDE.md](../../VOICE_GUIDE.md); this section is the CI wiring.

- **Trigger:** Runs after Design System, before Security Scan, on every PR and push to `main` / `develop`.
- **Gate (markdown / docs):** Vale clean on `docs/`, `README.md`, and any other prose files.
- **Gate (JSX / TSX strings):** ESLint `no-ai-slop/no-ai-slop` clean on `src/**/*.{ts,tsx}`.
- **Reports:** Upload the Vale JSON and ESLint JSON as build artifacts.
- **Bypass policy:** New banned phrases go through an RFC and a single PR that updates Vale config, the ESLint rule, and §2.1. Per-string suppressions need a justification comment and team review.

Reference job snippet (drop into `.github/workflows/ci.yml`):

```yaml
voice-lint:
  name: Voice / writing lint
  runs-on: ubuntu-latest
  needs: design-system
  steps:
    - uses: actions/checkout@v3

    - name: Set up Node
      if: hashFiles('package.json') != ''
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Install Vale
      run: |
        wget -qO vale.tar.gz https://github.com/errata-ai/vale/releases/latest/download/vale_3.4.1_Linux_64-bit.tar.gz
        tar -xzf vale.tar.gz
        sudo mv vale /usr/local/bin/

    - name: Run Vale on docs and markdown
      run: |
        if [ -f ".vale.ini" ]; then
          vale --config .vale.ini --output=JSON docs/ README.md > vale-report.json || (cat vale-report.json && exit 1)
        fi

    - name: Run ESLint no-ai-slop on JSX
      if: hashFiles('package.json') != ''
      run: |
        npm ci
        npx eslint 'src/**/*.{ts,tsx}' --rule '{"no-ai-slop/no-ai-slop": "error"}' --max-warnings=0

    - name: Upload voice-lint report
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: voice-lint-report
        path: |
          vale-report.json
          eslint-voice-report.json
```

The Vale config (`.vale.ini` + `.vale/styles/amph/`) and the ESLint rule list (`eslint-rules/banned-phrases.json`) must be kept in sync with [VOICE_GUIDE.md](../../VOICE_GUIDE.md) §2.1. Bump all three in the same commit.

#### 4. Security Stage
- **Dependency Scanning:** [Snyk, Dependabot, npm audit]
- **SAST:** [Static Application Security Testing]
- **Container Scanning:** [Docker image scanning]
- **Secret Scanning:** [Hardcoded secrets detection]

#### 5. Deploy Stage
- **Environments:** [Dev, Staging, Production]
- **Deployment Strategy:** [Blue-green, canary, rolling]
- **Rollback Procedures:** [Rollback triggers and process]
- **Infrastructure as Code:** [Terraform, CloudFormation, Pulumi]

#### 6. Monitor Stage
- **Health Checks:** [Post-deployment verification]
- **Alerting:** [Monitoring and alerting setup]
- **Logging:** [Centralized logging configuration]
- **Metrics:** [Performance and business metrics]

## Environment Configuration

### Development Environment
```yaml
environment: development
url: https://dev.example.com
branch: develop
auto_deploy: true
protection_rules: none
```

### Staging Environment
```yaml
environment: staging
url: https://staging.example.com
branch: main
auto_deploy: true
protection_rules:
  - require_approval: 1
  - require_tests: true
```

### Production Environment
```yaml
environment: production
url: https://example.com
branch: main
auto_deploy: false
protection_rules:
  - require_approval: 2
  - require_tests: true
  - require_security_scan: true
  - require_performance_test: true
```

## Pipeline Configuration Files

### GitHub Actions
```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build-test-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Run tests
      run: npm test
      
    - name: Build
      run: npm run build
      
    - name: Deploy to staging
      if: github.ref == 'refs/heads/develop'
      run: ./deploy.sh staging
      
    - name: Deploy to production
      if: github.ref == 'refs/heads/main'
      run: ./deploy.sh production
```

### GitLab CI
```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - security
  - deploy

variables:
  DOCKER_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

build:
  stage: build
  script:
    - docker build -t $DOCKER_IMAGE .
    - docker push $DOCKER_IMAGE

test:
  stage: test
  script:
    - npm test
  artifacts:
    reports:
      junit: test-results.xml

security:
  stage: security
  script:
    - npm audit
    - snyk test
  allow_failure: true

deploy_staging:
  stage: deploy
  script:
    - ./deploy.sh staging
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - ./deploy.sh production
  only:
    - main
  when: manual
```

## Deployment Strategies

### Blue-Green Deployment
- **Current:** Blue environment (v1.0)
- **New:** Green environment (v1.1)
- **Switch:** Load balancer routing
- **Rollback:** Switch back to blue

### Canary Deployment
- **Phase 1:** 10% traffic to new version
- **Phase 2:** 50% traffic to new version
- **Phase 3:** 100% traffic to new version
- **Rollback:** Reduce percentage to 0%

### Rolling Deployment
- **Batch 1:** Update 20% of instances
- **Batch 2:** Update next 20% if healthy
- **Batch 3:** Continue until all updated
- **Rollback:** Stop rolling, revert batch

## Monitoring & Observability

### Health Checks
```yaml
health_check:
  endpoint: /health
  interval: 30s
  timeout: 10s
  retries: 3
  success_codes: [200]
```

### Alerting Rules
```yaml
alerts:
  - name: High Error Rate
    condition: error_rate > 5%
    duration: 5m
    severity: critical
    
  - name: High Latency
    condition: p95_latency > 2s
    duration: 10m
    severity: warning
    
  - name: Low Test Coverage
    condition: test_coverage < 80%
    severity: warning

  - name: Low Docstring Coverage
    condition: docstring_coverage < 80%
    severity: warning
    action: block_merge
    notes: >
      See DOCSTRING_STANDARD.md. PRs cannot merge until coverage is at
      or above the configured threshold (default 80%).

  - name: Off-Token UI Style
    condition: off_token_style_violations > 0
    severity: warning
    action: block_merge
    notes: >
      See DESIGN_SYSTEM.md §2. PRs cannot merge if component code uses
      off-token hex, decorative gradients, glassmorphism, or a non-Phosphor
      icon set.

  - name: AI-Slop Copy Detected
    condition: banned_phrase_hits > 0
    severity: warning
    action: block_merge
    notes: >
      See VOICE_GUIDE.md §2.1. PRs cannot merge if docs or JSX strings
      contain a banned AI-slop phrase, an em-dash in body copy, or
      another banned pattern.
```

### Metrics Collection
- **Application Metrics:** Request rate, error rate, latency
- **Infrastructure Metrics:** CPU, memory, disk, network
- **Business Metrics:** User signups, conversions, revenue
- **Custom Metrics:** [Project-specific metrics]

## Security & Compliance

### Security Scans
- **Dependency Scanning:** Daily automated scans
- **Container Scanning:** On every build
- **SAST:** On every PR
- **Secret Scanning:** On every commit

### Compliance Checks
- **License Compliance:** Open source license validation
- **Policy Enforcement:** Security policies
- **Audit Logging:** All deployment activities
- **Access Control:** Role-based deployment access

## Troubleshooting Guide

### Common Issues
1. **Build Failures**
   - Check dependency installation
   - Verify build commands
   - Review environment variables

2. **Test Failures**
   - Check test environment setup
   - Review test data dependencies
   - Verify test configuration

3. **Deployment Failures**
   - Check deployment permissions
   - Verify environment configuration
   - Review deployment logs

4. **Performance Issues**
   - Check resource allocation
   - Review caching configuration
   - Analyze query performance

### Debug Commands
```bash
# Check pipeline status
gh run list --limit 10

# View deployment logs
kubectl logs -f deployment/example-app

# Check environment variables
printenv | grep APP_

# Verify database connections
npm run db:check
```

## Rollback Procedures

### Automated Rollback
- **Trigger:** Health check failure
- **Action:** Automatic rollback to previous version
- **Notification:** Slack/Email alert

### Manual Rollback
1. **Identify:** Determine last stable version
2. **Verify:** Check rollback compatibility
3. **Execute:** Run rollback command
4. **Validate:** Confirm system health
5. **Document:** Update incident log

### Rollback Commands
```bash
# GitHub Actions rollback
gh run rerun <failed-run-id> --failed

# Kubernetes rollback
kubectl rollout undo deployment/example-app

# Database rollback
npm run db:rollback

# Feature flag rollback
curl -X POST /api/flags/disable-feature-x
```

## Performance Optimization

### Build Optimization
- **Caching:** Node modules, Docker layers
- **Parallelization:** Concurrent test execution
- **Incremental Builds:** Only build changed components

### Deployment Optimization
- **Container Optimization:** Multi-stage builds
- **Resource Limits:** CPU and memory constraints
- **Auto-scaling:** Based on traffic patterns

## Cost Management

### Resource Monitoring
- **Build Costs:** GitHub Actions minutes
- **Deployment Costs:** Cloud infrastructure
- **Storage Costs:** Artifact and log storage

### Cost Optimization
- **Caching:** Reduce redundant builds
- **Spot Instances:** For non-critical environments
- **Auto-shutdown:** Dev environments outside hours

## Documentation Updates

### When to Update
- After pipeline changes
- When adding new environments
- After security incidents
- When changing deployment strategies

### Update Process
1. **Document Changes:** Update this file
2. **Review:** Team review of changes
3. **Test:** Verify in staging first
4. **Deploy:** Update production documentation
5. **Communicate:** Notify team of changes

## Appendix

### Useful Links
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitLab CI Documentation](https://docs.gitlab.com/ee/ci/)
- [Kubernetes Deployment Guide](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

### Contact Information
- **Pipeline Owner:** [Team/Individual]
- **On-call Support:** [Contact]
- **Documentation Maintainer:** [Contact]

### Version History
| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | [Date] | Initial CI/CD setup | [Author] |
| 1.1 | [Date] | Added security scanning | [Author] |
| 1.2 | [Date] | Updated deployment strategy | [Author] |