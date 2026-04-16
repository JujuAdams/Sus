function __SusClassAdapterSteam() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Steam adapter");
    }
    
    var _avatar = steam_get_user_avatar(steam_get_user_steam_id(), SUS_STEAM_AVATAR_SIZE);
    __playerAvatar = (_avatar < 0)? SusBlankSprite : __SusSteamImageCreateSprite(_avatar);
    
    
    
    static __BeginStep = function()
    {
        steam_update();
        
        if (SUS_STEAM_SCREENSHOT_FILENAME != undefined)
        {
    		if (steam_is_screenshot_requested())
    		{
                var _time = date_current_datetime();
                var _safeDatetime = $"{date_get_year(_time)}-{date_get_month(_time)}-{date_get_day(_time)}";
                
                var _filename = string_replace(SUS_STEAM_SCREENSHOT_FILENAME, "#", _safeDatetime);
                _filename = string_replace_all(_filename, "#", ""); //Clean up other hashes
                
    			screen_save(_filename);
    			steam_send_screenshot(_filename, window_get_width(), window_get_height());
    		}
        }
        
        __BeginStepShared();
    }
    
    static __GetName = function()
    {
        return steam_get_persona_name();
    }
    
    static __GetAvatar = function()
    {
        return __playerAvatar;
    }
    
    static __GetUserID = function()
    {
        return steam_get_user_account_id();
    }
}