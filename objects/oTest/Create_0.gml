draw_set_font(fntConsolas);

SusSetCanPauseCallback(function()
{
    return true;
});

SusSetPauseCallback(function()
{
    //show_debug_message("Pause event");
});

SusSetCanXboxSuspendCallback(function()
{
    return true;
});

SusSetXboxSuspendingCallback(function()
{
    //show_debug_message("Suspending event");
});