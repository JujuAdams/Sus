draw_set_font(fntConsolas);

SusSetCanPauseCallback(function()
{
    return true;
});

SusSetPauseCallback(function()
{
    show_debug_message("Pause event");
});