
# All errors should be terminating by default!
$ErrorActionPreference = 'Stop'

$nodePath = ".node/node-v11.15.0-win-x86"
if (-not (Test-Path -Path $nodePath)) {
    $null = New-Item -ItemType Directory -Path $nodePath    
}

$nodePath = Resolve-Path $nodePath
$env:Path += ";$nodePath"

Write-Host "Welcome to js-dos dev console!"
Write-Host ""
Write-Host "Type Cmd to list commands."
Write-Host "Use <tab> to autocomplete command."
Write-Host ""

function Cmd
{
	Get-ChildItem function: | where {$_.Name.startsWith("Cmd_") } | % {$_.Name}
}

function Cmd_Build
{
    npx gulp
}

function Cmd_Setup
{    
    $zipFilename = ".node/node-v11.15.0-win-x86.zip"    
    $url = "https://nodejs.org/download/release/v11.15.0/node-v11.15.0-win-x86.zip"
    Write-Host "Installing $url to $nodePath"
    $global:ProgressPreference = "SilentlyContinue"
    Invoke-WebRequest -Uri $url -OutFile $zipFilename
    Expand-Archive -Path $zipFilename -DestinationPath ".node"
    $global:ProgressPreference = "Continue"
    
    Remove-Item -Path $zipFilename

    Write-Host "Installing project dependecies..."
    npm install
    npm install gulp@3.9.1
    Write-Host "Success 😎😎😎!"
}