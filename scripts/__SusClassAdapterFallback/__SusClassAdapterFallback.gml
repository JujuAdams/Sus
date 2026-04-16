function __SusClassAdapterFallback() constructor
{
    static _system = __SusSystem();
    
    if (SUS_VERBOSE)
    {
        __SusTrace("Using fallback adapter");
    }
    
    
    
    static __GetName = function()
    {
        return "";
    }
    
    static __GetAvatar = function()
    {
        return SusBlankSprite;
    }
    
    static __GetUserID = function()
    {
        return -1;
    }
    
    static __GamepadDisconnected = function()
    {
        if (__SusCallbackCanPause())
        {
            __SusCallbackPause();
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
    
    static __SystemAsync = function() {}
}