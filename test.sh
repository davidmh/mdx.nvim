#!/usr/bin/env bash
# test.sh — Verifies that multi-line JSX component bodies in MDX get TSX injection.
#
# Passes on the current commit (indented_code_block rule present in injections.scm).
# Fails on the previous commit (rule absent).
#
# Dependencies: only `nvim` — the markdown treesitter parser is bundled with it.

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
INJECTIONS_SCM="$PLUGIN_DIR/after/queries/markdown/injections.scm"

# ── temp files ─────────────────────────────────────────────────────────────
FIXTURE=$(mktemp /tmp/mdx_fixture_XXXXXXXX)
LUA_SCRIPT=$(mktemp /tmp/mdx_test_XXXXXXXX)
trap 'rm -f "$FIXTURE" "$LUA_SCRIPT"' EXIT

# ── MDX fixture ────────────────────────────────────────────────────────────
# MultiLine's body is indented → markdown parses it as `indented_code_block`.
# That is the node the fix injects TSX into.
cat > "$FIXTURE" << 'MDX'
# Test MDX

export const SingleLine = ({ x }) => ( <span>{x}</span> );

export const MultiLine = () => (
	<div className="wrapper">
		<span>hello world</span>
	</div>
);
MDX

# ── Lua test script ────────────────────────────────────────────────────────
cat > "$LUA_SCRIPT" << 'LUA'
-- Register #lua-match? so Neovim doesn't error on an unknown predicate.
-- Returns true unconditionally — we only care about the indented_code_block
-- capture which has no predicate of its own.
pcall(function()
  vim.treesitter.query.add_predicate("lua-match?", function()
    return true
  end, { force = true })
end)

local fixture    = assert(os.getenv("MDX_FIXTURE"),    "MDX_FIXTURE not set")
local injections = assert(os.getenv("MDX_INJECTIONS"), "MDX_INJECTIONS not set")

local buf = vim.fn.bufadd(fixture)
vim.fn.bufload(buf)

local parser = vim.treesitter.get_parser(buf, "markdown")
local root   = parser:parse()[1]:root()

local f   = assert(io.open(injections, "r"), "cannot open " .. injections)
local src = f:read("*a"); f:close()
local query = vim.treesitter.query.parse("markdown", src)

local found = false
for _, node in query:iter_captures(root, buf) do
  if node:type() == "indented_code_block" then
    found = true
    break
  end
end

if found then
  io.write("PASS: indented_code_block captured with tsx injection\n")
  vim.cmd("qa!")
else
  io.write("FAIL: indented_code_block NOT captured — multi-line JSX won't be highlighted\n")
  vim.cmd("cq 1")
end
LUA

MDX_FIXTURE="$FIXTURE" MDX_INJECTIONS="$INJECTIONS_SCM" \
  nvim --headless -u NORC -c "luafile $LUA_SCRIPT" 2>/dev/null
