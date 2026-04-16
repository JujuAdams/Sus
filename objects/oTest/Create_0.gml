draw_set_font(fntConsolas);

SusSetPauseCallback(function()
{
    show_debug_message("Pause event");
});

SusSetGamepadConnectedCallback(function()
{
    show_debug_message("Gamepad connected event");
});

SusSetGamepadDisconnectedCallback(function()
{
    show_debug_message("Gamepad disconnected event");
});