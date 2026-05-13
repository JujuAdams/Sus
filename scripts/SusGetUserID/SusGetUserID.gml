// Feather disable all

/// Returns the display name for the current user. Exactly what function is called depends on
/// what platform the game is running on:
/// 
/// Steam:
///   Returns `steam_get_user_account_id()`.
/// 
/// Switch:
///   Returns the value that `switch_accounts_open_preselected_user()` returned when the game
///   started. You can then use this value with other Switch functions to return other user
///   handles etc.
/// 
/// PlayStation 5:
///   Returns `psn_default_user()`.
/// 
/// Xbox Series X/S & Windows GDK:
///   Returns a 64-bit integer, typically the value given by `xboxone_get_activating_user()`. If
///   this value is `0` then no user is currently signed in.
/// 
/// Other platforms:
///   Returns `-1`.

function SusGetUserID()
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetUserID();
}