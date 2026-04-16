// Feather disable all

/// Defines a callback that is executed by Sus whenever the library decides that the pause needs to
/// be paused. This is usually when a gamepad has been disconnected.
/// 
/// @param function

function SusSetPauseCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__pauseCallback = _function;
}