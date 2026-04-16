var _string = $"Sus (Single User System) {SUS_VERSION}, {SUS_DATE}\n";
_string += $"\n";
_string += $"name = \"{SusGetName()}\"\n";
_string += $"user ID = {SusGetUserID()}\n";
_string += $"\n";
_string += $"gamepad = {InputPlayerGetDevice()}\n";
_string += $"connected = {InputPlayerIsConnected()? "true" : "false"}\n";
_string += $"invalid Xbox state = {SusGetInvalidXboxState()? "true" : "false"}\n";
_string += $"gamepad thumbstick = {InputX(INPUT_CLUSTER.NAVIGATION)}, {InputY(INPUT_CLUSTER.NAVIGATION)}\n";
_string += $"\n";

var _i = 0;
repeat(gamepad_get_device_count())
{
    _string += $"gamepad {_i} connected = {gamepad_is_connected(_i)? "true" : "false"}\n";
    ++_i;
}

draw_text(10, 10, _string);

var _string = ".";
repeat((current_time mod 499) / 100) _string += ".";

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_text(room_width - 10, 10, _string);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _sprite = SusGetAvatar();
draw_sprite(_sprite, 0, room_width - 10 - sprite_get_width(_sprite), 64);