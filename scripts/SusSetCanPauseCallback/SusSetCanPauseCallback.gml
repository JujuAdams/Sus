// Feather disable all

/// Defines a callback that is executed by Sus whenever the library needs to check if the game can
/// be paused. The function that you specify must return either `true` (the game can pause) or
/// `false` (the game cannot pause). Ideally, you should allow pausing at any point in a game's
/// execution but this is often unworkable e.g. when the game is booting up or during a loading
/// screen.
/// 
/// N.B. If this function is never called and no callback is set then Sus will assume that the game
///      can always be paused.
/// 
/// @param function

function SusSetCanPauseCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__canPauseCallback = _function;
}