// Feather disable all

/// Returns whether the game application has been backgrounded in some sense where the OS has
/// hidden the application or some other OS user interface element is being drawn over the top of
/// the application.

function SusGetBackgrounded()
{
    return (os_is_paused() || (SUS_ON_XBOX_SERIES && xboxone_is_constrained()));
}