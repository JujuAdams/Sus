function __SusCallbackCanXboxSuspend()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__canXboxSuspendCallback))
    {
        _system.__canXboxSuspendCallback();
    }
}