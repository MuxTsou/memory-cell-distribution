#!/usr/bin/env bash
# ==============================================================================
# Memory Cell — Universal One-Liner Installer & Environment Setup (macOS & Linux)
# ==============================================================================
# Supported OS: macOS (Apple Silicon & Intel), Linux (x86_64 & ARM64)
# Supported IDEs: Claude Desktop, Claude Code, Cursor, Windsurf, Antigravity, OpenCode, Zed
# ==============================================================================

set -e

# ANSI Color Codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
DIM='\033[0;90m'
NC='\033[0m' # No Color

# Universal POSIX/Bash Print Helpers (Eliminates raw -e in all shells)
print_msg() {
    printf "%b\n" "$*"
}
print_prompt() {
    printf "%b" "$*"
}

# Parse CLI flags
NON_INTERACTIVE=false
CUSTOM_DB_PATH=""

while [ $# -gt 0 ]; do
    case "$1" in
        -y|--yes|--non-interactive|-s|--silent)
            NON_INTERACTIVE=true
            shift
            ;;
        --db)
            CUSTOM_DB_PATH="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# If not running in an interactive terminal and /dev/tty is absent, default to non-interactive mode
if [ ! -t 0 ] && [ ! -e /dev/tty ]; then
    NON_INTERACTIVE=true
fi

print_msg "${BLUE}======================================================${NC}"
print_msg "${BLUE}  🧠 Memory Cell Cognitive Engine — Setup Wizard      ${NC}"
print_msg "${BLUE}======================================================${NC}"

# 1. Detect Operating System and CPU Architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

TARGET=""
case "$OS" in
    Darwin)
        case "$ARCH" in
            arm64|aarch64)
                TARGET="macos-arm64"
                ;;
            x86_64)
                TARGET="macos-x86_64"
                ;;
            *)
                print_msg "${RED}❌ Unsupported macOS architecture: $ARCH${NC}"
                exit 1
                ;;
        esac
        ;;
    Linux)
        case "$ARCH" in
            x86_64)
                TARGET="linux-x86_64"
                ;;
            aarch64|arm64)
                TARGET="linux-arm64"
                ;;
            *)
                print_msg "${RED}❌ Unsupported Linux architecture: $ARCH${NC}"
                exit 1
                ;;
        esac
        ;;
    *)
        print_msg "${RED}❌ Unsupported OS: $OS. Please use install.ps1 for Windows.${NC}"
        exit 1
        ;;
esac

print_msg "🖥️  Detected System: ${GREEN}${OS} (${ARCH})${NC} -> Target: ${YELLOW}${TARGET}${NC}"

# Setup Mode Selection
SETUP_MODE="1"
if [ "$NON_INTERACTIVE" = false ] && [ -e /dev/tty ]; then
    print_msg "\n${BOLD}🚀 Choose setup mode:${NC}"
    print_msg "  ${GREEN}[1] ⚡ Quick Setup (Recommended — Zero prompts, auto-detect everything)${NC} [Default]"
    print_msg "  ${YELLOW}[2] 🛠️  Custom Setup (Interactive configuration: identity, DB path)${NC}"
    print_prompt "👉 Press ${GREEN}[Enter]${NC} for Quick Setup, or select [1/2]: "
    read -r USER_MODE_INPUT < /dev/tty || USER_MODE_INPUT=""
    if [ "$USER_MODE_INPUT" = "2" ]; then
        SETUP_MODE="2"
    fi
fi

# 2. Identity and Attribution Detection (Defaults to 'engineer' role)
DETECTED_USER="$(git config user.name 2>/dev/null || echo "${USER:-anonymous}")"
DETECTED_EMAIL="$(git config user.email 2>/dev/null || echo "")"
DEFAULT_ROLE="engineer"

if [ -n "$DETECTED_EMAIL" ]; then
    print_msg "👤 Detected Identity: ${GREEN}${DETECTED_USER}${NC} <${CYAN}${DETECTED_EMAIL}${NC}> | Role: ${YELLOW}${DEFAULT_ROLE}${NC}"
else
    print_msg "👤 Detected Identity: ${GREEN}${DETECTED_USER}${NC} | Role: ${YELLOW}${DEFAULT_ROLE}${NC}"
fi

# Custom identity prompt only if Custom Setup selected
if [ "$SETUP_MODE" = "2" ] && [ -e /dev/tty ]; then
    print_prompt "   👉 Press ${GREEN}[Enter]${NC} to use detected identity, or enter custom user name: "
    read -r USER_INPUT_NAME < /dev/tty || USER_INPUT_NAME=""
    if [ -n "$USER_INPUT_NAME" ]; then
        DETECTED_USER="$USER_INPUT_NAME"
        print_msg "   👤 User identity updated to: ${GREEN}${DETECTED_USER}${NC}"
    fi
fi

# 3. Environment Setup (DB Location & Scope)
DEFAULT_DB="$HOME/.memory_cell/global.sqlite3"
DB_PATH="${CUSTOM_DB_PATH:-$DEFAULT_DB}"

if [ "$SETUP_MODE" = "2" ] && [ -e /dev/tty ]; then
    print_msg "\n${BOLD}📁 SQLite Database Path Configuration:${NC}"
    print_msg "   Default Path: ${CYAN}${DEFAULT_DB}${NC}"
    print_prompt "   👉 Press ${GREEN}[Enter]${NC} to use default, or enter custom path: "
    read -r USER_INPUT_DB < /dev/tty || USER_INPUT_DB=""
    if [ -n "$USER_INPUT_DB" ]; then
        # Expand ~ if present
        DB_PATH="${USER_INPUT_DB/#\~/$HOME}"
    fi
fi

DB_DIR="$(dirname "$DB_PATH")"
mkdir -p "$DB_DIR"
print_msg "💾 Database path: ${GREEN}${DB_PATH}${NC}"

# 4. Neural Embedding Engine Notice
print_msg "\n${BOLD}🧠 [Neural Engine 2/2] Embedding Model Specifications:${NC}"
print_msg "   ⚡ Model: ${GREEN}FastEmbed all-minilm (384-dimensional)${NC}"
print_msg "   🔒 Privacy: Zero-config / 100% Offline Local Inference / Team-wide Compatible"

# 5. Setup Install Directory & Binary Download / Build
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"
BIN_PATH="$INSTALL_DIR/memory-cell"

GITHUB_REPO="${MEMORY_CELL_REPO:-"muxtsou/memory-cell-distribution"}"
RELEASE_TAG="${MEMORY_CELL_VERSION:-"latest"}"
if [ "$RELEASE_TAG" = "latest" ]; then
    RELEASE_DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/latest/download/memory-cell-${TARGET}"
else
    RELEASE_DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/download/${RELEASE_TAG}/memory-cell-${TARGET}"
fi

print_msg "\n📦 Installing binary to: ${GREEN}${BIN_PATH}${NC}..."

if [ -n "$CUSTOM_BINARY_URL" ]; then
    print_msg "⬇️  Downloading from custom URL: ${CUSTOM_BINARY_URL}..."
    curl -fsSL "$CUSTOM_BINARY_URL" -o "$BIN_PATH"
elif [ "$USE_LOCAL_BINARY" = "1" ] && [ -f "dist/memory-cell-$TARGET" ]; then
    print_msg "ℹ️  USE_LOCAL_BINARY=1: Found local architecture binary in dist/ (memory-cell-$TARGET). Copying..."
    cp "dist/memory-cell-$TARGET" "$BIN_PATH"
elif [ "$USE_LOCAL_BINARY" = "1" ] && [ -f "dist/memory-cell-macos-universal" ]; then
    print_msg "ℹ️  USE_LOCAL_BINARY=1: Found local Universal 2 binary in dist/. Copying..."
    cp "dist/memory-cell-macos-universal" "$BIN_PATH"
elif [ "$USE_LOCAL_BINARY" = "1" ] && [ -f "target/release/memory-cell" ]; then
    print_msg "ℹ️  USE_LOCAL_BINARY=1: Found local release binary in target/release/. Copying..."
    cp "target/release/memory-cell" "$BIN_PATH"
else
    print_msg "⬇️  Downloading memory-cell-${TARGET} from GitHub Release (${GITHUB_REPO})..."
    TMP_BIN_PATH="${BIN_PATH}.download.tmp"
    DOWNLOAD_OK=false
    for attempt in 1 2 3; do
        rm -f "$TMP_BIN_PATH"
        if curl -fsSL --connect-timeout 15 --max-time 300 --retry 2 --retry-delay 2 --retry-connrefused \
            "$RELEASE_DOWNLOAD_URL" -o "$TMP_BIN_PATH"; then
            DOWNLOAD_OK=true
            break
        fi
        print_msg "${YELLOW}⚠️  Download attempt ${attempt}/3 failed or was interrupted. Retrying...${NC}"
        sleep 2
    done

    if [ "$DOWNLOAD_OK" = true ] && [ -s "$TMP_BIN_PATH" ]; then
        mv "$TMP_BIN_PATH" "$BIN_PATH"
        print_msg "✅ Successfully downloaded binary from GitHub Release."
    else
        rm -f "$TMP_BIN_PATH"
        print_msg "${RED}❌ Error: Failed to download binary from ${RELEASE_DOWNLOAD_URL} after 3 attempts.${NC}"
        print_msg "${YELLOW}💡 This is usually caused by an unstable connection (mobile hotspot, VPN drop, Wi-Fi handoff). Try again on a stable network, or download manually:${NC}"
        print_msg "   ${CYAN}curl -fSL -o \"$BIN_PATH\" \"$RELEASE_DOWNLOAD_URL\" && chmod +x \"$BIN_PATH\"${NC}"
        exit 1
    fi
fi

chmod +x "$BIN_PATH" 2>/dev/null || true
print_msg "✅ Binary installed as memory-cell."

# 6. Pre-Warm Local Neural Embedding Models (Zero-Latency IDE Boot)
if [ -x "$BIN_PATH" ]; then
    print_msg "\n🧠 Pre-warming Local FastEmbed Model (all-minilm)..."
    "$BIN_PATH" warmup all-minilm || print_msg "${YELLOW}⚠️ FastEmbed warmup skipped (will initialize on first IDE launch).${NC}"
fi

# 7. Auto-Configure PATH in ~/.zshrc or ~/.bashrc
SHELL_RC=""
if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ] || [ "$SHELL" = "/usr/bin/bash" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if [ -n "$SHELL_RC" ] && [ -f "$SHELL_RC" ]; then
    if ! grep -q '\.local/bin' "$SHELL_RC"; then
        print_msg "🔧 Adding ~/.local/bin to PATH in ${SHELL_RC}..."
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    fi
fi

# 8. Workspace Initialization (Delegated to memory-cell init)
if [ ! -x "$BIN_PATH" ]; then
    print_msg "${RED}❌ Error: memory-cell binary is missing or not executable at ${BIN_PATH}.${NC}"
    print_msg "${YELLOW}💡 It was present moments ago (warmup succeeded above) but has since disappeared -- most likely removed or replaced by another process (e.g. an IDE/MCP client launching it concurrently). Re-run this installer, or restore it manually:${NC}"
    print_msg "   ${CYAN}curl -fSL -o \"$BIN_PATH\" \"$RELEASE_DOWNLOAD_URL\" && chmod +x \"$BIN_PATH\"${NC}"
    exit 1
fi

CURRENT_WORKSPACE="$(pwd)"

if [ "$NON_INTERACTIVE" = true ]; then
    print_msg "\n🚀 Initializing Memory Cell for workspace: ${CYAN}${CURRENT_WORKSPACE}${NC}..."
    "$BIN_PATH" init "$CURRENT_WORKSPACE" -y
else
    echo ""
    print_msg "${BOLD}📂 Workspace Setup:${NC}"
    print_msg "   Current terminal directory: ${CYAN}${CURRENT_WORKSPACE}${NC}"
    printf "${BOLD}👉 Initialize Memory Cell in current directory? [Y/n/custom path]: ${NC}"
    read -r INIT_INPUT < /dev/tty || INIT_INPUT=""
    INIT_INPUT="${INIT_INPUT:-Y}"

    case "$INIT_INPUT" in
        [nN]|[nN][oO])
            print_msg "💡 Skipped workspace init. You can run '${CYAN}memory-cell init${NC}' anytime inside your project."
            ;;
        [yY]|[yY][eE][sS]|"")
            TARGET_INIT_PATH="$CURRENT_WORKSPACE"
            print_msg "\n🚀 Initializing Memory Cell for workspace: ${CYAN}${TARGET_INIT_PATH}${NC}..."
            if [ -e /dev/tty ]; then
                "$BIN_PATH" init "$TARGET_INIT_PATH" < /dev/tty
            else
                "$BIN_PATH" init "$TARGET_INIT_PATH"
            fi
            ;;
        *)
            TARGET_INIT_PATH="$INIT_INPUT"
            # Expand tilde ~ if provided
            TARGET_INIT_PATH="${TARGET_INIT_PATH/#\~/$HOME}"
            if [ ! -d "$TARGET_INIT_PATH" ]; then
                print_msg "${YELLOW}⚠️  Directory '${TARGET_INIT_PATH}' does not exist. Creating it...${NC}"
                mkdir -p "$TARGET_INIT_PATH" 2>/dev/null || true
            fi
            if [ -d "$TARGET_INIT_PATH" ]; then
                TARGET_INIT_PATH="$(cd "$TARGET_INIT_PATH" && pwd)"
                print_msg "\n🚀 Initializing Memory Cell for workspace: ${CYAN}${TARGET_INIT_PATH}${NC}..."
                if [ -e /dev/tty ]; then
                    "$BIN_PATH" init "$TARGET_INIT_PATH" < /dev/tty
                else
                    "$BIN_PATH" init "$TARGET_INIT_PATH"
                fi
            else
                print_msg "${RED}❌ Invalid directory path. Skipped workspace init.${NC}"
                print_msg "💡 You can run '${CYAN}memory-cell init <path>${NC}' anytime."
            fi
            ;;
    esac
fi

# 9. Auto-Configure Global Standalone Apps (e.g. Claude Desktop)
if [ "$OS" = "Darwin" ]; then
    CLAUDE_DIR="$HOME/Library/Application Support/Claude"
else
    CLAUDE_DIR="$HOME/.config/Claude"
fi
CLAUDE_CONFIG="$CLAUDE_DIR/claude_desktop_config.json"

if [ -d "$CLAUDE_DIR" ] || [ -f "$CLAUDE_CONFIG" ]; then
    python3 -c "
import json, os
path = '$CLAUDE_CONFIG'
os.makedirs(os.path.dirname(path), exist_ok=True)
try:
    with open(path, 'r') as f:
        data = json.load(f)
except Exception:
    data = {}

if 'mcpServers' not in data:
    data['mcpServers'] = {}

data['mcpServers']['memory-cell'] = {
    'command': '$BIN_PATH',
    'args': ['--db', '$DB_PATH'],
    'env': {
        'MEMORY_CELL_USER': '$DETECTED_USER',
        'MEMORY_CELL_ROLE': '$DEFAULT_ROLE'
    }
}

with open(path, 'w') as f:
    json.dump(data, f, indent=2)
" 2>/dev/null || true
    print_msg "  ${GREEN}✅ Claude Desktop App${NC} -> Configured (${CLAUDE_CONFIG})"
fi

print_msg "\n${GREEN}======================================================${NC}"
print_msg "${GREEN}🎉 Memory Cell Setup & Installation Completed!       ${NC}"
print_msg "${GREEN}======================================================${NC}"
print_msg "📁 Database:    ${CYAN}${DB_PATH}${NC}"
print_msg "👤 Attribution: ${CYAN}${DETECTED_USER}${NC} (role: ${DEFAULT_ROLE})"
print_msg "🧠 Embeddings:  ${CYAN}all-minilm (384-dimensional)${NC}"

print_msg "\n${BOLD}🚀 How to Use Memory Cell (2 Simple Ways):${NC}"
print_msg "\n${YELLOW}[Method 1: Direct CLI Commands in Terminal]${NC}"
print_msg "  • ${CYAN}memory-cell doctor${NC}         -> Run comprehensive environment & API diagnostic"
print_msg "  • ${CYAN}memory-cell config distill${NC}   -> Switch distillation engine (openai/anthropic/gemini/groq/ollama/heuristic)"
print_msg "  • ${CYAN}memory-cell takeover${NC}       -> Seamlessly take over working memory from previous agent session"
print_msg "  • ${CYAN}memory-cell recall [query]${NC} -> Query episodic timeline logs and debugging history"
print_msg "  • ${CYAN}memory-cell codegraph on|off${NC} -> Toggle Full Code Graph mode (Call tree & variable defs)"
print_msg "  • ${CYAN}memory-cell sync${NC}           -> Ingest & index all project documents into knowledge graph"
print_msg "  • ${CYAN}memory-cell stats${NC}          -> View token savings ROI & team knowledge assets"
print_msg "  • ${CYAN}memory-cell stats --share${NC}  -> Generate Markdown ROI report card for Slack/PRs"
print_msg "  • ${CYAN}memory-cell --help${NC}         -> Show full CLI command list & flags"

print_msg "\n${YELLOW}[Method 2: Natural Language & Slash Commands in your AI IDE]${NC}"
print_msg "  Simply talk to your AI agent or use slash commands! You can say:"
print_msg "  • ${CYAN}/takeover${NC} or ${GREEN}\"Where did we leave off? Take over progress\"${NC} (Seamlessly reconstructs working memory)"
print_msg "  • ${CYAN}/recall${NC} or ${GREEN}\"Check historical debugging logs\"${NC} (Recalls spatiotemporal episodic timeline)"
print_msg "  • ${GREEN}\"How do we configure Redis timeout in our project?\"${NC} (Queries synaptic memory)"
print_msg "  • ${GREEN}\"Evaluate impact before I modify StorageAdapter\"${NC} (Runs JIT Blast Radius Analysis)"
print_msg "  • ${GREEN}\"Who calls save_engram in our codebase?\"${NC} (Traces JIT Call Hierarchy)"
print_msg "  • ${GREEN}\"Record this pitfall: Never use blocking locks in async functions\"${NC} (Saves anti-pattern)"
print_msg "  • ${GREEN}\"Record our deployment SOP step-by-step\"${NC} (Saves living procedural doc)"
print_msg "  • ${GREEN}\"How many tokens has Memory Cell saved our team?\"${NC} (Queries ROI metrics)"

print_msg "\n${BOLD}${CYAN}👉 Next Step:${NC} Restart your IDE or reload window (${CYAN}Cmd+Shift+P${NC} -> ${YELLOW}Developer: Reload Window${NC}) to connect!"
print_msg "${DIM}💡 Pro-Tip: Memory Cell is active and will autonomously auto-sync your project codebase and recall past workflows in the background.${NC}"
print_msg "${GREEN}======================================================${NC}\n"
