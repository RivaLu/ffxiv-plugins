# Developing

## Requirements

- [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0)
- XIVLauncher with Dalamud installed. The build uses Dalamud's files from `%AppData%\XIVLauncher\addon\Hooks\dev`.

## Repository layout

Each plugin is a top-level folder named after its project, e.g. `InvaderTags/InvaderTags.csproj`, with a manifest `InvaderTags.json` next to it. All plugins are listed in `ffxiv-plugins.slnx`.

To add a plugin:

1. Create `<Name>/<Name>.csproj` using `Sdk="Dalamud.NET.Sdk/15.0.0"`, plus a `<Name>.json` manifest with `Author`, `Name`, `Punchline`, `Description` and `RepoUrl`.
2. Add it to the solution: `dotnet sln ffxiv-plugins.slnx add <Name>/<Name>.csproj`
3. Optional: add a square icon (64–512 px) at `<Name>/images/icon.png`.
4. Add a row to the plugin table in `README.md`.

## Building

```
dotnet build ffxiv-plugins.slnx -c Release
```

Each plugin is built to `<Name>/bin/Release/`, with an installable zip at `<Name>/bin/Release/<Name>/latest.zip`.

## Testing in game

1. `/xlsettings` → **Experimental** → add the full path to `<Name>/bin/Release/<Name>.dll` under **Dev Plugin Locations** → Save.
2. `/xlplugins` → **Dev Tools** → **Installed Dev Plugins** → turn the plugin on. New dev plugins start switched off.

Don't have the same plugin installed from the custom repository at the same time.

## Releasing

1. Raise `<Version>` in each changed plugin's `.csproj`. Dalamud only offers an update when the version goes up.
2. Commit and push to `main`.
3. Tag and push a release:
   ```
   git tag v1.0.1
   git push origin v1.0.1
   ```

The **Release** workflow then builds every plugin and publishes a GitHub Release containing `<Name>.zip` files and a `repo.json`. Players' repo URL always points at the newest release's `repo.json`, so they get the update automatically.

The **Build** workflow checks that everything compiles on every push and pull request to `main`.
