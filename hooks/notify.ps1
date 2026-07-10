#Requires -Version 5.1
<#
  Windows toast notification for Claude Code hooks.
  Replaces the macOS `osascript -e 'display notification ...'` calls.

  Messages live here rather than in settings.json so no Hangul ever crosses
  the command line, where the console code page would mangle it.

  Usage: powershell -NoProfile -ExecutionPolicy Bypass -File notify.ps1 -Kind permission
#>
param(
    [ValidateSet('permission', 'stop', 'custom')]
    [string]$Kind = 'custom',

    [string]$Message = '',
    [string]$Sound = 'Default'
)

switch ($Kind) {
    'permission' { $Message = '확인이 필요합니다'; $Sound = 'Reminder' }
    'stop'       { $Message = '작업이 완료되었습니다'; $Sound = 'Default' }
}

function Show-Toast {
    param([string]$Text, [string]$SoundName)

    [void][Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    [void][Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]

    # Registered AppUserModelID for Windows PowerShell; toasts without one are dropped.
    $appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
    $escaped = [System.Security.SecurityElement]::Escape($Text)

    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $xml.LoadXml(@"
<toast>
  <visual>
    <binding template="ToastGeneric">
      <text>Claude Code</text>
      <text>$escaped</text>
    </binding>
  </visual>
  <audio src="ms-winsoundevent:Notification.$SoundName"/>
</toast>
"@)

    $toast = New-Object Windows.UI.Notifications.ToastNotification $xml
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show($toast)
}

try {
    Show-Toast -Text $Message -SoundName $Sound
} catch {
    # A failed notification must never fail the tool call that triggered it.
    [System.Media.SystemSounds]::Asterisk.Play()
}
exit 0
