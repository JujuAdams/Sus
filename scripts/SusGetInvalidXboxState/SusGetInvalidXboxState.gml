// Feather disable all

/// Returns whether the Xbox wrapper is in a valid state. The state will be considered invalid if
/// the current user is not signed in or no gamepad has been set. Additionally, if the game is
/// running using the simplified user model then the state will be considered invalid if the
/// current user is not the activating user.
/// 
/// You should use this function to detect if some sort of user input is needed. Once you have
/// received input from a gamepad, call `XboxSetGamepad()`.

function SusGetInvalidXboxState()
{
    static _system = __SusSystem();
    
    with(_system.__adapter)
    {
        if (SUS_USING_WINDOWS_GDK)
        {
            return (__user == 0);
        }
        else if (SUS_ON_XBOX_SERIES)
        {
            return (__user != __activatingUser);
        }
    }
    
    return false;
}