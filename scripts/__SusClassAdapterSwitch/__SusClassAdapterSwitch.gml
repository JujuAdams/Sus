function __SusClassAdapterSwitch() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Switch adapter");
    }
    
    __SusConfigSwitch();
    
    __accountIndex = switch_accounts_open_preselected_user();
    
    
    
    static __GetName = function()
    {
        return switch_accounts_get_nickname(__accountIndex);
    }
    
    static __GetUserID = function()
    {
        return __accountIndex;
    }
    
    static __GamepadDisconnected = function()
    {
        if (__SusCallbackCanPause())
        {
            __SusCallbackPause();
            
            switch_controller_support_show();
            
            if (SUS_VERBOSE)
            {
                __SusTrace($"CSA selected gamepad {switch_controller_support_get_selected_id()}");
            }
            
            InputPlayerSetDevice(switch_controller_support_get_selected_id());
        }
    }
}