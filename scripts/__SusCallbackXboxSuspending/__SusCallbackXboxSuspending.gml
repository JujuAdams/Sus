function __SusCallbackXboxSuspending()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__xboxSuspendCallback))
    {
        _system.__xboxSuspendCallback();
    }
}