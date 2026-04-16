// Feather disable all

function SusGetName()
{
    static _adapter = __SusSystem().__adapter;
    return _adapter.__GetName();
}