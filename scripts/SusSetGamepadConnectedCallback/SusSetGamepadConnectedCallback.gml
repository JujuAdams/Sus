function SusSetGamepadConnectedCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__gamepadConnectedCallback = _function;
}