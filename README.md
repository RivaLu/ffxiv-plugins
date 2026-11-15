# FFXIV Dalamud Plugins

Small, client-side plugins for Final Fantasy XIV, installed through [Dalamud](https://github.com/goatcorp/Dalamud) (XIVLauncher).

| Plugin | What it does |
| --- | --- |
| **Invader Tags** | Shows the «Voyager» tag above players' heads as «Invader». |

All of these plugins are cosmetic and only change what **you** see on your own screen. Nothing is sent to the game server, and other players see the game as normal.

## Installing

You need [XIVLauncher](https://goatcorp.github.io/) with Dalamud enabled.

1. In game, type `/xlsettings` and open the **Experimental** tab.
2. Under **Custom Plugin Repositories**, paste this URL into the empty box:
   ```
   https://github.com/RivaLu/ffxiv-plugins/releases/latest/download/repo.json
   ```
3. Click the **+** button, make sure **Enabled** is ticked, then click **Save and Close**.
4. Type `/xlplugins`, open **All Plugins**, search for the plugin (e.g. **Invader Tags**) and click **Install**.

Dalamud shows a warning that custom repositories aren't checked by the Dalamud team. That's normal for any plugin not in the official list.

## Updating and removing

- **Updates** install automatically through Dalamud, the same as any other plugin.
- **To remove** a plugin, open `/xlplugins` → **Installed Plugins**, select it, and click **Uninstall**.

## Problems or ideas

Please [open an issue](https://github.com/RivaLu/ffxiv-plugins/issues) and say which plugin and what you saw.

## Disclaimer

These are unofficial third-party plugins. They aren't affiliated with or endorsed by Square Enix, and using third-party tools is against the FFXIV terms of service. These plugins don't automate gameplay or change anything other players see.

## License

[AGPL-3.0](LICENSE). Building or contributing? See [DEVELOPING.md](DEVELOPING.md).
