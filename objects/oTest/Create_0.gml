draw_set_font(fntConsolas);

SusSetCanPauseCallback(function()
{
    return true;
});

SusSetPauseCallback(function()
{
    //show_debug_message("Pause event");
});

SusSetCanSuspendCallback(function()
{
    return true;
});

SusSetSuspendingCallback(function()
{
    //show_debug_message("Suspending event");
});