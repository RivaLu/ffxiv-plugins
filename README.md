# FFXIV Dalamud Plugins

Small client-side [Dalamud](https://github.com/goatcorp/Dalamud) plugins for Final Fantasy XIV.

| Plugin | What it does |
| --- | --- |
| [InvaderTags](InvaderTags) | Shows the «Voyager» nameplate tag as «Invader». Only your screen changes. |

## Building

Requires the .NET 10 SDK and XIVLauncher with Dalamud installed.

```
dotnet build ffxiv-plugins.slnx -c Release
```

This builds every plugin. Each one ends up in its own `bin/Release` folder, e.g. `InvaderTags/bin/Release/InvaderTags.dll`. You can also open `ffxiv-plugins.slnx` in Visual Studio or Rider.

## Loading in-game

1. `/xlsettings` → **Experimental** → add the path to the built `.dll` under **Dev Plugin Locations** → Save.
2. `/xlplugins` → **Dev Tools** → **Installed Dev Plugins** → turn the plugin on.

## License

[AGPL-3.0](LICENSE)
