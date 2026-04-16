// Feather disable all

/// Defines a callback that is executed by Sus whenever the library decides that the player's
/// input device (usually a gamepad) has been disconnected. This callback will be executed every
/// step until the player is assigned a working device.
/// 
/// On Switch and Xbox, the operating system provides a native user interface modal that handles
/// gamepad assignment for you. However, on other platforms (notably PlayStation) you will need to
/// communicate to the user that they need to connect a new gamepad. Input (the library) handles
/// hotswapping for you so all the player needs to do is press a button on their gamepad but you
/// are responsible for telling the player that they need to do this.
/// 
/// @param function

function SusSetGamepadDisconnectedCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__gamepadDisconnectedCallback = _function;
}