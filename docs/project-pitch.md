# Felt — Project Pitch

## Problem

Poker players have no good way to share, review, or learn from hand histories.

**Problem 1 — Hand sharing is broken.**
The standard hand history format (used by PokerStars, GGPoker, etc.) is dense, ugly, and unreadable to anyone who wasn't at the table. When players want to discuss a hand — with friends, in a group chat, on a forum — they resort to writing paragraphs of natural language prose. There is no tool that lets someone *speak* what happened and get back something visual, clean, and shareable in seconds.

**Problem 2 — AI coaching doesn't exist in an accessible form.**
GTO solvers (GTO+, PioSOLVER, etc.) exist but require technical knowledge, desktop software, and manual setup per hand. There is no app where a player can describe a hand and get real, contextual coaching advice — not a lookup table, but actual analysis of *what happened* and *why*.

---

## Solution

A web app (iOS to follow) with two tightly integrated components:

### Component 1 — Voice-to-Visual Hand Entry
- User speaks (or types) a natural language description of a hand
- AI parses the description into a fully structured Hand object: players, positions, stack sizes, hole cards, street-by-street actions, pot sizes
- App renders the hand as a clean, visual breakdown — cards displayed, actions shown step by step, pot tracked automatically
- Output is shareable as a link or image

### Component 2 — AI Coaching
- Every rendered hand is automatically analyzed by AI
- Coach identifies key decision points and evaluates lines taken
- Advice is contextual: accounts for position, stack depth, and opponent tendencies if described
- Users build a hand history over time; coach can identify leaks and patterns across sessions

---

## Target User

Recreational to semi-serious poker players who:
- Play live or online (home games, casinos, online poker sites)
- Want to discuss hands with friends or in communities
- Are looking to improve but don't have access to or patience for solver software

---

## MVP Features

| Feature | Description |
|---|---|
| Voice hand entry | Speak a hand, AI parses it into structured format |
| Text hand entry | Type a hand description as a fallback |
| Visual hand renderer | Card-by-card, street-by-street breakdown |
| AI hand analysis | Coaching advice per hand |
| Shareable hand cards | Generate a public link or image to share a hand |

## Post-MVP Features

| Feature | Description |
|---|---|
| User accounts | Auth, profiles, hand history storage |
| Hand library | Browse, search, filter, tag saved hands |
| Bulk hand history import | Upload PokerStars / GGPoker hand history files |
| iOS app | Follows web MVP |

---

## Initiatives & Work Items

### Initiative 1 — Foundation
> Project scaffolding, infrastructure, auth, accounts

- `I1-1` Scaffold Next.js project, deploy to AWS Amplify
- `I1-2` Set up AWS Cognito auth (sign up, log in, password reset)
- `I1-3` Design DynamoDB schema for users and hand histories
- `I1-4` Set up API Gateway + Lambda skeleton (Java runtime)
- `I1-5` Set up S3 bucket for bulk hand history file uploads
- `I1-6` CI/CD pipeline (GitHub Actions → Amplify)

### Initiative 2 — Hand Entry: Voice & Text
> The core input mechanism

- `I2-1` Integrate Amazon Transcribe for voice-to-text
- `I2-2` Build voice recording UI component
- `I2-3` Define structured Hand object schema (TypeScript + JSON)
- `I2-4` Build Claude API prompt: natural language → Hand object
- `I2-5` Build text input fallback (type a hand description)
- `I2-6` Hand entry review/edit step before saving

### Initiative 3 — Visual Hand Renderer
> Turn a structured Hand object into something beautiful

- `I3-1` Design Hand object → UI component mapping
- `I3-2` Build playing card component (suit + rank)
- `I3-3` Build table position component (seat labels, positions)
- `I3-4` Build street-by-street action timeline (preflop → flop → turn → river)
- `I3-5` Build pot tracker (running pot size per action)
- `I3-6` Build shareable hand card (static image export or shareable URL)

### Initiative 4 — AI Coaching
> Analysis and advice on every hand

- `I4-1` Design coaching prompt (Hand object → structured analysis)
- `I4-2` Identify key decision points automatically
- `I4-3` Build coaching response UI (decision-by-decision breakdown)
- `I4-4` Coaching depth settings (beginner / intermediate / advanced)
- `I4-5` Session-level leak detection (patterns across saved hands)

### Initiative 5 — Hand History Management
> Storage, library, and bulk import

- `I5-1` Save/retrieve hand histories per user (DynamoDB)
- `I5-2` Hand library view: list, search, filter, tag
- `I5-3` PokerStars HH file parser
- `I5-4` GGPoker HH file parser
- `I5-5` Bulk import flow: upload file → parse → review → save
- `I5-6` Export hands (download as PDF or JSON)

### Initiative 6 — Social & Sharing
> Making hands easy to share

- `I6-1` Shareable hand URL (public link, no auth required to view)
- `I6-2` OG image generation for link previews (Twitter/Discord/iMessage)
- `I6-3` Hand collections / groups (share a set of hands with friends)

---

## Out of Scope (MVP)

- User accounts and auth
- Hand history storage / hand library
- Bulk hand history import
- Real-time multiplayer / live session tracking
- Range analysis / equity calculators
- Native iOS app (follows web MVP)
- Monetization / paywall (design for it, don't build it yet)
- PLO variants (Hold'em only for MVP)

---

## Open Questions

- [ ] AI coach — opinionated (recommends a line) or balanced (presents options)?
- [ ] Which additional hand history formats to support after PokerStars + GGPoker?
- [ ] Mobile-first or desktop-first UI layout?
