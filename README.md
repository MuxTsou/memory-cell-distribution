# 🧠 Memory Cell

<p align="center">
  <strong>Reinvent Cognition.</strong><br>
  <em>To give autonomous agents mind, alignment, and continuity.</em>
</p>

<p align="center">
  <a href="https://www.npmjs.com/package/@muxtsou/memory-cell"><img src="https://img.shields.io/npm/v/@muxtsou/memory-cell?color=blue&style=flat-square" alt="npm version" /></a>
  <a href="https://www.npmjs.com/package/@muxtsou/memory-cell"><img src="https://img.shields.io/npm/dm/@muxtsou/memory-cell?style=flat-square" alt="npm downloads" /></a>
  <img src="https://img.shields.io/badge/Platforms-macOS%20%7C%20Linux%20%7C%20Windows-brightgreen?style=flat-square" alt="Platforms" />
  <img src="https://img.shields.io/badge/Interface-CLI%20%2B%20MCP-orange?style=flat-square" alt="Interface: CLI + MCP" />
  <img src="https://img.shields.io/badge/License-Apache--2.0-blue?style=flat-square" alt="License" />
</p>

> **Mission**: We build the cognitive operating system for governed collective intelligence. By fusing stateful memory, code topological intelligence, and autonomous execution into a unified architecture, we enable developers and networked agents to collectively reason, self-align, and act indefinitely.

---

## 🤯 Problems & Dilemmas of Agents

Despite using frontier models, developers and engineering teams face painful realities every single day:

1. 💸 **The Amnesia Tax (Paying to Re-explain Everything)**  
   Every new session erases working context. You are forced to repeatedly paste code snippets, re-explain architecture, and burn thousands of tokens just to bring the AI back up to speed, destroying unit economics.

2. 🌀 **The "Smart but Blind" Dilemma (Local Fixes, Global Breakages)**  
   Agents write great code in isolation, but are completely blind to overall codebase topology. They confidently fix function A while silently breaking service B, turning code generation into an endless debugging loop.

3. 🏰 **The Knowledge Silo & Sovereignty Lock-in (Zero Cross-Tool Neutrality)**  
   Hard-won fixes and proprietary architectural insights are trapped inside vendor silos. Moving between Cursor, Claude Code, Windsurf, or Terminal means resetting experience to zero. Teams lack a sovereign, platform-neutral memory layer that they truly own.

4. ⚖️ **The Knowledge Governance Void (Unversioned, Stale & Ungoverned Context)**  
   Technical specs and ADRs evolve continuously, but vector black boxes cannot surgically prune stale rules. Deprecated patterns poison future runs, with zero line-level audit trails back to authoritative sources.

---

## 💡 The Solution: Memory Cell

**Memory Cell solves the memory trilemma through first-principles cognitive governance.** By decoupling **Knowledge** (Git-native Living Docs), **Meaning** (Semantic Engrams), and **Location** (Code Topology Pointers), Memory Cell delivers a 100% private, < 15ms P75 intelligence layer with zero graph database maintenance overhead. It is designed for seamless dual-mode usage:

1. 🖥️ **When You Work in the Terminal (Native CLI)**: Your lightning-fast, zero-dependency engineering companion to explore codebase architecture, trace bidirectional call flows, query documentation with semantic reasoning, and maintain persistent engineering playbooks (ADRs, anti-patterns, workflows) directly from your shell.
2. 🤖 **When You Pair with AI Agents (MCP Mode)**: Your persistent intelligence hub that bridges all your AI assistants (**Claude Code, Cursor, Google Antigravity, Hermes, Codex, Copilot**). It eliminates repetitive context-setting, enables frictionless session handover (`/takeover`), and cuts 50%~90% token waste by replacing brute-force file scans with precision lookups.

```text
       ┌──────────────────────────────┐        ┌──────────────────────────────┐
       │   🖥️ Interactive Terminal     │        │ 🤖 Agentic Pair Programming  │
       │    (You in Shell / CI/CD)    │        │  (You with Claude, Cursor...)│
       └──────────────┬───────────────┘        └──────────────┬───────────────┘
                      │                                       │
                      │ Native CLI Commands                   │ Model Context Protocol (MCP)
                      └───────────────────┬───────────────────┘
                                          ▼
       ┌──────────────────────────────────────────────────────────────────────┐
       │                   🧠 MEMORY CELL (Cognitive Core)                    │
       │  ┌────────────────────────────┐      ┌────────────────────────────┐  │
       │  │ ⚡ Code Intelligence Core  │      │ 🏛️ 6-Dimension Knowledge   │  │
       │  │  • Multi-Language Topology │      │  • Living SOPs & Playbooks │  │
       │  │  • Bidirectional Callsites │ <──> │  • Anti-patterns & Rules   │  │
       │  │  • Refactoring Blast Radius│      │  • Architectural Decisions │  │
       │  └────────────────────────────┘      └────────────────────────────┘  │
       └──────────────────────────────────┬───────────────────────────────────┘
                                          ▼
                      Embedded Engine + Local Embeddings (100% Offline & Private)
```

---

## 🚀 Key Benefits

- ⚡ **< 15ms P75 In-Conversation Retrieval**: Instant precision grounding across code, living documentation, and shared team playbooks without context lag.
- 🗜️ **50%–90% Token Reduction**: Decoupled reasoning retrieves only the necessary context window without stuffing entire files or brute-forcing vector chunks.
- 🛡️ **Zero GraphDB Overhead**: Pure embedded SQLite architecture. Zero Neo4j, Redis, or external vector service dependencies.
- 🌐 **True Cross-Tool Continuity**: Works seamlessly across Claude Code, Cursor, Windsurf, Codex, Gemini, Terminal, and CI/CD pipelines via universal MCP protocols.
- 🔄 **Zero-Friction Living Knowledge**: Edit any markdown file or code in your repo as usual. Memory Cell automatically hot-syncs changes and prunes deleted files in real-time.

---


## 📦 Installation Options

### Option 1: One-Line Installer (Recommended, Zero-Dependency)
No Node.js or build tools required. Directly installs the pre-compiled native binary for your OS and architecture:

```bash
curl -fsSL https://raw.githubusercontent.com/muxtsou/memory-cell-distribution/main/install.sh | bash
```

### Option 2: npm Package
Install globally or run on demand with `npx`:

```bash
# Global installation
npm install -g @muxtsou/memory-cell

# Or instant zero-install
npx @muxtsou/memory-cell init
```

---

## ⚡ 10-Second Quickstart (Zero-Config)

Run directly inside any project repository root:

```bash
memory-cell init
```

✨ **Automatically detects and configures all supported environments on your machine:**
- [x] **Google Antigravity** (`.agents/mcp_config.json` + `hooks.json` + `skills/` + `plugin.json`)
- [x] **Cursor IDE** (`.cursor/mcp.json`)
- [x] **Claude Code CLI** (`.mcp.json` + `.claude/hooks.json` + `.claude/commands/`)
- [x] **OpenCode Interpreter** (`.opencode/mcp.json`)
- [x] **Hermes Agent** (`.hermes/config.yaml`)
- [x] **OpenAI Codex CLI** (`.codex/config.toml`)
- [x] **GitHub Copilot / VS Code** (`.vscode/mcp.json`)

---

## 🛠️ MCP Cognitive Tools (For AI Agents)

Memory Cell equips coding agents with a structured cognitive layer composed of specialized tools that replace noisy brute-force file scanning with surgical, token-efficient intelligence:

### 1. 🧠 Grounded Reasoning & Unified Search (Cognitive Retrieval)
- `reason("<query>", workspace_path: ".")`: **Grounding Engine.** Retrieves structured document sections, active domain concepts, verified workflows, and architectural rules without reading raw files or blowing context tokens.
- `search("<query>")`: **Holographic Search.** Concurrently queries code symbols (`find_symbol`) and long-term memory (`reason`), synthesizing verified code locations and living docs into a single high-density context.
- `ingest(file_path: "...")`: Ingests documents (Markdown, Code, PDF) through the zero-leakage cognitive pipeline into memory.
- `forget(id: "...")`: Removes obsolete engrams and their associated living doc from disk.

### 2. ⚡ Deep Code Intelligence & Topological Navigation (22 Languages)
Instant syntax-aware code navigation across 22 major languages in < 15ms P75 lookup:
- `find_symbol("<name>")`: Pinpoints functions, structs, classes, interfaces, traits, and exact line definitions.
- `trace_callers("<symbol>", direction: "callers" | "callees")`: Bidirectional call hierarchy tracing across files without manual searching.
- `find_references("<identifier>")`: Locates exact declarations, reads, and writes for variables and fields.
- `analyze_impact("<symbol>")`: Evaluates blast radius and affected call sites before refactoring critical interfaces.

### 3. 🔄 Autonomous Continuous Learning (Automated Dream Consolidation)
Zero manual curation or learning commands required. During live development, the **Hippocampus automatically snapshots** fine-grained events, execution trails, and troubleshooting corrections in real time. **Dream Consolidation (`dream()`)** then distills and solidifies these episodic footprints into long-term structured Neocortex knowledge whenever triggered:
- **Episodic Snapshots ➔ Semantic Engrams**: Distills raw session logs into permanent structured engrams across 6 Universal Knowledge Dimensions:
  - 🛠️ **Workflows & SOPs**: Verified step-by-step procedures distilled from successful tasks for automated replay.
  - ⚠️ **Anti-Patterns & Pitfalls**: Inhibitory guardrails learned from bugs, failed attempts, and user corrections.
  - 👤 **Developer Preferences**: Coding guidelines, project conventions, and stylistic directives.
  - 🏛️ **Architectural Decisions (ADRs)**: Key trade-offs and structural rationale recorded in context.
  - 💡 **Domain Concepts**: Project terminology, mental models, and core entity definitions.
  - ⚡ **Heuristics**: Fast-and-frugal engineering rules of thumb and performance optimizations.
- **On-Demand Wrap-up & Graph Hygiene**: Run `/dream` (or `memory-cell dream`) whenever you wrap up a task or session—safely pruning redundant noise, resolving contradictions, and crystallizing lessons into Git-tracked assets.

### 4. 🤝 Cross-Agent Working Memory Handover & Episodic Recall
- `takeover()`: Switching between different agents, models, or IDEs? Run `/takeover` (or `memory-cell takeover`). The next agent instantly resumes the active goal, obstacle trails, and execution context (<180 tokens) without losing state.
- `recall("<query>")`: Recalls chronological episodic timeline logs and debugging history from Hippocampus across past sessions.

### 5. 🌙 Consolidation & Cognitive Governance
- `dream(dry_run: false)`: Triggers two-phase consolidation (Hippocampus episodic events ➔ Neocortex structured Engrams + contradiction detection).
- `list_governance_tickets()`: Lists knowledge contradictions flagged during consolidation.
- `resolve_governance_ticket(ticket_id, action)`: Human-in-the-loop conflict resolution (supersede, inhibit, or ignore).
- `stats()`: Real-time token savings, cognitive health scorecards, and managed engram distribution.

---

## ⚡ Agent Skills & Slash Commands (Zero-Friction UX)

`memory-cell init` automatically provisions specialized agent skills and slash commands across all your IDEs and CLI agents (Google Antigravity, Claude Code, Cursor, Codex). Agents proactively load these workflows or you can invoke them directly:

| Slash Command | Agent Skill | Capability & Description |
| :--- | :--- | :--- |
| `/takeover` | `takeover` | **Instant Cross-Tool Handover.** Resumes working memory, active subgoals, and obstacles across IDEs in < 180 tokens without manual briefing. |
| `/dream` | `dream` | **Consolidation & Graph Hygiene.** Runs two-phase consolidation to distill raw episodic sessions into permanent Neocortex knowledge and resolve contradictions. |
| `/memorize` | `memorize` | **Explicit Knowledge Persistence.** Quickly captures and classifies critical lessons, SOPs, or rules into `.memory/` across 6 dimensions. |
| `/impact <symbol>` | `impact` | **Blast Radius Evaluation.** Inspects call hierarchies and calculates risk before refactoring critical functions, structs, or traits. |
| `/recall <query>` | `recall` | **Episodic Timeline Explorer.** Queries chronological debugging trails and past session decisions with forward-timeline synthesis. |
| `/stats` | `stats` | **Cognitive Health & ROI Scorecard.** Displays managed engram distribution, duplicate filter ratio, and total context token savings. |

---

## 🧠 Distillation Engine Configuration (Zero-API-Key with Claude Max)

Memory Cell uses an intelligent distillation engine to synthesize session events into long-term structured knowledge. You don't need a separate paid API key if you have a Claude subscription (Claude Pro / Max) or local tools:

### Recommended: Use Your Existing Claude CLI (No API Key Required)
If you already use Claude Code CLI with your Claude Max / Pro plan, Memory Cell can reuse your authenticated CLI directly:
```bash
memory-cell config distill cli/claude
```
This lets you run distillation without incurring extra API costs or exposing API keys!

### Alternative Distillation Engines:
Switch engines anytime with a single command:
```bash
# Auto-detect any logged-in local CLI agent (claude, codex, gemini)
memory-cell config distill cli

# Local Ollama (Auto-detects installed models, 100% private)
memory-cell config distill ollama

# Cloud APIs (Requires API key in .env)
memory-cell config distill anthropic   # Claude 3.5 Haiku
memory-cell config distill openai      # GPT-4o-mini
memory-cell config distill gemini      # Gemini 2.5/3.7 Flash
memory-cell config distill groq        # Groq LPU (Ultra-fast)

# ⚡ Fast Offline Fallback (Zero-LLM, rule-based; instant but basic quality)
memory-cell config distill heuristic
```

---

## 🛠️ CLI Quick Reference

| Command | Description |
| :--- | :--- |
| `memory-cell init` | Zero-config initialization: configure MCP across all IDEs and index codebase |
| `memory-cell config distill <engine>` | Switch distillation engine (`cli/claude`, `cli`, `heuristic`, `ollama`, `openai`) |
| `memory-cell sync` | Incrementally re-index workspace code changes into the intelligence layer |
| `memory-cell search <query>` | Unified hybrid search across code symbols, docs, and semantic memory |
| `memory-cell takeover` | Seamlessly resume working state and goals from previous agent sessions |
| `memory-cell stats` | Inspect token ROI economics, cognitive health scorecard, and memory engrams |
| `memory-cell doctor` | Validate local embedding models, storage integrity, and IDE MCP links |
| `memory-cell dream` | Consolidate session events into long-term structured knowledge |
| `memory-cell uninstall` | Cleanly remove binary, IDE configurations, and injected rules |

---

## 💻 Supported Programming Languages (22 Languages)

Memory Cell provides native, instant symbol and call hierarchy intelligence across 22 major programming languages with zero additional dependencies:

| Language | Recognized File Extensions | Primary Capabilities |
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

---

## 🖥️ Supported Platforms

Pre-compiled native binaries are bundled automatically for your architecture (no compilation or runtime setup required):
- **macOS**: Apple Silicon (`darwin-arm64`) & Intel (`darwin-x64`)
- **Linux**: x86_64 (`linux-x64`) & ARM64 (`linux-arm64`)
- **Windows**: x86_64 (`win32-x64`)

---

## 📄 License
Apache-2.0 © Memory Cell Team & Mux Tsou

