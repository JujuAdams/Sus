function __SusCallbackGamepadDisconnected()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__gamepadDisconnectedCallback))
    {
        _system.__gamepadDisconnectedCallback();
    }
}