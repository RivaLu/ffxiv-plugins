using System;
using System.Collections.Generic;
using Dalamud.Game.Gui.NamePlate;
using Dalamud.IoC;
using Dalamud.Plugin;
using Dalamud.Plugin.Services;

namespace InvaderTags;

/// <summary>
/// Entry point. Dalamud creates this when the plugin loads and calls Dispose when it unloads.
/// </summary>
public sealed class Plugin : IDalamudPlugin
{
    // The tag text the game shows (without the « » quotes) and what we want instead.
    private const string FromTag = "Voyager";
    private const string ToTag = "Invader";

    // Dalamud fills this in for us ("dependency injection").
    [PluginService] internal static INamePlateGui NamePlateGui { get; private set; } = null!;

    public Plugin()
    {
        // Run our code every time the game updates nameplates.
        NamePlateGui.OnNamePlateUpdate += OnNamePlateUpdate;

        // Redraw nameplates now so tags already on screen change immediately.
        NamePlateGui.RequestRedraw();
    }

    private static void OnNamePlateUpdate(
        INamePlateUpdateContext context,
        IReadOnlyList<INamePlateUpdateHandler> handlers)
    {
        foreach (var handler in handlers)
        {
            // Only player nameplates carry free company / travel tags.
            if (handler.NamePlateKind != NamePlateKind.PlayerCharacter)
                continue;

            // InfoView gives us the tag text without the surrounding « » quotes.
            var tag = handler.InfoView.FreeCompanyTag.TextValue.Trim();

            if (string.Equals(tag, FromTag, StringComparison.OrdinalIgnoreCase))
            {
                // Replace only the text, keeping the game's own quote marks.
                handler.FreeCompanyTagParts.Text = ToTag;
            }
        }
    }

    public void Dispose()
    {
        NamePlateGui.OnNamePlateUpdate -= OnNamePlateUpdate;

        // Redraw so the original «Voyager» tags come back after unloading.
        NamePlateGui.RequestRedraw();
    }
}
