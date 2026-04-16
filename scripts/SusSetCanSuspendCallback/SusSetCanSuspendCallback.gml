function SusSetCanSuspendCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__canSuspendCallback = _function;
}