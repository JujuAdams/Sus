// Feather disable all

function SusGetUserID()
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetUserID();
}