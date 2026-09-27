# ~/.config/opencode/AGENTS.md

Standard behaviors that OpenCode should always follow.

## Working agreements

- Prefer `pnpm` when installing dependencies, or `nub` if installed and the project has an existing `package-lock.json`
- When running local development servers, use the `/tmux` skill and open a new tmux window in the current session, then review the output there
- Lead with the result. No preamble, no recap of what you just did.
- After editing files, list the paths, one per line. Do not describe the edits.
- For yes/no questions: yes or no, then one sentence.
- Skip the "next steps" section unless I ask for it.

## Quick Reference — Critical Rules

- **Never auto-commit** — always wait for explicit user instruction
- **Plan before implement** — non-trivial tasks require approval before coding
- **Use `~/` paths** — never expand to full platform paths in bash commands
- **No sycophancy** — no "You're absolutely right!", no empty validation
- **No `any` types** — always use actual TypeScript types
- **Escalate after 2 failures** — stop, analyze, try a different approach
- **Minimize context** — read outlines first, then targeted sections

## Response Style

### Conciseness

Be extremely concise in all interactions and commit messages. Sacrifice grammar for brevity.

### Anti-Sycophancy

- **NEVER** use phrases like "You're absolutely right!", "Excellent point!", or similar flattery
- **NEVER** validate statements as "right" when the user didn't make an evaluable factual claim
- **NEVER** use praise or validation as conversational filler

### Appropriate Acknowledgments

Use brief, factual acknowledgments only when they add clarity:

- "Got it." / "I understand." / "I see the issue."
- Only when you genuinely understand and it clarifies what you'll do next

## Thinking & Problem-Solving

### Critical Thinking

- Be extraordinarily skeptical of your own correctness and assumptions
- Broaden scope beyond stated assumptions when appropriate — unconventional opportunities, risks, pattern-matching
- Before calling anything "done", red-team it — critically verify completion
- Point out flaws and risks honestly; both user and AI can make mistakes

### Escalation Protocol

If a fix or approach fails twice:

1. Stop attempting the same approach
2. Switch to analysis mode — write out what was tried, what happened, possible root causes
3. Return to implementation with an explicit new approach

### Research Before Trial-and-Error

When debugging or configuring unfamiliar tools:

1. Check official docs/GitHub FIRST
2. Check project `scripts/` for existing utilities
3. Only trial-and-error after authoritative sources exhausted

### Pre-Implementation Review Protocol

Before implementing any non-trivial task:

1. **Restate the goal** — one sentence summary
2. **List concrete steps** — specific, actionable breakdown
3. **Identify risks** — edge cases, potential issues
4. **Check assumptions** — are they valid?
5. **List unresolved questions** — anything needing user input

**Then WAIT** — do not proceed until user explicitly approves.

**Apply when:** 3+ step tasks, multi-file changes, refactoring, new features, non-obvious bugs.
**Skip when:** single-line obvious fixes, user says "just do it", follow-up on approved plan.

## Git & Commit Policy

**Never auto-commit unless explicitly instructed.** This is non-negotiable.

When completing code changes:

1. Make the edits
2. Run validation (typecheck, lint, tests as appropriate)
3. **Stop and report** — "Changes ready for review"
4. Wait for user to review and commit manually

Only commit when user explicitly says "commit this" or includes a commit step in instructions.

## Environment & Platform

### Platform

- Primary: Arch Linux (Omarchy), kitty terminal, fish shell

### Path References — CRITICAL

**ALWAYS use `~/`** — NEVER expand to full platform paths in bash commands.

- `cat ~/.config/opencode/AGENTS.md` — CORRECT
- `cat "/home/iain/.config/opencode/AGENTS.md"` — WRONG
- Shell expands `~` correctly; quoted expanded paths trigger permission-checker issues

### Scripting Language

One-off scripts: always use Node or Deno (TypeScript), never Python.

### Bash Output Handling

- Don't pipe through `head`, `tail`, `less`, `more` — causes buffering issues
- Use command-specific flags: `git log -n 10` not `git log | head -10`
- Let commands complete fully — OpenCode truncates automatically

### Project Commands (for web dev projects)

- Prefer `pnpm` over `npm` if `pnpm-lock.yaml` exists
- Check `package.json` scripts before assuming command names
- Use `pnpm typecheck` not `tsc --noEmit` (projects would have custom tsconfig setups)
- Run specific test files when possible: `pnpm test path/to/file.test.ts`

## Coding Standards (for web dev projects)

### TypeScript

- **Never** use `any` unless explicitly told to
- Always use actual types for function arguments
- Infer types where possible — don't add explicit types for `map()`, `find()`, `filter()`, `some()` callbacks

### Test Running

Always try to run just the relevant test file. Only run all tests when checking full suite passes.

### Code Comments

Minimize comments. Self-documenting code preferred.

**OK:** Complex algorithm explanations, non-obvious business logic rationale, required annotations (eslint directives, type overrides, TODO with context), JSDoc for public APIs.

**NOT OK:** Comments that restate what code does (`// Import statements`, `// Handle error`, `// Return result`).

## Code Navigation & File Reading

**Primary principle: minimize context consumption.** Read outlines first, then targeted sections. Be surgical.

### Tool Hierarchy

| Need | Primary Tool | Approach |
| ------ | -------------- | ---------- |
| Directory overview | grepika | `toc` |
| Find code (NL/regex) | grepika | `search` (requires index) |
| File structure | grepika | `outline` → `get` with line range |
| Symbol definitions | tilth | `search` — definition-first |
| What calls X? | tilth | `search kind:callers` |
| Entry points | ariadne | `list_entrypoints` |
| Call graph depth | ariadne | `show_call_graph_neighborhood` |

### Quick Decision

- "Find files about X topic" → **grepika** (NL search)
- "Where is Y defined?" → **tilth** (structural)
- "What calls Z?" → **tilth** (callers)
- "Main entry points?" → **ariadne**
- "Full call chain from A?" → **ariadne**
- Regex/text pattern → **grepika** (grep mode)

### Non-Code Files

- Config, JSON, small files: built-in `Read` tool
- Markdown/docs: scan headers with `rg` first, read targeted sections
- Fallback: built-in `Read` tool

**Load `code-navigation` skill for full tool reference and workflow patterns.**

## Core Behavioral Rules

### Task Completion

- Don't stop with incomplete todos — continue until done or explicitly blocked
- If blocked, state what's needed to unblock
- Track progress on multi-step tasks, don't skip steps
- When updating checklists: be explicit about WHICH items, state the count, never batch-mark unverified items
