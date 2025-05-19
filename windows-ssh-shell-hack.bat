@echo off
REM  powershell -NoProfile -NoLogo %*
pwsh -NoProfile -NoLogo %*
REM  pwsh -NoLogo %*

REM This file is a hack to resolve the issue that Win32-OpenSSH doesn't (didn't) respect the
REM DefaultShellArguments/DefaultShellCommandOption registers
REM
REM How to install this batch file as the default "shell" when connecting to ssh:
REM sudo Set-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value (Get-ChildItem .\windows-ssh-shell-hack.bat | % { $_.FullName })
REM
REM See this issue/comments for details:
REM https://github.com/PowerShell/Win32-OpenSSH/issues/1677#issuecomment-709525286
REM https://github.com/PowerShell/Win32-OpenSSH/issues/1677#issuecomment-1499545946&
