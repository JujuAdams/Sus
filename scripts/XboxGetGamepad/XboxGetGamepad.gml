// Feather disable all

function XboxGetGamepad()
{
    with(obj_platform_xbox)
    {
        return __gamepad;
    }
    
    return -1;
}