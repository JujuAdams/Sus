function __SusClassAdapterSwitch() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Switch adapter");
    }
    
    __SusConfigSwitch();
    __waitingForGamepad = 5;
    
    
    
    static __GamepadDisconnected = function()
    {
        if (__SusCallbackCanPause())
        {
            __SusCallbackPause();
            
            __waitingForGamepad = 30;
            switch_controller_support_show();
            
            if (SUS_VERBOSE)
            {
                __SusTrace($"CSA selected gamepad {switch_controller_support_get_selected_id()}");
            }
            
            InputPlayerSetDevice(switch_controller_support_get_selected_id());
        }
    }
    
    static __BeginStep = function()
    {
        --__waitingForGamepad;
        
        if ((__waitingForGamepad <= 0) && (not InputPlayerIsConnected()))
        {
            __GamepadDisconnected();
        }
    }
}