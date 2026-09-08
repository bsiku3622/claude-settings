#Requires -Version 5.1
# PreToolUse hook: blocks Edit/Write while DISCUSS mode is active for this session.
# Windows counterpart of mode-guard.sh.
#
# State is judged by the EXISTENCE of "$env:USERPROFILE\.claude\modes\<session id>".
# Content is not read. discuss-done removes the file, so most sessions leave no trace.
#
# If the session id can't be determined, the hook passes (fail-open): Discuss Mode
# is a mistake-prevention guardrail, not a security boundary, so blocking normal
# work on an indeterminate state is worse than letting it through.

$sid = $env:CLAUDE_CODE_SESSION_ID

if (-not $sid) {
    $stdin = [Console]::In.ReadToEnd()
    if ($stdin -match '"session_id"\s*:\s*"([^"]*)"') {
        $sid = $Matches[1]
    }
}

if (-not $sid) { exit 0 }

$modeFile = Join-Path $env:USERPROFILE ".claude\modes\$sid"
if (-not (Test-Path -LiteralPath $modeFile -PathType Leaf)) { exit 0 }

[Console]::Error.WriteLine('Cannot edit files in Discuss Mode - use /discuss-done to exit.')
exit 2
