function __SusConfigSwitch()
{
    switch_controller_set_supported_styles(switch_controller_handheld | switch_controller_joycon_right | switch_controller_joycon_left | switch_controller_joycon_dual | switch_controller_pro_controller);
    switch_controller_joycon_set_holdtype(switch_controller_joycon_holdtype_horizontal);
    switch_controller_support_set_singleplayer_only(true);
    switch_controller_set_default_joycon_assignment(switch_controller_joycon_assignment_single);
    switch_controller_support_set_all(false, true, true, true, true, true, 1, 1);
}