# Felt — CLAUDE.md

## What This Project Is

Felt is an AI-powered poker hand journal. Users speak or type a description of a poker hand, the app parses it into a structured format, renders it as a visual breakdown, and provides AI coaching advice. Users can also import standard hand history files from poker clients.

## Tech Stack

- **Frontend:** Next.js (React)
- **Voice:** Amazon Transcribe
- **AI:** Claude API (hand parsing + coaching)
- **Backend:** AWS Lambda (Java) + API Gateway
- **Auth:** AWS Cognito
- **Database:** DynamoDB (hand histories, user data)
- **File Storage:** S3 (bulk hand history uploads)
- **Hosting:** AWS Amplify
- **CI/CD:** GitHub Actions → Amplify
- **IaC:** Terraform (`infra/terraform/`)

## Repository Structure

```
Felt/
├── CLAUDE.md               # This file
├── README.md               # Project overview
├── PLAN.md                 # Work item log — gitignored, not committed
├── .gitignore
├── docs/
│   └── project-pitch.md   # Full project pitch and initiative breakdown
├── assets/                # Static assets (logo, etc.)
├── src/
│   ├── app/               # Next.js app directory
│   ├── components/        # Reusable UI components
│   ├── lib/               # Shared utilities, API clients
│   └── types/             # TypeScript type definitions
├── infra/
│   └── terraform/         # All AWS infrastructure as Terraform
│       ├── environments/  # Per-environment configs (dev, prod)
│       └── modules/       # Reusable resource modules
└── tests/                 # Unit and integration tests
```

## Core Concepts

### Hand Object
The central data structure. A Hand contains: players, positions, stack sizes, hole cards, and a list of streets (preflop/flop/turn/river), each with ordered actions (fold/call/raise/check/bet) and pot size.

### Pipeline
Voice/text input → Claude API parses to Hand object → Visual renderer displays the hand → AI coaching analyzes the hand → Hand saved to DynamoDB

### Hand Formats Supported (for import)
- PokerStars hand history (priority 1)
- GGPoker hand history (priority 2)
- More to follow

## Claude Instructions

### Security
- Security is the #1 priority
- IAM policies must always use least privilege — specific actions and specific resource ARNs only, never `*` for actions
- CORS `allow_origins` must never be `["*"]` — always scoped to the actual domain per environment
- All data stores must have encryption at rest explicitly configured
- Before marking any feature complete, perform a security review: check IAM permissions, input validation, data exposure, and network access
- Review every new AWS resource for IAM and network exposure before committing

### Always Do
- Update `CLAUDE.md` if the tech stack, architecture, or core conventions change
- Update `README.md` if top-level user-facing functionality changes significantly
- Update `docs/project-pitch.md` if scope or initiatives change
- Update `PLAN.md` after every work session — log completed items, update statuses, add new items the user has requested
- Keep `PLAN.md` as the single source of truth for project status (it is the Jira)

### Never Do
- Commit `PLAN.md` — it is gitignored
- Add speculative features or abstractions beyond what is explicitly requested
- Skip updating docs when something meaningful changes
- Add a license section to the README or any doc unless explicitly asked
- Hallucinate — never invent facts, APIs, library behavior, or project details. If unsure, say so and verify first

### Commit Messages
Always prefix commit messages with: `Genevieve's Intern Claude:`

### Work Item Log
`PLAN.md` is the running project plan and work item log. It tracks:
- Initiatives and their work items
- Status of each item (todo / in progress / done / deferred)
- Items the user has explicitly deferred
- A log of completed sessions

Always read `PLAN.md` at the start of a session to understand current state.
