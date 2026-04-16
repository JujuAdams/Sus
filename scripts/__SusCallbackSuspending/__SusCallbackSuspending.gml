function __SusCallbackSuspending()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__suspendingCallback))
    {
        _system.__suspendingCallback();
    }
}