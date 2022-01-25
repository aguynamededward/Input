/// @param type
/// @param [value]
/// @param [axisNegative]
/// @param [labelOverride]

function __input_class_binding() constructor
{
    type          = undefined;
    value         = undefined;
    axis_negative = undefined;
    label         = undefined;
    
    if (os_type == os_android)
    {
        //We have an additional field on Android
        //This is used to check for uppercase *and* lowercase letters as Android checks for both individually
        android_lowercase = undefined;
    }
    
    static set_key = function(_key, _player_set)
    {
        //Fix uses of straight strings instead of ord("A") etc.
        if (is_string(_key)) _key = ord(string_upper(_key));

        //Fix UTF-8 where used
        if (!__INPUT_KEYBOARD_NORMATIVE && !_player_set)
        {
            if      (_key == vk_enter    ) { _key = 10; }
            else if (_key == vk_comma    ) { _key = 44; }
            else if (_key == vk_hyphen   ) { _key = 45; }
            else if (_key == vk_period   ) { _key = 46; }
            else if (_key == vk_fslash   ) { _key = 47; }
            else if (_key == vk_semicolon) { _key = 59; }
            else if (_key == vk_equals   ) { _key = 61; }
            else if (_key == vk_lbracket ) { _key = 91; }
            else if (_key == vk_bslash   ) { _key = 92; }
            else if (_key == vk_rbracket ) { _key = 93; }
            else if (_key == vk_grave    ) { _key = 96; }
        }
                
        if (os_type == os_android)
        {
            //Force binding to uppercase
            if (((_key >= ord("a")) && (_key <= ord("z"))
            || (((os_type == os_linux) || (os_type == os_android)) 
            && ((_key >= 224 && _key <= 246) || (_key >= 248 && _key <= 254))))
            {
                _key -= 32;
            }

            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            if (((_key >= ord("A")) && (_key <= ord("Z"))
            || (((os_type == os_linux) || (os_type == os_android)) 
            && ((_key >= 192 && _key <= 214) || (_key >= 216 && _key <= 222))))
            {
                android_lowercase = _key + 32;
            }
        }
        
        type  = "key";
        value = _key;
        
        set_label();
        
        return self;
    }
    
    static set_gamepad_axis = function(_axis, _negative)
    {
        type          = "gamepad axis";
        value         = _axis;
        axis_negative = _negative;
        
        set_label();
        
        return self;
    }
    
    static set_gamepad_button = function(_button)
    {
        type  = "gamepad button";
        value = _button;
        
        set_label();
        
        return self;
    }
    
    static set_mouse_button = function(_button)
    {
        type  = "mouse button";
        value = _button;
        
        set_label();
        
        return self;
    }
    
    static set_mouse_wheel_down = function()
    {
        type = "mouse wheel down";
        
        set_label();
        
        return self;
    }
    
    static set_mouse_wheel_up = function()
    {
        type = "mouse wheel up";
        
        set_label();
        
        return self;
    }
    
    static set_label = function(_label)
    {
        if (_label == undefined)
        {
            label = __input_binding_get_label(type, value, axis_negative)
        }
        else
        {
            label = _label;
        }
        
        return self;
    }
}
