function __SusClassAdapterGDK() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Xbox / GDK adapter");
    }
    
    __findContollerID = -1;
    __funcFindController = function(_user)
    {
        if ((__findContollerID < 0) && (_user != int64(0)) && (not xboxone_is_constrained()))
        {
            __findContollerID = xboxone_find_controller_for_user(_user);
            __SusTrace($"__findContollerID = {__findContollerID}");
        }
    }
    
    __funcEnsureAvatar = function()
    {
        if (not XboxGetUserIsSignedIn())
        {
            if (sprite_exists(__avatar))
            {
                sprite_delete(__avatar);
                __avatar = -1;
            }
        }
        else
        {
            if (sprite_exists(__avatar))
            {
                sprite_delete(__avatar);
                __avatar = -1;
            }
            
            __avatar = xboxone_sprite_add_from_gamerpicture(__user, SUS_XBOX_AVATAR_SIZE, 0, 0);
        }
    }
    
    __user    = xboxone_get_activating_user();
    __gamepad = XboxGetGamepadExt(__user);
    __avatar  = -1; __funcEnsureAvatar();
    
    __activatingUser = __user;
    __seenGamepad = true;
    
    __userChanged  = false;
    __userPrevious = __user;
    __userDefer    = undefined;
    
    __gamepadChanged  = false;
    __gamepadPrevious = __gamepad;
    __gamepadDefer    = undefined;
    
    __SusTrace($"On boot: user = {__user}, gamepad = {__gamepad}");
    
    if (SUS_ON_XBOX_SERIES)
    {
        __XboxSetupUser(XboxGetUser());
        
        //If we hotswap then communicate that change to the Xbox wrapper
        InputSetHotswapCallback(function()
        {
            XboxSetGamepad(InputPlayerGetDevice());
        });
    }
    
    
    
    static __GetName = function()
    {
        return XboxGetUserGamertag();
    }
    
    static __GetAvatar = function()
    {
        return __avatar ?? SusBlankSprite;
    }
    
    static __BeginStep = function()
    {
        if (SUS_USING_WINDOWS_GDK)
        {
            gdk_update();
        }
        
        if (__userDefer != undefined)
        {
            __user = __userDefer;
            __userDefer = undefined;
        }
        
        if (__gamepadDefer != undefined)
        {
            __gamepad = __gamepadDefer;
            __seenGamepad = true;
            __gamepadDefer = undefined;
        }
        
        if (SUS_ON_XBOX_SERIES)
        {
            if ((__user != int64(0)) && (xboxone_user_for_pad(__gamepad) != __user))
            {
                if (__gamepad >= 0)
                {
                    __gamepad = -1;
                    __SusTrace($"Gamepad for {__user} changed to {__gamepad}");
                }
            }
            
            if (__user != __activatingUser)
            {
                __funcFindController(__activatingUser);
            }
            else if (__gamepad < 0)
            {
                if (__seenGamepad)
                {
                    __funcFindController(__activatingUser);
                }
            }
        }
        
        __userChanged    = (__userPrevious    !=__user);
        __gamepadChanged = (__gamepadPrevious !=__gamepad);
        
        __userPrevious    = __user;
        __gamepadPrevious = __gamepad;
        
        if (__userChanged)
        {
            __funcEnsureAvatar();
            __XboxSetupUser(__user);
        }
        
        if (SUS_ON_XBOX_SERIES)
        {
            //When we receive a "gamepad changed" signal from the internal wrapper code, pass that to Input
            if (XboxGetGamepadChanged())
            {
                InputPlayerSetDevice(XboxGetGamepad());
            }
            
            //Try to pause the game if the application is constrained
            if (xboxone_is_constrained())
            {
                __SusCallbackPause();
            }
            
            if (xboxone_is_suspending())
            {
                var _genericSaveCount = instance_exists(obj_save_controller)? array_length(obj_save_controller.generic_save_array) : 0;
                
                __SusTrace($"Waiting for saves to finish... global.SETTINGS_SAVE_ID = {global.SETTINGS_SAVE_ID}, global.SAVE_ID = {global.SAVE_ID}, genericSaveCount = {_genericSaveCount}");
                
                //Finish the suspension once all the async save operations have completed
                if ((global.SETTINGS_SAVE_ID < 0)
                &&  (global.SAVE_ID < 0)
                &&  (_genericSaveCount <= 0))
                {
                    __SusTrace("All saves finished, calling `xboxone_suspend()`");
                    xboxone_suspend();
                }
            }
        }
    }
    
    static __SystemAsync = function()
    {
        __SusTrace($"system: {json_encode(async_load, true)}");
        
        if (SUS_ON_WINDOWS)
        {
            if (async_load[? "event_type"] == "user signed in")
            {
                var _user = async_load[? "user"];
                if (_user != int64(0))
                {
                    __userDefer = _user;
                }
            }
        }
        else if (SUS_ON_XBOX_SERIES)
        {
            if ((async_load[? "id"] == __findContollerID) && (async_load[? "event_type"] == "find_controller_for_user_result"))
            {
                var _user    = async_load[? "userID"];
                var _gamepad = async_load[? "pad_index"];
                
                __SusTrace("xboxone_find_controller_for_user() returned");
                __SusTrace($"Event user = {_user} \"{XboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad}");
                
                if (_user != int64(0))
                {
                    __userDefer = _user;
                
                    if (xboxone_user_for_pad(_gamepad) == _user)
                    {
                        __gamepadDefer = _gamepad;
                    }
                    else
                    {
                        __SusTrace($"xboxone_find_controller_for_user() user {_user} for gamepad {_gamepad} is incorrect, trying workaround");
                        if (xboxone_pad_count_for_user(_user) <= 0)
                        {
                            __SusTrace("xboxone_find_controller_for_user() workaround failed");
                        }
                        else
                        {
                            __gamepadDefer = xboxone_pad_for_user(_user, 0);
                            __SusTrace($"Workaround set gamepad {__gamepadDefer}");
                        }
                    }
                }
                
                __findContollerID = -1;
            }
            
            if (async_load[? "event_type"] == "user controller associated")
            {
                var _user    = async_load[? "user"];
                var _gamepad = async_load[? "pad_index"];
                
                __SusTrace($"User controller associated: user = {_user} \"{XboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad} (existing user = {__user} \"{XboxGetUserGamertagExt(__user)}\", existing gamepad = {__gamepad})");
                
                if ((_gamepad == __gamepad) && (_user != __user))
                {
                    __SusTrace($"User for current gamepad {__gamepad} changed");
                    
                    __userDefer = _user;
                }
                
                if ((_gamepad != __gamepad) && (_user == __user))
                {
                    __SusTrace($"Gamepad for current user {__user} changed");
                    
                    __gamepadDefer = _gamepad;
                }
            } 
            
            if (async_load[? "event_type"] == "user controller disassociated")
            {
                var _user    = async_load[? "user"];
                var _gamepad = async_load[? "pad_index"];
                
                __SusTrace($"User controller disassociated: user = {_user} \"{XboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad} (existing user = {__user} \"{XboxGetUserGamertagExt(__user)}\", existing gamepad = {__gamepad})");
                
                if ((_gamepad == __gamepad) && (_user == __user))
                {
                    __SusTrace($"User lost current gamepad {__gamepad}");
                    
                    __gamepadDefer = -1;
                }
            }
        }
    }
}