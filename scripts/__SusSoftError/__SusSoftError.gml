function __SusSoftError(_string)
{
    if (SUS_RUNNING_FROM_IDE)
    {
        __SusError(_string);
    }
    else
    {
        __SusWarning(_string);
    }
}