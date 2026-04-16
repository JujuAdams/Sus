function __SusWarning(_string)
{
    _string = $"Warning! {string_replace_all(_string, "\n", " ")}";
    
    if (SUS_WARNINGS_HAVE_CALLSTACKS)
    {
        _string += $"          {debug_get_callstack()}";
    }
    
    __SusTrace(_string);
}