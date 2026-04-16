#macro SUS_VERSION  "1.0.0"
#macro SUS_DATE     "2026-04-13"

#macro SUS_RUNNING_FROM_IDE  (GM_build_type == "run")

#macro SUS_ON_WINDOWS      (os_type == os_windows)
#macro SUS_ON_MACOS        (os_type == os_macosx)
#macro SUS_ON_LINUX        (os_type == os_linux)
#macro SUS_ON_DESKTOP      (SUS_ON_WINDOWS || SUS_ON_MACOS || SUS_ON_LINUX)
#macro SUS_ON_IOS          (os_type == os_ios)
#macro SUS_ON_ANDROID      (os_type == os_android)
#macro SUS_ON_XBOX_SERIES  (os_type == os_xboxseriesxs)
#macro SUS_ON_PS5          (os_type == os_ps5)
#macro SUS_ON_SWITCH       (os_type == os_switch)

#macro SUS_USING_STEAMWORKS     (SUS_ON_DESKTOP && extension_exists("Steamworks"))
#macro SUS_USING_GAMECENTER     (SUS_ON_IOS && extension_exists("GameCenter"))
#macro SUS_USING_PLAY_SERVICES  (SUS_ON_ANDROID && extension_exists("GooglePlayServices"))
#macro SUS_USING_GDK            (SUS_ON_XBOX_SERIES || SUS_USING_WINDOWS_GDK)
#macro SUS_USING_WINDOWS_GDK    (SUS_ON_WINDOWS && extension_exists("GDKExtension"))

#macro SUS_AVATAR_SMALL   0
#macro SUS_AVATAR_MEDIUM  1
#macro SUS_AVATAR_LARGE   2