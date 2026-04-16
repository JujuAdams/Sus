/// Must be called in the scope of an adapter

function __SusConsoleFindGamepad()
{
    static _system = __SusSystem();
    
    var _i = 0;
    repeat(gamepad_get_device_count())
    {
        if (gamepad_is_connected(_i))
        {
            if (SUS_VERBOSE)
            {
                __SusTrace($"Found connected gamepad {_i}");
            }
            
            _system.__gamepad = _i;
            break;
        }
        
        ++_i;
    }
    
    if (not gamepad_is_connected(_system.__gamepad))
    {
        __SusWarning("Could not find connected gamepad");
    }
}