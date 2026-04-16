// Feather disable all

/// Returns a sprite that contains the avatar for the currently signed in user. This function is
/// intended for use with Steam, Xbox hardware, and Windows GDK. On other platforms, this function
/// will return `SusBlankSprite` which is a fully transparent 64x64 sprite.
/// 
/// The `size` parameter for this function should be one of the `SUS_AVATAR_*` constants. The sizes
/// are as follows:
/// 
/// Steam:
///   SUS_AVATAR_SMALL  = steam_user_avatar_size_small  =  32 x  32
///   SUS_AVATAR_MEDIUM = steam_user_avatar_size_medium =  64 x  64
///   SUS_AVATAR_LARGE  = steam_user_avatar_size_large  = 184 x 184
/// 
/// Xbox & Windows GDK:
///   SUS_AVATAR_SMALL  = xboxone_gamerpic_small  =  64 x  64
///   SUS_AVATAR_MEDIUM = xboxone_gamerpic_medium = 208 x 208
///   SUS_AVATAR_LARGE  = xboxone_gamerpic_large  = 424 x 424

/// @param size

function SusGetAvatar(_size)
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetAvatar(clamp(_size, 0, 2));
}