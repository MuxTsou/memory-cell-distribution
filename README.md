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

## 💡 The Solution: Memory Cell (Dual-Mode Intelligence)

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
- 🔄 **Git-Native Memory Governance**: Human-readable Living Docs (`docs/` and `.memorycell/`) that commit, branch, and PR alongside your regular code.

---

## 🛠️ MCP Cognitive Tools (For AI Agents)

When configured as an MCP server, Memory Cell exposes powerful cognitive tools that your AI agents use autonomously:

- `reason("<question>")`: Decoupled semantic reasoning that pinpoints active concepts, verified SOPs, architectural decisions, and relevant document sections.
- `find_symbol("<name>")`: < 15ms P75 lookup of functions, structs, classes, interfaces, and traits.

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

## 🌟 Core Capabilities

### 1. ⚡ Deep Code Intelligence & Topological Navigation (22 Languages)
Deep semantic understanding across 22 major programming languages:
- `find_symbol("<name>")`: < 15ms P75 lookup of functions, structs, classes, interfaces, and traits.
- `trace_callers("<symbol>", direction: "callers" | "callees")`: Instant call hierarchy tracing across files without manual searching.
- `find_references("<identifier>")`: Pinpoint exact declarations, reads, and writes.
- `analyze_impact("<symbol>")`: Evaluate blast radius before making critical refactoring changes.

### 2. 🔄 Autonomous Learning Across 6 Universal Knowledge Dimensions
Agents and developers autonomously distill experience and preserve knowledge into long-term memory:
1. 🛠️ **Workflow**: Verified step-by-step procedures for automated replay.
2. ⚠️ **Anti-Pattern**: Inhibitory rules that prevent recurring mistakes and hallucinations.
3. 👤 **Preference**: User/team coding style, architectural constraints, and guidelines.
4. 🏛️ **Decision**: Architectural Decision Records (ADRs) and trade-offs.
5. 💡 **Concept**: Domain models, entities, and project terminology.
6. ⚡ **Heuristic**: Fast-and-frugal rules of thumb and optimization shortcuts.

### 3. 🤝 Cross-Agent Working Memory Handover (`takeover`)
Switching between different agents, models, or environments? Run `/takeover` (or `memory-cell takeover`). The next agent instantly resumes your active goal, execution context, and ongoing tasks without losing state.

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

