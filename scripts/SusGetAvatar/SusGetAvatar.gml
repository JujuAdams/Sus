// Feather disable all

/// Returns a sprite that contains the avatar for the currently signed in user. This function is
/// intended for use with Steam, Xbox hardware, and Windows GDK. On other platforms, this function
/// will return `SusBlankSprite` which is a fully transparent 64x64 sprite.

function SusGetAvatar()
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetAvatar();
}