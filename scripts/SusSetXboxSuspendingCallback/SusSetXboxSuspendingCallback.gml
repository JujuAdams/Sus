// Feather disable all

/// Defines a callback that is executed by Sus whenever the library has detected that the OS is
/// suspending the game (`xboxone_is_suspending()` is returning `true`). This callback will be
/// executed every Step that the game is suspending.
/// 
/// Please refer to documentation for the appropriate steps to take in this callback but, briefly,
/// you will need to save the game immediately!
/// 
/// @param function

function SusSetXboxSuspendingCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__xboxSuspendCallback = _function;
}