# Memory Cell

**Reinvent Cognition.**  
*Built for AI-native companies and autonomous agent builders — giving agents mind, alignment, and continuity across every session, tool, and teammate.*

Local-first memory engine and structural grounding layer for autonomous agents. Proven first in high-stakes software engineering, architected for all autonomous agent domains — packaged as a single Rust binary with embedded SQLite and zero API keys required.

<p align="left">
  <a href="https://www.npmjs.com/package/@muxtsou/memory-cell"><img src="https://img.shields.io/npm/v/@muxtsou/memory-cell?color=blue&style=flat-square" alt="npm version" /></a>
  <a href="https://www.npmjs.com/package/@muxtsou/memory-cell"><img src="https://img.shields.io/npm/dm/@muxtsou/memory-cell?style=flat-square" alt="npm downloads" /></a>
  <img src="https://img.shields.io/badge/Platforms-macOS%20%7C%20Linux%20%7C%20Windows-brightgreen?style=flat-square" alt="Platforms" />
  <img src="https://img.shields.io/badge/Interface-CLI%20%2B%20MCP-orange?style=flat-square" alt="Interface: CLI + MCP" />
  <img src="https://img.shields.io/badge/License-Apache--2.0-blue?style=flat-square" alt="License" />
</p>

- **Mind — Agents stop repeating yesterday's mistakes**: Distills execution trails, pitfalls, workflows, and decisions into durable, Git-tracked Markdown in `.memory/` and surfaces them before the next task.
- **Alignment — Actions stay grounded in real structure**: Anchors agent reasoning to physical documents and 22-language tree-sitter AST symbol/call graphs (`find_symbol`, `trace_callers`, `analyze_impact`) so changes do not silently break dependencies.
- **Continuity — Switching tools or compacting context never resets progress**: Connects via native MCP and lifecycle hooks across Claude Code, Cursor, Antigravity, Codex, Copilot, Devin, Windsurf, OpenCode, Hermes, and custom agent workflows; resume any session with `/takeover`.

---

## Quick Install

### macOS & Linux (One-Line Installer)
No Node.js or Rust toolchain required:

```bash
curl -fsSL https://raw.githubusercontent.com/muxtsou/memory-cell-distribution/main/install.sh | bash
```

### npm (macOS, Linux, Windows)
Install globally so IDE hooks can invoke `memory-cell` on your `PATH`, then initialize inside your repository root:

```bash
npm install -g @muxtsou/memory-cell
memory-cell init
```

`memory-cell init` runs zero-prompt by default (pass `--interactive` for the guided wizard). It downloads and warms the local embedding model (`multilingual-e5-small`) once on first run, syncs your project docs and AST index with live progress bars, configures detected IDEs, and auto-selects a working distillation backend without creating or modifying `.env`.

---

## Who It's Built For

Memory Cell is designed for **AI-native companies** where autonomous agents are no longer an occasional autocomplete, but part of daily execution:

| Target Audience | Real-World Scenario | What Memory Cell Solves |
| :--- | :--- | :--- |
| **AI-Native Engineering Teams (5–25+ engineers)** | Everyone ships daily with Claude Code, Cursor, Antigravity, Codex, or Devin. Agent A breaks Agent B's module, and the same bug shows up in PR reviews every week. | Anchors changes to 22-language AST call graphs (`analyze_impact`, `trace_callers`) and shares verified `.memory/` rules, workflows, and anti-patterns across the team via Git. |
| **Autonomous Agent & AI Product Builders** | You are building multi-agent or domain workflows (research, ops, technical/legal/financial docs) that need persistent memory without maintaining Neo4j or burning tokens on raw RAG dumps. | Provides a local-first, auditable memory engine over native MCP (embedded SQLite + Git-tracked Markdown) that turns execution trails into structured, reusable knowledge. |
| **Multi-Tool Power Users** | You switch between IDE agents and terminal CLIs all day, or hit `/compact` mid-task and lose all working context. | Lifecycle hooks snapshot session trails automatically; `/takeover` resumes goals and progress across tools with zero API keys required. |

---

## What Changes in Daily Work

| Everyday Friction | Without Memory Cell | With Memory Cell |
| :--- | :--- | :--- |
| **Repeated bug / pitfall** | You explain the same workaround again in the next chat. | Recorded in `.memory/anti_patterns/` and surfaced automatically on related prompts. |
| **Cross-file refactoring** | Agent greps loosely and misses downstream callers. | `find_symbol`, `trace_callers`, and `analyze_impact` map exact definitions and call sites from the AST graph. |
| **`/compact` or IDE switch** | Context resets; you manually re-brief the new session. | Hooks snapshot session progress; `/takeover` resumes active goals and trails across tools. |
| **Reading project docs & code** | Agent dumps whole files into context just to find one rule or function. | `reason` and `search` return grounded document sections, rules, and exact symbol locations. |

### What Setup Looks Like

```text
$ memory-cell init
✅ Embedding model ready (384d, 3820ms)
Syncing docs  [████████████████████] 4/4 (100%) README.md
Indexing code [████████████████████] 28/28 (100%) main.rs
✅ Initialized my-app (antigravity, cursor, claude · cli/claude (no API key) · 4 docs, 312 AST nodes)
Next: Reload your IDE window to connect MCP

$ memory-cell doctor
memory-cell doctor  ~/code/my-app

✅ Binary        ~/.local/bin/memory-cell
✅ Workspace     antigravity, cursor, claude
✅ Database      ~/.memory_cell/global.sqlite3
✅ Model cache   warm (multilingual-e5-small)
✅ Index         synced (312 AST nodes, 540 synapses)
✅ Distillation  cli/claude (~/.local/bin/claude, no API key required)

✅ Healthy (0 issues).
```

---

## Why Not Just `.cursorrules`, Bigger Context, or Vector RAG?

| Approach | Where It Falls Short | How Memory Cell Handles It |
| :--- | :--- | :--- |
| **Bigger context windows** | Dumping raw files dilutes attention, slows every turn, and still resets when a session ends. | Retrieves only the relevant AST symbols, call sites, and `.memory/` entries needed for the current question. |
| **Vector RAG alone** | Code is a syntax tree, not prose. Embedding similarity misses exact callers and goes stale after edits. | Combines local embeddings for docs/memories with exact tree-sitter AST symbol and call-graph lookups. |
| **Static `.cursorrules` / `CLAUDE.md`** | Hand-written rule files go stale quickly and cannot track session history, call graphs, or cross-IDE handover. | Auto-captures session trails via hooks, consolidates them into structured `.memory/` Markdown via `/dream`, and syncs incrementally on file changes. |

---

## How It Works

Memory Cell runs 100% locally on your machine with no Docker containers, external vector databases, or cloud accounts:

- **Single Rust Binary + Embedded SQLite**: All structured memories and AST call graphs live in `~/.memory_cell/global.sqlite3`, paired with a per-repo binary symbol index (`.memorycell/symbols.idx`).
- **Local Embeddings + Tree-Sitter AST**: Uses local `multilingual-e5-small` embeddings for semantic recall and native tree-sitter parsers across 22 languages for exact symbol and reference queries.
- **Git-Tracked Knowledge (`.memory/`)**: Durable knowledge is stored as readable Markdown across 6 folders (`workflows/`, `anti_patterns/`, `preferences/`, `decisions/`, `concepts/`, `heuristics/`), kept in sync with SQLite automatically.

```text
  Your Autonomous Agents (Claude Code, Cursor, Antigravity, Codex, Custom MCP...)
                                    │
                            MCP + Lifecycle Hooks
                                    ▼
              ┌────────────────────────────────────────────┐
              │           memory-cell (Rust Binary)        │
              │                                            │
              │  • Tree-sitter AST & Call Graph (22 langs) │
              │  • Local Embeddings (multilingual-e5-small)│
              │  • Session Snapshots & /dream Consolidation│
              └──────────────┬──────────────┬──────────────┘
                             ▼              ▼
             ~/.memory_cell/global.sqlite3  .memory/*.md (Git-tracked)
```

---

## Supported IDEs & Agents

`memory-cell init` automatically detects installed tools and wires up MCP servers, lifecycle hooks, rules, and skills without overwriting your existing settings:

| Platform | What `init` Configures |
| :--- | :--- |
| **Claude Code** | MCP server (`.mcp.json`), hooks (`.claude/settings.json`), rules, slash commands |
| **Google Antigravity** | MCP server (`.agents/mcp_config.json`), hooks, rules, skills |
| **Cursor** | MCP server (`.cursor/mcp.json`), hooks, always-applied rules (`.cursor/rules/memory-cell.mdc`) |
| **GitHub Copilot (VS Code)** | MCP server (`.vscode/mcp.json`), hooks (`.github/hooks/memory-cell.json`), instructions |
| **OpenAI Codex** | MCP server (`.codex/config.toml`), hooks (approve once via `/hooks`, or Settings > Hooks) |
| **Devin** | MCP server (`.devin/mcp_config.json`), hooks (`.devin/hooks.v1.json`), rules |
| **OpenCode** | MCP server (`opencode.json`), plugin (`.opencode/plugins/memory-cell.js`; restart OpenCode to load), instructions |
| **Hermes Agent** | Global MCP server & hooks (`~/.hermes/config.yaml`; run `hermes` once or pass `--accept-hooks`; Hermes One is not supported) |
| **Windsurf** | MCP server (`.codeium/windsurf/mcp_config.json`) |

---

## Slash Commands & Distillation

### Slash Commands
Provisioned automatically by `memory-cell init` across supported clients:

| Command | Purpose |
| :--- | :--- |
| `/takeover` | Resume active goals, recent steps, and blockers after `/compact` or when switching IDEs. |
| `/dream` | Consolidate recent session logs into structured `.memory/` entries and flag contradictions. |
| `/memorize` | Explicitly save a workflow, anti-pattern, decision, preference, concept, or heuristic to `.memory/`. |
| `/impact <symbol>` | Trace callers and estimate blast radius before refactoring a symbol. |
| `/recall <query>` | Search chronological episodic session history and past debugging trails. |
| `/stats` | Inspect indexed symbols, managed memories, and cache health. |

### Zero-API-Key Distillation
Memory Cell distills session trails into structured memories without requiring a separate paid API key. `memory-cell init` auto-selects the best available backend on your machine, and you can switch anytime:

```bash
# Reuse your logged-in local CLI agent (no API key required)
memory-cell config distill cli/claude   # Claude Pro / Max via Claude Code CLI
memory-cell config distill cli          # Auto-detect claude, codex, gemini, or agy

# Fully local LLM or offline rule-based fallback
memory-cell config distill ollama       # Local Ollama (auto-detects installed models)
memory-cell config distill heuristic    # 100% offline, zero-LLM fast track

# Optional cloud APIs (uses existing environment variable)
memory-cell config distill anthropic    # ANTHROPIC_API_KEY
memory-cell config distill openai       # OPENAI_API_KEY
memory-cell config distill gemini       # GEMINI_API_KEY
memory-cell config distill groq         # GROQ_API_KEY
```

Need per-project `.env` or CI overrides? See [Environment Variables](#reference-details) below.

---

## CLI Quick Reference

| Command | Description |
| :--- | :--- |
| `memory-cell init` | Zero-prompt setup: download/warm embedding model once (`--skip-warmup`), sync docs & AST index (`--skip-sync`), configure IDEs, and select distillation (`--interactive` for wizard, `-v` for verbose output). |
| `memory-cell doctor` | Verify `PATH` binary, workspace & IDE MCP configs, SQLite health, model cache, index state, and distillation backend. |
| `memory-cell sync` | Incrementally sync changed docs and AST files with live progress bars (`--text-only` skips LLM extraction; `--force` re-reads all files). |
| `memory-cell search <query>` | Unified search across AST symbols, project docs, and long-term memories. |
| `memory-cell takeover` | Print a handover briefing for the current workspace from recent session trails. |
| `memory-cell dream` | Run memory consolidation and hygiene checks from the terminal (`--dry-run` to preview). |
| `memory-cell stats` | View indexed symbols, engram counts, and workspace health metrics. |
| `memory-cell audit` | Offline, read-only scan of local Claude Code, Codex, Antigravity, and OpenCode logs for repeated mistakes, risky writes, and retry cost (`--output json`, `--since 30d`). |
| `memory-cell config distill <engine>` | Switch the distillation backend (`cli/claude`, `cli`, `ollama`, `heuristic`, `openai`, `anthropic`, `gemini`, `groq`). |
| `memory-cell uninstall` | Remove installed binary, workspace `.memorycell/` cache, IDE configs, and rules (`--all` also removes `~/.memory_cell` and `.memory/`). |

---

## Reference Details

<details>
<summary><strong>MCP Tools Reference</strong></summary>

### Retrieval & Memory
- `reason(query, workspace_path)` — Grounded retrieval across `.memory/` rules, project docs, and AST architecture context.
- `search(query)` — Unified lookup across code symbols and long-term memory.
- `ingest(file_path)` — Ingest Markdown, source files, or PDFs into workspace memory.
- `forget(id)` — Remove an obsolete memory and its linked `.memory/` file.

### Code Intelligence (22 Languages)
- `find_symbol(name)` — Pinpoint function, struct, class, interface, or trait definitions and exact line numbers.
- `trace_callers(symbol, direction)` — Trace callers or callees across files without manual grep.
- `find_references(identifier)` — Locate declarations, reads, and writes for variables and fields.
- `analyze_impact(symbol)` — Evaluate refactoring blast radius and affected call sites before editing.

### Session Handover, Consolidation & Governance
- `takeover()` — Reconstruct active working memory and next steps across sessions or IDEs.
- `recall(query)` — Query chronological episodic history and past debugging trails.
- `dream(dry_run)` — Consolidate episodic events into structured memories and detect contradictions.
- `list_governance_tickets()` / `resolve_governance_ticket(ticket_id, action)` — Inspect and resolve flagged knowledge conflicts.
- `stats()` — Return managed memory counts and workspace index statistics.

</details>

<details>
<summary><strong>Supported Languages (22 Languages) & Binary Platforms</strong></summary>

### Programming Languages
| Language | File Extensions | Primary AST Capabilities |
| :--- | :--- | :--- |
| **Rust** | `.rs` | Functions, structs, enums, traits, `impl` blocks, call hierarchies |
| **TypeScript** | `.ts`, `.tsx`, `.ets` | Functions, classes, interfaces, type aliases, methods, call sites |
| **JavaScript** | `.js`, `.jsx`, `.mjs`, `.cjs` | Functions, classes, methods, object calls, property access |
| **Python** | `.py`, `.pyw` | Functions, classes, methods, module-level invocations |
| **Go** | `.go` | Functions, methods, structs, interfaces, package calls |
| **C** | `.c`, `.h` | Function definitions, struct specifiers, type definitions, calls |
| **C++** | `.cpp`, `.cc`, `.cxx`, `.hpp`, `.hh`, `.hxx`, `.cu`, `.metal` | Classes, structs, methods, alias declarations, function calls |
| **Java** | `.java` | Classes, interfaces, methods, constructors, invocations |
| **C#** | `.cs` | Classes, interfaces, structs, methods, invocations |
| **PHP** | `.php` | Functions, classes, interfaces, traits, methods, function calls |
| **Ruby** | `.rb` | Methods, singleton methods, classes, modules, call sites |
| **Swift** | `.swift` | Functions, classes, structs, protocols, typealiases, calls |
| **Kotlin** | `.kt`, `.kts` | Functions, classes, object declarations, calls |
| **Dart** | `.dart` | Classes, enums, extensions, functions, type aliases, calls |
| **Scala** | `.scala`, `.sc` | Functions, classes, objects, traits, type definitions, calls |
| **Lua** | `.lua`, `.luau` | Function declarations, function calls |
| **Solidity** | `.sol` | Contracts, interfaces, structs, functions, modifiers, events |
| **HCL / Terraform** | `.tf`, `.hcl` | Blocks, resource declarations, module references |
| **Svelte** | `.svelte` | Component script logic, functions, declarations |
| **Nix** | `.nix` | Attribute bindings, let expressions, variable expressions |
| **R** | `.r`, `.R` | Function definitions, variable assignments, calls |
| **Erlang** | `.erl`, `.hrl` | Function clauses, exported functions, atoms, calls |

### Pre-Compiled Platforms
- **macOS**: Apple Silicon (`darwin-arm64`) & Intel (`darwin-x64`)
- **Linux**: x86_64 (`linux-x64`) & ARM64 (`linux-arm64`)
- **Windows**: x86_64 (`win32-x64`)

</details>

<details>
<summary><strong>Environment Variables (.env &amp; Shell Overrides)</strong></summary>

Shell environment variables and a project `.env` file override the global defaults stored in `~/.memory_cell/config.json`.

```bash
# Example: pin Claude Code CLI for a single project (no API key required)
DISTILL_PROVIDER=cli
DISTILL_MODEL=claude
```

| Variable | Default | Purpose |
| :--- | :--- | :--- |
| `DISTILL_PROVIDER` | auto (`~/.memory_cell/config.json`) | Override distillation backend (`cli`, `ollama`, `heuristic`, `openai`, `anthropic`, `gemini`, `groq`, `mcp`) |
| `DISTILL_MODEL` | provider default | Pin CLI agent (`claude`, `codex`, `gemini`, `agy`) or model name |
| `DISTILL_ENDPOINT` | provider default | Custom endpoint (e.g. Ollama `http://localhost:11434` or OpenAI-compatible base URL) |
| `MEMORY_CELL_DB` | `~/.memory_cell/global.sqlite3` | Custom SQLite database path |
| `MEMORY_CELL_PROVIDER` / `MEMORY_CELL_MODEL` | `local` / `multilingual-e5-small` | Override embedding provider (`local`, `openai`) and model |
| `MEMORY_CELL_USER` / `MEMORY_CELL_WORKSPACE` | auto-detected | Pin user scope or workspace root |
| `MEMORY_CELL_HOOK_CONTEXT` | `on` | Set to `off` to disable per-message hook context injection while still recording episodes |
| `OPENAI_API_KEY` / `ANTHROPIC_API_KEY` / `GEMINI_API_KEY` / `GROQ_API_KEY` | unset | Only required when using a cloud API distillation or embedding provider |

</details>

---

## Team Adoption & Git-Native Sharing

Every rule, workflow, anti-pattern, and architectural decision in `.memory/` is plain Markdown. Commit `.memory/` to your repository so new hires and teammates automatically inherit the same agent guardrails on `git pull` and `memory-cell init` — regardless of which IDE or agent they use. For AI-native teams exploring multi-repo topology or real-time team sync, open a discussion or issue on GitHub.

---

## License

Apache-2.0 © Memory Cell Team & Mux Tsou
