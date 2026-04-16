with(__SusSystem())
{
    __adapter.__BeginStep();
    
    if (__SusGetGamepadDisconnected())
    {
        ++__disconnectedTime;
        if (__disconnectedTime == __SUS_DISCONNECTION_THRESHOLD) //Trigger on exactly one frame
        {
            __adapter.__GamepadDisconnected();
        }
    }
    else
    {
        __disconnectedTime = 0;
    }
}