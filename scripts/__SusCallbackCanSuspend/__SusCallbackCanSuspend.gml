function __SusCallbackCanSuspend()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__canSuspendCallback))
    {
        _system.__canSuspendCallback();
    }
}