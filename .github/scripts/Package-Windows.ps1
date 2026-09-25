[CmdletBinding()]
param(
    [ValidateSet('x64', 'arm64')]
    [string] $Target = 'x64',
    [ValidateSet('Debug', 'RelWithDebInfo', 'Release', 'MinSizeRel')]
    [string] $Configuration = 'RelWithDebInfo'
)

$ErrorActionPreference = 'Stop'

if ( $DebugPreference -eq 'Continue' ) {
    $VerbosePreference = 'Continue'
    $InformationPreference = 'Continue'
}

if ( $env:CI -eq $null ) {
    throw "Package-Windows.ps1 requires CI environment"
}

if ( ! ( [System.Environment]::Is64BitOperatingSystem ) ) {
    throw "wear-stream-studio requires a 64-bit system to build and run."
}

if ( $PSVersionTable.PSVersion -lt '7.2.0' ) {
    Write-Warning 'The wear-stream-studio packaging script requires PowerShell Core 7. Install or upgrade your PowerShell version: https://aka.ms/pscore6'
    exit 2
}

function Package {
    trap {
        Write-Error $_
        exit 2
    }

    $ScriptHome = $PSScriptRoot
    $ProjectRoot = Resolve-Path -Path "$PSScriptRoot/../.."

    $UtilityFunctions = Get-ChildItem -Path $PSScriptRoot/utils.pwsh/*.ps1 -Recurse

    foreach( $Utility in $UtilityFunctions ) {
        Write-Debug "Loading $($Utility.FullName)"
        . $Utility.FullName
    }

    Install-BuildDependencies -WingetFile "${ScriptHome}/.Wingetfile"

    # Untagged checkouts have no `git describe` output: fall back to the
    # commit SHA so packaging never fails for lack of tags (phase 4 fix).
    $GitDescription = git describe --tags --long --always 2>$null

    if ($LASTEXITCODE -eq 0 -and
        $GitDescription -match '^(?<version>.+)-(?<distance>\d+)-g(?<hash>[0-9a-fA-F]+)$') {
        $CommitVersion = $Matches.version
        $CommitDistance = [int]$Matches.distance
        $CommitHash = $Matches.hash

        if ( $CommitDistance -gt 0 ) {
            $OutputName = "wear-stream-studio-${CommitVersion}-${CommitHash}"
        } else {
            $OutputName = "wear-stream-studio-${CommitVersion}"
        }
    } else {
        $CommitHash = $env:GITHUB_SHA.Substring(0, 8)
        $OutputName = "wear-stream-studio-untagged-${CommitHash}"
    }

    $CpackArgs = @(
        '-C', "${Configuration}"
    )

    if ( $DebugPreference -eq 'Continue' ) {
        $CpackArgs += ('--verbose')
    }

    Log-Group "Packaging wear-stream-studio..."

    Push-Location -Stack PackageTemp "build_${Target}"

    cpack @CpackArgs

    $Package = Get-ChildItem -filter "wear-stream-studio-*-windows-${Target}.zip" -File
    Move-Item -Path $Package -Destination "${OutputName}-windows-${Target}.zip"

    Pop-Location -Stack PackageTemp
}

Package
