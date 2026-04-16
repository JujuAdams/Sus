function SusSwitchShowCSA()
{
    static _adapter = __SusSystem().__adapter;
    
    if (is_instanceof(_adapter, __SusClassAdapterSwitch))
    {
        return _adapter.__GamepadDisconnected();
    }
}