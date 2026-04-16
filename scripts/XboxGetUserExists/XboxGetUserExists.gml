// Feather disable all

/// Returns if there is an Xbox user signed in.

function XboxGetUserExists()
{
    return (XboxGetUser() != int64(0));
}