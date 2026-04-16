// Feather disable all

/// @param gamepad

function XboxSetGamepad(_gamepad)
{
    with(obj_platform_xbox)
    {
        //Keep things simple on Windows
        if (os_type == os_windows)
        {
            __gamepad = _gamepad;
            
            if (_gamepad >= 0)
            {
                __seenGamepad = true;
            }
            
            return;
        }
        
        if (__findContollerID >= 0)
        {
            __SusTrace("Cannot set gamepad, find_controller dialog is open");
            return;
        }
        
        var _user = xboxone_user_for_pad(_gamepad);
        if (_user == __activatingUser)
        {
            __gamepad = _gamepad;
            __seenGamepad = true;
            
            __SusTrace($"Set gamepad {__gamepad}");
        }
        else
        {
            __SusTrace($"Cannot set gamepad {_gamepad}, its user {_user} is not the activating user {__activatingUser}");
            
            __funcFindController(__activatingUser);
        }
    }
}