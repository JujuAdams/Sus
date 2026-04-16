// Feather disable all

/// Returns the currently signed in Xbox user.

function XboxGetUser()
{
    with(obj_platform_xbox)
    {
        if (__user == int64(0))
        {
            return int64(0);
        }
        
        if (XboxGetUserIsSignedInExt(__user))
        {
            return __user;
        }
    }
    
    return int64(0);
}