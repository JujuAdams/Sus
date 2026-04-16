// Feather disable all

/// Defines a callback that is executed by Sus whenever the library needs to check if the game can
/// be safely suspended. The function that you specify must return either `true` (the game can be
/// suspended safely) or `false` (the game cannot yet be suspended safely).
/// 
/// The callback that you set using this function should only return `true` once your game has
/// finished critical operations, such as saving the game.
/// 
/// N.B. If this function is never called and no callback is set then Sus will assume that the game
///      can suspended safely after 800 milliseconds.
/// 
/// @param function

function SusSetCanXboxSuspendCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__canXboxSuspendCallback = _function;
}