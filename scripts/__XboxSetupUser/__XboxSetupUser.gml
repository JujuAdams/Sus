// Feather disable all

/// @param user

function __XboxSetupUser(_user)
{
    __SusTrace($"Setting Xbox savedata user to {_user}");
    xboxone_set_savedata_user(_user);
    xboxone_stats_add_user(_user);
    
    if (SUS_ON_XBOX_SERIES)
    {
        //Use the Xbox device for the player's device. Despite using the "simplified user
        //model" this can still be an invalid device.
        var _device = XboxGetGamepad();
        __SusTrace($"Xbox device = {_device}");
        
        InputPlayerSetDevice((_device < 0)? SUS_NO_DEVICE : _device);
    }
}