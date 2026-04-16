function __SusClassAdapterSwitch() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Switch adapter");
    }
    
    __SusConfigSwitch();
    __waitingForGamepad = 0;
    
    
    
    static __GamepadDisconnected = function()
    {
        __SusCallbackGamepadDisconnected();
        __SusCallbackPause();
        
        __waitingForGamepad = 20;
        switch_controller_support_show();
    }
    
    static __BeginStep = function()
    {
        --__waitingForGamepad;
    }
    
    static __SystemAsync = function()
    {
        var _type  = async_load[? "event_type"];
        var _index = async_load[? "pad_index" ];
        
        if (_type == "gamepad discovered")
        {
            //If a gamepad was discovered during the CSA then that's our new gamepad!
            if ((__waitingForGamepad > 0) && __SusGetGamepadDisconnected())
            {
                __waitingForGamepad = 0;
                
                _system.__gamepad = _index;
                _system.__disconnectedTime = 0;
                
                __SusCallbackGamepadConnected(_index);
            }
        }
    }
}