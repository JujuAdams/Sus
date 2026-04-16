function SusSetGamepadDisconnectedCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__gamepadDisconnectedCallback = _function;
}