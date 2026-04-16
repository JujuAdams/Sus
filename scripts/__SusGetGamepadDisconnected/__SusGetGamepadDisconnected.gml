function __SusGetGamepadDisconnected()
{
    static _system = __SusSystem();
    
    return (not gamepad_is_connected(_system.__gamepad));
}