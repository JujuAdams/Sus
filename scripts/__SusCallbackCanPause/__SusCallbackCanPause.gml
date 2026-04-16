function __SusCallbackCanPause()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__canPauseCallback))
    {
        return (_system.__canPauseCallback() == true);
    }
    else
    {
        return true;
    }
}