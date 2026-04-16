// Feather disable all

/// Defines a callback that is executed by Sus whenever the library needs to check if the game can
/// be interrupted by native OS user interface. This callback is used on the Switch and Xbox
/// platforms to determine when to show OS modals that are used to set the player's current gamepad.
/// You should generally build your game to be pausable in any situation; however, you may not want
/// to disrupt the games on a loading screen etc.
/// 
/// The function that you specify must return either `true` (the game can be interrupted) or
/// `false` (the game should not be interrupted right now). Try to permit the OS interrupting your
/// game in as many places as possible for best results.
/// 
/// N.B. If this function is never called and no callback is set then Sus will assume that the game
///      can always be interrupted at any point.
/// 
/// @param function

function SusSetCanInterruptGameCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__canInterruptGameCallback = _function;
}