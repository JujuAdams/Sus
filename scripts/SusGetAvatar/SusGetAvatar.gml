// Feather disable all

function SusGetAvatar()
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetAvatar();
}