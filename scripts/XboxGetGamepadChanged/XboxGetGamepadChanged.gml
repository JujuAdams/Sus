// Feather disable all

function XboxGetGamepadChanged()
{
    with(obj_platform_xbox)
    {
        return __gamepadChanged;
    }
    
    return false;
}