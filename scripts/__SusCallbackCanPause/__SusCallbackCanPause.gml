function __SusCallbackCanInterruptGame()
{
    static _system = __SusSystem();
    
    if (is_callable(_system.__canInterruptGameCallback))
    {
        return (_system.__canInterruptGameCallback() == true);
    }
    else
    {
        return true;
    }
}