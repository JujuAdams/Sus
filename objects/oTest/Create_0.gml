draw_set_font(fntConsolas);

SusSetCanInterruptGameCallback(function()
{
    return true;
});

SusSetGamepadDisconnectedCallback(function()
{
    //show_debug_message("Gamepad disconnected event");
});

SusSetCanXboxSuspendCallback(function()
{
    return true;
});

SusSetXboxSuspendingCallback(function()
{
    //show_debug_message("Suspending event");
});