function __SusCallbackPause()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__pauseCallback))
    {
        _system.__pauseCallback();
    }
}