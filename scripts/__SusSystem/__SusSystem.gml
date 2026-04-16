#macro __SUS_DISCONNECTION_THRESHOLD  5
#macro __SUS_CONTROLLER_INSTANCE_DEPTH  -15_999

__SusSystem();
function __SusSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    
    if (SUS_RUNNING_FROM_IDE)
    {
        global.__SusSystem = _system;
    }
    
    with(_system)
    {
        __SusTrace($"Welcome to Sus by Juju Adams! This is version {SUS_VERSION}, {SUS_DATE}");
        
        __gamepadDisconnectedCallback = undefined;
        __canInterruptGameCallback    = undefined;
        __xboxSuspendCallback         = undefined;
        __canXboxSuspendCallback      = undefined;
        
        if (SUS_USING_STEAMWORKS)
        {
            __adapter = new __SusClassAdapterSteam();
        }
        else if (SUS_ON_SWITCH)
        {
            __adapter = new __SusClassAdapterSwitch();
        }
        else if (SUS_ON_PS5)
        {
            __adapter = new __SusClassAdapterPS5();
        }
        else if (SUS_USING_GDK)
        {
            __adapter = new __SusClassAdapterGDK();
        }
        else
        {
            __adapter = new __SusClassAdapterFallback();
        }
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            //Ensure existance of our controller object
            if (not instance_exists(SusControllerObject))
            {
                //Try to detect deactivation of the controller object
                instance_activate_object(SusControllerObject);
                if (instance_exists(SusControllerObject))
                {
                    //Be nasty when running from the IDE >:(
                    __SusSoftError("SusControllerObject has been deactivated\nPlease ensure that SusControllerObject is never deactivated\nYou may need to use instance_activate_object(SusControllerObject)");
                }
                else
                {
                    static _created = false;
                    if (_created) __SusSoftError("SusControllerObject has been destroyed\nPlease ensure that SusControllerObject is never destroyed");
                    _created = true;
                    
                    instance_create_depth(0, 0, __SUS_CONTROLLER_INSTANCE_DEPTH, SusControllerObject);
                }
            }
        
            //Detect if the controller object has been set to non-persistent
            if (!SusControllerObject.persistent)
            {
                __SusSoftError("SusControllerObject has been set as non-persistent\nPlease ensure that SusControllerObject is always persistent");
                SusControllerObject.persistent = true;
            }
        
            //Detect if the controller object depth has been set
            if (SusControllerObject.depth != __SUS_CONTROLLER_INSTANCE_DEPTH)
            {
                __SusSoftError($"SusControllerObject depth has been changed (expected {__SUS_CONTROLLER_INSTANCE_DEPTH}, got {SusControllerObject.depth})\nPlease ensure that SusControllerObject is never manually created and depth is not manually set");
                SusControllerObject.depth = __SUS_CONTROLLER_INSTANCE_DEPTH;
            }
        },
        [], -1));
    }
    
    return _system;
}