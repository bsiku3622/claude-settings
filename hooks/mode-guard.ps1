#Requires -Version 5.1
# PreToolUse hook: blocks Edit/Write while .codex/.mode contains "discuss".
# Windows counterpart of mode-guard.sh. Exit code 2 = denied tool call.

$modeFile = Join-Path $env:USERPROFILE '.codex\.mode'

$mode = 'normal'
if (Test-Path -LiteralPath $modeFile -PathType Leaf) {
    $raw = Get-Content -LiteralPath $modeFile -Raw -ErrorAction SilentlyContinue
    if ($raw) {
        # Tolerate a UTF-8/UTF-16 BOM and any trailing newline written by echo.
        $mode = $raw.Trim([char]0xFEFF, [char]0xFFFE, ' ', "`t", "`r", "`n").ToLowerInvariant()
    }
}

if ($mode -eq 'discuss') {
    [Console]::Error.WriteLine('Cannot edit files in Discuss Mode - use /discuss-done to exit.')
    exit 2
}
exit 0
