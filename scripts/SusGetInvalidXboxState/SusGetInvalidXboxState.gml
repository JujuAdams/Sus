// Feather disable all

/// Returns whether the Xbox component of the library is in a valid state. The state will be
/// considered invalid if the current user is not signed in or no input device is connected.
/// Additionally, the gamestate will be considered invalid if the current user is not the
/// activating user. If the game is neither running on Xbox hardware nor running on Windows using
/// the GDK extension then this function will return `false`.
/// 
/// You should check this function (on all platforms) to see if user input is needed when the game
/// boots up. You would typically request user input at the same time as displaying the gamertag of
/// the currently signed in user as well as their avatar. The way I've done this in the past is to
/// show a "Press Start to continue" screen or similar.

function SusGetInvalidXboxState()
{
    static _system = __SusSystem();
    
    with(_system.__adapter)
    {
        if (SUS_USING_WINDOWS_GDK)
        {
            return ((__user == 0) && InputPlayerIsConnected());
        }
        else if (SUS_ON_XBOX_SERIES)
        {
            return ((__user != __activatingUser) && InputPlayerIsConnected());
        }
    }
    
    return false;
}