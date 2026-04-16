function SusGetGamepadDisconnected()
{
    static _system = __SusSystem();
    
    return (__SusGetGamepadDisconnected() && (_system.__disconnectedTime >= __SUS_DISCONNECTION_THRESHOLD));
}