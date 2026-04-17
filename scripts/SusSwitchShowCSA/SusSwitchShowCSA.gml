// Feather disable all

/// Manually shows the controller support applet when the game is running on a Nintendo Switch.
/// This function does nothing on other functions. Sus will automatically show the CSA when the
/// player's gamepad is disconnected; this function is provided in case you'd like to let the
/// player open the CSA manually to swap gamepads using the CSA.
/// 
/// N.B. You should never call `switch_controller_support_show()` yourself. Please ensure that
///      you're using `SusSwitchShowCSA()`.

function SusSwitchShowCSA()
{
    static _adapter = __SusSystem().__adapter;
    
    if (is_instanceof(_adapter, __SusClassAdapterSwitch))
    {
        return _adapter.__GamepadDisconnected();
    }
}