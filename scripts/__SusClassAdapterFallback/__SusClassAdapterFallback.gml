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
    
    static __GetAvatar = function(_size)
    {
        return SusBlankSprite;
    }
    
    static __GetUserID = function()
    {
        return -1;
    }
    
    static __GamepadDisconnected = function()
    {
        __SusCallbackGamepadDisconnected();
    }
    
    static __BeginStep = function()
    {
        __BeginStepShared();
    }
    
    static __BeginStepShared = function()
    {
        if (not InputPlayerIsConnected())
        {
            __GamepadDisconnected();
        }
    }
    
    static __SystemAsync = function() {}
}