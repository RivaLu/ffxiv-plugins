<#
  Collects every built plugin into a release folder and writes the repo.json
  that players add to Dalamud as a custom plugin repository.

  Run after `dotnet build ffxiv-plugins.slnx -c Release`.

  -Repo   owner/name of the GitHub repo, e.g. RivaLu/ffxiv-plugins
  -Tag    the release tag the zips will be attached to, e.g. v1.0.0
  -OutDir folder to write <Plugin>.zip files and repo.json into
#>
param(
    [Parameter(Mandatory)] [string] $Repo,
    [Parameter(Mandatory)] [string] $Tag,
    [string] $OutDir = "dist"
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
New-Item -ItemType Directory -Force $OutDir | Out-Null
$OutDir = Resolve-Path $OutDir

$entries = @()

# Each plugin project is a top-level folder containing <Name>/<Name>.csproj.
foreach ($proj in Get-ChildItem $root -Directory) {
    $name = $proj.Name
    if (-not (Test-Path (Join-Path $proj.FullName "$name.csproj"))) { continue }

    # DalamudPackager writes bin/Release/<Name>/latest.zip and a full manifest next to it.
    $packDir = Join-Path $proj.FullName "bin\Release\$name"
    $zip = Join-Path $packDir "latest.zip"
    $manifestPath = Join-Path $packDir "$name.json"
    if (-not (Test-Path $zip)) { throw "No build output for $name at $zip. Build first." }

    Copy-Item $zip (Join-Path $OutDir "$name.zip") -Force

    $manifest = Get-Content $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
    $download = "https://github.com/$Repo/releases/download/$Tag/$name.zip"

    $entry = [ordered]@{}
    foreach ($p in $manifest.PSObject.Properties) { $entry[$p.Name] = $p.Value }
    $entry["DownloadLinkInstall"] = $download
    $entry["DownloadLinkUpdate"]  = $download
    $entry["DownloadLinkTesting"] = $download
    $entry["IsHide"] = $false
    $entry["IsTestingExclusive"] = $false
    $entry["LastUpdate"] = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()

    # Optional icon: <Name>/images/icon.png (square, 64-512 px).
    if (Test-Path (Join-Path $proj.FullName "images\icon.png")) {
        $entry["IconUrl"] = "https://raw.githubusercontent.com/$Repo/$Tag/$name/images/icon.png"
    }

    $entries += [pscustomobject]$entry
    Write-Host "Packaged $name $($manifest.AssemblyVersion)"
}

if ($entries.Count -eq 0) { throw "No plugins found." }

$json = ConvertTo-Json -InputObject @($entries) -Depth 5
[IO.File]::WriteAllText((Join-Path $OutDir "repo.json"), $json, (New-Object Text.UTF8Encoding $false))
Write-Host "Wrote repo.json with $($entries.Count) plugin(s) to $OutDir"
