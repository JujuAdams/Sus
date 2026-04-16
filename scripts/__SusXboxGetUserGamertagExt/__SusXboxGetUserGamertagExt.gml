// Feather disable all

/// @param user

function __SusXboxGetUserGamertagExt(_user)
{
    return __SusXboxGetUserIsSignedInExt(_user)? xboxone_classic_gamertag_for_user(_user) : "";
}