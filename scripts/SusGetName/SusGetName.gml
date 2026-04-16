// Feather disable all

/// Returns the display name for the current user. Exactly what function is called depends on
/// what platform the game is running on:
/// 
/// Steam:
///   Returns `steam_get_persona_name()`
/// 
/// Switch:
///   Returns `switch_accounts_get_nickname()` targetting the preselected user
/// 
/// PlayStation 5:
///   Returns `psn_default_user_name()`
/// 
/// Xbox Series X/S & Windows GDK:
///   Returns `xboxone_modern_gamertag_for_user()`
/// 
/// Other platforms:
///   Returns an empty string
/// 
/// N.B. Drawing names built from Latin script is easy. However, it is common a user has chosen a
///      display name that contains non-Latin character. Sus does not help with this problem;
///      however, you may want to consider using Moniker to draw arbitrary names:
///        https://github.com/jujuadams/moniker

function SusGetName()
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetName();
}