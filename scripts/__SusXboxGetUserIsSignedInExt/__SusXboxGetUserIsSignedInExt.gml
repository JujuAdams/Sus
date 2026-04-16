// Feather disable all

/// @param user

function __SusXboxGetUserIsSignedInExt(_user)
{
    var _i = 0;
    repeat(xboxone_get_user_count())
    {
        if (_user == xboxone_get_user(_i))
        {
            return true;
        }
        
        ++_i;
    }
    
    return false;
}