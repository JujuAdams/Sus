/// @param gamepad

function __SusCallbackGamepadConnected(_gamepad)
{
    static _system = __SusSystem();
    
    _system.__gamepad = _gamepad;
    
    if (is_callable(_system.__gamepadConnectedCallback))
    {
        _system.__gamepadConnectedCallback(_gamepad);
    }
}