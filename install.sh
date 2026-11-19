#!/usr/bin/env bash
# ==============================================================================
# Memory Cell — Zero-Prompt Installer (macOS & Linux)
# ==============================================================================
# Supported OS: macOS (Apple Silicon & Intel), Linux (x86_64 & ARM64)
# ==============================================================================

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

print_msg() {
    printf "%b\n" "$*"
}

usage() {
    cat <<'EOF'
Memory Cell Installer

Usage:
  install.sh [options]

Options:
  --db <path>       Custom SQLite database path (default: ~/.memory_cell/global.sqlite3)
  --skip-warmup     Skip pre-downloading the local embedding model
  --no-init         Do not auto-run `memory-cell init` in the current project directory
  --version <tag>   Install a specific release tag (default: latest)
  -y, --yes         Accepted for compatibility (installer is zero-prompt by default)
  -h, --help        Show this help message
EOF
}

CUSTOM_DB_PATH=""
SKIP_WARMUP=false
NO_INIT=false
RELEASE_TAG="${MEMORY_CELL_VERSION:-latest}"

while [ $# -gt 0 ]; do
    case "$1" in
        -y|--yes|--non-interactive|-s|--silent)
            shift
            ;;
        --db)
            if [ $# -lt 2 ]; then
                print_msg "${RED}Error: --db requires a path argument.${NC}"
                exit 1
            fi
            CUSTOM_DB_PATH="$2"
            shift 2
            ;;
        --skip-warmup)
            SKIP_WARMUP=true
            shift
            ;;
        --no-init)
            NO_INIT=true
            shift
            ;;
        --version)
            if [ $# -lt 2 ]; then
                print_msg "${RED}Error: --version requires a tag argument.${NC}"
                exit 1
            fi
            RELEASE_TAG="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

# 1. Detect OS and CPU Architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

TARGET=""
case "$OS" in
    Darwin)
        case "$ARCH" in
            arm64|aarch64) TARGET="macos-arm64" ;;
            x86_64) TARGET="macos-x86_64" ;;
            *)
                print_msg "${RED}Error: Unsupported macOS architecture: $ARCH${NC}"
                exit 1
                ;;
        esac
        ;;
    Linux)
        case "$ARCH" in
            x86_64) TARGET="linux-x86_64" ;;
            aarch64|arm64) TARGET="linux-arm64" ;;
            *)
                print_msg "${RED}Error: Unsupported Linux architecture: $ARCH${NC}"
                exit 1
                ;;
        esac
        ;;
    *)
        print_msg "${RED}Error: Unsupported OS: $OS. On Windows, install via npm: npm install -g @muxtsou/memory-cell${NC}"
        exit 1
        ;;
esac

# 2. Resolve database path and user identity (matches core detect_user_identity)
DEFAULT_DB="$HOME/.memory_cell/global.sqlite3"
DB_PATH="${CUSTOM_DB_PATH:-$DEFAULT_DB}"
DB_PATH="${DB_PATH/#\~/$HOME}"
mkdir -p "$(dirname "$DB_PATH")"

DETECTED_USER="${MEMORY_CELL_USER:-$(git config user.email 2>/dev/null || git config user.name 2>/dev/null || echo "${USER:-anonymous}")}"
DEFAULT_ROLE="engineer"

# 3. Install binary into ~/.local/bin
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"
BIN_PATH="$INSTALL_DIR/memory-cell"

GITHUB_REPO="${MEMORY_CELL_REPO:-muxtsou/memory-cell-distribution}"
if [ "$RELEASE_TAG" = "latest" ]; then
    RELEASE_DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/latest/download/memory-cell-${TARGET}"
else
    RELEASE_DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/download/${RELEASE_TAG}/memory-cell-${TARGET}"
fi

if [ -n "${CUSTOM_BINARY_URL:-}" ]; then
    curl -fsSL "$CUSTOM_BINARY_URL" -o "$BIN_PATH"
elif [ "${USE_LOCAL_BINARY:-0}" = "1" ] && [ -f "dist/memory-cell-$TARGET" ]; then
    cp "dist/memory-cell-$TARGET" "$BIN_PATH"
elif [ "${USE_LOCAL_BINARY:-0}" = "1" ] && [ -f "dist/memory-cell-macos-universal" ]; then
    cp "dist/memory-cell-macos-universal" "$BIN_PATH"
elif [ "${USE_LOCAL_BINARY:-0}" = "1" ] && [ -f "target/release/memory-cell" ]; then
    cp "target/release/memory-cell" "$BIN_PATH"
else
    TMP_BIN_PATH="${BIN_PATH}.download.tmp"
    DOWNLOAD_OK=false
    for attempt in 1 2 3; do
        rm -f "$TMP_BIN_PATH"
        if curl -fsSL --connect-timeout 15 --max-time 300 --retry 2 --retry-delay 2 --retry-connrefused \
            "$RELEASE_DOWNLOAD_URL" -o "$TMP_BIN_PATH"; then
            DOWNLOAD_OK=true
            break
        fi
        print_msg "${YELLOW}Download attempt ${attempt}/3 failed. Retrying...${NC}"
        sleep 2
    done

    if [ "$DOWNLOAD_OK" = true ] && [ -s "$TMP_BIN_PATH" ]; then
        mv "$TMP_BIN_PATH" "$BIN_PATH"
    else
        rm -f "$TMP_BIN_PATH"
        print_msg "${RED}Error: Failed to download binary from ${RELEASE_DOWNLOAD_URL} after 3 attempts.${NC}"
        print_msg "Try again on a stable connection, or install manually:"
        print_msg "  ${CYAN}curl -fSL -o \"$BIN_PATH\" \"$RELEASE_DOWNLOAD_URL\" && chmod +x \"$BIN_PATH\"${NC}"
        exit 1
    fi
fi

chmod +x "$BIN_PATH" 2>/dev/null || true

if [ ! -x "$BIN_PATH" ]; then
    print_msg "${RED}Error: memory-cell binary is missing or not executable at ${BIN_PATH}.${NC}"
    exit 1
fi

INSTALLED_VER="$("$BIN_PATH" --version 2>/dev/null || echo "memory-cell")"
print_msg "✅ Installed ${INSTALLED_VER} -> ${BIN_PATH/#$HOME/~}"

# 4. Configure PATH before warmup and init
ORIG_PATH="$PATH"
NEED_PATH_RELOAD=false
case ":${ORIG_PATH}:" in
    *":${INSTALL_DIR}:"*) ;;
    *) NEED_PATH_RELOAD=true ;;
esac
export PATH="$INSTALL_DIR:$PATH"

LOGIN_SHELL="$(basename "${SHELL:-}")"
PATH_RELOAD_CMD=""
case "$LOGIN_SHELL" in
    zsh)
        SHELL_RC="$HOME/.zshrc"
        mkdir -p "$(dirname "$SHELL_RC")"
        touch "$SHELL_RC"
        if ! grep -qs '\.local/bin' "$SHELL_RC"; then
            printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$SHELL_RC"
        fi
        PATH_RELOAD_CMD="source ~/.zshrc"
        ;;
    bash)
        if [ "$OS" = "Darwin" ] && [ -f "$HOME/.bash_profile" ]; then
            SHELL_RC="$HOME/.bash_profile"
        else
            SHELL_RC="$HOME/.bashrc"
        fi
        mkdir -p "$(dirname "$SHELL_RC")"
        touch "$SHELL_RC"
        if ! grep -qs '\.local/bin' "$SHELL_RC"; then
            printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$SHELL_RC"
        fi
        PATH_RELOAD_CMD="source ${SHELL_RC/#$HOME/~}"
        ;;
    fish)
        FISH_CFG="$HOME/.config/fish/config.fish"
        mkdir -p "$(dirname "$FISH_CFG")"
        touch "$FISH_CFG"
        if ! grep -qs '\.local/bin' "$FISH_CFG"; then
            printf '\nfish_add_path "$HOME/.local/bin"\n' >> "$FISH_CFG"
        fi
        PATH_RELOAD_CMD="source ~/.config/fish/config.fish"
        ;;
    *)
        PATH_RELOAD_CMD='export PATH="$HOME/.local/bin:$PATH"'
        ;;
esac

# 5. Zero-prompt workspace initialization (downloads/warms embedding model once + syncs workspace)
CURRENT_WORKSPACE="$(pwd -P 2>/dev/null || pwd)"
HOME_CANON="$(cd "$HOME" 2>/dev/null && pwd -P || echo "$HOME")"

is_project_dir() {
    if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return 0
    fi
    for marker in Cargo.toml package.json pyproject.toml go.mod Makefile CMakeLists.txt pom.xml build.gradle Gemfile composer.json mix.exs Package.swift .memorycell; do
        if [ -e "$CURRENT_WORKSPACE/$marker" ]; then
            return 0
        fi
    done
    return 1
}

if [ "$NO_INIT" = false ] && [ "$CURRENT_WORKSPACE" != "$HOME_CANON" ] && [ "$CURRENT_WORKSPACE" != "/" ] && is_project_dir; then
    INIT_ARGS=(--db "$DB_PATH" init "$CURRENT_WORKSPACE")
    if [ "$SKIP_WARMUP" = true ]; then
        INIT_ARGS+=(--skip-warmup)
    fi
    "$BIN_PATH" "${INIT_ARGS[@]}"
else
    if [ "$SKIP_WARMUP" = false ]; then
        "$BIN_PATH" warmup multilingual-e5-small || print_msg "${YELLOW}Warmup skipped (model downloads on first use).${NC}"
    fi
    if [ "$NO_INIT" = true ]; then
        print_msg "Skipped workspace init (--no-init); run \`memory-cell init\` inside a project directory."
    elif [ "$CURRENT_WORKSPACE" = "$HOME_CANON" ] || [ "$CURRENT_WORKSPACE" = "/" ]; then
        print_msg "Skipped init in ${CURRENT_WORKSPACE/#$HOME/~}; cd into a project and run \`memory-cell init\`."
    else
        print_msg "No project detected in ${CURRENT_WORKSPACE/#$HOME/~}; cd into a project and run \`memory-cell init\`."
    fi
fi

# 7. Auto-configure Claude Desktop if installed
if [ "$OS" = "Darwin" ]; then
    CLAUDE_DIR="$HOME/Library/Application Support/Claude"
else
    CLAUDE_DIR="$HOME/.config/Claude"
fi
CLAUDE_CONFIG="$CLAUDE_DIR/claude_desktop_config.json"

if { [ -d "$CLAUDE_DIR" ] || [ -f "$CLAUDE_CONFIG" ]; } && command -v python3 >/dev/null 2>&1; then
    if MC_CLAUDE_CONFIG="$CLAUDE_CONFIG" MC_BIN_PATH="$BIN_PATH" MC_DB_PATH="$DB_PATH" MC_USER="$DETECTED_USER" MC_ROLE="$DEFAULT_ROLE" python3 - <<'PY'
import json
import os

path = os.environ["MC_CLAUDE_CONFIG"]
os.makedirs(os.path.dirname(path), exist_ok=True)
try:
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    if not isinstance(data, dict):
        data = {}
except Exception:
    data = {}

servers = data.setdefault("mcpServers", {})
if isinstance(servers, dict):
    servers["memory-cell"] = {
        "command": os.environ["MC_BIN_PATH"],
        "args": ["--db", os.environ["MC_DB_PATH"]],
        "env": {
            "MEMORY_CELL_USER": os.environ["MC_USER"],
            "MEMORY_CELL_ROLE": os.environ["MC_ROLE"],
        },
    }
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)
PY
    then
        print_msg "✅ Configured Claude Desktop (${CLAUDE_CONFIG/#$HOME/~})"
    else
        print_msg "${YELLOW}Warning: Could not update ${CLAUDE_CONFIG/#$HOME/~}${NC}"
    fi
fi

# 8. Remind only when the current shell PATH needs reloading
if [ "$NEED_PATH_RELOAD" = true ] && [ -n "$PATH_RELOAD_CMD" ]; then
    print_msg "Reload PATH in this shell: ${PATH_RELOAD_CMD}"
fi
