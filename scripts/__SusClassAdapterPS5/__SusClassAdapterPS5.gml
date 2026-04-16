function __SusClassAdapterPS5() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using PlayStation 5 adapter");
    }
    
    __userID = psn_default_user();
    
    
    
    static __GetName = function()
    {
        return psn_default_user_name();
    }
    
    static __GetUserID = function()
    {
        return __userID;
    }
    
    static __BeginStep = function()
    {
        psn_tick();
    }
}