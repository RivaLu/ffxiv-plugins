# FFXIV Dalamud Plugins

Small client-side [Dalamud](https://github.com/goatcorp/Dalamud) plugins for Final Fantasy XIV.

| Plugin | What it does |
| --- | --- |
| [InvaderTags](InvaderTags) | Shows the «Voyager» nameplate tag as «Invader». Only your screen changes. |

## Building

Requires the .NET 10 SDK and XIVLauncher with Dalamud installed.

```
dotnet build InvaderTags/InvaderTags.csproj -c Release
```

The plugin is built to `InvaderTags/bin/Release/InvaderTags.dll`.

## Loading in-game

1. `/xlsettings` → **Experimental** → add the path to the built `.dll` under **Dev Plugin Locations** → Save.
2. `/xlplugins` → **Dev Tools** → **Installed Dev Plugins** → turn the plugin on.
