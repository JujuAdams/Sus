function SusSetCanPauseCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__canPauseCallback = _function;
}