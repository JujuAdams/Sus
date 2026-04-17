// Feather disable all

/// Returns whether the game application has been backgrounded in some sense where the OS has
/// hidden the application or some other OS user interface element is being drawn over the top of
/// the application. This function will return `true` for one Step when GameMaker reports the
/// application as being backgrounded. Exactly when that is depends on the platform, please
/// continue reading for more information.
/// 
/// Windows (Steam & GDK):
///   Returns `true` when the application is minimized.
/// 
/// MacOS:
///   `os_is_paused()` is buggy on this platform. 
/// 
/// Switch:
///   Returns `true` when the application is brought back to the foreground after being
///   backgrounded.
/// 
/// PlayStation 5:
///   Returns `true` when either the OS opens user interface over the application, or the
///   application is minimized.
/// 
/// Xbox Series X/S:
///   Returns `true` when either the OS opens user interface over the application, or the
///   application is minimized.
/// 
/// Android:
///   Returns `true` when the application is brought back to the foreground after being
///   backgrounded.

function SusGetBackgrounded()
{
    static _oldState = undefined;
    
    var _newState = (os_is_paused() || (SUS_ON_XBOX_SERIES && xboxone_is_constrained()));
    var _result = (_newState && (not _oldState));
    _oldState = _newState;
    
    return _result;
}