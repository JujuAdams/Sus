function __SusCallbackCanXboxSuspend()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__canXboxSuspendCallback))
    {
        return _system.__canXboxSuspendCallback() ?? false;
    }
    else
    {
        return false;
    }
}