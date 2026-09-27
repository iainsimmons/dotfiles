# Code Navigation & File Reading

Full tool reference for navigating codebases. The AGENTS.md quick-reference table covers tool selection; this skill provides detailed usage patterns, workflows, and edge cases.

## Grepika — Default Exploration Tool

Use grepika first for all code exploration and reading.

### Commands

- `grepika_toc` — directory tree overview
- `grepika_search` — find code patterns (regex or natural language). **Requires index** — run `grepika_index` first if results are empty/stale.
- `grepika_outline` — extract file structure (functions, classes, types). **Always do this before reading code.**
- `grepika_get` with `start_line`/`end_line` — read targeted sections. Use outline results to pick exact line ranges. **Never omit line range on large files.**
- `grepika_context` — see surrounding code at a search match location
- `grepika_refs` — find all references to a symbol/identifier
- `grepika_index` — rebuild search index if results seem stale. Use `force=true` for full rebuild.

### Core Workflow

```
grepika_outline → identify symbols of interest → grepika_get with line range → read only what's needed
```

Repeat as necessary. This keeps context lean.

## Tilth — Structural / Definition Queries

When you need to know *where something is defined* or *what calls what*, prefer tilth over grepika.

### Commands

- `tilth_read` — smart file reading. Small files shown whole, large files auto-outlined with drillable line ranges.
- `tilth_search` — definition-first search. Finds where symbols are **defined** (not just string matches), shows surrounding structure, resolves callees inline.
  - Use `scope` param to limit to a subdirectory
  - Multi-symbol: pass comma-separated names to trace across files in one call
  - Callers: `kind: callers` finds all call sites using tree-sitter structural matching
- `tilth_deps` — blast-radius check. Shows what a file imports and what other files use its exports. **Use before breaking changes** (renaming exports, changing signatures).

### When to Choose Tilth Over Grepika

- You want the **definition** of a symbol, not just occurrences of a string
- You need **callers** of a function (structural, not text grep)
- You want to trace **multiple symbols** across files in one call

## Ariadne — Architectural / Call-Graph Analysis

For high-level structure understanding and tracing call chains beyond immediate callers.

### Commands

- `ariadne_list_entrypoints` — find top-level entry points (functions never called by others), ranked by call tree complexity. Great for onboarding to unfamiliar code.
- `ariadne_show_call_graph_neighborhood` — bidirectional call graph (callers + callees) with configurable depth.
  - `symbol_ref` format: `file_path:line#name`
  - Both tools accept `files` and `folders` params to scope analysis
  - Use absolute paths for cross-workspace targeting

### When to Choose Ariadne

- "What are the main entry points in this module?"
- "Show me the full call chain from X down 3 levels"
- Understanding unfamiliar codebase architecture

## Non-Code Files

- **Config, JSON, small files:** Use the built-in `Read` tool directly.
- **Markdown/docs:** Don't blindly read whole file. Scan headers with `rg "^#{1,3} "` first, then read targeted sections with offset/limit. Only full-read if small or genuinely needed.
- **Fallback:** Use the built-in `Read` tool directly.

## Decision Flowchart

| Question | Tool | Why |
| ---------- | ------ | ----- |
| "Find files about X topic" | grepika search | NL relevance ranking |
| "Where is Y defined?" | tilth search | Definition-first structural |
| "What calls Z?" | tilth search (callers) | Tree-sitter structural matching |
| "Main entry points?" | ariadne list_entrypoints | Ranks by call tree complexity |
| "Full call chain from A?" | ariadne call_graph | Bidirectional with depth |
| Regex/text pattern match | grepika search (grep mode) | Fast text search |
| "What would break if I change X?" | tilth deps | Blast-radius analysis |

## Anti-Patterns

- **Reading entire large files** — always outline first, then targeted get
- **Using grepika search without index** — results will be empty. Run `grepika_index` first.
- **Omitting line ranges on grepika_get** — wastes context on large files
- **Using grep/text search when you need definitions** — will find usages, imports, comments. Use tilth for definitions.
