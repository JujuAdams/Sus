function __SusClassAdapterGDK() : __SusClassAdapterFallback() constructor
{
    if (SUS_VERBOSE)
    {
        __SusTrace("Using Xbox / GDK adapter");
    }
    
    __suspending = false;
    __suspendStartTime = infinity;
    
    __findContollerID = -1;
    
    __user           = xboxone_get_activating_user(); //This will often be 0 on Windows
    __activatingUser = __user;
    __userPrevious   = __user;
    __userDefer      = undefined;
    
    __avatar = SusBlankSprite;
    __UpdateAvatar();
    
    if (SUS_VERBOSE)
    {
        __SusTrace($"On boot: user = {__user}, gamepad = {InputPlayerGetDevice()}");
    }
    
    
    
    static __UpdateAvatar = function()
    {
        if (not __SusXboxGetUserIsSignedInExt(__user))
        {
            if (sprite_exists(__avatar) && (__avatar != SusBlankSprite))
            {
                sprite_delete(__avatar);
                __avatar = SusBlankSprite;
            }
        }
        else
        {
            if (sprite_exists(__avatar) && (__avatar != SusBlankSprite))
            {
                sprite_delete(__avatar);
                __avatar = SusBlankSprite;
            }
            
            __avatar = xboxone_sprite_add_from_gamerpicture(__user, SUS_XBOX_AVATAR_SIZE, 0, 0);
        }
        
        return __avatar
    }
    
    static __GetName = function()
    {
        return __SusXboxGetUserGamertagExt(__user);
    }
    
    static __GetAvatar = function()
    {
        return __avatar;
    }
    
    static __GetUserID = function()
    {
        return __user;
    }
    
    static __GamepadDisconnected = function()
    {
        if (SUS_ON_XBOX_SERIES)
        {
            if ((__findContollerID < 0) && (__activatingUser != 0) && (not xboxone_is_constrained()) && (not xboxone_is_suspending()))
            {
                __findContollerID = xboxone_find_controller_for_user(__activatingUser);
            }
        }
        
        if (__SusCallbackCanInterruptGame())
        {
            __SusCallbackGamepadDisconnected();
        }
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
        
        if (__userPrevious !=__user)
        {
            __UpdateAvatar();
        }
        
        __userPrevious = __user;
        
        if (SUS_USING_WINDOWS_GDK)
        {
            if (not InputPlayerIsConnected())
            {
                __GamepadDisconnected();
            }
        }
        else if (SUS_ON_XBOX_SERIES)
        {
            if (not InputPlayerIsConnected()) //Gamepad is plain not connected
            {
                if (SUS_VERBOSE && (__findContollerID < 0))
                {
                    __SusTrace($"Gamepad {InputPlayerGetDevice()} isn't connected")
                }
                
                __GamepadDisconnected();
            }
            else if (__user != __activatingUser) //Current user isn't the activating user
            {
                if (SUS_VERBOSE && (__findContollerID < 0))
                {
                    __SusTrace($"User {__user} isn't the activating user {__activatingUser}")
                }
                
                __GamepadDisconnected();
            }
            else if ((__user != 0) && (xboxone_user_for_pad(InputPlayerGetDevice()) != __user)) //User for the pad doesn't match what we think the user should be
            {
                if (SUS_VERBOSE && (__findContollerID < 0))
                {
                    __SusTrace($"User {xboxone_user_for_pad(InputPlayerGetDevice())} for gamepad {InputPlayerGetDevice()} isn't the expected user {__user}")
                }
                
                __GamepadDisconnected();
            }
            
            if (not xboxone_is_suspending())
            {
                if (__suspending && SUS_VERBOSE)
                {
                    __SusTrace("Application stopped suspending");
                }
                
                __suspending = false;
            }
            else
            {
                if (not __suspending)
                {
                    if (SUS_VERBOSE)
                    {
                        __SusTrace("Application suspending");
                    }
                    
                    __suspending = true;
                    __suspendStartTime = current_time;
                }
                
                __SusCallbackXboxSuspending();
                
                if (__SusCallbackCanXboxSuspend() || (current_time - __suspendStartTime > 800))
                {
                    if (SUS_VERBOSE)
                    {
                        __SusTrace("Calling `xboxone_suspend()`");
                    }
                    
                    xboxone_suspend();
                }
            }
        }
    }
    
    static __SystemAsync = function()
    {
        if (SUS_USING_WINDOWS_GDK)
        {
            if (async_load[? "event_type"] == "user signed in")
            {
                var _user = async_load[? "user"];
                if (_user != 0)
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
                __SusTrace($"Event user = {_user} \"{__SusXboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad}");
                
                if (_user != 0)
                {
                    __userDefer = _user;
                
                    if (xboxone_user_for_pad(_gamepad) == _user)
                    {
                        InputPlayerSetDevice(_gamepad);
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
                            var _gamepad = xboxone_pad_for_user(_user, 0);
                            InputPlayerSetDevice(_gamepad);
                            __SusTrace($"Workaround set gamepad {_gamepad}");
                        }
                    }
                }
                
                __findContollerID = -1;
            }
            
            if (async_load[? "event_type"] == "user controller associated")
            {
                var _user    = async_load[? "user"];
                var _gamepad = async_load[? "pad_index"];
                
                __SusTrace($"User controller associated: user = {_user} \"{__SusXboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad} (existing user = {__user} \"{__SusXboxGetUserGamertagExt(__user)}\", existing gamepad = {InputPlayerGetDevice()})");
                
                if ((_gamepad == InputPlayerGetDevice()) && (_user != __user))
                {
                    __SusTrace($"User for current gamepad {InputPlayerGetDevice()} changed");
                    
                    __userDefer = _user;
                }
                
                if ((_gamepad != InputPlayerGetDevice()) && (_user == __user))
                {
                    __SusTrace($"Gamepad for current user {__user} changed");
                    
                    InputPlayerSetDevice(_gamepad);
                }
            } 
            
            if (async_load[? "event_type"] == "user controller disassociated")
            {
                var _user    = async_load[? "user"];
                var _gamepad = async_load[? "pad_index"];
                
                __SusTrace($"User controller disassociated: user = {_user} \"{__SusXboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad} (existing user = {__user} \"{__SusXboxGetUserGamertagExt(__user)}\", existing gamepad = {InputPlayerGetDevice()})");
                
                if ((_gamepad == InputPlayerGetDevice()) && (_user == __user))
                {
                    __SusTrace($"User lost current gamepad {InputPlayerGetDevice()}");
                    //InputPlayerSetDevice(INPUT_NO_DEVICE);
                }
            }
        }
    }
}