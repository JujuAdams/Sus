/// Whether to report lots of information messages to the console. This can be helpful to diagnose
/// problems. You will likely want to set this macro to `false` for production builds.
#macro SUS_VERBOSE  (SUS_RUNNING_FROM_IDE)

#macro SUS_WARNINGS_HAVE_CALLSTACKS  true

#macro SUS_STEAM_SCREENSHOT_FILENAME  "screenshot#.png"

#macro SUS_STEAM_AVATAR_SIZE  steam_user_avatar_size_medium

// Should be one of the `xboxone_gamerpic_*` constants. According to YYG's documentation, the sizes
// are as follows:
// - xboxone_gamerpic_small  =  64 x  64
// - xboxone_gamerpic_medium = 208 x 208
// - xboxone_gamerpic_large  = 424 x 424
#macro SUS_XBOX_AVATAR_SIZE  xboxone_gamerpic_medium



function __SusConfigSwitch()
{
    switch_controller_set_supported_styles(switch_controller_handheld | switch_controller_joycon_right | switch_controller_joycon_left | switch_controller_joycon_dual | switch_controller_pro_controller);
    switch_controller_joycon_set_holdtype(switch_controller_joycon_holdtype_horizontal);
    switch_controller_support_set_singleplayer_only(true);
    switch_controller_set_default_joycon_assignment(switch_controller_joycon_assignment_single);
    switch_controller_support_set_all(false, true, true, true, true, true, 1, 1);
}