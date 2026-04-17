function __SusClassAdapterSteam() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Steam adapter");
    }
    
    __avatarSpriteArray = array_create(3, SusBlankSprite);
    
    var _steamImage = steam_get_user_avatar(steam_get_user_steam_id(), steam_user_avatar_size_small);
    __avatarSpriteArray[@ SUS_AVATAR_SMALL] = (_steamImage < 0)? SusBlankSprite : __CreateAvatarSprite(_steamImage);
    
    var _steamImage = steam_get_user_avatar(steam_get_user_steam_id(), steam_user_avatar_size_medium);
    __avatarSpriteArray[@ SUS_AVATAR_MEDIUM] = (_steamImage < 0)? SusBlankSprite : __CreateAvatarSprite(_steamImage);
    
    var _steamImage = steam_get_user_avatar(steam_get_user_steam_id(), steam_user_avatar_size_large);
    __avatarSpriteArray[@ SUS_AVATAR_LARGE] = (_steamImage < 0)? SusBlankSprite : __CreateAvatarSprite(_steamImage);
    
    
    
    static __CreateAvatarSprite = function(_steamImage)
    {
        var _sizeArray = steam_image_get_size(_steamImage);
        
        if (not is_array(_sizeArray))
        {
            return SusBlankSprite;
        }
        
        var _width  = _sizeArray[0];
        var _height = _sizeArray[1];
        
        var _bufferSize = 4*_width*_height;
        var _buffer = buffer_create(_bufferSize, buffer_fixed, 1);
        
        if (steam_image_get_rgba(_steamImage, _buffer, _bufferSize)) 
        {
            var _surface = surface_create(_width, _height);
            buffer_set_surface(_buffer, _surface, 0);
            var _sprite = sprite_create_from_surface(_surface, 0, 0, _width, _height, false, false, 0, 0);
            surface_free(_surface);
        } 
        else 
        {
            _sprite = SusBlankSprite;
        }
        
        buffer_delete(_buffer);
        
        return _sprite;
    }
    
    static __BeginStep = function()
    {
        steam_update();
        
        if (is_string(SUS_STEAM_SCREENSHOT_FILENAME))
        {
    		if (steam_is_screenshot_requested())
    		{
                var _time = date_current_datetime();
                var _safeDatetime = $"{date_get_year(_time)}-{date_get_month(_time)}-{date_get_day(_time)}__{date_get_hour(_time)}-{date_get_minute(_time)}-{date_get_second(_time)}";
                
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
    
    static __GetAvatar = function(_size)
    {
        return __avatarSpriteArray[_size];
    }
    
    static __GetUserID = function()
    {
        return steam_get_user_account_id();
    }
}