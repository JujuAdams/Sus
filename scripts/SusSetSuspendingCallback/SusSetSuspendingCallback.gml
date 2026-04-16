function SusSetSuspendingCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__suspendingCallback = _function;
}