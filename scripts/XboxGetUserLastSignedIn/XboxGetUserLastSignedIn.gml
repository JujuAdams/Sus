// Feather disable all

/// Returns which user was last signed in.

function XboxGetUserLastSignedIn()
{
    with(obj_platform_xbox)
    {
        return __user;
    }
    
    return int64(0);
}