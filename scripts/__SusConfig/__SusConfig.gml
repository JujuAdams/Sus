/// Whether to report lots of information messages to the console. This can be helpful to diagnose
/// problems. You will likely want to set this macro to `false` for production builds.
#macro SUS_VERBOSE  (SUS_RUNNING_FROM_IDE)

/// Whether warning messages emitted by Sus should contain callstacks. You may want to consider
/// setting this macro to `false` if you are concerned about security.
#macro SUS_WARNINGS_HAVE_CALLSTACKS  true

/// The filename pattern to use when saving Steam screenshots. The # character will be replaced by
/// a timestamp in the format `yyyy-m-d__h-m-s`. If you want to manage Steam screenshots yourself,
/// set this macro to `undefined`.
#macro SUS_STEAM_SCREENSHOT_FILENAME  "screenshot__#.png"