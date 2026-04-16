function SusGetGamepad()
{
    static _system = __SusSystem();
    
    return _system.__gamepad;
}