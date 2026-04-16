function __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using fallback adapter");
    }
    
    static _system = __SusSystem();
    
    static __BeginStep = function() {}
    
    static __SystemAsync = function() {}
    
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
        __SusCallbackGamepadDisconnected();
        __SusCallbackPause();
    }
}