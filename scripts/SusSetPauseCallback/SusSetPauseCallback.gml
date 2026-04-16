function SusSetPauseCallback(_function)
{
    static _system = __SusSystem();
    
    _system.__pauseCallback = _function;
}